Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488C42465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLRHX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:23:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36212 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLRHXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:23:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 43B7D200184;
        Wed, 18 Dec 2019 08:23:23 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B597200A42;
        Wed, 18 Dec 2019 08:23:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E8A6F402DF;
        Wed, 18 Dec 2019 15:23:05 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com,
        aisheng.dong@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 3/3] drivers/irqchip: enable INTMUX interrupt controller driver
Date:   Wed, 18 Dec 2019 15:20:15 +0800
Message-Id: <1576653615-27954-4-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable INTMUX interrupt controller driver for i.MX platforms.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/Kconfig  | 6 ++++++
 drivers/irqchip/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..7e2b1e9d0b45 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,6 +457,12 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config IMX_INTMUX
+	def_bool y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX INTMUX interrupt multiplexer.
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..af976a79d1fb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
+obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
-- 
2.17.1

