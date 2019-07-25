Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4B2C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F40216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGYXlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfGYXlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874648"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:04 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
Date:   Thu, 25 Jul 2019 18:39:56 -0500
Message-Id: <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file to dump the Intel SoundWire registers

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
is the use of scnprintf to avoid known issues with snprintf.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 115 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 317873bc0555..aeadc341c0a3 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -16,6 +17,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
 #include "cadence_master.h"
+#include "bus.h"
 #include "intel.h"
 
 /* Intel SHIM Registers Definition */
@@ -98,6 +100,7 @@ struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
 	struct sdw_intel_link_res *res;
+	struct dentry *fs;
 };
 
 #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
@@ -161,6 +164,115 @@ static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
 	return -EAGAIN;
 }
 
+/*
+ * debugfs
+ */
+
+#define RD_BUF (2 * PAGE_SIZE)
+
+static ssize_t intel_sprintf(void __iomem *mem, bool l,
+			     char *buf, size_t pos, unsigned int reg)
+{
+	int value;
+
+	if (l)
+		value = intel_readl(mem, reg);
+	else
+		value = intel_readw(mem, reg);
+
+	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
+}
+
+static ssize_t intel_reg_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct sdw_intel *sdw = file->private_data;
+	void __iomem *s = sdw->res->shim;
+	void __iomem *a = sdw->res->alh;
+	char *buf;
+	ssize_t ret;
+	int i, j;
+	unsigned int links, reg;
+
+	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	links = intel_readl(s, SDW_SHIM_LCAP) & GENMASK(2, 0);
+
+	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
+
+	for (i = 0; i < 4; i++) {
+		reg = SDW_SHIM_LCAP + i * 4;
+		ret += intel_sprintf(s, true, buf, ret, reg);
+	}
+
+	for (i = 0; i < links; i++) {
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\nLink%d\n", i);
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLSCAP(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS0CM(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS1CM(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS2CM(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS3CM(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PCMSCAP(i));
+
+		for (j = 0; j < 8; j++) {
+			ret += intel_sprintf(s, false, buf, ret,
+					SDW_SHIM_PCMSYCHM(i, j));
+			ret += intel_sprintf(s, false, buf, ret,
+					SDW_SHIM_PCMSYCHC(i, j));
+		}
+
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PDMSCAP(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
+	}
+
+	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKEEN);
+	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKESTS);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nALH\n");
+	for (i = 0; i < 8; i++)
+		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations intel_reg_fops = {
+	.open = simple_open,
+	.read = intel_reg_read,
+	.llseek = default_llseek,
+};
+
+static void intel_debugfs_init(struct sdw_intel *sdw)
+{
+	struct dentry *root = sdw->cdns.bus.debugfs;
+
+	if (!root)
+		return;
+
+	sdw->fs = debugfs_create_dir("intel-sdw", root);
+	if (IS_ERR_OR_NULL(sdw->fs)) {
+		dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
+		sdw->fs = NULL;
+		return;
+	}
+
+	debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
+			    &intel_reg_fops);
+
+	sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs);
+}
+
+static void intel_debugfs_exit(struct sdw_intel *sdw)
+{
+	debugfs_remove_recursive(sdw->fs);
+}
+
 /*
  * shim ops
  */
@@ -896,6 +1008,8 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_dai;
 	}
 
+	intel_debugfs_init(sdw);
+
 	return 0;
 
 err_dai:
@@ -912,6 +1026,7 @@ static int intel_remove(struct platform_device *pdev)
 
 	sdw = platform_get_drvdata(pdev);
 
+	intel_debugfs_exit(sdw);
 	free_irq(sdw->res->irq, sdw);
 	snd_soc_unregister_component(sdw->cdns.dev);
 	sdw_delete_bus_master(&sdw->cdns.bus);
-- 
2.20.1

