Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CD1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85972183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JHdcxAbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfDRKTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:19:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33640 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388595AbfDRKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:19:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so1371764ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NPruNiTZOmEOtPyLgn5BfelJiHp0PqiRMUV1YAkDEE=;
        b=JHdcxAbHEQN7dxqQgORwHTlZmuwikiwWK3bp9KTnyNFHyhipSuPKMZ3EnK+ACadXyt
         UYsWxPpdrOEq139v0LnDpxld6jfyXdqPaFmuPD2fNo5kK14KxUziq1eJdbULdGVgCN9k
         spJ/y0ouBAKv8y4pekrQu3TE8sZjRdsSIm8vW0htoXk2o8EAzRwvaZkz0Nhc3aNKvlEz
         5FcRJaA2wda+P4LjWGhfFBu6tXQ1cDcN1NlajLE5Ul91eXOkWNAFy37YVabJXEYeaQp6
         Y7PJ7W0f4H9dkYRQXrHUxuYHtt97T7fXLliSiUOzbFSyg9+WhFfZ6MCAew5U17m+93Mc
         2yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NPruNiTZOmEOtPyLgn5BfelJiHp0PqiRMUV1YAkDEE=;
        b=dZgQimjjRo4K4FALufufrjitT5HSJUsL3Nj2d4DLh+J+AIjSHfZadonK59GzlxcWik
         bCsjFaMte1IaDyTvnkw+5EHIMaLpPZXoEOlhn2sareC9Uue9O1aDrNXUWPl1c9kLJQqS
         qmf2Vnsc7EkqHg/Qbk1+Ol9CVdiPzJEtuUyMHY3M7fRxHpZAezHyaIgsmQBBj0efwoa8
         tsmtD30520jwlL0NMYVHrtoXr3XjgcahQMW6NZKbxGxSW3DlEP5auJCDfbIvG4dlZSO4
         Z6luIlWVVZ8wylmOjR8bKpVzGbz851EaZyEWBeC2zBDyoLZZKj+ihDVvjCBDUyeoZM2f
         MDmg==
X-Gm-Message-State: APjAAAXVs2mw+BqCW9Qk0ZAa7foZV5YGMDgBRfRgKslKOxtJM8L60het
        eICXx8wm/oJV3nc0nZhOOWdXNQ==
X-Google-Smtp-Source: APXvYqzGjzLxPA7gMZCC81gQdaNCjECGM7I/CS219Gug2ov3/QOTxNhXfY9oKTUrPLJp9pItrqE0CA==
X-Received: by 2002:aa7:dd8d:: with SMTP id g13mr3525527edv.290.1555582765730;
        Thu, 18 Apr 2019 03:19:25 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 31sm400479edf.18.2019.04.18.03.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:19:24 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 4/5] signal: support CLONE_PIDFD with pidfd_send_signal
Date:   Thu, 18 Apr 2019 12:18:40 +0200
Message-Id: <20190418101841.4476-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418101841.4476-1-christian@brauner.io>
References: <20190418101841.4476-1-christian@brauner.io>
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
/* changelog */
v1: patch unchanged
v2:
- Oleg Nesterov <oleg@redhat.com>:
  - split s/fdget_raw()/fdget()/ into separate patch as it has nothing to
    do with supporting CLONE_PIDFD
---
 kernel/signal.c | 12 +++++++++---
 kernel/sys_ni.c |  3 ---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 227ba170298e..cd83cc376767 100644
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

