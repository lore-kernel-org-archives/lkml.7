Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED21C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEB72084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDMU54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:57:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:57:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKuSBB2266523
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:56:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKuS0I2266520;
        Sat, 13 Apr 2019 13:56:28 -0700
Date:   Sat, 13 Apr 2019 13:56:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-0cecca9d03c964abbd2b7927d0670eb70db4ebf2@git.kernel.org>
Cc:     kirill.shutemov@linux.intel.com, kvm@vger.kernel.org,
        bigeasy@linutronix.de, x86@kernel.org, jgross@suse.com,
        luto@kernel.org, rkrcmar@redhat.com, mingo@kernel.org,
        jroedel@suse.de, Jason@zx2c4.com, bp@suse.de, aubrey.li@intel.com,
        jannh@google.com, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@intel.com, hpa@zytor.com, peterz@infradead.org,
        mhocko@suse.cz, pbonzini@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, riel@surriel.com
Reply-To: jroedel@suse.de, mingo@kernel.org, kvm@vger.kernel.org,
          x86@kernel.org, bigeasy@linutronix.de,
          kirill.shutemov@linux.intel.com, jgross@suse.com,
          luto@kernel.org, rkrcmar@redhat.com, tglx@linutronix.de,
          jannh@google.com, aubrey.li@intel.com, mingo@redhat.com,
          Jason@zx2c4.com, bp@suse.de, mhocko@suse.cz,
          peterz@infradead.org, hpa@zytor.com, dave.hansen@intel.com,
          riel@surriel.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, pbonzini@redhat.com
In-Reply-To: <20190403164156.19645-16-bigeasy@linutronix.de>
References: <20190403164156.19645-16-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Eager switch PKRU state
Git-Commit-ID: 0cecca9d03c964abbd2b7927d0670eb70db4ebf2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0cecca9d03c964abbd2b7927d0670eb70db4ebf2
Gitweb:     https://git.kernel.org/tip/0cecca9d03c964abbd2b7927d0670eb70db4ebf2
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Wed, 3 Apr 2019 18:41:44 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 15:57:10 +0200

x86/fpu: Eager switch PKRU state

While most of a task's FPU state is only needed in user space, the
protection keys need to be in place immediately after a context switch.

The reason is that any access to userspace memory while running in
kernel mode also needs to abide by the memory permissions specified in
the protection keys.

The "eager switch" is a preparation for loading the FPU state on return
to userland. Instead of decoupling PKRU state from xstate, update PKRU
within xstate on write operations by the kernel.

For user tasks the PKRU should be always read from the xsave area and it
should not change anything because the PKRU value was loaded as part of
FPU restore.

For kernel threads the default "init_pkru_value" will be written. Before
this commit, the kernel thread would end up with a random value which it
inherited from the previous user task.

 [ bigeasy: save pkru to xstate, no cache, don't use __raw_xsave_addr() ]

 [ bp: update commit message, sort headers properly in asm/fpu/xstate.h ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-16-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 24 ++++++++++++++++++++++--
 arch/x86/include/asm/fpu/xstate.h   |  4 +++-
 arch/x86/include/asm/pgtable.h      |  6 ++++++
 arch/x86/mm/pkeys.c                 |  1 -
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 3e0c2c496f2d..6eb4a0b1ad0e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include <asm/user.h>
 #include <asm/fpu/api.h>
@@ -534,8 +535,27 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU))
-		__fpregs_load_activate(new_fpu, cpu);
+	u32 pkru_val = init_pkru_value;
+	struct pkru_state *pk;
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
index fbe41f808e5d..7e42b285c856 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -2,9 +2,11 @@
 #ifndef __ASM_X86_XSAVE_H
 #define __ASM_X86_XSAVE_H
 
+#include <linux/uaccess.h>
 #include <linux/types.h>
+
 #include <asm/processor.h>
-#include <linux/uaccess.h>
+#include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e8875ca75623..9beb371b1adf 100644
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
index 50f65fc1b9a3..2ecbf4155f98 100644
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
