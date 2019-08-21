Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813A22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfHUS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:58:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:47792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbfHUS6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:58:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 11:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="262586635"
Received: from dbarua-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.198.189])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2019 11:58:37 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 2/4] soundwire: cadence_master: add debugfs register dump
Date:   Wed, 21 Aug 2019 13:58:19 -0500
Message-Id: <20190821185821.12690-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
References: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file to dump the Cadence master registers.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 107 +++++++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3338269397dd..dcb698e43c48 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -8,6 +8,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -230,6 +231,112 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 	return -EAGAIN;
 }
 
+/*
+ * debugfs
+ */
+#ifdef CONFIG_DEBUG_FS
+
+#define RD_BUF (2 * PAGE_SIZE)
+
+static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
+			    char *buf, size_t pos, unsigned int reg)
+{
+	return scnprintf(buf + pos, RD_BUF - pos,
+			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
+}
+
+static int cdns_reg_show(struct seq_file *s, void *data)
+{
+	struct sdw_cdns *cdns = s->private;
+	char *buf;
+	ssize_t ret;
+	int num_ports;
+	int i, j;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
+	/* 8 MCP registers */
+	for (i = CDNS_MCP_CONFIG; i <= CDNS_MCP_PHYCTRL; i += sizeof(u32))
+		ret += cdns_sprintf(cdns, buf, ret, i);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nStatus & Intr Registers\n");
+	/* 13 Status & Intr registers (offsets 0x70 and 0x74 not defined) */
+	for (i = CDNS_MCP_STAT; i <=  CDNS_MCP_FIFOSTAT; i += sizeof(u32))
+		ret += cdns_sprintf(cdns, buf, ret, i);
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
+
+	/*
+	 * in sdw_cdns_pdi_init() we filter out the Bulk PDIs,
+	 * so the indices need to be corrected again
+	 */
+	num_ports = cdns->num_ports + CDNS_PCM_PDI_OFFSET;
+
+	for (i = 0; i < num_ports; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+		for (j = CDNS_DPN_B0_CONFIG(i);
+		     j < CDNS_DPN_B0_ASYNC_CTRL(i); j += sizeof(u32))
+			ret += cdns_sprintf(cdns, buf, ret, j);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn B1 Registers\n");
+	for (i = 0; i < num_ports; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret,
+				 "\nDP-%d\n", i);
+
+		for (j = CDNS_DPN_B1_CONFIG(i);
+		     j < CDNS_DPN_B1_ASYNC_CTRL(i); j += sizeof(u32))
+			ret += cdns_sprintf(cdns, buf, ret, j);
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nDPn Control Registers\n");
+	for (i = 0; i < num_ports; i++)
+		ret += cdns_sprintf(cdns, buf, ret,
+				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret,
+			 "\nPDIn Config Registers\n");
+
+	/* number of PDI and ports is interchangeable */
+	for (i = 0; i < num_ports; i++)
+		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
+
+	seq_printf(s, "%s", buf);
+	kfree(buf);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cdns_reg);
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
+EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
+
+#endif /* CONFIG_DEBUG_FS */
+
 /*
  * IO Calls
  */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 8254a9e8deb4..0b72b7094735 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -163,6 +163,10 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
 
+#ifdef CONFIG_DEBUG_FS
+void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
+#endif
+
 int sdw_cdns_get_stream(struct sdw_cdns *cdns,
 			struct sdw_cdns_streams *stream,
 			u32 ch, u32 dir);
-- 
2.20.1

