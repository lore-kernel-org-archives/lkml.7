Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A0F204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J/X3jmVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfDSTPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:15:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56024 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfDSTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:15:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so7136915wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82EFZ7vKSv7vxsYrF12VZ/Sb+9R+E/StMhhz8Y5TMKo=;
        b=J/X3jmVFRp/D4PbIASgD0BG37kfEhiPTgiEyorbMDbTyk3Jus4ZFKNBjI1IocLXijA
         NjZ+vhK1K+HJhPAvjO+oxrBqViA7oSYHFiNrraVADF00mWgztJtvIor7TiNVwE3m/La6
         Rgi6vCg/r/51vL6FDwpJg4iHtId0zC3dFP5JhfFgqU067rHJ5Bo8yjrC0yxzUsJVxHCF
         IB+m8GxX/Wb0BZjTewa2qBiSinjW8tPs4YCtYqqqIhNEPE5D1vEXUwxxLrtP01gGgvgi
         3AgZC6qfOO87eF+CudfrmN04isVL5H2Dw9LtQJLd6v87za9GkEbcYs4RmSxrrJVXXgQ6
         8frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82EFZ7vKSv7vxsYrF12VZ/Sb+9R+E/StMhhz8Y5TMKo=;
        b=lU540KOW1PIIpCUbFnDOdF+icdZGn7lWNk6qz6FycpQ4iqt0Q1642Pafe6gE4t7Q7+
         vDvwc67jN/w6qG18EQr1MjJqhnH7b6OYWJzJgVMNYvPrbfVG9rqHV6c3EMMZFW4VyS8o
         hcX8ONFWQbhXdbBKjIgHrd+6IafxqSxFLwiqIFwx13RZEdL2TvDAGLCnO0Azv9o4v+p4
         D7PmABdhvXQnFDBa+1IjY0gGyKoE47dRT3fRcQ1WCFzATlZWXSPrqIRJSYOoMcn6uFG4
         ZgpqmPDfWjuGngKM12pSTMqcKoRdl+GCb2hYx05KSjyiuPmb4+Nzk+uLWD2UZwopi1Rm
         IkPg==
X-Gm-Message-State: APjAAAUN//q0N8/9mY8EstA6ERVi56kTjoydUCKtedH6O78J3io25fhH
        /AaenMvJaS9F8JzvslGhy+aNAI4bMGMcqg==
X-Google-Smtp-Source: APXvYqzQna4k1Ge5YEKku7bjz8MkZ7vadTogxKgSxpuZcLMSZcGmPe44S8jQRapIlh0xTIXo/n54cw==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr2431985wme.126.1555675768965;
        Fri, 19 Apr 2019 05:09:28 -0700 (PDT)
Received: from localhost.localdomain ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id f128sm6464574wme.28.2019.04.19.05.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 05:09:28 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jann@thejh.net>
Subject: [PATCH v3 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Date:   Fri, 19 Apr 2019 14:09:03 +0200
Message-Id: <20190419120904.27502-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190419120904.27502-1-christian@brauner.io>
References: <20190419120904.27502-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let pidfd_send_signal() use pidfds retrieved via CLONE_PIDFD.  With this
patch pidfd_send_signal() becomes independent of procfs.  This fullfils
the request made when we merged the pidfd_send_signal() patchset.  The
pidfd_send_signal() syscall is now always available allowing for it to
be used by users without procfs mounted or even users without procfs
support compiled into the kernel.

Signed-off-by: Christian Brauner <christian@brauner.io>
Co-developed-by: Jann Horn <jann@thejh.net>
Signed-off-by: Jann Horn <jann@thejh.net>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
/* changelog */
v1: patch unchanged
v2:
- Oleg Nesterov <oleg@redhat.com>:
  - split s/fdget_raw()/fdget()/ into separate patch as it has nothing to
    do with supporting CLONE_PIDFD
v3:
- Christian Brauner <christian@brauner.io>:
  - Linus has applied the s/fdget_raw()/fdget()/ patch right away so the
    patch is gone from the series
---
 kernel/signal.c | 12 +++++++++---
 kernel/sys_ni.c |  3 ---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f98448cf2def..1581140f2d99 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3513,7 +3513,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 	return kill_something_info(sig, &info, pid);
 }
 
-#ifdef CONFIG_PROC_FS
 /*
  * Verify that the signaler and signalee either are in the same pid namespace
  * or that the signaler's pid namespace is an ancestor of the signalee's pid
@@ -3550,6 +3549,14 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
 	return copy_siginfo_from_user(kinfo, info);
 }
 
+static struct pid *pidfd_to_pid(const struct file *file)
+{
+	if (file->f_op == &pidfd_fops)
+		return file->private_data;
+
+	return tgid_pidfd_to_pid(file);
+}
+
 /**
  * sys_pidfd_send_signal - send a signal to a process through a task file
  *                          descriptor
@@ -3586,7 +3593,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		return -EBADF;
 
 	/* Is this a pidfd? */
-	pid = tgid_pidfd_to_pid(f.file);
+	pid = pidfd_to_pid(f.file);
 	if (IS_ERR(pid)) {
 		ret = PTR_ERR(pid);
 		goto err;
@@ -3620,7 +3627,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	fdput(f);
 	return ret;
 }
-#endif /* CONFIG_PROC_FS */
 
 static int
 do_send_specific(pid_t tgid, pid_t pid, int sig, struct kernel_siginfo *info)
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d21f4befaea4..4d9ae5ea6caf 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -167,9 +167,6 @@ COND_SYSCALL(syslog);
 
 /* kernel/sched/core.c */
 
-/* kernel/signal.c */
-COND_SYSCALL(pidfd_send_signal);
-
 /* kernel/sys.c */
 COND_SYSCALL(setregid);
 COND_SYSCALL(setgid);
-- 
2.21.0

