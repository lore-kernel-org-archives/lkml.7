Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE44C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C0221880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ApP73zZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbfGXXrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:47:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37232 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfGXXrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564012025; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ZClIlxQHDoZwcWywOLbFHID80yVsfDEESlYYD3vTm1A=;
        b=ApP73zZikTLAiqk3L+2+k7tcfe7Oy0F93dpanKKpYQ9eOIf1BFR2c8T6TK8xLY5ii8SHC2
        jqsL07t2ynNn55vpEnHLP7fbCQ/u5bbSxzPYH2u+dT0emt82vFieQOzYWVzhirGtdIHpiP
        cRQs2hfAfpQFUvnuO22kwHJC8/VzQ3Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MIPS: Add support for partial kernel mode on Xburst CPUs
Date:   Wed, 24 Jul 2019 19:46:54 -0400
Message-Id: <20190724234654.16555-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support partial kernel mode of Xburst CPUs found in Ingenic SoCs.
Partial kernel mode means the userspace applications have access to
the TCSM0 banks of the VPU, and can execute cache instructions.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Kconfig                | 7 +++++++
 arch/mips/include/asm/mipsregs.h | 1 +
 arch/mips/kernel/cpu-probe.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac9ed08a7fff..02831908d676 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2986,6 +2986,13 @@ config MIPS_O32_FP64_SUPPORT
 
 	  If unsure, say N.
 
+config MIPS_XBURST_PARTIAL_KERNEL_MODE
+	bool "Partial kernel mode for Xburst CPUs" if MACH_INGENIC
+	help
+	  Support partial kernel mode of Xburst CPUs found in Ingenic SoCs.
+	  Partial kernel mode means the userspace applications have access to
+	  the TCSM0 banks of the VPU, and can execute cache instructions.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 1e6966e8527e..01e0fcb1d4c2 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -2813,6 +2813,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a9c82338396a..fd275f37cb7c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1985,6 +1985,10 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	 */
 	if ((c->processor_id & PRID_COMP_MASK) == PRID_COMP_INGENIC_D0)
 		c->isa_level &= ~MIPS_CPU_ISA_M32R2;
+
+	/* config7 bit 6 controls the "partial kernel mode" */
+	if (IS_ENABLED(CONFIG_MIPS_XBURST_PARTIAL_KERNEL_MODE))
+		set_c0_config7(BIT(6));
 }
 
 static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
-- 
2.21.0.593.g511ec345e18

