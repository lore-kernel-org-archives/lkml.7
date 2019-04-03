Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278D820830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCMnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:43:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:43:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33ChB681849664
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 05:43:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33ChBxC1849661;
        Wed, 3 Apr 2019 05:43:11 -0700
Date:   Wed, 3 Apr 2019 05:43:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-89833fab15d6017ba006a45b5af68caa067171a7@git.kernel.org>
Cc:     x86@kernel.org, qiaowei.ren@intel.com, bigeasy@linutronix.de,
        mojha@codeaurora.org, mathieu.desnoyers@efficios.com,
        jannh@google.com, hpa@zytor.com, bp@suse.de, mingo@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, luto@kernel.org, tglx@linutronix.de
Reply-To: luto@kernel.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, mingo@kernel.org, mingo@redhat.com,
          tglx@linutronix.de, mojha@codeaurora.org, qiaowei.ren@intel.com,
          bigeasy@linutronix.de, x86@kernel.org, bp@suse.de, hpa@zytor.com,
          jannh@google.com, mathieu.desnoyers@efficios.com
In-Reply-To: <20190329214652.258477-3-jannh@google.com>
References: <20190329214652.258477-3-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Fix __user annotations
Git-Commit-ID: 89833fab15d6017ba006a45b5af68caa067171a7
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

Commit-ID:  89833fab15d6017ba006a45b5af68caa067171a7
Gitweb:     https://git.kernel.org/tip/89833fab15d6017ba006a45b5af68caa067171a7
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 29 Mar 2019 22:46:51 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 3 Apr 2019 14:12:40 +0200

x86/fpu: Fix __user annotations

In save_xstate_epilog(), use __user when type-casting userspace
pointers.

In setup_sigcontext() and x32_setup_rt_frame(), cast the userspace
pointers to 'unsigned long __user *' before writing into them. These
pointers are originally '__u32 __user *' or '__u64 __user *', causing
sparse to complain when a userspace pointer is written into them. The
casts are okay because the pointers always point to pointer-sized
values.

Thanks to Luc Van Oostenryck and Al Viro for explaining this to me.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190329214652.258477-3-jannh@google.com
---
 arch/x86/kernel/fpu/signal.c | 6 +++---
 arch/x86/kernel/signal.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index f6a1d299627c..55b80de13ea5 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -92,13 +92,13 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 		return err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 *)(buf + fpu_user_xstate_size));
+			  (__u32 __user *)(buf + fpu_user_xstate_size));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
 	 * from the state in task struct) to the user buffers.
 	 */
-	err |= __get_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
@@ -113,7 +113,7 @@ static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
 	 */
 	xfeatures |= XFEATURE_MASK_FPSSE;
 
-	err |= __put_user(xfeatures, (__u32 *)&x->header.xfeatures);
+	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
 	return err;
 }
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 08dfd4c1a4f9..b419e1a1a0ce 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		put_user_ex(regs->ss, &sc->ss);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, &sc->fpstate);
+		put_user_ex(fpstate, (unsigned long __user *)&sc->fpstate);
 
 		/* non-iBCS2 extensions.. */
 		put_user_ex(mask, &sc->oldmask);
@@ -569,7 +569,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 			restorer = NULL;
 			err |= -EFAULT;
 		}
-		put_user_ex(restorer, &frame->pretcode);
+		put_user_ex(restorer, (unsigned long __user *)&frame->pretcode);
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
