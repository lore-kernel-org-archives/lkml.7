Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2FB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b3QN/RlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfCYQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:21:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40566 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfCYQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:21:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so8077213edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlmVmhFtFF17R2zMjcoi9Xir9ccCsOLRnLsfBQhOtUo=;
        b=b3QN/RlTe1ztWUa4ytFtz7sQ96KQC+Zsf6g+NluXWHi63bTRZ28JYZVhIWnuhuHA6H
         WExnksbnIymOFveTkiVDCp/e+iCBeoPVxv9r2aBuGM3o57NI78POoV8mCj2cJSV/vB6c
         0tMM4AtpDm/Jm67GNesUe1QUSEaXJdcDihguQ4tOR/GgA3AD6ACh/CftHOtq+pKCD5dn
         G3TgLa6M/1jhuIvqlPPjdcyzJc9IaTQ8Q7obr6IPxJICYodE9UoL1cQLmtFwg0J5qmXO
         QyObitLpIAyTdokRN6wRHHccrWskA0jEheMwbaD946+kUEsAW2Ws9ZZWTcZDaO+0tI0C
         mzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlmVmhFtFF17R2zMjcoi9Xir9ccCsOLRnLsfBQhOtUo=;
        b=eHp851pqcLwjIHMFq35oHWjMCQr3bw3TgXkuuK/+m/JB9jI+I02GizOD9eG1I/9uNP
         5Is/0GOKHyeuxzTn3c99adfy69gVOs4U9SlKNl+wqssQNCD4wKWsEd2jiIvVGu+yiwqx
         5HxEUUIgg+DhDVNpoKsbXRry6tWOHoD5zrZ0Cd9NxRksoDAtNOfE890Y/MvMj8NPS6Wx
         9l6MqWQKTnfZNWK6tjfhx696fsuP9vgRjxhlJgv8vlMcXXB+XK67l4ljYKsbJBiq3nfW
         QLjjXrEZaFczNTMP05MfvU+Cyl8HNsfsfUqqgYIi9vCdQC2w7mCaXpupm2yIHfbrDq7W
         emxA==
X-Gm-Message-State: APjAAAX9y8gAjTqILlwConBk7nD7SGvCG+sQzv4OzxR7SM6rXyJlXUWC
        pzpJBa1rTmU1qUqSW8xdFJ7Yvw==
X-Google-Smtp-Source: APXvYqw/QAA7Pr6GIQxpcCkDnN44HZsfanOxP/Usp1NrFR1Hwaoy9FKPLg2yFsFaGBKuetz/JXc75A==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr14738909ejf.21.1553530882701;
        Mon, 25 Mar 2019 09:21:22 -0700 (PDT)
Received: from localhost.localdomain ([193.96.224.244])
        by smtp.gmail.com with ESMTPSA id e45sm5027759edd.3.2019.03.25.09.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:21:22 -0700 (PDT)
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
Subject: [PATCH 3/4] signal: support pidctl() with pidfd_send_signal()
Date:   Mon, 25 Mar 2019 17:20:51 +0100
Message-Id: <20190325162052.28987-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325162052.28987-1-christian@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
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
 kernel/signal.c | 20 +++++++++-----------
 kernel/sys_ni.c |  3 ---
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..d77183be1677 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3513,7 +3513,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 	return kill_something_info(sig, &info, pid);
 }
 
-#ifdef CONFIG_PROC_FS
 /*
  * Verify that the signaler and signalee either are in the same pid namespace
  * or that the signaler's pid namespace is an ancestor of the signalee's pid
@@ -3521,16 +3520,13 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
  */
 static bool access_pidfd_pidns(struct pid *pid)
 {
+	int ret;
 	struct pid_namespace *active = task_active_pid_ns(current);
 	struct pid_namespace *p = ns_of_pid(pid);
 
-	for (;;) {
-		if (!p)
-			return false;
-		if (p == active)
-			break;
-		p = p->parent;
-	}
+	ret = pidnscmp(active, p);
+	if (ret < 0)
+		return false;
 
 	return true;
 }
@@ -3581,12 +3577,15 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (flags)
 		return -EINVAL;
 
-	f = fdget_raw(pidfd);
+	f = fdget(pidfd);
 	if (!f.file)
 		return -EBADF;
 
 	/* Is this a pidfd? */
-	pid = tgid_pidfd_to_pid(f.file);
+	if (f.file->f_op == &pidfd_fops)
+		pid = f.file->private_data;
+	else
+		pid = tgid_pidfd_to_pid(f.file);
 	if (IS_ERR(pid)) {
 		ret = PTR_ERR(pid);
 		goto err;
@@ -3625,7 +3624,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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

