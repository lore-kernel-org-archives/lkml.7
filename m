Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D785217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Xq04HTGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDKHxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:53:15 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35822 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDKHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:53:12 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::360])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8E4D95C1037;
        Thu, 11 Apr 2019 09:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554969190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KpX3gG9yx43KuiavdFHDUFIDIvT5TJDIaFy7ZWJfXI=;
        b=Xq04HTGbpiBbGkwaQamZ0Biq2zV/u500ztaWYWGJ+4XRhgNyDFMYBJk8tLQ02SybRgInvf
        D4PqDn1MkZt/4YXzQKjflYmwFoQ5M3ztp2hy4h2Zc2TBb0yT05ddU7igLQCvAr1gwuoWe/
        +lDYXjDHUyrLvD69Hk5h+CDPCRKrAjg=
From:   Stefan Agner <stefan@agner.ch>
To:     arm@kernel.org
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 2/4] ARM: OMAP2: drop explicit assembler architecture
Date:   Thu, 11 Apr 2019 09:54:01 +0200
Message-Id: <d0fb7e55d76da42bea449011ec38b0ad651a3778.1554968922.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch>
References: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP2 depends on ARCH_MULTI_V6, which makes sure that the kernel is
compiled with -march=armv6. The compiler frontend will pass the
architecture to the assembler. There is no explicit architecture
specification necessary.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes since v2:
- New patch

 arch/arm/mach-omap2/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f1d283995b31..600650551621 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -45,9 +45,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
 
-AFLAGS_sram242x.o			:=-Wa,-march=armv6
-AFLAGS_sram243x.o			:=-Wa,-march=armv6
-
 # Restart code (OMAP4/5 currently in omap4-common.c)
 obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
 obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
@@ -89,8 +86,6 @@ obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
-AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-
 endif
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-- 
2.21.0

