Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB450C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBF420882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfEJQW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJQW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:22:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4B74308FC20;
        Fri, 10 May 2019 16:22:27 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 197BB5D6A9;
        Fri, 10 May 2019 16:22:13 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org, ebiederm@xmission.com,
        oleg@redhat.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak111 V2] audit: deliver signal_info regarless of syscall
Date:   Fri, 10 May 2019 12:21:49 -0400
Message-Id: <67828806f9d2bf0f1e98e24afa58af55c8c8678f.1557358701.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 10 May 2019 16:22:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process signals the audit daemon (shutdown, rotate, resume,
reconfig) but syscall auditing is not enabled, we still want to know the
identity of the process sending the signal to the audit daemon.

Move audit_signal_info() out of syscall auditing to general auditing but
create a new function audit_signal_info_syscall() to take care of the
syscall dependent parts for when syscall auditing is enabled.

Please see the github kernel audit issue
https://github.com/linux-audit/audit-kernel/issues/111

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Changelog:
v2:
- change patch title to avoid siginfo_t confusion
- change return value to "0" from AUDIT_OFF
- use dummy functions instead of macros in header files

Compile/boot/test auditsyscall enable/disable, audit disable,
auditsyscall enable/selinux disable.

 include/linux/audit.h |  9 +++++++++
 kernel/audit.c        | 27 +++++++++++++++++++++++++++
 kernel/audit.h        |  8 ++++++--
 kernel/auditsc.c      | 19 +++----------------
 kernel/signal.c       |  2 +-
 5 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 43a23e28ba23..b4078560cb73 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -196,6 +196,9 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
 }
 
 extern u32 audit_enabled;
+
+extern int audit_signal_info(int sig, struct task_struct *t);
+
 #else /* CONFIG_AUDIT */
 static inline __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
@@ -249,6 +252,12 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
 }
 
 #define audit_enabled AUDIT_OFF
+
+static inline int audit_signal_info(int sig, struct task_struct *t)
+{
+	return 0;
+}
+
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_AUDIT_COMPAT_GENERIC
diff --git a/kernel/audit.c b/kernel/audit.c
index b96bf69183f4..67399ff72d43 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2274,6 +2274,33 @@ int audit_set_loginuid(kuid_t loginuid)
 }
 
 /**
+ * audit_signal_info - record signal info for shutting down audit subsystem
+ * @sig: signal value
+ * @t: task being signaled
+ *
+ * If the audit subsystem is being terminated, record the task (pid)
+ * and uid that is doing that.
+ */
+int audit_signal_info(int sig, struct task_struct *t)
+{
+	kuid_t uid = current_uid(), auid;
+
+	if (auditd_test_task(t) &&
+	    (sig == SIGTERM || sig == SIGHUP ||
+	     sig == SIGUSR1 || sig == SIGUSR2)) {
+		audit_sig_pid = task_tgid_nr(current);
+		auid = audit_get_loginuid(current);
+		if (uid_valid(auid))
+			audit_sig_uid = auid;
+		else
+			audit_sig_uid = uid;
+		security_task_getsecid(current, &audit_sig_sid);
+	}
+
+	return audit_signal_info_syscall(t);
+}
+
+/**
  * audit_log_end - end one audit record
  * @ab: the audit_buffer
  *
diff --git a/kernel/audit.h b/kernel/audit.h
index 958d5b8fc1b3..e5df0c125e2d 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -299,7 +299,7 @@ extern bool audit_tree_match(struct audit_chunk *chunk,
 extern void audit_put_tree(struct audit_tree *tree);
 extern void audit_kill_trees(struct audit_context *context);
 
-extern int audit_signal_info(int sig, struct task_struct *t);
+extern int audit_signal_info_syscall(struct task_struct *t);
 extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
@@ -330,7 +330,11 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 #define audit_tree_path(rule) ""	/* never called */
 #define audit_kill_trees(context) BUG()
 
-#define audit_signal_info(s, t) AUDIT_DISABLED
+static inline int audit_signal_info_syscall(struct task_struct *t)
+{
+	return 0;
+}
+
 #define audit_filter_inodes(t, c) AUDIT_DISABLED
 #endif /* CONFIG_AUDITSYSCALL */
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5371b59bde36..3209640df2cb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2360,30 +2360,17 @@ void __audit_ptrace(struct task_struct *t)
 }
 
 /**
- * audit_signal_info - record signal info for shutting down audit subsystem
- * @sig: signal value
+ * audit_signal_info_syscall - record signal info for syscalls
  * @t: task being signaled
  *
  * If the audit subsystem is being terminated, record the task (pid)
  * and uid that is doing that.
  */
-int audit_signal_info(int sig, struct task_struct *t)
+int audit_signal_info_syscall(struct task_struct *t)
 {
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
-	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
-
-	if (auditd_test_task(t) &&
-	    (sig == SIGTERM || sig == SIGHUP ||
-	     sig == SIGUSR1 || sig == SIGUSR2)) {
-		audit_sig_pid = task_tgid_nr(current);
-		auid = audit_get_loginuid(current);
-		if (uid_valid(auid))
-			audit_sig_uid = auid;
-		else
-			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
-	}
+	kuid_t t_uid = task_uid(t);
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
diff --git a/kernel/signal.c b/kernel/signal.c
index b7953934aa99..73db5dfa797d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -43,6 +43,7 @@
 #include <linux/compiler.h>
 #include <linux/posix-timers.h>
 #include <linux/livepatch.h>
+#include <linux/audit.h>	/* audit_signal_info() */
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -52,7 +53,6 @@
 #include <asm/unistd.h>
 #include <asm/siginfo.h>
 #include <asm/cacheflush.h>
-#include "audit.h"	/* audit_signal_info() */
 
 /*
  * SLAB caches for signal bits.
-- 
1.8.3.1

