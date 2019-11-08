Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD805FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF1E207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbfKHVRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:17:17 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:17:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MOzjW-1iGzrf2lB6-00POk9; Fri, 08 Nov 2019 22:17:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 18/23] y2038: itimer: compat handling to itimer.c
Date:   Fri,  8 Nov 2019 22:12:17 +0100
Message-Id: <20191108211323.1806194-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sKTu+aehkLi4mpZI9L51qCcvfZPOune5jAXYr+8eQpsLlW4QCre
 AVECqXdKoJqyYpWVKN5iXyYkggKuyzdskAvwx8c4fwEmHcSu598+x8PAkTdgBJOBRnYqTiR
 PH+RnasU01ZA26yDcU8PEJjbQHUI5HU6q6gSAX+Q37nxirWx4WqKLScIcCuhV0mJJTFcamx
 nISOXSw3iMogw3k1mEYsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uvnbtfCZiDE=:4YmbQmmwUOQ/w+FbyCswVu
 mruEkV4ksyGYF2Wu8gnWUkwzudEIDy4wq+pbB4+3QyIplB63BQ5WRn+97jbzGVXAsWUyh0BxN
 6Qy+ysJ3jADC9pPdAOvmxDrfRVQ5ydD4QzLUrE7CfhWDeHD95qFU9SQV4pNMWxC7HAj/S838W
 /1eS/NklDw8dcQaZE36FWBWMNkoj9LJB1vKlFzfH6pH2Oxk4W0xy7npLbHZPCSO6zHjVr8q1q
 dp8fzePlbsSKDmTq4eafi83UMR12F8aBX+y+egCYZVMeGsWgELXjn6JBLkkflr3QB8P2J0nv9
 PGFBOKFSocsMxwU9l5CeCod/JgQKSMUC2bYUUIfPfNnZaIbZVz89061SC2mS1v1w0EqA4yvXW
 cHRuZ23ZgBUIgKtrY0UMQLPAqPk4+cQQi/B6nmtkzRIwDAmF2IPZCkh9sIjsb7K3OVQEpBJ4D
 626GAT4vUoG4NIqKlfXy8ZIXkvVbSIoYje51i4DLocCZty205Ajj2ZYRh6IVcWSlfP43dhxvl
 rNz2uTc2i8r0G9Eu5HbyI4aIPOrPaW1uJblP46P8D8YB8owNddFsv1++PN5DtiUnl/zgxjVSi
 xkzDyjmheWVp6BXDXAO5yb/Bl0xLV98qMR8GIZpaY7pxC9MJ0H/dmXGwmpvHTx6MR0z2n9ZyE
 jdpA3sy3QJPsn6irjY6SuALBKERFn9dPbD10onbCOSm0P4tka4PRu0gjAqTVX52PvlE0GbcvE
 0NTzmeSkUIat5+blFmquysTD68xx1rU1H9gXQU4ghIgQajGQsBNb1R8OokZG4c+KZczxkQcvf
 RlRlIaIOXTDawO8IaBMw5cSRJ5kNFGm67W8Xs2JI8CyZQJ6j3gMAGwRZ5dzPu5GqZITXz9Wjt
 BSv8IH0PdOpaFI/oHY0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure is only used in one place, moving it there simplifies the
interface and helps with later changes to this code.

Rename it to match the other time32 structures in the process.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h | 15 ++++-----------
 kernel/compat.c        | 24 ------------------------
 kernel/time/itimer.c   | 42 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 3735a22bfbc0..906a0ea933cd 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -116,14 +116,7 @@ typedef __compat_gid32_t	compat_gid_t;
 struct compat_sel_arg_struct;
 struct rusage;
 
-struct compat_itimerval {
-	struct old_timeval32	it_interval;
-	struct old_timeval32	it_value;
-};
-
-struct itimerval;
-int get_compat_itimerval(struct itimerval *, const struct compat_itimerval __user *);
-int put_compat_itimerval(struct compat_itimerval __user *, const struct itimerval *);
+struct old_itimerval32;
 
 struct compat_tms {
 	compat_clock_t		tms_utime;
@@ -668,10 +661,10 @@ compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
-				     struct compat_itimerval __user *it);
+				     struct old_itimerval32 __user *it);
 asmlinkage long compat_sys_setitimer(int which,
-				     struct compat_itimerval __user *in,
-				     struct compat_itimerval __user *out);
+				     struct old_itimerval32 __user *in,
+				     struct old_itimerval32 __user *out);
 
 /* kernel/kexec.c */
 asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
