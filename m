Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F9C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A8F20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfEWAkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:40:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57239 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfEWAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:40:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmF-00087u-DY; Wed, 22 May 2019 18:40:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmD-0005Z3-E5; Wed, 22 May 2019 18:40:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:38:51 -0500
Message-Id: <20190523003916.20726-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbmD-0005Z3-E5;;;mid=<20190523003916.20726-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oLSyth5cPdfAB5jZdENZxJdpgNbS/kZE=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 01/26] signal: Correct namespace fixups of si_pid and si_uid
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function send_signal was split from __send_signal so that it would
be possible to bypass the namespace logic based upon current[1].  As it
turns out the si_pid and the si_uid fixup are both inappropriate in
the case of kill_pid_usb_asyncio so move that logic into send_signal.

It is difficult to arrange but possible for a signal with an si_code
of SI_TIMER or SI_SIGIO to be sent across namespace boundaries.  In
which case tests for when it is ok to change si_pid and si_uid based
on SI_FROMUSER are incorrect.  Replace the use of SI_FROMUSER with a
new test has_si_pid_and_used based on siginfo_layout.

Now that the uid fixup is no longer present after expanding
SEND_SIG_NOINFO properly calculate the si_uid that the target
task needs to read.

[1] 7978b567d315 ("signals: add from_ancestor_ns parameter to send_signal()")
Cc: stable@vger.kernel.org
Fixes: 6588c1e3ff01 ("signals: SI_USER: Masquerade si_pid when crossing pid ns boundary")
Fixes: 6b550f949594 ("user namespace: make signal.c respect user namespaces")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 67 +++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 18040d6bd63a..39a3eca5ce22 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1056,27 +1056,6 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
 
-#ifdef CONFIG_USER_NS
-static inline void userns_fixup_signal_uid(struct kernel_siginfo *info, struct task_struct *t)
-{
-	if (current_user_ns() == task_cred_xxx(t, user_ns))
-		return;
-
-	if (SI_FROMKERNEL(info))
-		return;
-
-	rcu_read_lock();
-	info->si_uid = from_kuid_munged(task_cred_xxx(t, user_ns),
-					make_kuid(current_user_ns(), info->si_uid));
-	rcu_read_unlock();
-}
-#else
-static inline void userns_fixup_signal_uid(struct kernel_siginfo *info, struct task_struct *t)
-{
-	return;
-}
-#endif
-
 static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
 			enum pid_type type, int from_ancestor_ns)
 {
@@ -1134,7 +1113,11 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			q->info.si_code = SI_USER;
 			q->info.si_pid = task_tgid_nr_ns(current,
 							task_active_pid_ns(t));
-			q->info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
+			rcu_read_lock();
+			q->info.si_uid =
+				from_kuid_munged(task_cred_xxx(t, user_ns),
+						 current_uid());
+			rcu_read_unlock();
 			break;
 		case (unsigned long) SEND_SIG_PRIV:
 			clear_siginfo(&q->info);
@@ -1146,13 +1129,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			break;
 		default:
 			copy_siginfo(&q->info, info);
-			if (from_ancestor_ns)
-				q->info.si_pid = 0;
 			break;
 		}
-
-		userns_fixup_signal_uid(&q->info, t);
-
 	} else if (!is_si_special(info)) {
 		if (sig >= SIGRTMIN && info->si_code != SI_USER) {
 			/*
@@ -1196,6 +1174,28 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	return ret;
 }
 
+static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
+{
+	bool ret = false;
+	switch (siginfo_layout(info->si_signo, info->si_code)) {
+	case SIL_KILL:
+	case SIL_CHLD:
+	case SIL_RT:
+		ret = true;
+		break;
+	case SIL_TIMER:
+	case SIL_POLL:
+	case SIL_FAULT:
+	case SIL_FAULT_MCEERR:
+	case SIL_FAULT_BNDERR:
+	case SIL_FAULT_PKUERR:
+	case SIL_SYS:
+		ret = false;
+		break;
+	}
+	return ret;
+}
+
 static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
 			enum pid_type type)
 {
@@ -1205,7 +1205,20 @@ static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct
 	from_ancestor_ns = si_fromuser(info) &&
 			   !task_pid_nr_ns(current, task_active_pid_ns(t));
 #endif
+	if (!is_si_special(info) && has_si_pid_and_uid(info)) {
+		struct user_namespace *t_user_ns;
 
+		rcu_read_lock();
+		t_user_ns = task_cred_xxx(t, user_ns);
+		if (current_user_ns() != t_user_ns) {
+			kuid_t uid = make_kuid(current_user_ns(), info->si_uid);
+			info->si_uid = from_kuid_munged(t_user_ns, uid);
+		}
+		rcu_read_unlock();
+
+		if (!task_pid_nr_ns(current, task_active_pid_ns(t)))
+			info->si_pid = 0;
+	}
 	return __send_signal(sig, info, t, type, from_ancestor_ns);
 }
 
-- 
2.21.0

