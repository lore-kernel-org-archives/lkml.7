Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBA42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfGYXm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:42:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfGYXlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874775"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:35 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults for frame shape
Date:   Thu, 25 Jul 2019 18:40:16 -0500
Message-Id: <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hard-coding and use BIOS values. If they are wrong use default
48x2 frame shape.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 442f78c00f09..d84344e29f71 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -175,7 +175,6 @@
 /* Driver defaults */
 
 #define CDNS_DEFAULT_CLK_DIVIDER		0
-#define CDNS_DEFAULT_FRAME_SHAPE		0x30
 #define CDNS_DEFAULT_SSP_INTERVAL		0x18
 #define CDNS_TX_TIMEOUT				2000
 
@@ -954,6 +953,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 }
 EXPORT_SYMBOL(sdw_cdns_pdi_init);
 
+static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
+{
+	u32 val;
+	int c;
+	int r;
+
+	r = sdw_find_row_index(n_rows);
+	c = sdw_find_col_index(n_cols);
+
+	val = (r << 3) | c;
+
+	return val;
+}
+
 /**
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
@@ -977,7 +990,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
 
 	/* Set the default frame shape */
-	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, CDNS_DEFAULT_FRAME_SHAPE);
+	val = cdns_set_default_frame_shape(prop->default_row,
+					   prop->default_col);
+	cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
 
 	/* Set SSP interval to default value */
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
-- 
2.20.1

