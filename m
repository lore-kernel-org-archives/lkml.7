Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355EC004C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3322081C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEDBBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 21:01:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:20974 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEDBBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 21:01:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 18:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="148114237"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga007.fm.intel.com with ESMTP; 03 May 2019 18:00:58 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 6/7] soundwire: cadence_master: add debugfs register dump
Date:   Fri,  3 May 2019 20:00:29 -0500
Message-Id: <20190504010030.29233-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file to dump the Cadence master registers

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
is the use of scnprintf to avoid known issues with snprintf.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 98 ++++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |  5 ++
 2 files changed, 103 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 682789bb8ab3..e9c30f18ce25 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -8,6 +8,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -222,6 +223,103 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * debugfs
+ */
+
+#define RD_BUF (2 * PAGE_SIZE)
+
+static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
+			    char *buf, size_t pos, unsigned int reg)
+{
+	return scnprintf(buf + pos, RD_BUF - pos,
+			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
+}
+
+static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct sdw_cdns *cdns = file->private_data;
+	char *buf;
+	ssize_t ret;
+	int i, j;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
+	for (i = 0; i < 8; i++) /* 8 MCP registers */
+		ret += cdns_sprintf(cdns, buf, ret, i * 4);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nStatus & Intr Registers\n");
+	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
+		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nSSP & Clk ctrl Registers\n");
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
+	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn B0 Registers\n");
+	for (i = 0; i < 7; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+		for (j = 0; j < 6; j++)
+			ret += cdns_sprintf(cdns, buf, ret,
+					CDNS_DPN_B0_CONFIG(i) + j * 4);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn B1 Registers\n");
+	for (i = 0; i < 7; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+
+		for (j = 0; j < 6; j++)
+			ret += cdns_sprintf(cdns, buf, ret,
+					CDNS_DPN_B1_CONFIG(i) + j * 4);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn Control Registers\n");
+	for (i = 0; i < 7; i++)
+		ret += cdns_sprintf(cdns, buf, ret,
+				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nPDIn Config Registers\n");
+	for (i = 0; i < 7; i++)
+		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations cdns_reg_fops = {
+	.open = simple_open,
+	.read = cdns_reg_read,
+	.llseek = default_llseek,
+};
+
+/**
+ * sdw_cdns_debugfs_init() - Cadence debugfs init
+ * @cdns: Cadence instance
+ * @root: debugfs root
+ */
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
+{
+	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
+}
+EXPORT_SYMBOL(sdw_cdns_debugfs_init);
+
 /*
  * IO Calls
  */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index fe2af62958b1..d375bbfead18 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -163,6 +163,11 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
+
+int sdw_cdns_suspend(struct sdw_cdns *cdns);
+bool sdw_cdns_check_resume_status(struct sdw_cdns *cdns);
+
 int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			struct sdw_cdns_streams *stream,
 			u32 ch, u32 dir);
-- 
2.17.1

