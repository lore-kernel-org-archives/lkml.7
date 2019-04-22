Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF98C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E77221905
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962323;
	bh=OhJZk7L4zM+/lKoDMmPYjEkP6Af7sIJE3xtBTNGYlg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TANRGp5TRjjPy9Nv78Qfl+HciJiZpd7B7twSzbuaU3R9XjVnijaagg/d72bcrwVfp
	 8J9enIqKgD6i9h8RuMkEgeacco1RZCaffuLtXBZtBumnS+KwaKPglMK2WsNKtp/uRq
	 3oyeNN6WuSvX9PUm+SKQmlmKI1sFkK+K52OztKrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfDVTpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbfDVTpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE9B218DA;
        Mon, 22 Apr 2019 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962311;
        bh=OhJZk7L4zM+/lKoDMmPYjEkP6Af7sIJE3xtBTNGYlg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UO6wOX3hGUj0k1FgnGQTfsB3iwCy1a0rZDJrp7cwqGK+0qrM5jl4iQzQjQ98pq7uk
         ospxEMEuvl2GX6ElCmetU5ena9BG7cKt+sMIwMRSzbHsCcckBGH50PCzhKfNzNXqIz
         5acZ+AHjEYme1Rn5Q1o1w6IG96D56RCNmDHuDBw8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 96/98] ptrace: take into account saved_sigmask in PTRACE{GET,SET}SIGMASK
Date:   Mon, 22 Apr 2019 15:42:03 -0400
Message-Id: <20190422194205.10404-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

[ Upstream commit fcfc2aa0185f4a731d05a21e9f359968fdfd02e7 ]

There are a few system calls (pselect, ppoll, etc) which replace a task
sigmask while they are running in a kernel-space

When a task calls one of these syscalls, the kernel saves a current
sigmask in task->saved_sigmask and sets a syscall sigmask.

On syscall-exit-stop, ptrace traps a task before restoring the
saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
saved_sigmask, when the task returns to user-space.

This patch fixes this problem.  PTRACE_GETSIGMASK returns saved_sigmask
if it's set.  PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.

Link: http://lkml.kernel.org/r/20181120060616.6043-1-avagin@gmail.com
Fixes: 29000caecbe8 ("ptrace: add ability to get/set signal-blocked mask")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 include/linux/sched/signal.h | 18 ++++++++++++++++++
 kernel/ptrace.c              | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 13789d10a50e..76b8399b17f6 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -417,10 +417,20 @@ static inline void set_restore_sigmask(void)
 	set_thread_flag(TIF_RESTORE_SIGMASK);
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
+
+static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+}
+
 static inline void clear_restore_sigmask(void)
 {
 	clear_thread_flag(TIF_RESTORE_SIGMASK);
 }
+static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	return test_tsk_thread_flag(tsk, TIF_RESTORE_SIGMASK);
+}
 static inline bool test_restore_sigmask(void)
 {
 	return test_thread_flag(TIF_RESTORE_SIGMASK);
@@ -438,6 +448,10 @@ static inline void set_restore_sigmask(void)
 	current->restore_sigmask = true;
 	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
 }
+static inline void clear_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	tsk->restore_sigmask = false;
+}
 static inline void clear_restore_sigmask(void)
 {
 	current->restore_sigmask = false;
@@ -446,6 +460,10 @@ static inline bool test_restore_sigmask(void)
 {
 	return current->restore_sigmask;
 }
+static inline bool test_tsk_restore_sigmask(struct task_struct *tsk)
+{
+	return tsk->restore_sigmask;
+}
 static inline bool test_and_clear_restore_sigmask(void)
 {
 	if (!current->restore_sigmask)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 771e93f9c43f..6f357f4fc859 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
+#include <linux/sched/signal.h>
 
 /*
  * Access another process' address space via ptrace.
@@ -924,18 +925,26 @@ int ptrace_request(struct task_struct *child, long request,
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
-	case PTRACE_GETSIGMASK:
+	case PTRACE_GETSIGMASK: {
+		sigset_t *mask;
+
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
 		}
 
-		if (copy_to_user(datavp, &child->blocked, sizeof(sigset_t)))
+		if (test_tsk_restore_sigmask(child))
+			mask = &child->saved_sigmask;
+		else
+			mask = &child->blocked;
+
+		if (copy_to_user(datavp, mask, sizeof(sigset_t)))
 			ret = -EFAULT;
 		else
 			ret = 0;
 
 		break;
+	}
 
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
@@ -961,6 +970,8 @@ int ptrace_request(struct task_struct *child, long request,
 		child->blocked = new_set;
 		spin_unlock_irq(&child->sighand->siglock);
 
+		clear_tsk_restore_sigmask(child);
+
 		ret = 0;
 		break;
 	}
-- 
2.19.1

