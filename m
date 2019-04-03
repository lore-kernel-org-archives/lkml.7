Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EAF214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfDCQmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:42:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41945 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfDCQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:26 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBixw-0004GO-MG; Wed, 03 Apr 2019 18:42:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/27] x86/fpu: Eager switch PKRU state
Date:   Wed,  3 Apr 2019 18:41:44 +0200
Message-Id: <20190403164156.19645-16-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

While most of a task's FPU state is only needed in user space, the
protection keys need to be in place immediately after a context switch.

The reason is that any access to userspace memory while running in
kernel mode also need to abide by the memory permissions specified in
the protection keys.

The "eager switch" is a preparation for loading the FPU state on return
to userland. Instead of decoupling PKRU state from xstate I update PKRU
within xstate on write operations by the kernel.

The read/write_pkru() is moved to another header file so it can easily
accessed from pgtable.h and fpu/internal.h.

For user tasks we should always get the PKRU from the xsave area and it
should not change anything because the PKRU value was loaded as part of
FPU restore.
For kernel threads we now will have the default "init_pkru_value"
written. Before this commit the kernel thread would end up with a
random value which it inherited from the previous user task.

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: save pkru to xstate, no cache, don't use __raw_xsave_addr()]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 24 ++++++++++++++++++++++--
 arch/x86/include/asm/fpu/xstate.h   |  1 +
 arch/x86/include/asm/pgtable.h      |  6 ++++++
 arch/x86/mm/pkeys.c                 |  1 -
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 237ff8dc8559b..82ff84a4c4ab7 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include <asm/user.h>
 #include <asm/fpu/api.h>
@@ -531,8 +532,27 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU))
-		__fpregs_load_activate(new_fpu, cpu);
+	struct pkru_state *pk;
+	u32 pkru_val = init_pkru_value;
+
+	if (!static_cpu_has(X86_FEATURE_FPU))
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	/*
+	 * PKRU state is switched eagerly because it needs to be valid before we
+	 * return to userland e.g. for a copy_to_user() operation.
+	 */
+	if (current->mm) {
+		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
+		if (pk)
+			pkru_val = pk->pkru;
+	}
+	__write_pkru(pkru_val);
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fbe41f808e5d8..4e18a837223ff 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 64333e5222cd9..1df90feeea5c6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1355,6 +1355,12 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
 #define PKRU_WD_BIT 0x2
 #define PKRU_BITS_PER_PKEY 2
 
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+extern u32 init_pkru_value;
+#else
+#define init_pkru_value	0
+#endif
+
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
 	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 50f65fc1b9a3f..2ecbf4155f98f 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -126,7 +126,6 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-static
 u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
 		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-- 
2.20.1

