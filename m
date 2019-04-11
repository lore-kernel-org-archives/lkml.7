Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BC920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsQW3DxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDKBoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:44:08 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:48352 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDKBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:44:05 -0400
Received: by mail-yb1-f201.google.com with SMTP id u125so3214202ybb.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PyLdI7PZk1GSB43N13T7W74jY1CSZ1+A35vi7emlRBQ=;
        b=FsQW3DxUQfr3UEIOZaRtKQ14YG36rNMZAoP4RXuDnHZhTnzx8vfU+n++RB/3o0dp0u
         SH9s3G7Hv6ADWQtomsgGHp312SSsN6EYFO/ZI8x3zaQMzGdV60aG2if6ijB0CU2Xj/5p
         Wr+u7Wyb361ndUXGOOmlpRDdcHAAPNwaAxiqvx8CH06ziaPdVT7gmlngsPDr1J560YOg
         I5i/EcCf6HzZpeddrmKyHhq3l9q6cka24b266kjFb1tp+leUWTHkX9an5xjDZPYer8TK
         J/UNaD9DJCmOSB51Myj5q3PE83dNf3d9ehU/VPU0ePxzOZUM8hhQHSuA7EePSmvIH3LA
         aFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PyLdI7PZk1GSB43N13T7W74jY1CSZ1+A35vi7emlRBQ=;
        b=TQ8UDMv7MaV/Z+H8EaKA3U72CySp1UDnV9V9ya5gd3MU4SOuDOIN84He25tRPcecdH
         RMhSy2TB0/1RLgqM7uYdcgweXhbtn9z6u5RC5PCVAIfaIy8Og8I++nge/aAraHqU6V8g
         WMauJ+x8U7rIX8jW46xMhgsq4brvCJGWzh9c4BRNdHKm72jO3Wfl6T7KpzmiBkHo3CMX
         oHddXV0mkgb4ijgKTOZSh3xHnQMPrjNKH+4yLPDrqx6XMgFtegzHq5oXxa/YWghExMWC
         Z2dkGaILWSgs2mQFG7ftxxVgfCTb1VNye8pZ2nP5m5O3pFFNkFWnIKAJNKx6ErXbeMHK
         wsiQ==
X-Gm-Message-State: APjAAAXXwYa7lDfU20uY98UuLpRK8xT6NCe31EjhftWaoYciTw7u+KQE
        TjXTBs00MES/uBsAQq0SeXN8uN9Din4=
X-Google-Smtp-Source: APXvYqzoYtryft6snCAH2tsCLNm6pZ/FkqZ/mICxzIwSzE/D420FbpbEJQwThBXlAukM5+6xtF5vw2sOQK0=
X-Received: by 2002:a25:5:: with SMTP id 5mr10518104yba.52.1554947044969; Wed,
 10 Apr 2019 18:44:04 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:43:53 -0700
In-Reply-To: <20190411014353.113252-1-surenb@google.com>
Message-Id: <20190411014353.113252-3-surenb@google.com>
Mime-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, surenb@google.com,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SS_EXPEDITE flag to be used when sending SIGKILL via
pidfd_send_signal() syscall to allow expedited memory reclaim of the
victim process. The usage of this flag is currently limited to SIGKILL
signal and only to privileged users.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/sched/signal.h |  3 ++-
 include/linux/signal.h       | 11 ++++++++++-
 ipc/mqueue.c                 |  2 +-
 kernel/signal.c              | 37 ++++++++++++++++++++++++++++--------
 kernel/time/itimer.c         |  2 +-
 5 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e412c092c1e8..8a227633a058 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -327,7 +327,8 @@ extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig, struct task_struct *p);
 extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
-extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
+extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid,
+				bool expedite);
 extern int kill_pid_info_as_cred(int, struct kernel_siginfo *, struct pid *,
 				const struct cred *);
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..34b7852aa4a0 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -446,8 +446,17 @@ int __save_altstack(stack_t __user *, unsigned long);
 } while (0);
 
 #ifdef CONFIG_PROC_FS
