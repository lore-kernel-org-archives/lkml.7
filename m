Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C75218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JRbHmAxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfC2Pyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:54:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36887 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfC2Pys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:54:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so3389623wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zOT/6oGGO4RfpwVu2MvpDDHcC8R10yK6ORxwddccZg=;
        b=JRbHmAxpKrESMLUb7fysNYHKP1egJaCeqdpjqqqX9Z9UO46o7mMn9nubxgIgpGXO2e
         GfWBvnShb/hM1FLPwivc07JZ7M3yS0yKqcTrW492Dm3UCOAGfuzw+dLSQjM2iNk1LwXP
         IbqIm3zSI2ZVepVbltlccGYemq+W4OeTOvtw/1hCgQ0EpN9wGA/0OhF0CqtcFc5Hz219
         4tDII8M1g+eVH/gg+SXdkzBADs90Y4zGmPIG+mSZrHt/FnckcJZMw3jlA1Y3sZuKesUW
         PBnLmatHE5mhScD9fOPy+YMpXfZRPY1A5vMkPyKgbXz23GBpivjazHkvtvh0jYPYKEUV
         tUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zOT/6oGGO4RfpwVu2MvpDDHcC8R10yK6ORxwddccZg=;
        b=Xj9zHVwZLzcbHYS3Ic6WvikLYU3o/3o35Wz0rxWrTVfFWJge3kSteMYn1IpGZunp5T
         BUWEZuAM8WRxaukuDSpYX4tid6P1WHm2mfftXDOIhxx5odk0AJB0IoB/HSP52IuvEk0u
         r1tcxgB6OTWLIwPFXuIcqiZnTxiofjYeJIRr7NmvPGKDac/ntJT6kxAmeCgewjJVO+Ia
         uMw0Rjmuw5IB66ajBt4EaTl/raDyooLnhorephRzSJRvboK0YKyBvDYjp0OnNTYpIa9c
         layAx6K2jpOgC8r5mrLrRDACdG1HfOlvXhlZK6NEyOsWm/AhsfXkSOVcxWf0OjbEhL6W
         naqw==
X-Gm-Message-State: APjAAAV8JqU2W8zCNFECSSKqqJPgnnuO3WAaxl0V02PSO240r9m4n8Kn
        Zm9e35m5YdwdFbk5/5iQG8hCsQ==
X-Google-Smtp-Source: APXvYqydjxGJF1mVV7NaTK++SUcz56WkHFoazk6WFIhC79ZxWIZiIzh+YpmWIXx6BVZVdjRMV2CwHw==
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr3996879wme.108.1553874887122;
        Fri, 29 Mar 2019 08:54:47 -0700 (PDT)
Received: from localhost.localdomain (p2E5A5955.dip0.t-ipconnect.de. [46.90.89.85])
        by smtp.gmail.com with ESMTPSA id e1sm4177959wrw.66.2019.03.29.08.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:54:46 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        keescook@chromium.org, adobriyan@gmail.com, tglx@linutronix.de,
        mtk.manpages@gmail.com, bl0pbl33p@gmail.com, ldv@altlinux.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>,
        Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2 3/5] signal: support pidfd_open() with pidfd_send_signal()
Date:   Fri, 29 Mar 2019 16:54:23 +0100
Message-Id: <20190329155425.26059-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329155425.26059-1-christian@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let pidfd_send_signal() use pidfds retrieved via pidfd_open(). With this
patch pidfd_send_signal() becomes independent of procfs. This fullfils the
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
Cc: Florian Weimer <fweimer@redhat.com>
---
 kernel/signal.c | 14 ++++++++++----
 kernel/sys_ni.c |  3 ---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..eb97d0cc6ef7 100644
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
@@ -3625,7 +3632,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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

