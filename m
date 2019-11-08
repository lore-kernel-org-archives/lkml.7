Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42805FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64E207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfKHVR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:17:56 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:45817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:17:55 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MwgOK-1hjJ0r0tOk-00yBGN; Fri, 08 Nov 2019 22:17:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-alpha@vger.kernel.org
Subject: [PATCH 19/23] y2038: use compat_{get,set}_itimer on alpha
Date:   Fri,  8 Nov 2019 22:12:18 +0100
Message-Id: <20191108211323.1806194-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E3gQKHDY/P5Y9zeE38VfQQ9wJ3KSPGVX2xBd4RGUHKVBkeQ3cnh
 IkqObZNllWa36SZ83QqDO/3CSSqK5L1RxS4HiP7Gz1x9tR5rNAkZqcsi1zd97to4Urku7br
 wOB5TOqXT1CjZTRrO9u4pIvL/sKlKt0CEF8I4WVxfmUUkcu3jXo/fbLhOpTLguvEuaXNDuu
 IwKMBcMOQlfd8/jxNENKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e/W+TxPQhaM=:ml/G9/qCjz5DPXfgmu4Q4t
 yZe2Hg0nRciRf2WuBQZW/Os8at/YT+JfAVd8YSPJobZaGTAYEdkdNZ8QjbXRD4RU9n+FIKPYi
 7UwA2pXMgUWD3YqOuKCyHXYf7c/TMD0AEKjHm2CGb+P6bGSQkFY9JVHfyfa/uooG6du+p4kTi
 /+Czem+gkKCBl2npeJeRYC+9myim/rmPn3tRAwHtUWcVUxQyZTL+LEDtPRWrkit1u8ucjFz2o
 /uzORPNSEPTgi+yBTiBgb6rPAacISnj8GhYslwR9xV5O4rhrZt/o0knlvqJ1OOHRHr7YGgAkt
 2e7XN4C918xz/sStEaWB0WUwsBpFoXbwZ4eVkIEYsnlgrBEytl4mM3mGQS5nQwRFblH1/4t1r
 TZCIlc+mhWGQMAkMNWF56ETeL9+0Pv4ycy2UJrtXDVOoEwkCEujRWdRJj6nbi9PVrP8FwWSu0
 6fLrkR34CMHqE9UJxdud/zddxZeLF5D8oJp/LBeKqiLSnlnCZFzMw2jIyR3ZtBo7eNyckaFOO
 K81KuQ85Dg+q+hukG9UrVDDsqI3mBV8o+iI2SgLa82qIJM0pYgg4PYJRbRJ4bF//AXW5QvrAo
 2WpYGNn81uIU6NoSfveSz+6t5DuP7FkMF3nM9z3+0ZOmABNidQI9dPGZkrD+66boSLJDoDbrH
 HlvqmkedrVT5W0cOkd9cfOz8zxTDLWctcT5BqJ6X0imQRlZnvB30Ui9eYNGI3RQVJirnu3dj9
 LbCh36iw3QSump2JYcsCSduGbRTQZ5mo0Vhvu2mbq4jUwf9caYjIQyOasgoFdWtf/Wk79yW7j
 7OtWtCjpQLM6DDnwJBinuRAUNxOu95fI9kVSzywIoQ912E9IGurxNTfOsreC1IUMlgn5UDFEB
 67TnwtzMWoelIJ6k7u6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The itimer handling for the old alpha osf_setitimer/osf_getitimer
system calls is identical to the compat version of getitimer/setitimer,
so just use those directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/osf_sys.c            | 65 --------------------------
 arch/alpha/kernel/syscalls/syscall.tbl |  4 +-
 kernel/time/itimer.c                   |  4 +-
 3 files changed, 4 insertions(+), 69 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index bbe7a0da6264..94e4cde8071a 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -971,30 +971,6 @@ put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
 			    sizeof(struct timeval32));
 }
 
-static inline long
-get_it32(struct itimerval *o, struct itimerval32 __user *i)
-{
-	struct itimerval32 itv;
-	if (copy_from_user(&itv, i, sizeof(struct itimerval32)))
-		return -EFAULT;
-	o->it_interval.tv_sec = itv.it_interval.tv_sec;
-	o->it_interval.tv_usec = itv.it_interval.tv_usec;
-	o->it_value.tv_sec = itv.it_value.tv_sec;
-	o->it_value.tv_usec = itv.it_value.tv_usec;
-	return 0;
-}
-
-static inline long
-put_it32(struct itimerval32 __user *o, struct itimerval *i)
-{
-	return copy_to_user(o, &(struct itimerval32){
-				.it_interval.tv_sec = o->it_interval.tv_sec,
-				.it_interval.tv_usec = o->it_interval.tv_usec,
-				.it_value.tv_sec = o->it_value.tv_sec,
-				.it_value.tv_usec = o->it_value.tv_usec},
-			    sizeof(struct itimerval32));
-}
-
 static inline void
 jiffies_to_timeval32(unsigned long jiffies, struct timeval32 *value)
 {
@@ -1039,47 +1015,6 @@ SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __user *, tv,
 
 asmlinkage long sys_ni_posix_timers(void);
 
-SYSCALL_DEFINE2(osf_getitimer, int, which, struct itimerval32 __user *, it)
-{
-	struct itimerval kit;
-	int error;
-
-	if (!IS_ENABLED(CONFIG_POSIX_TIMERS))
-		return sys_ni_posix_timers();
-
-	error = do_getitimer(which, &kit);
-	if (!error && put_it32(it, &kit))
-		error = -EFAULT;
-
-	return error;
-}
-
-SYSCALL_DEFINE3(osf_setitimer, int, which, struct itimerval32 __user *, in,
-		struct itimerval32 __user *, out)
-{
-	struct itimerval kin, kout;
-	int error;
-
-	if (!IS_ENABLED(CONFIG_POSIX_TIMERS))
-		return sys_ni_posix_timers();
-
-	if (in) {
-		if (get_it32(&kin, in))
-			return -EFAULT;
-	} else
-		memset(&kin, 0, sizeof(kin));
-
-	error = do_setitimer(which, &kin, out ? &kout : NULL);
-	if (error || !out)
-		return error;
-
-	if (put_it32(out, &kout))
-		return -EFAULT;
-
-	return 0;
-
-}
-
 SYSCALL_DEFINE2(osf_utimes, const char __user *, filename,
 		struct timeval32 __user *, tvs)
 {
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 728fe028c02c..8e13b0b2928d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -89,10 +89,10 @@
 80	common	setgroups			sys_setgroups
 81	common	osf_old_getpgrp			sys_ni_syscall
 82	common	setpgrp				sys_setpgid
-83	common	osf_setitimer			sys_osf_setitimer
+83	common	osf_setitimer			compat_sys_setitimer
 84	common	osf_old_wait			sys_ni_syscall
 85	common	osf_table			sys_ni_syscall
-86	common	osf_getitimer			sys_osf_getitimer
+86	common	osf_getitimer			compat_sys_getitimer
 87	common	gethostname			sys_gethostname
 88	common	sethostname			sys_sethostname
 89	common	getdtablesize			sys_getdtablesize
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index c52ebb40b60b..4664c6addf69 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -111,7 +111,7 @@ SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, value)
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
 struct old_itimerval32 {
 	struct old_timeval32	it_interval;
 	struct old_timeval32	it_value;
@@ -324,7 +324,7 @@ SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
 	return 0;
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
 static int get_old_itimerval32(struct itimerval *o, const struct old_itimerval32 __user *i)
 {
 	struct old_itimerval32 v32;
-- 
2.20.0