+
+/*
+ * SS_FLAGS values used in pidfd_send_signal:
+ *
+ * SS_EXPEDITE indicates desire to expedite the operation.
+ */
+#define SS_EXPEDITE	0x00000001
+
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
-#endif
+
+#endif /* CONFIG_PROC_FS */
 
 #endif /* _LINUX_SIGNAL_H */
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index aea30530c472..27c66296e08e 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -720,7 +720,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 			rcu_read_unlock();
 
 			kill_pid_info(info->notify.sigev_signo,
-				      &sig_i, info->notify_owner);
+				      &sig_i, info->notify_owner, false);
 			break;
 		case SIGEV_THREAD:
 			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
diff --git a/kernel/signal.c b/kernel/signal.c
index f98448cf2def..02ed4332d17c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -43,6 +43,7 @@
 #include <linux/compiler.h>
 #include <linux/posix-timers.h>
 #include <linux/livepatch.h>
+#include <linux/oom.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1394,7 +1395,8 @@ int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp)
 	return success ? 0 : retval;
 }
 
-int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
+int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid,
+				  bool expedite)
 {
 	int error = -ESRCH;
 	struct task_struct *p;
@@ -1402,8 +1404,17 @@ int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
 	for (;;) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		if (p)
+		if (p) {
 			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
+
+			/*
+			 * Ignore expedite_reclaim return value, it is best
+			 * effort only.
+			 */
+			if (!error && expedite)
+				expedite_reclaim(p);
+		}
+
 		rcu_read_unlock();
 		if (likely(!p || error != -ESRCH))
 			return error;
@@ -1420,7 +1431,7 @@ static int kill_proc_info(int sig, struct kernel_siginfo *info, pid_t pid)
 {
 	int error;
 	rcu_read_lock();
-	error = kill_pid_info(sig, info, find_vpid(pid));
+	error = kill_pid_info(sig, info, find_vpid(pid), false);
 	rcu_read_unlock();
 	return error;
 }
@@ -1487,7 +1498,7 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 
 	if (pid > 0) {
 		rcu_read_lock();
-		ret = kill_pid_info(sig, info, find_vpid(pid));
+		ret = kill_pid_info(sig, info, find_vpid(pid), false);
 		rcu_read_unlock();
 		return ret;
 	}
@@ -1704,7 +1715,7 @@ EXPORT_SYMBOL(kill_pgrp);
 
 int kill_pid(struct pid *pid, int sig, int priv)
 {
-	return kill_pid_info(sig, __si_special(priv), pid);
+	return kill_pid_info(sig, __si_special(priv), pid, false);
 }
 EXPORT_SYMBOL(kill_pid);
 
@@ -3577,10 +3588,20 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 
-	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags)
+	/* Enforce no unknown flags. */
+	if (flags & ~SS_EXPEDITE)
 		return -EINVAL;
 
+	if (flags & SS_EXPEDITE) {
+		/* Enforce SS_EXPEDITE to be used with SIGKILL only. */
+		if (sig != SIGKILL)
+			return -EINVAL;
+
+		/* Limit expedited killing to privileged users only. */
+		if (!capable(CAP_SYS_NICE))
+			return -EPERM;
+	}
+
 	f = fdget_raw(pidfd);
 	if (!f.file)
 		return -EBADF;
@@ -3614,7 +3635,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		prepare_kill_siginfo(sig, &kinfo);
 	}
 
-	ret = kill_pid_info(sig, &kinfo, pid);
+	ret = kill_pid_info(sig, &kinfo, pid, (flags & SS_EXPEDITE) != 0);
 
 err:
 	fdput(f);
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 02068b2d5862..c926483cdb53 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -140,7 +140,7 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 	struct pid *leader_pid = sig->pids[PIDTYPE_TGID];
 
 	trace_itimer_expire(ITIMER_REAL, leader_pid, 0);
-	kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid);
+	kill_pid_info(SIGALRM, SEND_SIG_PRIV, leader_pid, false);
 
 	return HRTIMER_NORESTART;
 }
-- 
2.21.0.392.gf8f6787159e-goog

