Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF26920821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEqfC1aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDST5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:57:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41623 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDST5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:57:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so2956365pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=D21cMRWQI3hPl9EyHwVboeMdyxzoYOQ3w/Nj8Wi/rwg=;
        b=KEqfC1ajWVCLXhHMMb5JbDr27wjcQaXGquziLXSDfSycPb+Tw00LPeFrx49LVjU8yX
         EQDwunVVC2iEmP7kFlVfVgw3mL/QULX10azrG8YuSpkNsO3m2NASx0cJCrQDjvAgXpva
         uimIGH9UxnX5bMJIN4509dqmbVojLIz7T2xMTGfI29q6+qqXXNS+VDdE6SRc+tZuwcEh
         SIIkGEO1HrmfBKv9zT5OfzbB7ys63aATpEBcTV6LhbVmbKdfudJdUBxm9E6kYJoJTcD3
         mWwerPn53fTq9HCCx24J/2jLC6n0tRe2ssbg1ANr35pJmaVDfXN0Mh+c1U1QHmEHsEP7
         MuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D21cMRWQI3hPl9EyHwVboeMdyxzoYOQ3w/Nj8Wi/rwg=;
        b=ORnagHzoj2FMHm1mLvfDpZBrgoTqxZLLjxrjdgYwUtis3Uprqc2vX/f+1IfKJIZwUG
         JYRsRkAvh6sbCa0Wsqs5fPRG26ID2wkd5fmzILqUY7SOjN3pKC24rBYP5npNxYKZrlIp
         /tE9azCSFVxyXZS8oPLxeU0QubQcB+5gKkbQeanUi5pZe0XF0dn/3X9d52eyoidgO+K1
         oGeNIEAe3sPusM+R5sIXmyoX824PKhvBpEhFyZrRFEhr/L6S0kx2GBabvsg2PDWov7AP
         qDSmU3P2MAfMLVdFu2xH7lpBxCz4zErgUPRr8PWGkmnz8EfctcHfW/xbhOqw6A/a6gsS
         yDVQ==
X-Gm-Message-State: APjAAAX1uyl2+hwtpkPBeOMNHM/BdvPupk1BRaLWjgBG0sAIx4zLA1bX
        ABcDfInsO6ZM7B2a0xk1CVf7Yw==
X-Google-Smtp-Source: APXvYqzcM8eSWGCQYGklEo8Av1yVuSTkfGZaLpR29G1sMAzbL7Tj+5yXCmZOeQheWXyRPQ7WBOA05Q==
X-Received: by 2002:a63:1d45:: with SMTP id d5mr3206594pgm.184.1555671293108;
        Fri, 19 Apr 2019 03:54:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v189sm6890820pgd.77.2019.04.19.03.54.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 03:54:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     broonie@kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: sprd: Add Spreadtrum multi-channel data transfer support
Date:   Fri, 19 Apr 2019 18:54:32 +0800
Message-Id: <64ca5af0373c35590d8ac9f2b62e3c9fa46e3551.1555670768.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
References: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
In-Reply-To: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
References: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum platform, the audio subsystem will use the multi-channel
data transfer controller to transfer sound stream between audio subsystem
and other AP/CP subsystem.

It can support 10 DAC channel and 10 ADC channel, and each channel has
512 bytes depth data fifo. Moreover each channel can be used DMA mode
or interrupt mode to transfer data.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/soc/Kconfig           |    1 +
 drivers/soc/Makefile          |    1 +
 drivers/soc/sprd/Kconfig      |   12 +
 drivers/soc/sprd/Makefile     |    5 +
 drivers/soc/sprd/mcdt.c       | 1010 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/sprd/mcdt.h |  107 +++++
 6 files changed, 1136 insertions(+)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/mcdt.c
 create mode 100644 include/linux/soc/sprd/mcdt.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a8..4fc89de 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -11,6 +11,7 @@ source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
