Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2754206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J17iip5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfC2PzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:55:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfC2Pyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:54:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3389753wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbGs6cXysQS/1wimRaZF4lv67CXXZOSGEKKdeAccz9k=;
        b=J17iip5+1whmGxqox3jotNQjRRLRTtq4T6CIWNXJqX1qPo4dNfcaLZeHYd3/aJEzv+
         oi0kMpjGKHpjRI9wSUks22e7H96rpjSTISLnjczYwMlvklYe1XbouG5V5LNQCupas2Fk
         G477QvVluhn7CWRMR0pLuACr0Wa8sg96nMqeZw4DaB8hAsDR95WgycgngD5xi9NOE2xR
         VkBlsBsSfB0c87LRLu4qqGVl4CN6V0kvYQ119KLAA0IkjBfaM8IhZZJEozTlLQwVn368
         zd3kYwbi+z+fKsJEwlsgB326F5mAM+xDzdPYAzOjjvwYu0pNlaFXHEX7lMNmRXZXYmH5
         HCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbGs6cXysQS/1wimRaZF4lv67CXXZOSGEKKdeAccz9k=;
        b=JETUDOzwETf6Er0T0IE5kKwPjPIOxioAlJbqFD5TRcDa1MlNAz0/AJb8oRIZD7PHTC
         pb/xB7k5B9HcKOkigjyB7MO0/F3m2dfOX9OkFnMXFy+fClKstWXZDbinXNcDkA5tAtTc
         hN5SKx4o6VGckcye+z1edVuDftOtvIKl7WsSLSsH1VgVYhX8VlO6JvNFfvRpQ8wsxdEB
         EgVhNuJxZEhMUd0rbYfF3itraHGUf0ViFxy02Wxb0eDbyCuZ8wOhvfBb0iIS1oZ97SKf
         XVx/Lg9tIgvY5FcIwfOn4TcCZ723/CWTLzYU6AnjY0epyErT2rFB0sxIrCVQIjlpenbn
         lwCg==
X-Gm-Message-State: APjAAAWGE8Matm75W52C4ILskc5Trv8ym4iCX52FYTi9sbPQzvT3S6ny
        vZj1WTWdjmINlXGzjBTYI+46mQ==
X-Google-Smtp-Source: APXvYqzwksvIrvNoiAXcEpNRw4BP5tJad6M1aGZEpovD6PcY7lkijIbqEOR27shIx3mSjNa5bFIvKg==
X-Received: by 2002:a1c:a8d3:: with SMTP id r202mr4333551wme.106.1553874888767;
        Fri, 29 Mar 2019 08:54:48 -0700 (PDT)
Received: from localhost.localdomain (p2E5A5955.dip0.t-ipconnect.de. [46.90.89.85])
        by smtp.gmail.com with ESMTPSA id e1sm4177959wrw.66.2019.03.29.08.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:54:48 -0700 (PDT)
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
Subject: [PATCH v2 4/5] signal: PIDFD_SIGNAL_TID threads via pidfds
Date:   Fri, 29 Mar 2019 16:54:24 +0100
Message-Id: <20190329155425.26059-5-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329155425.26059-1-christian@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of pidfd_open() it is possible for users to reference a
specific thread by doing:

int pidfd = pidfd_open(<tid>, 0);

This means we can extend pidfd_send_signal() to signal a specific thread.
As promised in the commit for pidfd_send_signal() [1] the extension is
based on a flag argument, i.e. the scope of the signal delivery is based on
the flag argument, not on the type of file descriptor.
To this end the flag PIDFD_SIGNAL_TID is added. With this change we now
cover most of the functionality of all the other signal sending functions
combined:

- pidfd_send_signal(<pidfd>, <sig>, NULL, 0);
  which is equivalent to
  kill(<positive-pid>, <signal>)

- pidfd_send_signal(<pidfd>, <sig>, <info>, 0);
  which is equivalent to
  rt_sigqueueinfo(<tgid>, <sig>, <uinfo>)

- pidfd_send_signal(<pidfd>, <sig>, NULL, PIDFD_SIGNAL_TID);
  which is equivalent to
  tgkill(<tgid>, <tid>, <signal)

  rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
- pidfd_send_signal(<pidfd>, <sig>, <info>, PIDFD_SIGNAL_TID);
  which is equivalent to
  rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)

/* References */
[1]: commit 3eb39f47934 ("signal: add pidfd_send_signal() syscall")

Signed-off-by: Christian Brauner <christian@brauner.io>
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
 include/uapi/linux/wait.h |   3 +
 kernel/signal.c           | 116 ++++++++++++++++++++++++++------------
 2 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
index d6c7c0701997..b72f0ef84fe5 100644
--- a/include/uapi/linux/wait.h
+++ b/include/uapi/linux/wait.h
@@ -21,4 +21,7 @@
 /* Get a file descriptor for /proc/<pid> of the corresponding pidfd */
 #define PIDFD_GET_PROCFD _IOR('p', 1, int)
 
