Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D1FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87F1206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbfKHVPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:15:46 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52805 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbfKHVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:15:45 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBE3k-1idfB62d2c-00ChQV; Fri, 08 Nov 2019 22:13:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-alpha@vger.kernel.org
Subject: [PATCH 11/23] y2038: rusage: use __kernel_old_timeval
Date:   Fri,  8 Nov 2019 22:12:10 +0100
Message-Id: <20191108211323.1806194-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ccHgshTWM+8bd3ARSVMsRuKkh2xp2UsGP2nSeaQ4JIi6tssxXxX
 Ksc3ikHH0cvgfaaztiNxX2CA4M+Vpy+c174W7J82D3dRrGrnyPssN3YkhqOJl4UWmIO+gbA
 agHARrixznilq2Wuz/W8WEdYBVFHiiV/YAO+jxkRGfTb8j7isXTK1lMvsGAaljnSpEG5tr7
 YONctU0hfEGMMd9SvQr1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+IIOzgpyUfs=:iMdRdlqkxA2961O/fF/WN8
 CcJxoL2fphhDAhIBltVa6+Gt61QsWjNTOFQiqp1MqYVPg9/LFi3ErQAAVruRV7YdbfSaa9mGJ
 1r0WVU7G6r8giQHEnP6SQFW4nWLjxin/D1KCbvlc6qSAjJ6vVFl0ueyjfQ+Fi4LX+s1oncHJW
 vDOYP+1To6pKCk7ZKQrtDy/rhEA0NTXarJh4gni94dM0HE/D0a7pCESI0iC2N4wjJdsbWvjBO
 60olqAnUxBnn6DtJ9x7sg7fW2EkXkq9J4rZdAq8+n5fw8SRGLdV2YIdQGLGelKWDPMFrgZK1p
 G1ZNTYGy4XVQ+WRyzx4kFgQ2gfTeQBMS3uSasDhy/3DqXfNfY+9gEZlZoGHsls9UU4FSpt4QT
 naE81is5oZu5XB8WhhpmPgVbYzsS9KW8Hee3J7LIfeoUP6FSTxtUCfoiTw5E/VrneZm6t/F6d
 Iaop9Xga2XLJk/okoECprtGYovshzNQ2ju85E/aKRw5+IRMqM1+q867osQynyE8K1T0Ry0LXT
 OxIAszMbmXBnTRWViedHLRhWC54m0tpQ2w26mI8SqDO2fK7RyyE3jsPnMNaEocMILUGQ+hTxk
 egLHmH0JhSPS/PEumYbci3Xc4Xm1npOZXkoL4hTAAQWNMDDBaElo70zMEXWIoEZJqLKM47vrQ
 ZaqAvVVZUxRGlVmTRDpY/wHuXlsLIsvTB5zTs3f6fTystOzNzqC2xOpL1zox3J//miiRJgN6w
 1OQ/pXgBPQ/C9hmGqy3EkDdGMMiO+bpfvLWawHn/qvQrGpxGmGlS21ycwg9KbUiiHqRuiXcAv
 SBFxzIBWer/VjW7mpIVfMsHuzbNS/YGKGPHCjciAEMG1GdYbGaL5uVxJJh/ISJGG1W68JlKYo
 tVVXn5q/6uLeJPWY91Jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two 'struct timeval' fields in 'struct rusage'.

Unfortunately the definition of timeval is now ambiguous when used in
user space with a libc that has a 64-bit time_t, and this also changes
the 'rusage' definition in user space in a way that is incompatible with
the system call interface.

While there is no good solution to avoid all ambiguity here, change
the definition in the kernel headers to be compatible with the kernel
ABI, using __kernel_old_timeval as an unambiguous base type.

In previous discussions, there was also a plan to add a replacement
for rusage based on 64-bit timestamps and nanosecond resolution,
i.e. 'struct __kernel_timespec'. I have patches for that as well,
if anyone thinks we should do that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Question: should we also rename 'struct rusage' into 'struct __kernel_rusage'
here, to make them completely unambiguous?
---
 arch/alpha/kernel/osf_sys.c   | 2 +-
 include/uapi/linux/resource.h | 4 ++--
 kernel/sys.c                  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index bf497b8b0ec6..bbe7a0da6264 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -963,7 +963,7 @@ put_tv32(struct timeval32 __user *o, struct timespec64 *i)
 }
 
 static inline long
-put_tv_to_tv32(struct timeval32 __user *o, struct timeval *i)
+put_tv_to_tv32(struct timeval32 __user *o, struct __kernel_old_timeval *i)
 {
 	return copy_to_user(o, &(struct timeval32){
 				.tv_sec = i->tv_sec,
diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index cc00fd079631..74ef57b38f9f 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -22,8 +22,8 @@
 #define	RUSAGE_THREAD	1		/* only the calling thread */
 
 struct	rusage {
-	struct timeval ru_utime;	/* user time used */
-	struct timeval ru_stime;	/* system time used */
+	struct __kernel_old_timeval ru_utime;	/* user time used */
+	struct __kernel_old_timeval ru_stime;	/* system time used */
 	__kernel_long_t	ru_maxrss;	/* maximum resident set size */
 	__kernel_long_t	ru_ixrss;	/* integral shared memory size */
 	__kernel_long_t	ru_idrss;	/* integral unshared data size */
diff --git a/kernel/sys.c b/kernel/sys.c
index a611d1d58c7d..d3aef31e24dc 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1763,8 +1763,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unlock_task_sighand(p, &flags);
 
 out:
-	r->ru_utime = ns_to_timeval(utime);
-	r->ru_stime = ns_to_timeval(stime);
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 
 	if (who != RUSAGE_CHILDREN) {
 		struct mm_struct *mm = get_task_mm(p);
-- 
2.20.0

