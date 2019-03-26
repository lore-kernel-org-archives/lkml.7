Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0B320863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QPkoGYyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfCZPzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:55:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43329 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfCZPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:55:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so11200944ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Am79s2MFtzwlkWft6tgxKw2/+gmntcoPiF3kdxza7Ks=;
        b=QPkoGYyq9jG/c+yahCkGLHgm7+cQ0QfEl3djUkJEmJdXJ6dz63TGU27NBLHJi7FNsz
         BwqroFAEamY4Wzh9/fBsPLILtGBdtvCbntta5h8rBzD0LNt+ykFqRgCcaantMTiyVctn
         vngxmJiu5QrktVOrYSAClTkFt5TGlZ0zV5vKVNLwQjfyuERqWdidbt50zyehLuLVD7Rb
         F2PMzswfFpPoHyL0P4Vb9udMl1N5jVTAAepZhw59A4qs8i/QUXZG1vxwhEhHnF2sgpMV
         pjRnTvGNofRkeghCoYOvLHd4IeO5rH3Wv6bdKa/50eANrr5+6J1wYw/gsnXfncS4znaK
         X44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Am79s2MFtzwlkWft6tgxKw2/+gmntcoPiF3kdxza7Ks=;
        b=rkj/wF+HxcxMqCVz7hdGRq9d5IZNzhWqJBSzvIDUHBz9+ydw3pEKh3lUmB1P7WU73F
         mLI1TMHLi0z+A3yxJmg5AZ6cyyQMGZvaEzE8Plz51hHn7akuV65Y0rLhyuN4bRIMg1zl
         g8LM043Eit5XtkBeQZJc/kHsT9PLCGBv7H953RnQ8kLNMyx2cBxexalPyrVenzma5mF/
         5DCvt1ePMOD4JmCPlvEB6n4YZfYw2Git2kp0NI+8SegFrSvAjMeOdAFxctsUmjfrtyoD
         V1f+/6dcqlGO2px5XBwmCxqcPBuwlHLEpCnGoLKQlgU16xJFE3zcIpysIn9KdK7qXlQX
         UqpQ==
X-Gm-Message-State: APjAAAVqlcGfvXcXZJK45dO8OuQxQ2lkk4/5iuONfVZmL+KXEdOGyg5S
        zL7RYlwIIXOGnaRDuSpESCJyGA==
X-Google-Smtp-Source: APXvYqyJ3bv4uynMpAv72qQ1srwqtkBCQ5gcIW4XNMD7nXCYf9lUec/QUC7VDKAr9nqVaqZmwNl5pQ==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr8341180ejr.101.1553615731704;
        Tue, 26 Mar 2019 08:55:31 -0700 (PDT)
Received: from localhost.localdomain (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id k32sm6651057ede.97.2019.03.26.08.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:55:31 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 3/4] signal: support pidctl() with pidfd_send_signal()
Date:   Tue, 26 Mar 2019 16:55:12 +0100
Message-Id: <20190326155513.26964-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326155513.26964-1-christian@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let pidfd_send_signal() use pidfds retrieved via pidctl(). With this patch
pidfd_send_signal() becomes independent of procfs. This fullfils the
request made when we merged the pidfd_send_signal() patchset. The
pidfd_send_signal() syscall is now always available allowing for it to be
used by users without procfs mounted or even users without procfs support
compiled into the kernel.

Signed-off-by: Christian Brauner <christian@brauner.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
/* changelog */
v1:
- Jann Horn <jannh@google.com> in [1]:
  - make access_pidfd_pidns() more readable
---
 kernel/signal.c | 29 ++++++++++++-----------------
 kernel/sys_ni.c |  3 ---
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..7bdeda8333c8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3513,26 +3513,14 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 	return kill_something_info(sig, &info, pid);
 }
 
-#ifdef CONFIG_PROC_FS
 /*
  * Verify that the signaler and signalee either are in the same pid namespace
  * or that the signaler's pid namespace is an ancestor of the signalee's pid
  * namespace.
  */
-static bool access_pidfd_pidns(struct pid *pid)
+static inline bool access_pidfd_pidns(struct pid *pid)
 {
-	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *p = ns_of_pid(pid);
-
-	for (;;) {
-		if (!p)
-			return false;
-		if (p == active)
-			break;
-		p = p->parent;
-	}
-
-	return true;
+	return pidnscmp(task_active_pid_ns(current), ns_of_pid(pid)) >= 0;
 }
 
 static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
@@ -3550,6 +3538,14 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
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
@@ -3581,12 +3577,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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
@@ -3625,7 +3621,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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

