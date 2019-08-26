Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F094217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Nd2im0rt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfHZPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:52:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47816 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731702AbfHZPwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:52:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46HGj75Ds8z9v7Dp;
        Mon, 26 Aug 2019 17:52:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Nd2im0rt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id E-DYmznNiS5L; Mon, 26 Aug 2019 17:52:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46HGj746wGz9v7Dl;
        Mon, 26 Aug 2019 17:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566834731; bh=xGfRFNUMTh5YwdmtE2IADQHaONTmVZYYYLcDCSSJPM4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Nd2im0rtwtcL2e3eCdFQAuN/G7XB2kFC9FpBCj+Wai0iJonI2XEHFAuf6uHjrx76Y
         rSO7dNPYE+PGk/JeYnjR3bYjyt5LACCAW9t9j/z+jHItSLHR4QNunAg47LogBfEarC
         7DO7XjnOLXQTPnb+xuDfV9N5wClwYmOSMLQgiJY8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC1158B7EF;
        Mon, 26 Aug 2019 17:52:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jc_yYpavvVJ1; Mon, 26 Aug 2019 17:52:16 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B3058B7E1;
        Mon, 26 Aug 2019 17:52:16 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0815E696D5; Mon, 26 Aug 2019 15:52:16 +0000 (UTC)
Message-Id: <170411e2360861f4a95c21faad43519a08bc4040.1566834712.git.christophe.leroy@c-s.fr>
In-Reply-To: <d644eaf7dff8cc149260066802af230bdf34fded.1566834712.git.christophe.leroy@c-s.fr>
References: <d644eaf7dff8cc149260066802af230bdf34fded.1566834712.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/6] powerpc/32s: drop CPU_FTR_USE_RTC feature
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 26 Aug 2019 15:52:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_FTR_USE_RTC feature only applies to powerpc601.

Drop this feature and replace it with tests on CONFIG_PPC_BOOK3S_601.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cputable.h     |  3 +--
 arch/powerpc/include/asm/time.h         |  6 +-----
 arch/powerpc/kernel/vdso.c              | 22 ----------------------
 arch/powerpc/kernel/vdso32/datapage.S   |  2 ++
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  4 +++-
 5 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 0aad095896d6..fac1b81bbbd9 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -149,7 +149,6 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_SPEC7450		ASM_CONST(0x00004000)
 #define CPU_FTR_TAU			ASM_CONST(0x00008000)
 #define CPU_FTR_CAN_DOZE		ASM_CONST(0x00010000)
-#define CPU_FTR_USE_RTC			ASM_CONST(0x00020000)
 #define CPU_FTR_L3CR			ASM_CONST(0x00040000)
 #define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x00080000)
 #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x00100000)
@@ -293,7 +292,7 @@ static inline void cpu_feature_keys_init(void) { }
 #endif
 
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | \
-	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_USE_RTC)
+	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
 #define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_604	(CPU_FTR_COMMON | CPU_FTR_PPC_LE)
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 54f4ec1f9fab..08dbe3e6831c 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -41,11 +41,7 @@ struct div_result {
 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
-#ifdef CONFIG_PPC_BOOK3S_32
-#define __USE_RTC()	(cpu_has_feature(CPU_FTR_USE_RTC))
-#else
-#define __USE_RTC()	0
-#endif
+#define __USE_RTC()	(IS_ENABLED(CONFIG_PPC_BOOK3S_601))
 
 #ifdef CONFIG_PPC64
 
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index d60598113a9f..eae9ddaecbcf 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -94,28 +94,6 @@ static struct vdso_patch_def vdso_patches[] = {
 		CPU_FTR_COHERENT_ICACHE, CPU_FTR_COHERENT_ICACHE,
 		"__kernel_sync_dicache", "__kernel_sync_dicache_p5"
 	},
-#ifdef CONFIG_PPC32
-	{
-		CPU_FTR_USE_RTC, CPU_FTR_USE_RTC,
-		"__kernel_gettimeofday", NULL
-	},
-	{
-		CPU_FTR_USE_RTC, CPU_FTR_USE_RTC,
-		"__kernel_clock_gettime", NULL
-	},
-	{
-		CPU_FTR_USE_RTC, CPU_FTR_USE_RTC,
-		"__kernel_clock_getres", NULL
-	},
-	{
-		CPU_FTR_USE_RTC, CPU_FTR_USE_RTC,
-		"__kernel_get_tbfreq", NULL
-	},
-	{
-		CPU_FTR_USE_RTC, CPU_FTR_USE_RTC,
-		"__kernel_time", NULL
-	},
-#endif
 };
 
 /*
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 6984125b9fc0..6c7401bd284e 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -70,6 +70,7 @@ V_FUNCTION_END(__kernel_get_syscall_map)
  *
  * returns the timebase frequency in HZ
  */
+#ifndef CONFIG_PPC_BOOK3S_601
 V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
@@ -82,3 +83,4 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_get_tbfreq)
+#endif
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 099a6db14e67..00c025ba4a92 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -144,10 +144,13 @@ VERSION
 		__kernel_datapage_offset;
 
 		__kernel_get_syscall_map;
+#ifndef CONFIG_PPC_BOOK3S_601
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_time;
 		__kernel_get_tbfreq;
+#endif
 		__kernel_sync_dicache;
 		__kernel_sync_dicache_p5;
 		__kernel_sigtramp32;
@@ -155,7 +158,6 @@ VERSION
 #ifdef CONFIG_PPC64
 		__kernel_getcpu;
 #endif
-		__kernel_time;
 
 	local: *;
 	};
-- 
2.13.3

