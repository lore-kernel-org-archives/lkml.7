Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7860F2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfHFAzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:55:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbfHFAzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153156"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:36 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 06/17] soundwire: cadence_master: use firmware defaults for frame shape
Date:   Mon,  5 Aug 2019 19:55:11 -0500
Message-Id: <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hard-coding and use firmware (BIOS/DT) values. If they are
wrong use default 48x2 frame shape.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 5d9729b4d634..89c55e4bb72c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -48,6 +48,8 @@
 #define CDNS_MCP_SSPSTAT			0xC
 #define CDNS_MCP_FRAME_SHAPE			0x10
 #define CDNS_MCP_FRAME_SHAPE_INIT		0x14
+#define CDNS_MCP_FRAME_SHAPE_COL_MASK		GENMASK(2, 0)
+#define CDNS_MCP_FRAME_SHAPE_ROW_OFFSET		3
 
 #define CDNS_MCP_CONFIG_UPDATE			0x18
 #define CDNS_MCP_CONFIG_UPDATE_BIT		BIT(0)
@@ -175,7 +177,6 @@
 /* Driver defaults */
 
 #define CDNS_DEFAULT_CLK_DIVIDER		0
-#define CDNS_DEFAULT_FRAME_SHAPE		0x30
 #define CDNS_DEFAULT_SSP_INTERVAL		0x18
 #define CDNS_TX_TIMEOUT				2000
 
@@ -901,6 +902,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 }
 EXPORT_SYMBOL(sdw_cdns_pdi_init);
 
+static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
+{
+	u32 val;
+	int c;
+	int r;
+
+	r = sdw_find_row_index(n_rows);
+	c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
+
+	val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
+
+	return val;
+}
+
 /**
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
@@ -923,8 +938,13 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	val |= CDNS_DEFAULT_CLK_DIVIDER;
 	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
 
-	/* Set the default frame shape */
-	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, CDNS_DEFAULT_FRAME_SHAPE);
+	/*
+	 * Frame shape changes after initialization have to be done
+	 * with the bank switch mechanism
+	 */
+	val = cdns_set_initial_frame_shape(prop->default_row,
+					   prop->default_col);
+	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
 
 	/* Set SSP interval to default value */
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
-- 
2.20.1

