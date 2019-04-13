Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B187CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD012084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDMUxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:53:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfDMUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:53:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKqBXK2265887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:52:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKqA7V2265883;
        Sat, 13 Apr 2019 13:52:10 -0700
Date:   Sat, 13 Apr 2019 13:52:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-4ee91519e1dccc175665fe24bb20a47c6053575c@git.kernel.org>
Cc:     Jason@zx2c4.com, aubrey.li@intel.com, luto@kernel.org,
        dave.hansen@intel.com, rkrcmar@redhat.com, jannh@google.com,
        x86@kernel.org, pbonzini@redhat.com, mingo@redhat.com,
        riel@surriel.com, bp@suse.de, tglx@linutronix.de,
        kvm@vger.kernel.org, bigeasy@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@redhat.com, riel@surriel.com, luto@kernel.org,
          dave.hansen@intel.com, aubrey.li@intel.com, Jason@zx2c4.com,
          pbonzini@redhat.com, x86@kernel.org, jannh@google.com,
          rkrcmar@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, kvm@vger.kernel.org, tglx@linutronix.de,
          bp@suse.de, bigeasy@linutronix.de
In-Reply-To: <20190403164156.19645-10-bigeasy@linutronix.de>
References: <20190403164156.19645-10-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Add an __fpregs_load_activate() internal
 helper
Git-Commit-ID: 4ee91519e1dccc175665fe24bb20a47c6053575c
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

Commit-ID:  4ee91519e1dccc175665fe24bb20a47c6053575c
Gitweb:     https://git.kernel.org/tip/4ee91519e1dccc175665fe24bb20a47c6053575c
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Wed, 3 Apr 2019 18:41:38 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 16:23:14 +0200

x86/fpu: Add an __fpregs_load_activate() internal helper

Add a helper function that ensures the floating point registers for the
current task are active. Use with preemption disabled.

While at it, add fpregs_lock/unlock() helpers too, to be used in later
patches.

 [ bp: Add a comment about its intended usage. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-10-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/api.h      | 11 +++++++++++
 arch/x86/include/asm/fpu/internal.h | 22 ++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b56d504af654..73e684160f35 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -10,6 +10,7 @@
 
 #ifndef _ASM_X86_FPU_API_H
 #define _ASM_X86_FPU_API_H
+#include <linux/preempt.h>
 
 /*
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
@@ -22,6 +23,16 @@ extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
 
+static inline void fpregs_lock(void)
+{
+	preempt_disable();
+}
+
+static inline void fpregs_unlock(void)
+{
+	preempt_enable();
+}
+
 /*
  * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
  *
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 54f70cae2f15..3e0c2c496f2d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -484,6 +484,18 @@ static inline void fpregs_activate(struct fpu *fpu)
 	trace_x86_fpu_regs_activated(fpu);
 }
 
+/*
+ * Internal helper, do not use directly. Use switch_fpu_return() instead.
+ */
+static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
+{
+	if (!fpregs_state_valid(fpu, cpu)) {
+		if (current->mm)
+			copy_kernel_to_fpregs(&fpu->state);
+		fpregs_activate(fpu);
+	}
+}
+
 /*
  * FPU state switching for scheduling.
  *
@@ -522,14 +534,8 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	if (static_cpu_has(X86_FEATURE_FPU)) {
-		if (!fpregs_state_valid(new_fpu, cpu)) {
-			if (current->mm)
-				copy_kernel_to_fpregs(&new_fpu->state);
-		}
-
-		fpregs_activate(new_fpu);
-	}
+	if (static_cpu_has(X86_FEATURE_FPU))
+		__fpregs_load_activate(new_fpu, cpu);
 }
 
 /*
