Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A669C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C952081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="RidCRn50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfE0WlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:41:04 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35282 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfE0WlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:41:02 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3c0a::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 200D45C06AE;
        Tue, 28 May 2019 00:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1558996860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzRZ17pXEWQFjEk7pZRLwxgBHo2KMHTOBMHbwpIRG3E=;
        b=RidCRn50AciEbPsSMD+H0KVF3q+be+6DWATz87OjTTscmAmzpb6ygKYk/0ILdffLF4i07w
        oPHnIOmiOFA20BE9aBe38UKpcspn3QEr+M7QwFM6cIDLbqU+jwWrJYpy+ebKr9oGJDB9C7
        nZ4KWh/gFDnP+LxUnGlhFY3CVfjdLKg=
From:   Stefan Agner <stefan@agner.ch>
To:     arm@kernel.org, olof@lixom.net
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nico@fluxnic.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v4 2/2] ARM: OMAP2: drop explicit assembler architecture
Date:   Tue, 28 May 2019 00:40:51 +0200
Message-Id: <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
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
Acked-by: Tony Lindgren <tony@atomide.com>
---
Changes since v2:
- New patch

Changes since v3:
- Rebase on top of v5.2-rc2

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

