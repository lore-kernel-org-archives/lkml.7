Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1014CC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B7E2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="q837jNoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLIHG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:06:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41801 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfLIHG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:06:28 -0500
Received: by mail-io1-f66.google.com with SMTP id z26so13599132iot.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x0zFCiNSlnKRNEU0PtYMiqhfPhNw5nhVhlLq429PWcE=;
        b=q837jNoBniTeMoYtnAR+6omfLc1FBnL86g8L/0jn/p82DR8/jzDstLy0yM1z6TrSzO
         karFYyVlUA5IGN9Fqoq9c0VCIO7ONjO0RGki513iNTkqC5ppxg3QC2qevsDJ9cg4bk8B
         SHuLKcfGDmk/Sw5K2eaL1R4Lcj45qqwhChcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x0zFCiNSlnKRNEU0PtYMiqhfPhNw5nhVhlLq429PWcE=;
        b=jK5eRWhdaPN+GQSgo4ZGt3eJpI/UbGAannW+DocwDv0nFl+aJMgCtor0H/6/xZynRe
         y6KKVxPT70hEFkVNgyvcFp1sHyZ4xk7eVjd2Lkvv0bmpTMtK42KUwdfNfd+pf8beobx8
         /7n73lmCcGMAGT9yr9K/HPf8LCFA/He6AQ3fgLrpzgi5x7HTtfpT/ilp3Ys9WDis8eih
         +N8frNsRFfL87xXm1tb2cZIRq3GDAYMB6FXTLrzMOcp6yyV80+pOv7LKqFTjvbGiZF4/
         Tt2kfgfhCzn1Lm60ASvpOOWkNWpONKcMHJJWb9N3LF6RR54qbiowHja5jD2wlQjNg7g0
         sizA==
X-Gm-Message-State: APjAAAUoAGAjfp+LAWxy+5/tM2dYCymqoOuhBekVUQJARvGaV5P81PmU
        AMacDrFCmDpctyCQg+MxWsL/6WQtZBSu8Q==
X-Google-Smtp-Source: APXvYqyDfQlM7pHEBJ/gVfNz5VDaQQGyeYboFaFJupGYMYurTWZgjUCsv1wSQCHxdF+eTACDu0iJ6w==
X-Received: by 2002:a02:944b:: with SMTP id a69mr19733945jai.141.1575875186342;
        Sun, 08 Dec 2019 23:06:26 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id g64sm5304851ioa.78.2019.12.08.23.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 23:06:25 -0800 (PST)
Date:   Mon, 9 Dec 2019 07:06:24 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 2/4] ptrace: add PTRACE_GETFD request to fetch file
 descriptors from tracees
Message-ID: <20191209070621.GA32450@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_GETFD is a generic ptrace API that allows the tracer to
get file descriptors from the tracee.

One reason to use this is to allow sandboxers to take actions on file
descriptors on the behalf of a tracee. For example, this can be
combined with seccomp-bpf's user notification to ptrace on-demand and
capture an fd without requiring the tracer to always be attached to
the process. The tracer can then take a privileged action on behalf
of the tracee, like binding a socket to a privileged port.

It works whether or not the tracee is stopped. The only prior requirement
is that the tracer is attached to the process via PTRACE_ATTACH or
PTRACE_SEIZE. Stopping the process breaks certain runtimes that expect
to be able to preempt syscalls (quickly). In addition, it is meant to be
used in an on-demand fashion to avoid breaking debuggers.

The ptrace call takes a pointer to ptrace_getfd_args in data, and the
size of the structure in addr. There is an options field, which can
be used to state whether the fd should be opened with CLOEXEC, or not.
This options field may be extended in the future to include the ability
to clear cgroup information about the file descriptor at a later point.
If the structure is from a newer kernel, and includes members which
make it larger than the structure that's known to this kernel version,
E2BIG will be returned.

The requirement that the tracer has attached to the tracee prior to the
capture of the file descriptor may be lifted at a later point.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/ptrace.h | 15 +++++++++++++++
 kernel/ptrace.c             | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index a71b6e3b03eb..c84655bcc453 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -101,6 +101,21 @@ struct ptrace_syscall_info {
 	};
 };
 
+/*
+ * This gets a file descriptor from a process. It requires that the process
+ * has either been attached to. It does not require that the process is
+ * stopped.
+ */
+#define PTRACE_GETFD	0x420f
+
+/* options to pass in to ptrace_getfd_args */
+#define PTRACE_GETFD_O_CLOEXEC	(1 << 0)	/* open the fd with cloexec */
+
+struct ptrace_getfd_args {
+	__u32 fd;	/* the tracee's file descriptor to get */
+	__u32 options;
+} __attribute__((packed));
+
 /*
  * These values are stored in task->ptrace_message
  * by tracehook_report_syscall_* to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index cb9ddcc08119..8f619dceac6f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -31,6 +31,7 @@
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
+#include <linux/fdtable.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -994,6 +995,33 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 }
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
+static int ptrace_getfd(struct task_struct *child, unsigned long user_size,
+			void __user *datavp)
+{
+	struct ptrace_getfd_args args;
+	unsigned int fd_flags = 0;
+	struct file *file;
+	int ret;
+
+	ret = copy_struct_from_user(&args, sizeof(args), datavp, user_size);
+	if (ret)
+		goto out;
+	if ((args.options & ~(PTRACE_GETFD_O_CLOEXEC)) != 0)
+		return -EINVAL;
+	if (args.options & PTRACE_GETFD_O_CLOEXEC)
+		fd_flags &= O_CLOEXEC;
+	file = get_task_file(child, args.fd);
+	if (!file)
+		return -EBADF;
+	ret = get_unused_fd_flags(fd_flags);
+	if (ret >= 0)
+		fd_install(ret, file);
+	else
+		fput(file);
+out:
+	return ret;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
 {
@@ -1222,7 +1250,9 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_SECCOMP_GET_METADATA:
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
-
+	case PTRACE_GETFD:
+		ret = ptrace_getfd(child, addr, datavp);
+		break;
 	default:
 		break;
 	}
@@ -1265,7 +1295,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 	}
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+				  request == PTRACE_INTERRUPT ||
+				  request == PTRACE_GETFD);
 	if (ret < 0)
 		goto out_put_task_struct;
 
-- 
2.20.1

