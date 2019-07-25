Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F085C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CF022C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGYXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfGYXlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874669"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:12 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of CONFIG_UPDATE
Date:   Thu, 25 Jul 2019 18:40:01 -0500
Message-Id: <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the hardware documentation, all changes to MCP_CONFIG,
MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL need to be validated with a
self-clearing write to MCP_CONFIG_UPDATE.

For some reason, the existing code only does this write to
CONFIG_UPDATE when enabling interrupts. Add a helper and do the update
when the CONFIG is changed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 9f611a1fff0a..eb46cf651d62 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -224,6 +224,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
+ * need to be confirmed with a write to MCP_CONFIG_UPDATE
+ */
+static int cdns_update_config(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
+			     CDNS_MCP_CONFIG_UPDATE_BIT);
+	if (ret < 0)
+		dev_err(cdns->dev, "Config update timedout\n");
+
+	return ret;
+}
+
 /*
  * debugfs
  */
@@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
  */
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 {
-	int ret;
-
 	_cdns_enable_interrupt(cdns);
-	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
-			     CDNS_MCP_CONFIG_UPDATE_BIT);
-	if (ret < 0)
-		dev_err(cdns->dev, "Config update timedout\n");
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
@@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
 
-	return 0;
+	/* commit changes */
+	ret = cdns_update_config(cdns);
+
+	return ret;
 }
 EXPORT_SYMBOL(sdw_cdns_init);
 
-- 
2.20.1

