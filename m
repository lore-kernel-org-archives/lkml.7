Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1833F2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwDmI29k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCSTUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:20:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38993 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCSTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:20:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so14519573pgp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zX2I+WV09MAFoKOGvG5BuE+Ojt8cSFDVe53iWCQGyyc=;
        b=NwDmI29kK9iW19gKo3QaQ6ZTpqYSpnWlVTw/TenE+Rt9dvGOxsftotPNd2JNZqp4Eo
         Wl+NOH+ayhWBBCXtPFp7rfcg8xMRQS1iGDtNtlSW2d7OcvFE0FUD82PcKnnr45px2MS7
         SInLyxw1N/IQuG+oIat04PNJpw+pDNfIEu/uhlYP0z87J3IMawZxN1X8cnTj0rL6T63I
         R+au7hV8FcNoYDJrFkhJWlcNIwpPwBQ3SfhmMOOc1FOC+CQEJ3bhw8Kuhj1JGr18jp+L
         c6suk7Jc6uddRAHaBmBd8yCZ1rc46tv7ofCT/Mcpz0vhraNmP2mysQYAXe3QHjUV5CAO
         xMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zX2I+WV09MAFoKOGvG5BuE+Ojt8cSFDVe53iWCQGyyc=;
        b=b740SJyytkvkhv4z5em6f/yzQ8fcUDaEoHsXEJplZO3vC+aU1fGFHezQfI4hsZQPoP
         OOmt3O/ohuSUVArA9zw155Xw+czrezLfm3Yd1/ZZp74lSniAyyMspozVS6EFR5JDRTQA
         OP0+aA06wS84q0EXNvqrpyMZqPQClC/bith7104U/j6RaE6HAhfgH1irq8Fv2GOcWeIU
         WhBFZSGxpOp4l2cldQ0Z0c1k4aYbq5WB5qIiL9uk7bQOrl1XNjGq3WtsTuZYsL4vfli5
         AOkzNY091rYtYgUlo1CWDXi4WAhgOxdPGyl29X0u+N1lBNcFwXPIW/8MBAShTq4q21+N
         nQBw==
X-Gm-Message-State: APjAAAW3s04jC8CqAGwIbhLqSywHgEPaTxrJIx4Pb7Haf9wWjDDxEPrX
        ZA68Z3bPoSotncfCUL79KRk=
X-Google-Smtp-Source: APXvYqz5EtXZX4+z7V/l2EQigPmZV1ajGT+vmvNEzLbqxT6AKpFlZxqM51MhRom8syKiKhLneMliiA==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr27627035plo.52.1553023214574;
        Tue, 19 Mar 2019 12:20:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:0:1008:fd00:ed8e:8493:d2b7:8f54])
        by smtp.gmail.com with ESMTPSA id s4sm9350698pgp.89.2019.03.19.12.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:20:13 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [RESEND PATCH] ptrace: take into account saved_sigmask in PTRACE_{GET,SET}SIGMASK
Date:   Tue, 19 Mar 2019 12:19:57 -0700
Message-Id: <20190319191957.27156-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few system calls (pselect, ppoll, etc) which replace a task
sigmask while they are running in a kernel-space

When a task calls one of these syscalls, the kernel saves a current
sigmask in task->saved_sigmask and sets a syscall sigmask.

On syscall-exit-stop, ptrace traps a task before restoring the
saved_sigmask, so PTRACE_GETSIGMASK returns the syscall sigmask and
PTRACE_SETSIGMASK does nothing, because its sigmask is replaced by
saved_sigmask, when the task returns to user-space.

This patch fixes this problem.  PTRACE_GET_SIGMASK returns saved_sigmask
is it's set.  PTRACE_SETSIGMASK drops the TIF_RESTORE_SIGMASK flag.

Link: http://lkml.kernel.org/r/20181120060616.6043-1-avagin@gmail.com
Fixes: 29000caecbe8 ("ptrace: add ability to get/set signal-blocked mask")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

Hello Andrew,

This patch is in a queue for a long time and it looks like you are
waiting ack from Oleg. He said the patch is fine:
https://www.spinics.net/lists/kernel/msg2972154.html

And promised to send a formal ack in reply to this email.

 include/linux/sched/signal.h | 18 ++++++++++++++++++
 kernel/ptrace.c              | 15 +++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ae5655197698..e412c092c1e8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -418,10 +418,20 @@ static inline void set_restore_sigmask(void)
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
@@ -439,6 +449,10 @@ static inline void set_restore_sigmask(void)
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
@@ -447,6 +461,10 @@ static inline bool test_restore_sigmask(void)
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
2.20.1

