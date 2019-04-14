Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D869C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686B020870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Vj/jiFcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfDNUPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:15:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45008 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfDNUPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:15:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id i13so2136052edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKb4yFbXfLa/OJu4W+klncoNvbQ/la4YBpWHSraXapU=;
        b=Vj/jiFcqlYZA5zr7Ul6mvdSXRcj2EOIzUzXdXbfq4fXZCtVsiR/FJU/Vfd3XqMYVkf
         2ttQY1B0v9peEZYVX2HHoWJFBg+YiAmatRe1MUnTus0IvtgEePeSxmR6esSqGJsRzd4R
         UBoWLyGVIyrldrGUgV8vsCozVMnfo5V0gu5L/R84mwD9JbLqDy7nR3NARHXaB+a/PdXz
         MAzAzq+/1JlB5pbVYfVc0VSRO/2v2Km4+ptBMFQ0JBXuWRlXUJVixeoKK/QO7x51O3WW
         ixjNwaCA6T8uMo4fh+ayXcuv5KAlvHYokSsKNrP/KWQk/RZ3+RFmtFJb2noFXfUxXEjw
         iqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKb4yFbXfLa/OJu4W+klncoNvbQ/la4YBpWHSraXapU=;
        b=nBLDJ39K+XojLzRO90XH9M4xzs9Qpzq4IgohiOpZ7XzuDMYgPC8XfMJSNIMI8h2O/D
         I1v9fO3o7X32lVWhy+LPMnlE9OF77nAFX4PhycQYIyXGcwKGSkrgm9zwaW2dkjNx7AyC
         A15pSN82OeDnCm0eQ9a/J5C0O+iewr0pNPxEITaEn+S46a6XrIvu4w2qdtbN5SzSP0/a
         SNGQaPQzqN796vetkgbmbN4/nxhWtWBXR6TMcZMSbAGr0OxJ4tqmpEpzYLD3VqMjTOVX
         SpPFZyIEYeNonIOnWizr7mDbqOQq8Wi1OmGOUsibHbM5L3PEdACkiWAwyW9EiuEamRIR
         f+Yw==
X-Gm-Message-State: APjAAAVwBclQdL5r0kSQ4VLdtwR3WGs/4uR0thYlck//cE3c2NsfDxvj
        DJr69FlNa1v3g80SjNqwgVoFag==
X-Google-Smtp-Source: APXvYqz4XVdSiX5Phe4PaHGu9jDyuBsQ8QTHmoSRtSYllFq0e6GFbHWqqBjg3peEMtsSlTlwTwR6Lg==
X-Received: by 2002:a17:906:374a:: with SMTP id e10mr28185988ejc.182.1555272916613;
        Sun, 14 Apr 2019 13:15:16 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id n21sm3383068edq.14.2019.04.14.13.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:15:16 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Date:   Sun, 14 Apr 2019 22:14:35 +0200
Message-Id: <20190414201436.19502-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414201436.19502-1-christian@brauner.io>
References: <20190414201436.19502-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let pidfd_send_signal() use pidfds retrieved via CLONE_PIDFD. With this
patch pidfd_send_signal() becomes independent of procfs. This fullfils the
request made when we merged the pidfd_send_signal() patchset. The
pidfd_send_signal() syscall is now always available allowing for it to be
used by users without procfs mounted or even users without procfs support
compiled into the kernel.

Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Jann Horn <jann@thejh.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/signal.c | 14 ++++++++++----
 kernel/sys_ni.c |  3 ---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f98448cf2def..cd83cc376767 100644
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
@@ -3581,12 +3588,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (flags)
 		return -EINVAL;
 
-	f = fdget_raw(pidfd);
+	f = fdget(pidfd);
 	if (!f.file)
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

