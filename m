Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B1EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2244216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfHFAzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:55:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731384AbfHFAzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153214"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:45 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 12/17] soundwire: cadence_master: make use of mclk_freq property
Date:   Mon,  5 Aug 2019 19:55:17 -0500
Message-Id: <20190806005522.22642-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the prototype and Intel implementation are enabled, use this
property to avoid hard-coded values.

For example for ICL the mclk_freq value is 38.4 MHz while on CNL/CML
it's 24 MHz. The mclk_freq should not be confused with the
max_clk_freq, which si the maximum bus clock. The mclk_freq is
typically tied to the oscillator frequency and does not change between
platforms. The max_clk_freq value is linked to the maximum bandwidth
needed and topology/trace length.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 89c55e4bb72c..049ecfad2c00 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -175,8 +175,6 @@
 #define CDNS_PDI_CONFIG_PORT			GENMASK(4, 0)
 
 /* Driver defaults */
-
-#define CDNS_DEFAULT_CLK_DIVIDER		0
 #define CDNS_DEFAULT_SSP_INTERVAL		0x18
 #define CDNS_TX_TIMEOUT				2000
 
@@ -922,7 +920,10 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
  */
 int sdw_cdns_init(struct sdw_cdns *cdns)
 {
+	struct sdw_bus *bus = &cdns->bus;
+	struct sdw_master_prop *prop = &bus->prop;
 	u32 val;
+	int divider;
 	int ret;
 
 	/* Exit clock stop */
@@ -934,9 +935,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	}
 
 	/* Set clock divider */
+	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
 	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
-	val |= CDNS_DEFAULT_CLK_DIVIDER;
+	val |= divider;
 	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
+	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
 
 	/*
 	 * Frame shape changes after initialization have to be done
@@ -984,6 +987,7 @@ EXPORT_SYMBOL(sdw_cdns_init);
 
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 {
+	struct sdw_master_prop *prop = &bus->prop;
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int mcp_clkctrl_off, mcp_clkctrl;
 	int divider;
@@ -993,7 +997,9 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 		return -EINVAL;
 	}
 
-	divider	= (params->max_dr_freq / params->curr_dr_freq) - 1;
+	divider	= prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR /
+		params->curr_dr_freq;
+	divider--; /* divider is 1/(N+1) */
 
 	if (params->next_bank)
 		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL1;
-- 
2.20.1

