Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C77C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0628921874
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHIWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:43:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:61302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfHIWnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:43:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="175279587"
Received: from rmmeyer-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.138.140])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2019 15:43:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/3] soundwire: intel: add debugfs register dump
Date:   Fri,  9 Aug 2019 17:43:41 -0500
Message-Id: <20190809224341.15726-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs file to dump the Intel SoundWire registers

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 114 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c82ca4e13de7..9ae69dad1437 100644
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
@@ -83,6 +85,7 @@
 
 /* Intel ALH Register definitions */
 #define SDW_ALH_STRMZCFG(x)		(0x000 + (0x4 * (x)))
+#define SDW_ALH_NUM_STREAMS		64
 
 #define SDW_ALH_STRMZCFG_DMAT_VAL	0x3
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
@@ -98,6 +101,7 @@ struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
 	struct sdw_intel_link_res *res;
+	struct dentry *fs;
 };
 
 #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
@@ -161,6 +165,113 @@ static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
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
+static int intel_reg_show(struct seq_file *s_file, void *data)
+{
+	struct sdw_intel *sdw = s_file->private;
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
+	for (i = 0; i < links; i++) {
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
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\n PCMSyCH registers\n");
+
+		/*
+		 * the value 10 is the number of PDIs. We will need a
+		 * cleanup to remove hard-coded Intel configurations
+		 * from cadence_master.c
+		 */
+		for (j = 0; j < 10; j++) {
+			ret += intel_sprintf(s, false, buf, ret,
+					SDW_SHIM_PCMSYCHM(i, j));
+			ret += intel_sprintf(s, false, buf, ret,
+					SDW_SHIM_PCMSYCHC(i, j));
+		}
+		ret += scnprintf(buf + ret, RD_BUF - ret, "\n PDMSCAP, IOCTL, CTMCTL\n");
+
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PDMSCAP(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
+		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
+	}
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nWake registers\n");
+	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKEEN);
+	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKESTS);
+
+	ret += scnprintf(buf + ret, RD_BUF - ret, "\nALH STRMzCFG\n");
+	for (i = 0; i < SDW_ALH_NUM_STREAMS; i++)
+		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
+
+	seq_printf(s_file, "%s", buf);
+	kfree(buf);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(intel_reg);
+
+static void intel_debugfs_init(struct sdw_intel *sdw)
+{
+	struct dentry *root = sdw->cdns.bus.debugfs;
+
+	if (!root)
+		return;
+
+	sdw->fs = debugfs_create_dir("intel-sdw", root);
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
@@ -885,6 +996,8 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_dai;
 	}
 
+	intel_debugfs_init(sdw);
+
 	return 0;
 
 err_dai:
@@ -901,6 +1014,7 @@ static int intel_remove(struct platform_device *pdev)
 
 	sdw = platform_get_drvdata(pdev);
 
+	intel_debugfs_exit(sdw);
 	free_irq(sdw->res->irq, sdw);
 	snd_soc_unregister_component(sdw->cdns.dev);
 	sdw_delete_bus_master(&sdw->cdns.bus);
-- 
2.20.1