+/* Flags to pass to pidfd_send_signal */
+#define PIDFD_SIGNAL_TID 1 /* Send signal to specific thread */
+
 #endif /* _UAPI_LINUX_WAIT_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index eb97d0cc6ef7..9f93da85b2b9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3557,17 +3557,86 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
+static int __do_send_specific(struct task_struct *p, int sig,
+			      struct kernel_siginfo *info)
+{
+	int error = -ESRCH;
+
+	error = check_kill_permission(sig, info, p);
+	/*
+	 * The null signal is a permissions and process existence probe.
+	 * No signal is actually delivered.
+	 */
+	if (!error && sig) {
+		error = do_send_sig_info(sig, info, p, PIDTYPE_PID);
+		/*
+		 * If lock_task_sighand() failed we pretend the task
+		 * dies after receiving the signal. The window is tiny,
+		 * and the signal is private anyway.
+		 */
+		if (unlikely(error == -ESRCH))
+			error = 0;
+	}
+
+	return error;
+}
+
+static int do_send_specific(pid_t tgid, pid_t pid, int sig,
+			    struct kernel_siginfo *info)
+{
+	struct task_struct *p;
+	int error = -ESRCH;
+
+	rcu_read_lock();
+	p = find_task_by_vpid(pid);
+	if (p && (tgid <= 0 || task_tgid_vnr(p) == tgid))
+		error = __do_send_specific(p, sig, info);
+	rcu_read_unlock();
+
+	return error;
+}
+
+static int pidfd_send_signal_specific(struct pid *pid, int sig,
+				      struct kernel_siginfo *info)
+{
+	struct task_struct *p;
+	int error = -ESRCH;
+
+	rcu_read_lock();
+	p = pid_task(pid, PIDTYPE_PID);
+	if (p)
+		error = __do_send_specific(p, sig, info);
+	rcu_read_unlock();
+
+	return error;
+}
+
 /**
- * sys_pidfd_send_signal - send a signal to a process through a task file
- *                          descriptor
+ * sys_pidfd_send_signal - send a signal to a process through a pidfd
+
  * @pidfd:  the file descriptor of the process
  * @sig:    signal to be sent
  * @info:   the signal info
  * @flags:  future flags to be passed
  *
- * The syscall currently only signals via PIDTYPE_PID which covers
- * kill(<positive-pid>, <signal>. It does not signal threads or process
- * groups.
+ * The syscall currently covers:
+ * - pidfd_send_signal(<pidfd>, <sig>, NULL, 0);
+ *   which is equivalent to
+ *   kill(<positive-pid>, <signal>)
+ *
+ * - pidfd_send_signal(<pidfd>, <sig>, <info>, 0);
+ *   which is equivalent to
+ *   rt_sigqueueinfo(<tgid>, <sig>, <uinfo>)
+ *
+ * - pidfd_send_signal(<pidfd>, <sig>, NULL, PIDFD_SIGNAL_TID);
+ *   which is equivalent to
+ *   tgkill(<tgid>, <tid>, <signal)
+ *
+ *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
+ * - pidfd_send_signal(<pidfd>, <sig>, <info>, PIDFD_SIGNAL_TID);
+ *   which is equivalent to
+ *   rt_tgsigqueueinfo(<tgid>, <tid>, <sig>, <uinfo>)
+ *
  * In order to extend the syscall to threads and process groups the @flags
  * argument should be used. In essence, the @flags argument will determine
  * what is signaled and not the file descriptor itself. Put in other words,
@@ -3585,7 +3654,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	kernel_siginfo_t kinfo;
 
 	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags)
+	if (flags & ~PIDFD_SIGNAL_TID)
 		return -EINVAL;
 
 	f = fdget(pidfd);
@@ -3626,43 +3695,16 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo);
 	}
 
-	ret = kill_pid_info(sig, &kinfo, pid);
+	if (flags & PIDFD_SIGNAL_TID)
+		ret = pidfd_send_signal_specific(pid, sig, &kinfo);
+	else
+		ret = kill_pid_info(sig, &kinfo, pid);
 
 err:
 	fdput(f);
 	return ret;
 }
 
-static int
-do_send_specific(pid_t tgid, pid_t pid, int sig, struct kernel_siginfo *info)
-{
-	struct task_struct *p;
-	int error = -ESRCH;
-
-	rcu_read_lock();
-	p = find_task_by_vpid(pid);
-	if (p && (tgid <= 0 || task_tgid_vnr(p) == tgid)) {
-		error = check_kill_permission(sig, info, p);
-		/*
-		 * The null signal is a permissions and process existence
-		 * probe.  No signal is actually delivered.
-		 */
-		if (!error && sig) {
-			error = do_send_sig_info(sig, info, p, PIDTYPE_PID);
-			/*
-			 * If lock_task_sighand() failed we pretend the task
-			 * dies after receiving the signal. The window is tiny,
-			 * and the signal is private anyway.
-			 */
-			if (unlikely(error == -ESRCH))
-				error = 0;
-		}
-	}
-	rcu_read_unlock();
-
-	return error;
-}
-
 static int do_tkill(pid_t tgid, pid_t pid, int sig)
 {
 	struct kernel_siginfo info;
-- 
2.21.0