+source "drivers/soc/sprd/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 90b686e..fce8249 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -18,6 +18,7 @@ obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
+obj-y				+= sprd/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
diff --git a/drivers/soc/sprd/Kconfig b/drivers/soc/sprd/Kconfig
new file mode 100644
index 0000000..95fb7fb
--- /dev/null
+++ b/drivers/soc/sprd/Kconfig
@@ -0,0 +1,12 @@
+if ARCH_SPRD || COMPILE_TEST
+
+config SPRD_MCDT
+	bool "Spreadtrum multi-channel data transfer support"
+	help
+	  Say y here to enable multi-channel data transfer support. It
+	  is used for sound stream transmission between audio subsystem
+	  and other AP/CP subsystem.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/soc/sprd/Makefile b/drivers/soc/sprd/Makefile
new file mode 100644
index 0000000..696ba27
--- /dev/null
+++ b/drivers/soc/sprd/Makefile
@@ -0,0 +1,5 @@
+#
+# Spreadtrum Soc drivers
+#
+
+obj-$(CONFIG_SPRD_MCDT) += mcdt.o
diff --git a/drivers/soc/sprd/mcdt.c b/drivers/soc/sprd/mcdt.c
new file mode 100644
index 0000000..2377b29
--- /dev/null
+++ b/drivers/soc/sprd/mcdt.c
@@ -0,0 +1,1010 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/soc/sprd/mcdt.h>
+
+/* MCDT registers definition */
+#define MCDT_CH0_TXD		0x0
+#define MCDT_CH0_RXD		0x28
+#define MCDT_DAC0_WTMK		0x60
+#define MCDT_ADC0_WTMK		0x88
+#define MCDT_DMA_EN		0xb0
+
+#define MCDT_INT_EN0		0xb4
+#define MCDT_INT_EN1		0xb8
+#define MCDT_INT_EN2		0xbc
+
+#define MCDT_INT_CLR0		0xc0
+#define MCDT_INT_CLR1		0xc4
+#define MCDT_INT_CLR2		0xc8
+
+#define MCDT_INT_RAW1		0xcc
+#define MCDT_INT_RAW2		0xd0
+#define MCDT_INT_RAW3		0xd4
+
+#define MCDT_INT_MSK1		0xd8
+#define MCDT_INT_MSK2		0xdc
+#define MCDT_INT_MSK3		0xe0
+
+#define MCDT_DAC0_FIFO_ADDR_ST	0xe4
+#define MCDT_ADC0_FIFO_ADDR_ST	0xe8
+
+#define MCDT_CH_FIFO_ST0	0x134
+#define MCDT_CH_FIFO_ST1	0x138
+#define MCDT_CH_FIFO_ST2	0x13c
+
+#define MCDT_INT_MSK_CFG0	0x140
+#define MCDT_INT_MSK_CFG1	0x144
+
+#define MCDT_DMA_CFG0		0x148
+#define MCDT_FIFO_CLR		0x14c
+#define MCDT_DMA_CFG1		0x150
+#define MCDT_DMA_CFG2		0x154
+#define MCDT_DMA_CFG3		0x158
+#define MCDT_DMA_CFG4		0x15c
+#define MCDT_DMA_CFG5		0x160
+
+/* Channel water mark definition */
+#define MCDT_CH_FIFO_AE_SHIFT	16
+#define MCDT_CH_FIFO_AE_MASK	GENMASK(24, 16)
+#define MCDT_CH_FIFO_AF_MASK	GENMASK(8, 0)
+
+/* DMA channel select definition */
+#define MCDT_DMA_CH0_SEL_MASK	GENMASK(3, 0)
+#define MCDT_DMA_CH0_SEL_SHIFT	0
+#define MCDT_DMA_CH1_SEL_MASK	GENMASK(7, 4)
+#define MCDT_DMA_CH1_SEL_SHIFT	4
+#define MCDT_DMA_CH2_SEL_MASK	GENMASK(11, 8)
+#define MCDT_DMA_CH2_SEL_SHIFT	8
+#define MCDT_DMA_CH3_SEL_MASK	GENMASK(15, 12)
+#define MCDT_DMA_CH3_SEL_SHIFT	12
+#define MCDT_DMA_CH4_SEL_MASK	GENMASK(19, 16)
+#define MCDT_DMA_CH4_SEL_SHIFT	16
+#define MCDT_DAC_DMA_SHIFT	16
+
+/* DMA channel ACK select definition */
+#define MCDT_DMA_ACK_SEL_MASK	GENMASK(3, 0)
+
+/* Channel FIFO definition */
+#define MCDT_CH_FIFO_ADDR_SHIFT	16
+#define MCDT_CH_FIFO_ADDR_MASK	GENMASK(9, 0)
+#define MCDT_ADC_FIFO_SHIFT	16
+#define MCDT_FIFO_LENGTH	512
+
+#define MCDT_ADC_CHANNEL_NUM	10
+#define MCDT_DAC_CHANNEL_NUM	10
+#define MCDT_CHANNEL_NUM	(MCDT_ADC_CHANNEL_NUM + MCDT_DAC_CHANNEL_NUM)
+
+enum sprd_mcdt_fifo_int {
+	MCDT_ADC_FIFO_AE_INT,
+	MCDT_ADC_FIFO_AF_INT,
+	MCDT_DAC_FIFO_AE_INT,
+	MCDT_DAC_FIFO_AF_INT,
+	MCDT_ADC_FIFO_OV_INT,
+	MCDT_DAC_FIFO_OV_INT
+};
+
+enum sprd_mcdt_fifo_sts {
+	MCDT_ADC_FIFO_REAL_FULL,
+	MCDT_ADC_FIFO_REAL_EMPTY,
+	MCDT_ADC_FIFO_AF,
+	MCDT_ADC_FIFO_AE,
+	MCDT_DAC_FIFO_REAL_FULL,
+	MCDT_DAC_FIFO_REAL_EMPTY,
+	MCDT_DAC_FIFO_AF,
+	MCDT_DAC_FIFO_AE
+};
+
+struct sprd_mcdt_dev {
+	struct device *dev;
+	void __iomem *base;
+	spinlock_t lock;
+	struct sprd_mcdt_chan chan[MCDT_CHANNEL_NUM];
+};
+
+static LIST_HEAD(sprd_mcdt_chan_list);
+static DEFINE_MUTEX(sprd_mcdt_list_mutex);
+
+static void sprd_mcdt_update(struct sprd_mcdt_dev *mcdt, u32 reg, u32 val,
+			     u32 mask)
+{
+	u32 orig = readl_relaxed(mcdt->base + reg);
+	u32 tmp;
+
+	tmp = (orig & ~mask) | val;
+	writel_relaxed(tmp, mcdt->base + reg);
+}
+
+static void sprd_mcdt_dac_set_watermark(struct sprd_mcdt_dev *mcdt, u8 channel,
+					u32 full, u32 empty)
+{
+	u32 reg = MCDT_DAC0_WTMK + channel * 4;
+	u32 water_mark =
+		(empty << MCDT_CH_FIFO_AE_SHIFT) & MCDT_CH_FIFO_AE_MASK;
+
+	water_mark |= full & MCDT_CH_FIFO_AF_MASK;
+	sprd_mcdt_update(mcdt, reg, water_mark,
+			 MCDT_CH_FIFO_AE_MASK | MCDT_CH_FIFO_AF_MASK);
+}
+
+static void sprd_mcdt_adc_set_watermark(struct sprd_mcdt_dev *mcdt, u8 channel,
+					u32 full, u32 empty)
+{
+	u32 reg = MCDT_ADC0_WTMK + channel * 4;
+	u32 water_mark =
+		(empty << MCDT_CH_FIFO_AE_SHIFT) & MCDT_CH_FIFO_AE_MASK;
+
+	water_mark |= full & MCDT_CH_FIFO_AF_MASK;
+	sprd_mcdt_update(mcdt, reg, water_mark,
+			 MCDT_CH_FIFO_AE_MASK | MCDT_CH_FIFO_AF_MASK);
+}
+
+static void sprd_mcdt_dac_dma_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     bool enable)
+{
+	u32 shift = MCDT_DAC_DMA_SHIFT + channel;
+
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, BIT(shift), BIT(shift));
+	else
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, 0, BIT(shift));
+}
+
+static void sprd_mcdt_adc_dma_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     bool enable)
+{
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, BIT(channel), BIT(channel));
+	else
+		sprd_mcdt_update(mcdt, MCDT_DMA_EN, 0, BIT(channel));
+}
+
+static void sprd_mcdt_ap_int_enable(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    bool enable)
+{
+	if (enable)
+		sprd_mcdt_update(mcdt, MCDT_INT_MSK_CFG0, BIT(channel),
+				 BIT(channel));
+	else
+		sprd_mcdt_update(mcdt, MCDT_INT_MSK_CFG0, 0, BIT(channel));
+}
+
+static void sprd_mcdt_dac_write_fifo(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     u32 val)
+{
+	u32 reg = MCDT_CH0_TXD + channel * 4;
+
+	writel_relaxed(val, mcdt->base + reg);
+}
+
+static void sprd_mcdt_adc_read_fifo(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    u32 *val)
+{
+	u32 reg = MCDT_CH0_RXD + channel * 4;
+
+	*val = readl_relaxed(mcdt->base + reg);
+}
+
+static void sprd_mcdt_dac_dma_chn_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	switch (dma_chan) {
+	case SPRD_MCDT_DMA_CH0:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH0_SEL_SHIFT,
+				 MCDT_DMA_CH0_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH1:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH1_SEL_SHIFT,
+				 MCDT_DMA_CH1_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH2:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH2_SEL_SHIFT,
+				 MCDT_DMA_CH2_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH3:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH3_SEL_SHIFT,
+				 MCDT_DMA_CH3_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH4:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG0,
+				 channel << MCDT_DMA_CH4_SEL_SHIFT,
+				 MCDT_DMA_CH4_SEL_MASK);
+		break;
+	}
+}
+
+static void sprd_mcdt_adc_dma_chn_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	switch (dma_chan) {
+	case SPRD_MCDT_DMA_CH0:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH0_SEL_SHIFT,
+				 MCDT_DMA_CH0_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH1:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH1_SEL_SHIFT,
+				 MCDT_DMA_CH1_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH2:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH2_SEL_SHIFT,
+				 MCDT_DMA_CH2_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH3:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH3_SEL_SHIFT,
+				 MCDT_DMA_CH3_SEL_MASK);
+		break;
+
+	case SPRD_MCDT_DMA_CH4:
+		sprd_mcdt_update(mcdt, MCDT_DMA_CFG1,
+				 channel << MCDT_DMA_CH4_SEL_SHIFT,
+				 MCDT_DMA_CH4_SEL_MASK);
+		break;
+	}
+}
+
+static u32 sprd_mcdt_dma_ack_shift(u8 channel)
+{
+	switch (channel) {
+	default:
+	case 0:
+	case 8:
+		return 0;
+	case 1:
+	case 9:
+		return 4;
+	case 2:
+		return 8;
+	case 3:
+		return 12;
+	case 4:
+		return 16;
+	case 5:
+		return 20;
+	case 6:
+		return 24;
+	case 7:
+		return 28;
+	}
+}
+
+static void sprd_mcdt_dac_dma_ack_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	u32 reg, shift = sprd_mcdt_dma_ack_shift(channel), ack = dma_chan;
+
+	switch (channel) {
+	case 0 ... 7:
+		reg = MCDT_DMA_CFG2;
+		break;
+
+	case 8 ... 9:
+		reg = MCDT_DMA_CFG3;
+		break;
+
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, ack << shift,
+			 MCDT_DMA_ACK_SEL_MASK << shift);
+}
+
+static void sprd_mcdt_adc_dma_ack_select(struct sprd_mcdt_dev *mcdt, u8 channel,
+					 enum sprd_mcdt_dma_chan dma_chan)
+{
+	u32 reg, shift = sprd_mcdt_dma_ack_shift(channel), ack = dma_chan;
+
+	switch (channel) {
+	case 0 ... 7:
+		reg = MCDT_DMA_CFG4;
+		break;
+
+	case 8 ... 9:
+		reg = MCDT_DMA_CFG5;
+		break;
+
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, ack << shift,
+			 MCDT_DMA_ACK_SEL_MASK << shift);
+}
+
+static bool sprd_mcdt_chan_fifo_sts(struct sprd_mcdt_dev *mcdt, u8 channel,
+				    enum sprd_mcdt_fifo_sts fifo_sts)
+{
+	u32 reg, shift;
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_CH_FIFO_ST0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_CH_FIFO_ST1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_CH_FIFO_ST2;
+		break;
+	default:
+		return false;
+	}
+
+	switch (channel) {
+	case 0:
+	case 4:
+	case 8:
+		shift = fifo_sts;
+		break;
+
+	case 1:
+	case 5:
+	case 9:
+		shift = 8 + fifo_sts;
+		break;
+
+	case 2:
+	case 6:
+		shift = 16 + fifo_sts;
+		break;
+
+	case 3:
+	case 7:
+		shift = 24 + fifo_sts;
+		break;
+
+	default:
+		return false;
+	}
+
+	return !!(readl_relaxed(mcdt->base + reg) & BIT(shift));
+}
+
+static void sprd_mcdt_dac_fifo_clear(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	sprd_mcdt_update(mcdt, MCDT_FIFO_CLR, BIT(channel), BIT(channel));
+}
+
+static void sprd_mcdt_adc_fifo_clear(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 shift = MCDT_ADC_FIFO_SHIFT + channel;
+
+	sprd_mcdt_update(mcdt, MCDT_FIFO_CLR, BIT(shift), BIT(shift));
+}
+
+static u32 sprd_mcdt_dac_fifo_avail(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 reg = MCDT_DAC0_FIFO_ADDR_ST + channel * 8;
+	u32 r_addr = (readl_relaxed(mcdt->base + reg) >>
+		      MCDT_CH_FIFO_ADDR_SHIFT) & MCDT_CH_FIFO_ADDR_MASK;
+	u32 w_addr = readl_relaxed(mcdt->base + reg) & MCDT_CH_FIFO_ADDR_MASK;
+
+	if (w_addr >= r_addr)
+		return 4 * (MCDT_FIFO_LENGTH - w_addr + r_addr);
+	else
+		return 4 * (r_addr - w_addr);
+}
+
+static u32 sprd_mcdt_adc_fifo_avail(struct sprd_mcdt_dev *mcdt, u8 channel)
+{
+	u32 reg = MCDT_ADC0_FIFO_ADDR_ST + channel * 8;
+	u32 r_addr = (readl_relaxed(mcdt->base + reg) >>
+		      MCDT_CH_FIFO_ADDR_SHIFT) & MCDT_CH_FIFO_ADDR_MASK;
+	u32 w_addr = readl_relaxed(mcdt->base + reg) & MCDT_CH_FIFO_ADDR_MASK;
+
+	if (w_addr >= r_addr)
+		return 4 * (w_addr - r_addr);
+	else
+		return 4 * (MCDT_FIFO_LENGTH - r_addr + w_addr);
+}
+
+static u32 sprd_mcdt_int_type_shift(u8 channel,
+				    enum sprd_mcdt_fifo_int int_type)
+{
+	switch (channel) {
+	case 0:
+	case 4:
+	case 8:
+		return int_type;
+
+	case 1:
+	case 5:
+	case 9:
+		return  8 + int_type;
+
+	case 2:
+	case 6:
+		return 16 + int_type;
+
+	case 3:
+	case 7:
+		return 24 + int_type;
+
+	default:
+		return 0;
+	}
+}
+
+static void sprd_mcdt_chan_int_en(struct sprd_mcdt_dev *mcdt, u8 channel,
+				  enum sprd_mcdt_fifo_int int_type, bool enable)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_EN0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_EN1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_EN2;
+		break;
+	default:
+		return;
+	}
+
+	if (enable)
+		sprd_mcdt_update(mcdt, reg, BIT(shift), BIT(shift));
+	else
+		sprd_mcdt_update(mcdt, reg, 0, BIT(shift));
+}
+
+static void sprd_mcdt_chan_int_clear(struct sprd_mcdt_dev *mcdt, u8 channel,
+				     enum sprd_mcdt_fifo_int int_type)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_CLR0;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_CLR1;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_CLR2;
+		break;
+	default:
+		return;
+	}
+
+	sprd_mcdt_update(mcdt, reg, BIT(shift), BIT(shift));
+}
+
+static bool sprd_mcdt_chan_int_sts(struct sprd_mcdt_dev *mcdt, u8 channel,
+				   enum sprd_mcdt_fifo_int int_type)
+{
+	u32 reg, shift = sprd_mcdt_int_type_shift(channel, int_type);
+
+	switch (channel) {
+	case 0 ... 3:
+		reg = MCDT_INT_MSK1;
+		break;
+	case 4 ... 7:
+		reg = MCDT_INT_MSK2;
+		break;
+	case 8 ... 9:
+		reg = MCDT_INT_MSK3;
+		break;
+	default:
+		return false;
+	}
+
+	return !!(readl_relaxed(mcdt->base + reg) & BIT(shift));
+}
+
+static irqreturn_t sprd_mcdt_irq_handler(int irq, void *dev_id)
+{
+	struct sprd_mcdt_dev *mcdt = (struct sprd_mcdt_dev *)dev_id;
+	int i;
+
+	spin_lock(&mcdt->lock);
+
+	for (i = 0; i < MCDT_ADC_CHANNEL_NUM; i++) {
+		if (sprd_mcdt_chan_int_sts(mcdt, i, MCDT_ADC_FIFO_AF_INT)) {
+			struct sprd_mcdt_chan *chan = &mcdt->chan[i];
+
+			sprd_mcdt_chan_int_clear(mcdt, i, MCDT_ADC_FIFO_AF_INT);
+			if (chan->cb)
+				chan->cb->notify(chan->cb->data);
+		}
+	}
+
+	for (i = 0; i < MCDT_DAC_CHANNEL_NUM; i++) {
+		if (sprd_mcdt_chan_int_sts(mcdt, i, MCDT_DAC_FIFO_AE_INT)) {
+			struct sprd_mcdt_chan *chan =
+				&mcdt->chan[i + MCDT_ADC_CHANNEL_NUM];
+
+			sprd_mcdt_chan_int_clear(mcdt, i, MCDT_DAC_FIFO_AE_INT);
+			if (chan->cb)
+				chan->cb->notify(chan->cb->data);
+		}
+	}
+
+	spin_unlock(&mcdt->lock);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * sprd_mcdt_chan_write - write data to the MCDT channel's fifo
+ * @chan: the MCDT channel
+ * @tx_buf: send buffer
+ * @size: data size
+ *
+ * Note: We can not write data to the channel fifo when enabling the DMA mode,
+ * otherwise the channel fifo data will be invalid.
+ *
+ * If there are not enough space of the channel fifo, it will return errors
+ * to users.
+ *
+ * Returns 0 on success, or an appropriate error code on failure.
+ */
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int avail, i = 0, words = size / 4;
+	u32 *buf = (u32 *)tx_buf;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable) {
+		dev_err(mcdt->dev,
+			"Can not write data when DMA mode enabled\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	if (sprd_mcdt_chan_fifo_sts(mcdt, chan->id, MCDT_DAC_FIFO_REAL_FULL)) {
+		dev_err(mcdt->dev, "Channel fifo is full now\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	avail = sprd_mcdt_dac_fifo_avail(mcdt, chan->id);
+	if (size > avail) {
+		dev_err(mcdt->dev,
+			"Data size is larger than the available fifo size\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	while (i++ < words)
+		sprd_mcdt_dac_write_fifo(mcdt, chan->id, *buf++);
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_write);
+
+/**
+ * sprd_mcdt_chan_read - read data from the MCDT channel's fifo
+ * @chan: the MCDT channel
+ * @rx_buf: receive buffer
+ * @size: data size
+ *
+ * Note: We can not read data from the channel fifo when enabling the DMA mode,
+ * otherwise the reading data will be invalid.
+ *
+ * Usually user need start to read data once receiving the fifo full interrupt.
+ *
+ * Returns data size of reading successfully, or an error code on failure.
+ */
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int i = 0, avail, words = size / 4;
+	u32 *buf = (u32 *)rx_buf;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable) {
+		dev_err(mcdt->dev, "Can not read data when DMA mode enabled\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	if (sprd_mcdt_chan_fifo_sts(mcdt, chan->id, MCDT_ADC_FIFO_REAL_EMPTY)) {
+		dev_err(mcdt->dev, "Channel fifo is empty\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EBUSY;
+	}
+
+	avail = sprd_mcdt_adc_fifo_avail(mcdt, chan->id);
+	if (size > avail)
+		words = avail / 4;
+
+	while (i++ < words)
+		sprd_mcdt_adc_read_fifo(mcdt, chan->id, buf++);
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+	return words * 4;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_read);
+
+/**
+ * sprd_mcdt_chan_int_enable - enable the interrupt mode for the MCDT channel
+ * @chan: the MCDT channel
+ * @water_mark: water mark to trigger a interrupt
+ * @cb: callback when a interrupt happened
+ *
+ * Now it only can enable fifo almost full interrupt for ADC channel and fifo
+ * almost empty interrupt for DAC channel. Morevoer for interrupt mode, user
+ * should use sprd_mcdt_chan_read() or sprd_mcdt_chan_write() to read or write
+ * data manually.
+ *
+ * For ADC channel, user can start to read data once receiving one fifo full
+ * interrupt. For DAC channel, user can start to write data once receiving one
+ * fifo empty interrupt or just call sprd_mcdt_chan_write() to write data
+ * directly.
+ *
+ * Returns 0 on success, or an error code on failure.
+ */
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable || chan->int_enable) {
+		dev_err(mcdt->dev, "Failed to set interrupt mode.\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_adc_set_watermark(mcdt, chan->id, water_mark,
+					    MCDT_FIFO_LENGTH - 1);
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_ADC_FIFO_AF_INT, true);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, true);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_dac_set_watermark(mcdt, chan->id,
+					    MCDT_FIFO_LENGTH - 1, water_mark);
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_DAC_FIFO_AE_INT, true);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, true);
+		break;
+
+	default:
+		dev_err(mcdt->dev, "Unsupported channel type\n");
+		ret = -EINVAL;
+	}
+
+	if (!ret) {
+		chan->cb = cb;
+		chan->int_enable = true;
+	}
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_int_enable);
+
+/**
+ * sprd_mcdt_chan_int_disable - disable the interrupt mode for the MCDT channel
+ * @chan: the MCDT channel
+ */
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (!chan->int_enable) {
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_ADC_FIFO_AF_INT, false);
+		sprd_mcdt_chan_int_clear(mcdt, chan->id, MCDT_ADC_FIFO_AF_INT);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, false);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_chan_int_en(mcdt, chan->id,
+				      MCDT_DAC_FIFO_AE_INT, false);
+		sprd_mcdt_chan_int_clear(mcdt, chan->id, MCDT_DAC_FIFO_AE_INT);
+		sprd_mcdt_ap_int_enable(mcdt, chan->id, false);
+		break;
+
+	default:
+		break;
+	}
+
+	chan->int_enable = false;
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_int_disable);
+
+/**
+ * sprd_mcdt_chan_dma_enable - enable the DMA mode for the MCDT channel
+ * @chan: the MCDT channel
+ * @dma_chan: specify which DMA channel will be used for this MCDT channel
+ * @water_mark: water mark to trigger a DMA request
+ *
+ * Enable the DMA mode for the MCDT channel, that means we can use DMA to
+ * transfer data to the channel fifo and do not need reading/writing data
+ * manually.
+ *
+ * Returns 0 on success, or an error code on failure.
+ */
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan,
+			      u32 water_mark)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (chan->dma_enable || chan->int_enable ||
+	    dma_chan > SPRD_MCDT_DMA_CH4) {
+		dev_err(mcdt->dev, "Failed to set DMA mode\n");
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return -EINVAL;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_adc_set_watermark(mcdt, chan->id,
+					    water_mark, MCDT_FIFO_LENGTH - 1);
+		sprd_mcdt_adc_dma_enable(mcdt, chan->id, true);
+		sprd_mcdt_adc_dma_chn_select(mcdt, chan->id, dma_chan);
+		sprd_mcdt_adc_dma_ack_select(mcdt, chan->id, dma_chan);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		sprd_mcdt_dac_set_watermark(mcdt, chan->id,
+					    MCDT_FIFO_LENGTH - 1, water_mark);
+		sprd_mcdt_dac_dma_enable(mcdt, chan->id, true);
+		sprd_mcdt_dac_dma_chn_select(mcdt, chan->id, dma_chan);
+		sprd_mcdt_dac_dma_ack_select(mcdt, chan->id, dma_chan);
+		break;
+
+	default:
+		dev_err(mcdt->dev, "Unsupported channel type\n");
+		ret = -EINVAL;
+	}
+
+	if (!ret)
+		chan->dma_enable = true;
+
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_enable);
+
+/**
+ * sprd_mcdt_chan_dma_disable - disable the DMA mode for the MCDT channel
+ * @chan: the MCDT channel
+ */
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_dev *mcdt = chan->mcdt;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcdt->lock, flags);
+
+	if (!chan->dma_enable) {
+		spin_unlock_irqrestore(&mcdt->lock, flags);
+		return;
+	}
+
+	switch (chan->type) {
+	case SPRD_MCDT_ADC_CHAN:
+		sprd_mcdt_adc_dma_enable(mcdt, chan->id, false);
+		sprd_mcdt_adc_fifo_clear(mcdt, chan->id);
+		break;
+
+	case SPRD_MCDT_DAC_CHAN:
+		sprd_mcdt_dac_dma_enable(mcdt, chan->id, false);
+		sprd_mcdt_dac_fifo_clear(mcdt, chan->id);
+		break;
+
+	default:
+		break;
+	}
+
+	chan->dma_enable = false;
+	spin_unlock_irqrestore(&mcdt->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_chan_dma_disable);
+
+/**
+ * sprd_mcdt_request_chan - request one MCDT channel
+ * @channel: channel id
+ * @type: channel type, it can be one ADC channel or DAC channel
+ *
+ * Rreturn NULL if no available channel.
+ */
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type)
+{
+	struct sprd_mcdt_chan *temp, *chan = NULL;
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
+		if (temp->type == type && temp->id == channel) {
+			chan = temp;
+			break;
+		}
+	}
+
+	if (chan)
+		list_del(&chan->list);
+
+	mutex_unlock(&sprd_mcdt_list_mutex);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_request_chan);
+
+/**
+ * sprd_mcdt_free_chan - free one MCDT channel
+ * @chan: the channel to be freed
+ */
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan)
+{
+	struct sprd_mcdt_chan *temp;
+
+	sprd_mcdt_chan_dma_disable(chan);
+	sprd_mcdt_chan_int_disable(chan);
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list) {
+		if (temp == chan) {
+			mutex_unlock(&sprd_mcdt_list_mutex);
+			return;
+		}
+	}
+
+	list_add_tail(&chan->list, &sprd_mcdt_chan_list);
+	mutex_unlock(&sprd_mcdt_list_mutex);
+}
+EXPORT_SYMBOL_GPL(sprd_mcdt_free_chan);
+
+static void sprd_mcdt_init_chans(struct sprd_mcdt_dev *mcdt,
+				 struct resource *res)
+{
+	int i;
+
+	for (i = 0; i < MCDT_CHANNEL_NUM; i++) {
+		struct sprd_mcdt_chan *chan = &mcdt->chan[i];
+
+		if (i < MCDT_ADC_CHANNEL_NUM) {
+			chan->id = i;
+			chan->type = SPRD_MCDT_ADC_CHAN;
+			chan->fifo_phys = res->start + MCDT_CH0_RXD + i * 4;
+		} else {
+			chan->id = i - MCDT_ADC_CHANNEL_NUM;
+			chan->type = SPRD_MCDT_DAC_CHAN;
+			chan->fifo_phys = res->start + MCDT_CH0_TXD +
+				(i - MCDT_ADC_CHANNEL_NUM) * 4;
+		}
+
+		chan->mcdt = mcdt;
+		INIT_LIST_HEAD(&chan->list);
+
+		mutex_lock(&sprd_mcdt_list_mutex);
+		list_add_tail(&chan->list, &sprd_mcdt_chan_list);
+		mutex_unlock(&sprd_mcdt_list_mutex);
+	}
+}
+
+static int sprd_mcdt_probe(struct platform_device *pdev)
+{
+	struct sprd_mcdt_dev *mcdt;
+	struct resource *res;
+	int ret, irq;
+
+	mcdt = devm_kzalloc(&pdev->dev, sizeof(*mcdt), GFP_KERNEL);
+	if (!mcdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mcdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!mcdt->base)
+		return -ENOMEM;
+
+	mcdt->dev = &pdev->dev;
+	spin_lock_init(&mcdt->lock);
+	platform_set_drvdata(pdev, mcdt);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get MCDT interrupt\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, sprd_mcdt_irq_handler,
+			       0, "sprd-mcdt", mcdt);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request MCDT IRQ\n");
+		return ret;
+	}
+
+	sprd_mcdt_init_chans(mcdt, res);
+
+	return 0;
+}
+
+static int sprd_mcdt_remove(struct platform_device *pdev)
+{
+	struct sprd_mcdt_chan *temp;
+
+	mutex_lock(&sprd_mcdt_list_mutex);
+
+	list_for_each_entry(temp, &sprd_mcdt_chan_list, list)
+		list_del(&temp->list);
+
+	mutex_unlock(&sprd_mcdt_list_mutex);
+
+	return 0;
+}
+
+static const struct of_device_id sprd_mcdt_of_match[] = {
+	{ .compatible = "sprd,sc9860-mcdt", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sprd_mcdt_of_match);
+
+static struct platform_driver sprd_mcdt_driver = {
+	.probe = sprd_mcdt_probe,
+	.remove = sprd_mcdt_remove,
+	.driver = {
+		.name = "sprd-mcdt",
+		.of_match_table = sprd_mcdt_of_match,
+	},
+};
+
+module_platform_driver(sprd_mcdt_driver);
+
+MODULE_DESCRIPTION("Spreadtrum Multi-Channel Data Transfer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/sprd/mcdt.h b/include/linux/soc/sprd/mcdt.h
new file mode 100644
index 0000000..3d84277
--- /dev/null
+++ b/include/linux/soc/sprd/mcdt.h
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __SPRD_MCDT_H
+#define __SPRD_MCDT_H
+
+enum sprd_mcdt_channel_type {
+	SPRD_MCDT_DAC_CHAN,
+	SPRD_MCDT_ADC_CHAN,
+	SPRD_MCDT_UNKNOWN_CHAN,
+};
+
+enum sprd_mcdt_dma_chan {
+	SPRD_MCDT_DMA_CH0,
+	SPRD_MCDT_DMA_CH1,
+	SPRD_MCDT_DMA_CH2,
+	SPRD_MCDT_DMA_CH3,
+	SPRD_MCDT_DMA_CH4,
+};
+
+struct sprd_mcdt_chan_callback {
+	void (*notify)(void *data);
+	void *data;
+};
+
+/**
+ * struct sprd_mcdt_chan - this struct represents a single channel instance
+ * @mcdt: the mcdt controller
+ * @id: channel id
+ * @fifo_phys: channel fifo physical address which is used for DMA transfer
+ * @type: channel type
+ * @cb: channel fifo interrupt's callback interface to notify the fifo events
+ * @dma_enable: indicate if use DMA mode to transfer data
+ * @int_enable: indicate if use interrupt mode to notify users to read or
+ * write data manually
+ * @list: used to link into the global list
+ *
+ * Note: users should not modify any members of this structure.
+ */
+struct sprd_mcdt_chan {
+	struct sprd_mcdt_dev *mcdt;
+	u8 id;
+	unsigned long fifo_phys;
+	enum sprd_mcdt_channel_type type;
+	enum sprd_mcdt_dma_chan dma_chan;
+	struct sprd_mcdt_chan_callback *cb;
+	bool dma_enable;
+	bool int_enable;
+	struct list_head list;
+};
+
+#ifdef CONFIG_SPRD_MCDT
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type);
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan);
+
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size);
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size);
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb);
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan);
+
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan, u32 water_mark);
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan);
+
+#else
+
+struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
+					      enum sprd_mcdt_channel_type type)
+{
+	return NULL;
+}
+
+void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan)
+{ }
+
+int sprd_mcdt_chan_write(struct sprd_mcdt_chan *chan, char *tx_buf, u32 size)
+{
+	return -EINVAL;
+}
+
+int sprd_mcdt_chan_read(struct sprd_mcdt_chan *chan, char *rx_buf, u32 size)
+{
+	return 0;
+}
+
+int sprd_mcdt_chan_int_enable(struct sprd_mcdt_chan *chan, u32 water_mark,
+			      struct sprd_mcdt_chan_callback *cb)
+{
+	return -EINVAL;
+}
+
+void sprd_mcdt_chan_int_disable(struct sprd_mcdt_chan *chan)
+{ }
+
+int sprd_mcdt_chan_dma_enable(struct sprd_mcdt_chan *chan,
+			      enum sprd_mcdt_dma_chan dma_chan, u32 water_mark)
+{
+	return -EINVAL;
+}
+
+void sprd_mcdt_chan_dma_disable(struct sprd_mcdt_chan *chan)
+{ }
+
+#endif
+
+#endif /* __SPRD_MCDT_H */
-- 
1.7.9.5

