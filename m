Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB152189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Jm7L/VQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfH2IpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:45:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15697 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfH2IpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:45:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Jx540jNCz9tyrP;
        Thu, 29 Aug 2019 10:45:12 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Jm7L/VQb; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eB9ya2BiEsKH; Thu, 29 Aug 2019 10:45:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Jx536hbPz9tyrN;
        Thu, 29 Aug 2019 10:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567068311; bh=RtnxFZ8galZ9iyHfU5Oz/Hsl2pQKCYgIH0h1HyzzXoc=;
        h=From:Subject:To:Cc:Date:From;
        b=Jm7L/VQbV/d5R5D1o3FVuXWwFcv7oDRbgge0Qw86T666tjKOyx4CeYy6J7wkrRA36
         YP1cGr6aUYYjLdF5PIJLIh6pXnoHL1qQm+6/ouvE6sDY7ry6Lfl/P7pmf2O9HdakOm
         wck+mPr1BldQBXSTdIlpREVRdzY9fr4PapTDHjkg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BC608B8AC;
        Thu, 29 Aug 2019 10:45:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uSHDI0y2b93L; Thu, 29 Aug 2019 10:45:12 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB3318B7B2;
        Thu, 29 Aug 2019 10:45:12 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 61D08696C1; Thu, 29 Aug 2019 08:45:12 +0000 (UTC)
Message-Id: <dd82934ad91aab607d0eb7e626c14e6ac0d654eb.1567068137.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] powerpc: permanently include 8xx registers in reg.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 29 Aug 2019 08:45:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most 8xx registers have specific names, so just include
reg_8xx.h all the time in reg.h in order to have them defined
even when CONFIG_PPC_8xx is not selected. This will avoid
the need for #ifdefs in C code.

Guard SPRN_ICTRL in an #ifdef CONFIG_PPC_8xx as this register
has same name but different meaning and different spr number as
another register in the mpc7450.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: no change

v3: fixed build failure on ppc64e_defconfig (removed asm/mmu.h inclusion from asm/reg_8xx.h)
---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 1 +
 arch/powerpc/include/asm/reg.h               | 2 --
 arch/powerpc/include/asm/reg_8xx.h           | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 1c3133b5f86a..1006a427e99c 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_KUP_8XX_H_
 
 #include <asm/bug.h>
+#include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_KUAP
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 10caa145f98b..b17ee25df226 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -25,9 +25,7 @@
 #include <asm/reg_fsl_emb.h>
 #endif
 
-#ifdef CONFIG_PPC_8xx
 #include <asm/reg_8xx.h>
-#endif /* CONFIG_PPC_8xx */
 
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 7192eece6c3e..07df35ee8cbc 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -5,8 +5,6 @@
 #ifndef _ASM_POWERPC_REG_8xx_H
 #define _ASM_POWERPC_REG_8xx_H
 
-#include <asm/mmu.h>
-
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
  */
@@ -38,7 +36,9 @@
 #define SPRN_CMPF	153
 #define SPRN_LCTRL1	156
 #define SPRN_LCTRL2	157
+#ifdef CONFIG_PPC_8xx
 #define SPRN_ICTRL	158
+#endif
 #define SPRN_BAR	159
 
 /* Commands.  Only the first few are available to the instruction cache.
-- 
2.13.3

