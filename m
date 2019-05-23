Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84364C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9FD2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfEWAny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:54 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57534 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp9-0008S8-4u; Wed, 22 May 2019 18:43:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTboQ-0005Z3-G8; Wed, 22 May 2019 18:42:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:16 -0500
Message-Id: <20190523003916.20726-27-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTboQ-0005Z3-G8;;;mid=<20190523003916.20726-27-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OJ9Ce0yIQjk/2QJzZRWILlIU/+n3OUBA=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 26/26] signal: Remove the signal number and task parameters from force_sig_info
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

force_sig_info always delivers to the current task and the signal
parameter always matches info.si_signo.  So remove those parameters to
make it a simpler less error prone interface, and to make it clear
that none of the callers are doing anything clever.

This guarantees that force_sig_info will not grow any new buggy
callers that attempt to call force_sig on a non-current task, or that
pass an signal number that does not match info.si_signo.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h       |  2 +-
 include/linux/sched/signal.h |  2 +-
 kernel/seccomp.c             |  2 +-
 kernel/signal.c              | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index d5084ebd9f03..2a9df80ea887 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -355,7 +355,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 	info.si_code = SI_USER;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 #endif
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f872506e1de..532458698bde 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -329,7 +329,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig);
-extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
+extern int force_sig_info(struct kernel_siginfo *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
 extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 811b4a86cdf6..dba52a7db5e8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -609,7 +609,7 @@ static void seccomp_send_sigsys(int syscall, int reason)
 {
 	struct kernel_siginfo info;
 	seccomp_init_siginfo(&info, syscall, reason);
-	force_sig_info(SIGSYS, &info, current);
+	force_sig_info(&info);
 }
 #endif	/* CONFIG_SECCOMP_FILTER */
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 0984158cd41a..ff6944e4964e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1325,9 +1325,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	return ret;
 }
 
-int force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+int force_sig_info(struct kernel_siginfo *info)
 {
-	return force_sig_info_to_task(info, t);
+	return force_sig_info_to_task(info, current);
 }
 
 /*
@@ -1619,7 +1619,7 @@ void force_sig(int sig)
 	info.si_code = SI_KERNEL;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 EXPORT_SYMBOL(force_sig);
 
@@ -1708,7 +1708,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
@@ -1737,7 +1737,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	info.si_addr  = addr;
 	info.si_lower = lower;
 	info.si_upper = upper;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 #ifdef SEGV_PKUERR
@@ -1751,7 +1751,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 	info.si_code  = SEGV_PKUERR;
 	info.si_addr  = addr;
 	info.si_pkey  = pkey;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 #endif
 
@@ -1767,7 +1767,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	info.si_errno = errno;
 	info.si_code  = TRAP_HWBKPT;
 	info.si_addr  = addr;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int kill_pgrp(struct pid *pid, int sig, int priv)
-- 
2.21.0

