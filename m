Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F2C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFEF21738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ezztaJ0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfC0WTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:19:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40236 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfC0WTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:19:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so15490794edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLtjwEAo6dHd3Q0YdwPoEYvw8wxE9iWpDqCggNGnMXo=;
        b=ezztaJ0zi2QMV3967vZVYkbWiukgtfwBNxWSPC9zCiVh1zM4iZ9kYfwjhleJnzjl8Z
         4AFxMcOyQ/3EJLffkzgmyP3OAaiMsHHuCwsMYetXBsAS9tu0uW8pDi9Pyym6n4rsLjgg
         g2meSXfTb4LdDPUOMgpKRoxfqN2Oah5/jSIUBf4W04OqHg0zJxTt+ajd2vm24OSf+6Lf
         uA1MMRYY0+z9pBku0s0uZdOWqRIKYIbLYUi2qN6uT1NevmQLiLQaJd2S2x5NlSi+M2TJ
         4S8l0FDaukDriyK8TvD6xa1A/petIM1kYVrk9ivVOe/Q9mTeCcvGt2foYPbo8530wNoO
         IFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLtjwEAo6dHd3Q0YdwPoEYvw8wxE9iWpDqCggNGnMXo=;
        b=FbrMg1ScGROVJrXwzLfaRPg2d4P+0FtNt23U4rvv/IiTalmCztF1fjKH8dgvIUIgxJ
         agGIO1RFONytFZvRlXBoqI3f8P2POeD3T/areWZxuAg03fSreXazS2ZoSQoyuKOa6T9Q
         VAQ6x3rXLH7LANL2RoofmyY3SjTynJQ8g2c6KpWwQkPSDs+L7/tsk0K6qmAu5m55guRQ
         FKGOKh2koW7cu7QcRWcLklWa9UkpjHRvFrxq0zfRORxfI5XMwuxGkESh/+vu1sZGMvx0
         /tY29zaMZ2GATQMBcbomvjdi/MbrNkrI+2QJr9LRp4rHFm5kC2uezBrSu3DNWr17EcJC
         +yqg==
X-Gm-Message-State: APjAAAUjoyQCO0UrwWtifgq49KJ3HSubBneHe/hKeAsaL/Ky9AHUMJDP
        Ermk28WM6gApQtEAZoiZMrTnYQ==
X-Google-Smtp-Source: APXvYqwW2JrWix4CaJqoQfiEyTb9AIX0xJUerFUQHS3MjBp2sEfFRDr0ROVa5kMToG/leTCBEtZ3Xg==
X-Received: by 2002:a17:906:48c7:: with SMTP id d7mr22156541ejt.225.1553725184255;
        Wed, 27 Mar 2019 15:19:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id l20sm1878067ejb.30.2019.03.27.15.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:19:43 -0700 (PDT)
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
Subject: [PATCH v1 3/4] signal: support pidfd_open() with pidfd_send_signal()
Date:   Wed, 27 Mar 2019 23:19:09 +0100
Message-Id: <20190327221910.5897-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327221910.5897-1-christian@brauner.io>
References: <20190327221910.5897-1-christian@brauner.io>
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

