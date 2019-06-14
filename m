Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3295C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19120866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4MrwJm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfFNOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39289 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfFNOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so2784983wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/jl8n/4Hi7I84/RxTPRyUpUNxtWJ5MI2spuleKSocQ=;
        b=B4MrwJm761m+Cm3PbgoS46ikL4ODbyrleERo9RN5zwslHnmxExDdH/EuIyBwn+eowt
         sdaIuJ76CbXb8vfSpbMyMMqEK6vgWEWukzl3aQgnL4HcFdSnKAlJ8GgI5ViV8nhcKx9r
         HYA6tIp7hhf6PXQb2GL8eNq7tSzYAXf1Au3fnxLyqAp6KLrGFxckzlonL/kdLL6VxLvl
         9xsah9P5DURn+5ObMCl2mKNFqZGPIhNi9oWiGG0YBJwj4xlZOnPbkDukjvxkUa1XbId/
         lN5TXwIDYxF13QXcd9iZY2ytX09/eakU6bd7YzDSz+BHhVypioGvrZEkwLGgOViVET1T
         ed7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/jl8n/4Hi7I84/RxTPRyUpUNxtWJ5MI2spuleKSocQ=;
        b=g8fYkN1S1BiCHUA3IM6dTZ/GFm9lTcRbGXfjDgWhOZYGFebJDTUF4FHziJp9Cc+r7v
         Wv3MG/58DsH/G0kuFyXuUaBAyuL15tCM0vmB9ZCC7t/K5BLW8+y4am7LsbCk2umvOBjT
         OARm87tSH3eYprmL7vy/GREoxpRmyho9Ep0V9QqI8FNM4hc62Lj1m6z5SecSDtTVN6GP
         A+Z+U8oao4hWjWtOxNa7CCDkPnW50Bs/KiRcucTyn3yxVMARBOWArAIFdOYnXRrbkMpG
         56Vj4EriNxZi8ZpaWQP1jX6x10HPdoJEiEkraoUUladOHakEc2sxmoHc5EcngNpCiXLX
         E1zA==
X-Gm-Message-State: APjAAAWSeBPLFJrnjL0OZgQg2cFFxx2j5WkcwRU2SlAHVvJqMsVk1IsL
        0j5jSd7gfsiabZRanLUrocQErw==
X-Google-Smtp-Source: APXvYqzV8f/W63a8rb+YN3N1caz+U0FBhSKjsb09Ko087vyHpXbkB7VhEsXi7y7D7Mgy6huvrHwZVQ==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr61942112wrr.252.1560522747161;
        Fri, 14 Jun 2019 07:32:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nvmem: imx: add i.MX8 nvmem driver
Date:   Fri, 14 Jun 2019 15:32:19 +0100
Message-Id: <20190614143221.32035-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patch adds i.MX8 nvmem ocotp driver to access fuse via
RPC to i.MX8 system controller.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig         |   7 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/imx-ocotp-scu.c | 161 ++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/nvmem/imx-ocotp-scu.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6b2c4254c2fb..82a07c24e1db 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -46,6 +46,13 @@ config NVMEM_IMX_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-imx-ocotp.
 
+config NVMEM_IMX_OCOTP_SCU
+	tristate "i.MX8 SCU On-Chip OTP Controller support"
+	depends on IMX_SCU
+	help
+	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
+	  available on i.MX8 SoCs.
+
 config NVMEM_LPC18XX_EEPROM
 	tristate "NXP LPC18XX EEPROM Memory Support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index c1fe4768dfef..e5c153d99a67 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)	+= nvmem-imx-iim.o
 nvmem-imx-iim-y			:= imx-iim.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y		:= imx-ocotp.o
+obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
+nvmem-imx-ocotp-scu-y		:= imx-ocotp-scu.o
 obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)	+= nvmem_lpc18xx_otp.o
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
new file mode 100644
index 000000000000..d9dc482ecb2f
--- /dev/null
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * i.MX8 OCOTP fusebox driver
+ *
+ * Copyright 2019 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum ocotp_devtype {
+	IMX8QXP,
+};
+
+struct ocotp_devtype_data {
+	int devtype;
+	int nregs;
+};
+
+struct ocotp_priv {
+	struct device *dev;
+	const struct ocotp_devtype_data *data;
+	struct imx_sc_ipc *nvmem_ipc;
+};
+
+struct imx_sc_msg_misc_fuse_read {
+	struct imx_sc_rpc_msg hdr;
+	u32 word;
+} __packed;
+
+static struct ocotp_devtype_data imx8qxp_data = {
+	.devtype = IMX8QXP,
+	.nregs = 800,
+};
+
+static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
+				     u32 *val)
+{
+	struct imx_sc_msg_misc_fuse_read msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_MISC;
+	hdr->func = IMX_SC_MISC_FUNC_OTP_FUSE_READ;
+	hdr->size = 2;
+
+	msg.word = word;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	*val = msg.word;
+
+	return 0;
+}
+
+static int imx_scu_ocotp_read(void *context, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct ocotp_priv *priv = context;
+	u32 count, index, num_bytes;
+	u32 *buf;
+	void *p;
+	int i, ret;
+
+	index = offset >> 2;
+	num_bytes = round_up((offset % 4) + bytes, 4);
+	count = num_bytes >> 2;
+
+	if (count > (priv->data->nregs - index))
+		count = priv->data->nregs - index;
+
+	p = kzalloc(num_bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	buf = p;
+
+	for (i = index; i < (index + count); i++) {
+		if (priv->data->devtype == IMX8QXP) {
+			if ((i > 271) && (i < 544)) {
+				*buf++ = 0;
+				continue;
+			}
+		}
+
+		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
+		if (ret) {
+			kfree(p);
+			return ret;
+		}
+		buf++;
+	}
+
+	memcpy(val, (u8 *)p + offset % 4, bytes);
+
+	kfree(p);
+
+	return 0;
+}
+
+static struct nvmem_config imx_scu_ocotp_nvmem_config = {
+	.name = "imx-scu-ocotp",
+	.read_only = true,
+	.word_size = 4,
+	.stride = 1,
+	.owner = THIS_MODULE,
+	.reg_read = imx_scu_ocotp_read,
+};
+
+static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
+
+static int imx_scu_ocotp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ocotp_priv *priv;
+	struct nvmem_device *nvmem;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = imx_scu_get_handle(&priv->nvmem_ipc);
+	if (ret)
+		return ret;
+
+	priv->data = of_device_get_match_data(dev);
+	priv->dev = dev;
+	imx_scu_ocotp_nvmem_config.size = 4 * priv->data->nregs;
+	imx_scu_ocotp_nvmem_config.dev = dev;
+	imx_scu_ocotp_nvmem_config.priv = priv;
+	nvmem = devm_nvmem_register(dev, &imx_scu_ocotp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static struct platform_driver imx_scu_ocotp_driver = {
+	.probe	= imx_scu_ocotp_probe,
+	.driver = {
+		.name	= "imx_scu_ocotp",
+		.of_match_table = imx_scu_ocotp_dt_ids,
+	},
+};
+module_platform_driver(imx_scu_ocotp_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX8 SCU OCOTP fuse box driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