diff --git a/kernel/compat.c b/kernel/compat.c
index a2bc1d6ceb57..95005f849c68 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -90,30 +90,6 @@ int compat_put_timespec(const struct timespec *ts, void __user *uts)
 }
 EXPORT_SYMBOL_GPL(compat_put_timespec);
 
-int get_compat_itimerval(struct itimerval *o, const struct compat_itimerval __user *i)
-{
-	struct compat_itimerval v32;
-
-	if (copy_from_user(&v32, i, sizeof(struct compat_itimerval)))
-		return -EFAULT;
-	o->it_interval.tv_sec = v32.it_interval.tv_sec;
-	o->it_interval.tv_usec = v32.it_interval.tv_usec;
-	o->it_value.tv_sec = v32.it_value.tv_sec;
-	o->it_value.tv_usec = v32.it_value.tv_usec;
-	return 0;
-}
-
-int put_compat_itimerval(struct compat_itimerval __user *o, const struct itimerval *i)
-{
-	struct compat_itimerval v32;
-
-	v32.it_interval.tv_sec = i->it_interval.tv_sec;
-	v32.it_interval.tv_usec = i->it_interval.tv_usec;
-	v32.it_value.tv_sec = i->it_value.tv_sec;
-	v32.it_value.tv_usec = i->it_value.tv_usec;
-	return copy_to_user(o, &v32, sizeof(struct compat_itimerval)) ? -EFAULT : 0;
-}
-
 #ifdef __ARCH_WANT_SYS_SIGPROCMASK
 
 /*
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 77f1e5635cc1..c52ebb40b60b 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -112,19 +112,34 @@ SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, value)
 }
 
 #ifdef CONFIG_COMPAT
+struct old_itimerval32 {
+	struct old_timeval32	it_interval;
+	struct old_timeval32	it_value;
+};
+
+static int put_old_itimerval32(struct old_itimerval32 __user *o, const struct itimerval *i)
+{
+	struct old_itimerval32 v32;
+
+	v32.it_interval.tv_sec = i->it_interval.tv_sec;
+	v32.it_interval.tv_usec = i->it_interval.tv_usec;
+	v32.it_value.tv_sec = i->it_value.tv_sec;
+	v32.it_value.tv_usec = i->it_value.tv_usec;
+	return copy_to_user(o, &v32, sizeof(struct old_itimerval32)) ? -EFAULT : 0;
+}
+
 COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
-		       struct compat_itimerval __user *, it)
+		       struct old_itimerval32 __user *, it)
 {
 	struct itimerval kit;
 	int error = do_getitimer(which, &kit);
 
-	if (!error && put_compat_itimerval(it, &kit))
+	if (!error && put_old_itimerval32(it, &kit))
 		error = -EFAULT;
 	return error;
 }
 #endif
 
-
 /*
  * The timer is automagically restarted, when interval != 0
  */
@@ -310,15 +325,28 @@ SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
 }
 
 #ifdef CONFIG_COMPAT
+static int get_old_itimerval32(struct itimerval *o, const struct old_itimerval32 __user *i)
+{
+	struct old_itimerval32 v32;
+
+	if (copy_from_user(&v32, i, sizeof(struct old_itimerval32)))
+		return -EFAULT;
+	o->it_interval.tv_sec = v32.it_interval.tv_sec;
+	o->it_interval.tv_usec = v32.it_interval.tv_usec;
+	o->it_value.tv_sec = v32.it_value.tv_sec;
+	o->it_value.tv_usec = v32.it_value.tv_usec;
+	return 0;
+}
+
 COMPAT_SYSCALL_DEFINE3(setitimer, int, which,
-		       struct compat_itimerval __user *, in,
-		       struct compat_itimerval __user *, out)
+		       struct old_itimerval32 __user *, in,
+		       struct old_itimerval32 __user *, out)
 {
 	struct itimerval kin, kout;
 	int error;
 
 	if (in) {
-		if (get_compat_itimerval(&kin, in))
+		if (get_old_itimerval32(&kin, in))
 			return -EFAULT;
 	} else {
 		memset(&kin, 0, sizeof(kin));
@@ -327,7 +355,7 @@ COMPAT_SYSCALL_DEFINE3(setitimer, int, which,
 	error = do_setitimer(which, &kin, out ? &kout : NULL);
 	if (error || !out)
 		return error;
-	if (put_compat_itimerval(out, &kout))
+	if (put_old_itimerval32(out, &kout))
 		return -EFAULT;
 	return 0;
 }
-- 
2.20.0

