Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1EFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4CF22474
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfJUCKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfJUCKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84B04B1FF;
        Mon, 21 Oct 2019 02:10:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: Prepare Realtek RTD1195
Date:   Mon, 21 Oct 2019 04:10:34 +0200
Message-Id: <20191021021035.7032-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021021035.7032-1-afaerber@suse.de>
References: <20191021021035.7032-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ARCH_REALTEK Kconfig option also for 32-bit Arm.

Override the text offset to cope with boot ROM living up to 0xf4000.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/Kconfig              |  2 ++
 arch/arm/Makefile             |  1 +
 arch/arm/mach-realtek/Kconfig | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 arch/arm/mach-realtek/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a50efb559f3..ac0d1837253d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -700,6 +700,8 @@ source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-rda/Kconfig"
 
+source "arch/arm/mach-realtek/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..60c76380f380 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -148,6 +148,7 @@ head-y		:= arch/arm/kernel/head$(MMUEXT).o
 textofs-y	:= 0x00008000
 # We don't want the htc bootloader to corrupt kernel during resume
 textofs-$(CONFIG_PM_H1940)      := 0x00108000
+textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
diff --git a/arch/arm/mach-realtek/Kconfig b/arch/arm/mach-realtek/Kconfig
new file mode 100644
index 000000000000..67ae5f122acb
--- /dev/null
+++ b/arch/arm/mach-realtek/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+menuconfig ARCH_REALTEK
+	bool "Realtek SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select RESET_CONTROLLER
+	help
+	  This enables support for the Realtek RTD1195 SoC family.
-- 
2.16.4

