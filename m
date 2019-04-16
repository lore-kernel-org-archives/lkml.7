Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BCBC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B1420872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GGhdTz8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfDPRFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:05:07 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39173 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDPRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:05:06 -0400
Received: by mail-vk1-f194.google.com with SMTP id s80so4592759vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CB0a/z1DKBAR/CBfIEc1puxs5zWRnS7xbdC3R7PlbdE=;
        b=GGhdTz8ppAcpxB9rySOfzaqsT4qCqXaYudhe5AFls1xQkAKmn5IeLDoJCYlxqF+BVS
         IfYGSbxyZiGkjPoz6JHr53kN69HDudSEGApb6DVJDLlp6cS8eepkOVAsZSrID4qZTbuF
         DjpUldt8bI/hPpChuzV4rECckjSKjyV8pmkpMqGW+YGwFND5n1iMwQ3KKhkoqBci0dZV
         Bt3J8kBG8cotMYKLG5UDp5J9oyxxavoNl5TBEUDNAzWy5oFO+S29NkNjlyCWFT2WKoxj
         v78yskifIqsE52N6h7TEDaML1iDyoXLgjPxjehhu6MtxXeqi5h8PevxVGVHKJaAM5kMN
         MbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB0a/z1DKBAR/CBfIEc1puxs5zWRnS7xbdC3R7PlbdE=;
        b=XrYNlxAlZQBdO0fEFm7Ge7y3ZPS3POnqg/g3GJhzkYV24Etq77kC2mi8GMjoVYDEDt
         T6KqrB7AADQ9mKBTn4bRnWxgvJt/V1qvy8fS3cy1xOnDE+2RA0OsY7D0NImup7KwjGnt
         X0cs0TSpvoJSUOE+R23zQldAXndW0lZDn4YcgkrPcNlKc1C9Ra6o+gPto2JUw3+gNdKN
         0xYnKa9XD+k5ElcaS2u6bVlLg+dfmJvWO/gqwgMWGp4ojSzYeE6sa8NrsItpP/ZXp+oP
         bpy382bGdk7jxWHhcs/UVg8OQWHdQzRCOVrbiGsAjy6lvNazGFZ9R7aVv7YzZTSlrRUE
         YUIw==
X-Gm-Message-State: APjAAAV5CdEKXXSEebw15mF/6HrHl2HzQUK6cfFO9Qp8o/b6pfr2TaC+
        s6q4xGvmlscwBHIS+jVibp2J2A==
X-Google-Smtp-Source: APXvYqxcqGZQ54N/Kyvp3jY/4YD/5ORZmupHzld08QiwP2bw/hJHYq41PbXAiqYc9pkwunXNrnZo2A==
X-Received: by 2002:a1f:850c:: with SMTP id h12mr45481805vkd.70.1555434305219;
        Tue, 16 Apr 2019 10:05:05 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
        by smtp.gmail.com with ESMTPSA id c192sm45178368vka.10.2019.04.16.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:05:04 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Date:   Tue, 16 Apr 2019 19:02:32 +0200
Message-Id: <20190416170233.10208-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416170233.10208-1-christian@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
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

