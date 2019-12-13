Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381EC341C5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE63F2469B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLMUxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:53:19 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfLMUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:53:16 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MeDYt-1i6oQm1xF1-00bIho; Fri, 13 Dec 2019 21:53:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 06/24] acct: stop using get_seconds()
Date:   Fri, 13 Dec 2019 21:52:11 +0100
Message-Id: <20191213205221.3787308-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:st6X4iFmtJPxqaDEnWHJh5aO982P37Ptwn8bOhTHFWKcELag9Vj
 u9uy/F7aNCOxmXM8GDWXhPfPSVohIQLF/cpqmdRNDJlyjs5FoLkKZXuOl1wSWlYQ+1kjRh1
 MXR+HAXY+hf6qeZTKw5iO08MRRwWmloaOTspzIIzU3UYsnTgVrHP72aqgmTNlwyM7j30jQ2
 ewbhl+TxIIDPyaymGx+bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/P5Nke/yFgs=:XJpZhgz8TDetTezFII4o2+
 eXtRcfcirHDAi9Zi9JHrQDJaNR+fsE6lgyR707lukk/IkDM5bdUiibJAQ8wFN2sk1x185EgE5
 aCcIicl9JjgSh/3cxoeTedHnNmfg1HeleLIzCjxIYdYjLvquUQ0glGyP5LwcXSoExbYO6mVFE
 k5kXjzj8TxswNKV/NprsXkAmOdvMes1Rgz3pO19JRyXoMNqziMbjrT341AOaPEXbSC6gUGf8p
 abvoniCwWC0GkuJYSjw2qu97X5on4kRIS5wWU0dL6v9u9eg+tZWj5NVZz5prgYthgfvZ1yMjH
 Qe298ynwsh/zQY702mgpyvtXeNkSWK3fE6Fm5xoSfSYpDL2Tm86jGicej116D5fLtske8/c2N
 qThlrJvEkG/VomPdkDfKgJB7SE9E18ESIoOhHB8chd0fkzMSCF3jTzC4/OKRvC3kLQTp6xkuy
 p+F3k62RNvB9ErWZq4Ul8Cu3fgdqnoxHT6J9uGyYilnUH8HCDjxYVfz9j2O212z6ouv1yzqIq
 iT1G4fOMAVL4Pf2abMV4314Xdj/8ZCqa+wNa2okbhe9kfPM2TG3Nd9agKIBIF5IDGQgeJSbH0
 bf3F/RlQJ9IGAfWsNOt3X1fbZjlPQqnz7WL3pHPfZgEyCNq6bAEMKQlpJUovkamad/tr3BC+D
 DsQTqla5WW7KA1bmzTQ7nYz2YWitL+QoR9Ws1azKdiaa0vl4DEVUbXGEMoCDOkMP4VyzzSbYP
 wLYnd/v1HIBAAgmrdLwXsj9HYxHN6PaZSaC0NXOI1y9HrOUJTCNKeDSOy1MXmBb3HzdrvBIbW
 BSRYylPiHr0k8ZgJbYFXWRqFac/9Cl0riOhWctfDhLU8LLgOIgGzpCem/gwaLXqQOKHzi5wXc
 EIJXG1qqpjICfJ6VXKwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'struct acct', 'struct acct_v3', and 'struct taskstats' we have
a 32-bit 'ac_btime' field containing an absolute time value, which
will overflow in year 2106.

There are two possible ways to deal with it:

a) let it overflow and have user space code deal with reconstructing
   the data based on the current time, or
b) truncate the times based on the range of the u32 type.

Neither of them solves the actual problem. Pick the second
one to best document what the issue is, and have someone
fix it in a future version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/acct.h      | 2 ++
 include/uapi/linux/taskstats.h | 1 +
 kernel/acct.c                  | 4 +++-
 kernel/tsacct.c                | 8 +++++---
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/acct.h b/include/uapi/linux/acct.h
index 0e72172cd23a..985b89068591 100644
--- a/include/uapi/linux/acct.h
+++ b/include/uapi/linux/acct.h
@@ -49,6 +49,7 @@ struct acct
 	__u16		ac_uid16;		/* LSB of Real User ID */
 	__u16		ac_gid16;		/* LSB of Real Group ID */
 	__u16		ac_tty;			/* Control Terminal */
+	/* __u32 range means times from 1970 to 2106 */
 	__u32		ac_btime;		/* Process Creation Time */
 	comp_t		ac_utime;		/* User Time */
 	comp_t		ac_stime;		/* System Time */
@@ -81,6 +82,7 @@ struct acct_v3
 	__u32		ac_gid;			/* Real Group ID */
 	__u32		ac_pid;			/* Process ID */
 	__u32		ac_ppid;		/* Parent Process ID */
+	/* __u32 range means times from 1970 to 2106 */
 	__u32		ac_btime;		/* Process Creation Time */
 #ifdef __KERNEL__
 	__u32		ac_etime;		/* Elapsed Time */
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 5e8ca16a9079..7d3ea366e93b 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -112,6 +112,7 @@ struct taskstats {
 	__u32	ac_gid;			/* Group ID */
 	__u32	ac_pid;			/* Process ID */
 	__u32	ac_ppid;		/* Parent process ID */
+	/* __u32 range means times from 1970 to 2106 */
 	__u32	ac_btime;		/* Begin time [sec since 1970] */
 	__u64	ac_etime __attribute__((aligned(8)));
 					/* Elapsed time [usec] */
diff --git a/kernel/acct.c b/kernel/acct.c
index 81f9831a7859..11ff4a596d6b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -416,6 +416,7 @@ static void fill_ac(acct_t *ac)
 {
 	struct pacct_struct *pacct = &current->signal->pacct;
 	u64 elapsed, run_time;
+	time64_t btime;
 	struct tty_struct *tty;
 
 	/*
@@ -448,7 +449,8 @@ static void fill_ac(acct_t *ac)
 	}
 #endif
 	do_div(elapsed, AHZ);
-	ac->ac_btime = get_seconds() - elapsed;
+	btime = ktime_get_real_seconds() - elapsed;
+	ac->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
 #if ACCT_VERSION==2
 	ac->ac_ahz = AHZ;
 #endif
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 7be3e7530841..ab12616ee6fb 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,6 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 delta;
+	time64_t btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
@@ -32,9 +33,10 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	/* Convert to micro seconds */
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
-	/* Convert to seconds for btime */
-	do_div(delta, USEC_PER_SEC);
-	stats->ac_btime = get_seconds() - delta;
+	/* Convert to seconds for btime (note y2106 limit) */
+	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
+	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
+
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
 		if (tsk->flags & PF_FORKNOEXEC)
-- 
2.20.0

