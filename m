Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72092216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfHFAzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731414AbfHFAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153222"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 13/17] soundwire: cadence_master: fix divider setting in clock register
Date:   Mon,  5 Aug 2019 19:55:18 -0500
Message-Id: <20190806005522.22642-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

The existing code uses an OR operation which would mix the original
divider setting with the new one, resulting in an invalid
configuration that can make codecs hang.

Add the mask definition and use cdns_updatel to update divider

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 049ecfad2c00..fb198a806efd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -59,6 +59,7 @@
 #define CDNS_MCP_SSP_CTRL1			0x28
 #define CDNS_MCP_CLK_CTRL0			0x30
 #define CDNS_MCP_CLK_CTRL1			0x38
+#define CDNS_MCP_CLK_MCLKD_MASK		GENMASK(7, 0)
 
 #define CDNS_MCP_STAT				0x40
 
@@ -936,10 +937,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	/* Set clock divider */
 	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
-	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
-	val |= divider;
-	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
-	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
+
+	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
+		     CDNS_MCP_CLK_MCLKD_MASK, divider);
+	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
+		     CDNS_MCP_CLK_MCLKD_MASK, divider);
 
 	/*
 	 * Frame shape changes after initialization have to be done
@@ -989,7 +991,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 {
 	struct sdw_master_prop *prop = &bus->prop;
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
-	int mcp_clkctrl_off, mcp_clkctrl;
+	int mcp_clkctrl_off;
 	int divider;
 
 	if (!params->curr_dr_freq) {
@@ -1006,9 +1008,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 	else
 		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
 
-	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
-	mcp_clkctrl |= divider;
-	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
+	cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, divider);
 
 	return 0;
 }
-- 
2.20.1

