Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99449C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D7D2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDMVAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:00:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfDMVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:00:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKv8Lr2266782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:57:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKv8kl2266779;
        Sat, 13 Apr 2019 13:57:08 -0700
Date:   Sat, 13 Apr 2019 13:57:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-383c252545edcc708128e2028a2318b05c45ede4@git.kernel.org>
Cc:     pbonzini@redhat.com, Jason@zx2c4.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com, tim.c.chen@linux.intel.com,
        aubrey.li@intel.com, luto@kernel.org, riel@surriel.com,
        tglx@linutronix.de, hpa@zytor.com, dave.hansen@intel.com,
        jannh@google.com, x86@kernel.org, kvm@vger.kernel.org,
        konrad.wilk@oracle.com, bigeasy@linutronix.de, bp@suse.de,
        mingo@kernel.org
Reply-To: dave.hansen@intel.com, hpa@zytor.com, luto@kernel.org,
          riel@surriel.com, tglx@linutronix.de, tim.c.chen@linux.intel.com,
          aubrey.li@intel.com, bp@suse.de, mingo@kernel.org,
          kvm@vger.kernel.org, konrad.wilk@oracle.com, x86@kernel.org,
          bigeasy@linutronix.de, jannh@google.com, Jason@zx2c4.com,
          pbonzini@redhat.com, rkrcmar@redhat.com, mingo@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190403164156.19645-17-bigeasy@linutronix.de>
References: <20190403164156.19645-17-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/entry: Add TIF_NEED_FPU_LOAD
Git-Commit-ID: 383c252545edcc708128e2028a2318b05c45ede4
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

Commit-ID:  383c252545edcc708128e2028a2318b05c45ede4
Gitweb:     https://git.kernel.org/tip/383c252545edcc708128e2028a2318b05c45ede4
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:45 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 16:21:51 +0200

x86/entry: Add TIF_NEED_FPU_LOAD

Add TIF_NEED_FPU_LOAD. This flag is used for loading the FPU registers
before returning to userland. It must not be set on systems without a
FPU.

If this flag is cleared, the CPU's FPU registers hold the latest,
up-to-date content of the current task's (current()) FPU registers.
The in-memory copy (union fpregs_state) is not valid.

If this flag is set, then all of CPU's FPU registers may hold a random
value (except for PKRU) and it is required to load the content of the
FPU registers on return to userland.

Introduce it now as a preparatory change before adding the main feature.

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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-17-bigeasy@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 8 ++++++++
 arch/x86/include/asm/thread_info.h  | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 6eb4a0b1ad0e..da75d7b3e37d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -508,6 +508,14 @@ static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
  *  - switch_fpu_finish() restores the new state as
  *    necessary.
  *
+ * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
+ * are saved in the current thread's FPU register state.
+ *
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
+ * hold current()'s FPU registers. It is required to load the
+ * registers before returning to userland or using the content
+ * otherwise.
+ *
  * The FPU context is only stored/restored for a user task and
  * ->mm is used to distinguish between kernel and user threads.
  */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index e0eccbcb8447..f9453536f9bb 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -88,6 +88,7 @@ struct thread_info {
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
+#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
@@ -117,6 +118,7 @@ struct thread_info {
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
+#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
