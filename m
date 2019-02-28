Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543BA21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfB1KVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:21:49 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36328 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732306AbfB1KVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:21:47 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SAHwFO007042;
        Thu, 28 Feb 2019 11:20:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtwxpcm7t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:20:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 347B548;
        Thu, 28 Feb 2019 10:20:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12AEA2C4A;
        Thu, 28 Feb 2019 10:20:06 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:20:05
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
Date:   Thu, 28 Feb 2019 11:19:53 +0100
Message-ID: <1551349196-8956-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On STM32MP15, OTP area may be read/written by using BSEC (boot, security
and OTP control). BSEC registers set is composed of various regions, among
which control registers and OTP shadow registers.
Secure monitor calls are involved in this process to allow (or deny)
access to the full range of OTP data.
This adds support for reading and writing OTP data using SMC services.
Data content can be aligned on 16-bits or 8-bits. Then take care of it,
since BSEC data is 32-bits wide.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/nvmem/stm32-romem.c | 134 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 07e98b5..354be52 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -6,11 +6,29 @@
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com> for STMicroelectronics.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of_device.h>
 
+/* BSEC secure service access from non-secure */
+#define STM32_SMC_BSEC			0x82001003
+#define STM32_SMC_READ_SHADOW		0x01
+#define STM32_SMC_PROG_OTP		0x02
+#define STM32_SMC_WRITE_SHADOW		0x03
+#define STM32_SMC_READ_OTP		0x04
+
+/* shadow registers offest */
+#define STM32MP15_BSEC_DATA0		0x200
+
+/* 32 (x 32-bits) lower shadow registers */
+#define STM32MP15_BSEC_NUM_LOWER	32
+
+struct stm32_romem_cfg {
+	int size;
+};
+
 struct stm32_romem_priv {
 	void __iomem *base;
 	struct nvmem_config cfg;
@@ -29,8 +47,98 @@ static int stm32_romem_read(void *context, unsigned int offset, void *buf,
 	return 0;
 }
 
+static int stm32_bsec_smc(u8 op, u32 otp, u32 data, u32 *result)
+{
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(STM32_SMC_BSEC, op, otp, data, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EIO;
+
+	if (result)
+		*result = (u32)res.a1;
+
+	return 0;
+#else
+	return -ENXIO;
+#endif
+}
+
+static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
+			   size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 roffset, rbytes, val;
+	u8 *buf8 = buf, *val8 = (u8 *)&val;
+	int i, j = 0, ret, skip_bytes, size;
+
+	/* Round unaligned access to 32-bits */
+	roffset = rounddown(offset, 4);
+	skip_bytes = offset & 0x3;
+	rbytes = roundup(bytes + skip_bytes, 4);
+
+	if (roffset + rbytes > priv->cfg.size)
+		return -EINVAL;
+
+	for (i = roffset; (i < roffset + rbytes); i += 4) {
+		u32 otp = i >> 2;
+
+		if (otp < STM32MP15_BSEC_NUM_LOWER) {
+			/* read lower data from shadow registers */
+			val = readl_relaxed(
+				priv->base + STM32MP15_BSEC_DATA0 + i);
+		} else {
+			ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, otp, 0,
+					     &val);
+			if (ret) {
+				dev_err(dev, "Can't read data%d (%d)\n", otp,
+					ret);
+				return ret;
+			}
+		}
+		/* skip first bytes in case of unaligned read */
+		if (skip_bytes)
+			size = min(bytes, (size_t)(4 - skip_bytes));
+		else
+			size = min(bytes, (size_t)4);
+		memcpy(&buf8[j], &val8[skip_bytes], size);
+		bytes -= size;
+		j += size;
+		skip_bytes = 0;
+	}
+
+	return 0;
+}
+
+static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
+			    size_t bytes)
+{
+	struct stm32_romem_priv *priv = context;
+	struct device *dev = priv->cfg.dev;
+	u32 *buf32 = buf;
+	int ret, i;
+
+	/* Allow only writing complete 32-bits aligned words */
+	if ((bytes % 4) || (offset % 4))
+		return -EINVAL;
+
+	for (i = offset; i < offset + bytes; i += 4) {
+		ret = stm32_bsec_smc(STM32_SMC_PROG_OTP, i >> 2, *buf32++,
+				     NULL);
+		if (ret) {
+			dev_err(dev, "Can't write data%d (%d)\n", i >> 2, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int stm32_romem_probe(struct platform_device *pdev)
 {
+	const struct stm32_romem_cfg *cfg;
 	struct device *dev = &pdev->dev;
 	struct stm32_romem_priv *priv;
 	struct resource *res;
@@ -45,21 +153,37 @@ static int stm32_romem_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->cfg.name = "stm32-romem";
-	priv->cfg.read_only = true;
 	priv->cfg.word_size = 1;
 	priv->cfg.stride = 1;
-	priv->cfg.size = resource_size(res);
-	priv->cfg.reg_read = stm32_romem_read;
 	priv->cfg.dev = dev;
 	priv->cfg.priv = priv;
 	priv->cfg.owner = THIS_MODULE;
 
+	cfg = (const struct stm32_romem_cfg *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
+	if (!cfg) {
+		priv->cfg.read_only = true;
+		priv->cfg.size = resource_size(res);
+		priv->cfg.reg_read = stm32_romem_read;
+	} else {
+		priv->cfg.size = cfg->size;
+		priv->cfg.reg_read = stm32_bsec_read;
+		priv->cfg.reg_write = stm32_bsec_write;
+	}
+
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &priv->cfg));
 }
 
+static const struct stm32_romem_cfg stm32mp15_bsec_cfg = {
+	.size = 384, /* 96 x 32-bits data words */
+};
+
 static const struct of_device_id stm32_romem_of_match[] = {
-	{ .compatible = "st,stm32f4-otp", },
-	{},
+	{ .compatible = "st,stm32f4-otp", }, {
+		.compatible = "st,stm32mp15-bsec",
+		.data = (void *)&stm32mp15_bsec_cfg,
+	}, {
+	},
 };
 MODULE_DEVICE_TABLE(of, stm32_romem_of_match);
 
-- 
2.7.4

