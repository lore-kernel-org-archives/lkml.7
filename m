Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1823DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7202253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfLMFEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:04:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:58737 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbfLMFEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:04:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208340792"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:45 -0800
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
Subject: [PATCH v4 15/15] soundwire: intel_init: add implementation of sdw_intel_enable_irq()
Date:   Thu, 12 Dec 2019 23:04:09 -0600
Message-Id: <20191213050409.12776-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is required to enable all interrupts across all links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index a30d95ee71b7..391e8763638f 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -137,6 +137,30 @@ sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 	return 0;
 }
 
+#define HDA_DSP_REG_ADSPIC2             (0x10)
+#define HDA_DSP_REG_ADSPIS2             (0x14)
+#define HDA_DSP_REG_ADSPIC2_SNDW        BIT(5)
+
+/**
+ * sdw_intel_enable_irq() - enable/disable Intel SoundWire IRQ
+ * @mmio_base: The mmio base of the control register
+ * @enable: true if enable
+ */
+void sdw_intel_enable_irq(void __iomem *mmio_base, bool enable)
+{
+	u32 val;
+
+	val = readl(mmio_base + HDA_DSP_REG_ADSPIC2);
+
+	if (enable)
+		val |= HDA_DSP_REG_ADSPIC2_SNDW;
+	else
+		val &= ~HDA_DSP_REG_ADSPIC2_SNDW;
+
+	writel(val, mmio_base + HDA_DSP_REG_ADSPIC2);
+}
+EXPORT_SYMBOL(sdw_intel_enable_irq);
+
 static struct sdw_intel_ctx
 *sdw_intel_probe_controller(struct sdw_intel_res *res)
 {
-- 
2.20.1

