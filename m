Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1F220643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Vbg2DOA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCKIan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:30:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7677 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfCKIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:30:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Hrs256lTzB09Zy;
        Mon, 11 Mar 2019 09:30:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Vbg2DOA6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id P2I79fmTpMqz; Mon, 11 Mar 2019 09:30:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrs23zKdzB09ZD;
        Mon, 11 Mar 2019 09:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552293030; bh=viwz0+kQKH2jMfJ0rgJLsPM3KipIVrqR0y68CVp074c=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Vbg2DOA6mGIxUyUr60Bv+V6rP4LoNVtnrpqxHV36FBWWXdNWscXYP8LJ3CmXl05Rw
         U/XcJo2NyIsOsEKKQX0vQTHZGvZLj89ZxfdywOyuFmolF/bH96HOQ+cSlfgOkkc7dv
         XWBtZtfxQaJALJUJQXcSYvVtaE6E0qHkpvfFyMZI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25F8D8B813;
        Mon, 11 Mar 2019 09:30:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qrxih7oeDJcK; Mon, 11 Mar 2019 09:30:35 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F345B8B7FE;
        Mon, 11 Mar 2019 09:30:34 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E11056FA08; Mon, 11 Mar 2019 08:30:34 +0000 (UTC)
Message-Id: <bac688f0f7f60d6862d839982c9cccbeda6fec3c.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/10] powerpc/8xx: Add Kernel Userspace Access Protection
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Mar 2019 08:30:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Kernel Userspace Access Protection on the 8xx.

When a page is RO or RW, it is set RO or RW for Key 0 and NA
for Key 1.

Up to now, the User group is defined with Key 0 for both User and
Supervisor.

By changing the group to Key 0 for User and Key 1 for Supervisor,
this patch prevents the Kernel from being able to access user data.

At exception entry, the kernel saves SPRN_MD_AP in the regs struct,
and reapply the protection. At exception exit it restores SPRN_MD_AP
with the value saved on exception entry.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/kup.h               |  3 ++
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 68 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  7 +++
 arch/powerpc/mm/8xx_mmu.c                    | 12 +++++
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 5 files changed, 91 insertions(+)
 create mode 100644 arch/powerpc/include/asm/nohash/32/kup-8xx.h

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 632b367b93f4..75ade5a54607 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,6 +5,9 @@
 #ifdef CONFIG_PPC64
 #include <asm/book3s/64/kup-radix.h>
 #endif
+#ifdef CONFIG_PPC_8xx
+#include <asm/nohash/32/kup-8xx.h>
+#endif
 
 #ifdef __ASSEMBLY__
 #ifndef CONFIG_PPC_KUAP
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
new file mode 100644
index 000000000000..a44cc6c1b901
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_KUP_8XX_H_
+#define _ASM_POWERPC_KUP_8XX_H_
+
+#include <asm/bug.h>
+
+#ifdef CONFIG_PPC_KUAP
+
+#ifdef __ASSEMBLY__
+
+.macro kuap_save_and_lock	sp, thread, gpr1, gpr2, gpr3
+	lis	\gpr2, MD_APG_KUAP@h	/* only APG0 and APG1 are used */
+	mfspr	\gpr1, SPRN_MD_AP
+	mtspr	SPRN_MD_AP, \gpr2
+	stw	\gpr1, STACK_REGS_KUAP(\sp)
+.endm
+
+.macro kuap_restore	sp, current, gpr1, gpr2, gpr3
+	lwz	\gpr1, STACK_REGS_KUAP(\sp)
+	mtspr	SPRN_MD_AP, \gpr1
+.endm
+
+.macro kuap_check	current, gpr
+#ifdef CONFIG_PPC_KUAP_DEBUG
+	mfspr	\gpr, SPRN_MD_AP
+	rlwinm	\gpr, \gpr, 16, 0xffff
+999:	twnei	\gpr, MD_APG_KUAP@h
+	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
+#endif
+.endm
+
+#else /* !__ASSEMBLY__ */
+
+#include <asm/reg.h>
+
+static inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size)
+{
+	mtspr(SPRN_MD_AP, MD_APG_INIT);
+}
+
+static inline void prevent_user_access(void __user *to, const void __user *from,
+				       unsigned long size)
+{
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+
+static inline void allow_read_from_user(const void __user *from, unsigned long size)
+{
+	allow_user_access(NULL, from, size);
+}
+
+static inline void allow_write_to_user(void __user *to, unsigned long size)
+{
+	allow_user_access(to, NULL, size);
+}
+
+static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
+{
+	return WARN(!((regs->kuap ^ MD_APG_KUAP) & 0xf0000000),
+		    "Bug: fault blocked by AP register !");
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* _ASM_POWERPC_KUP_8XX_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 3cb743284e09..f620adef54fc 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -121,6 +121,13 @@
  */
 #define MD_APG_INIT	0x4fffffff
 
+/*
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 10 (all accesses performed according to swaped page definition)
+ * 2-16 => NA => 11 (all accesses performed as user iaw page definition)
+ */
+#define MD_APG_KUAP	0x6fffffff
+
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
  * this register are used to create the TLB entry.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index e257a0c9bd08..87648b58d295 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -225,3 +225,15 @@ void __init setup_kuep(bool disabled)
 	mtspr(SPRN_MI_AP, MI_APG_KUEP);
 }
 #endif
+
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
+{
+	pr_info("Activating Kernel Userspace Access Protection\n");
+
+	if (disabled)
+		pr_warn("KUAP cannot be disabled yet on 8xx when compiled in\n");
+
+	mtspr(SPRN_MD_AP, MD_APG_KUAP);
+}
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 00fa0d110dcb..ab586963893a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -35,6 +35,7 @@ config PPC_8xx
 	select FSL_SOC
 	select SYS_SUPPORTS_HUGETLBFS
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 
 config 40x
 	bool "AMCC 40x"
-- 
2.13.3

