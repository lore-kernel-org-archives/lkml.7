Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697E021850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="B2xydfKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDJXnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:43:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44890 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfDJXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:43:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id d11so3526983edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVX5reAEHqnZSbEGBIMo8Lhd3+eWF1qq+60vX7BrME8=;
        b=B2xydfKZ+g574j63z5QKy/gb2oZGMBXu7aRhxEhkQGMP5EcvGPfhsZI+yHTHNr/CMV
         NMZKTVuWnh/QH4tjo8rIKcbh1M03ilvOLg+RpJ/lkyTzFmw4GnHKFRloMYyUjjOPp3eG
         30r5Ud/2XSrgACQnHNvsCelcp55pvIl1YoPHD4YGw0xIQqNGmlt9NwFAJBMA8cx+yPLa
         Z0cCl8uroFiRx9+a0OKxWJLh8yTG1jEkx5+KqCmlEv0nKdYWX9F652eZ9vBkynlA2Bmo
         q2nRAm2IHMIfoeMNdzqNnlbkyIpycmoRCgxpgAsNI7jDzGjlDNCMxlU6V1Gqv9e/CoWk
         sG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVX5reAEHqnZSbEGBIMo8Lhd3+eWF1qq+60vX7BrME8=;
        b=hxxxCt8tBRBOgKbAAekk5BGnIHJAbuBs72mJt3jbaUoJKlLDcyNljkmptPFIB869O4
         iAgoBfKQbGsk8rzr9XVrUbgCh5P9rGhUDSQLh6qMa5j9wfYSE9usitS9cK43KtmHdxNw
         zKTRGiAlIpLD8nFDLRrOVoBWhegaHO7iLgf/v+h6D8wHEk7TV6o1YF5kdPjxfmw81SQP
         ne5qWgC7bQ+EhqGutRmDC6QIK78VdTEh3YkinuBlDb0TP7XEb15L1+6jCq+OYD+PVGhk
         PaSfgWvWGuNuWS0dDTqAHii/27ADa0wScQRol1UPcY4PdDsEthLTQrPbso4Bas3+yJBX
         G1Ig==
X-Gm-Message-State: APjAAAVwBx6mjPyhDhARVs4DhEAarPAZu5AiNxUIg++nNtC4mycx0HC3
        f2Edoxkz8zRCfMqeq9IWmjzXkg==
X-Google-Smtp-Source: APXvYqxe80uPSrNoWwADu8qpMRdBOVwtoXwIxCs/YtEWhWqfjF65Fxpw1yGQX9N/zn8PyR4d1SBy9w==
X-Received: by 2002:a17:906:3589:: with SMTP id o9mr8163512ejb.193.1554939815378;
        Wed, 10 Apr 2019 16:43:35 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f8sm4833015edt.36.2019.04.10.16.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:43:34 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [RFC-2 PATCH 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Date:   Thu, 11 Apr 2019 01:40:44 +0200
Message-Id: <20190410234045.29846-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410234045.29846-1-christian@brauner.io>
References: <20190410234045.29846-1-christian@brauner.io>
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
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
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

