Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C6FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7F3215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfKHVfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:35:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:37887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbfKHVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:35:51 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MyK1E-1hheq037vA-00yfkO; Fri, 08 Nov 2019 22:35:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>
Subject: [PATCH 07/16] acct: stop using get_seconds()
Date:   Fri,  8 Nov 2019 22:32:45 +0100
Message-Id: <20191108213257.3097633-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MvCmw8KZeUaCp8UqvAYmNhTL2rs0z/UL28/zpU8LBknjj8+U4pP
 pcYX5LoofEAaw6KYwpc6x17n34w/sKg6L9j6t/L4zZY7B6fKAZcIUpK2mXEKU8Mtbj4Q2de
 qEnNGj9XgUf9aYvlWbmVmwSRw8O38+8uX8yuBMGU4hHJBR5GtxWSYqgHkPFpXB8gbkFLvcZ
 QhE0VAW7PqzOU1XQoLp5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RFwLd9Ulic=:rITuPaqqQQO0WKu19dX8Tj
 Jm7c02EzCGuP2qODrhxkcuhXNv2+4aBeDdZAo7JiVra27cEP9Hmuv7YtlJbIiLsjeUbEFRznA
 g8TLpWCooqVYSlFnCJerjeLaKicNV1Gu2OixEJ/GARxSKas1KXt+0OSrkQMtH0zC3FH1W5dfz
 KP8tk56zSUp9hKHChaDeYdZnIeNqdfCMTL6fNOFqcQc0HLofvEo5imk6WDHgjmnsda8LvhDpH
 APU1qxqtGaIhQ13KNvWNfGPnf//JNE0ypNnraxc16pPQc0rFp0p0sp40M6dnc7ATGxI2tgOLM
 IW2m+4uqKbX8OzjW1s2Oy2PRkedwtZBOUULXgPZE8QGZt1gRHZSBKvkDkUtWqwnVf8teTdjA7
 vat1HR6p1GTIHWniLEMmhBtVCmsOHEXDK6hRXY3IFPInVNfs9CQvxO3uPwvMfinYcwXJevRza
 1fCHW3LXFAWGfXiUqHBMG+blCR8T8bGKYlmdBYH1DfdpYctFWXgIwZA5iw6uXjeyvAikAkOxZ
 z+QeI/N816XcY2gNgQuoM+n0ZANbrSuyBgLqJ8JFgSrZzaSatmEYFd6VjMwMPf8t/zhweL89d
 Keq4AL/5KVX6aiNLg+dBuDgBQbr55y6tBBnvI4P5urfLwhqyjxUEP9hbx4pEWrjZY4TuqsKnk
 7cn1T8pzkv2e10YFZNYA+twYD6mkk46atnArJi3BwNorZuv/0+FI3f6PIU3A0iA9YG+/yixDa
 mYTbtvuAZir5DhVTF1YxfoSJh4wQgPn/JKEVo1Kr93/7BFIZrClvLomRphRhpRKm7eqLu/XuX
 6J++42E3FR02EP8nlHBG8YZ/kh3gNCQNiJsZWa8OMViGYhshwLGQuFrrPD4YmUuX9oE3R/9IK
 EIfRk5sFTd+jO5CSffig==
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

