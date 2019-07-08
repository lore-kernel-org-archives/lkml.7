Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE082C606A8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE022064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfGHJWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfGHJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr7-0004pi-Kp; Mon, 08 Jul 2019 11:22:41 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/pti for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

up to:  993773d11d45: x86/tls: Fix possible spectre-v1 in do_get_thread_area()

The speculative paranoia departement delivers a few more plugs for possible
(probably theoretical) spectre/mds leaks.

Thanks,

	tglx

------------------>
Dianzhang Chen (2):
      x86/ptrace: Fix possible spectre-v1 in ptrace_get_debugreg()
      x86/tls: Fix possible spectre-v1 in do_get_thread_area()

Zhenzhong Duan (1):
      x86/speculation/mds: Eliminate leaks by trace_hardirqs_on()


 arch/x86/include/asm/mwait.h | 4 ++--
 arch/x86/kernel/ptrace.c     | 5 ++++-
 arch/x86/kernel/tls.c        | 9 +++++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index eb0f80ce8524..e28f8b723b5c 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -86,9 +86,9 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
-
 	trace_hardirqs_on();
+
+	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a166c960bc9e..cbac64659dc4 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -643,9 +644,11 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 {
 	struct thread_struct *thread = &tsk->thread;
 	unsigned long val = 0;
+	int index = n;
 
 	if (n < HBP_NUM) {
-		struct perf_event *bp = thread->ptrace_bps[n];
+		index = array_index_nospec(index, HBP_NUM);
+		struct perf_event *bp = thread->ptrace_bps[index];
 
 		if (bp)
 			val = bp->hw.info.address;
diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a12212..71d3fef1edc9 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,11 @@ int do_get_thread_area(struct task_struct *p, int idx,
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+	index = idx - GDT_ENTRY_TLS_MIN;
+	index = array_index_nospec(index,
+			GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);
+
+	fill_user_desc(&info, idx, &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;

