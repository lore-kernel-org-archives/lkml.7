Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F4FFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18AC2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfKHVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:11:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58533 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbfKHVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:11:05 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MrQR7-1i6FJk2Bdf-00oUk0; Fri, 08 Nov 2019 22:10:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org
Subject: [PATCH 05/23] y2038: vdso: change time_t to __kernel_old_time_t
Date:   Fri,  8 Nov 2019 22:07:25 +0100
Message-Id: <20191108210824.1534248-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o8Zkr+sOZ52wm0ae45/RQryAsK7xYXnsT+HPUpQaufkmPH+Q6/t
 Mx1QjONjSFAcKcXg6d+qmIO5Nz2Z1PzDnxY6Ir3M0ox/+vbOAVauXJZo7+cMsdRcRszJBe7
 Aj8ZN5RLd1R69CpmSVEU9MTURTureJNFvVMuvJJDqIIb4Y4IhYa+4XE+s6Ccc/3w7U5VVCC
 UD2jKhDgaH7FjqUd1a5VA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Ts/01x3JdM=:/uunyXLl4bvJWCavpfEcb/
 9UoHBVyzqBkcj75fodAjDhjhAyjHi2SMlxz2uJbRFRUmXsG6e6eAogVfcdfts7c47d1reojiA
 KrgDDY253RADofyZtnh5viCrKGzvxm4TKGABjrnBJ0bt1w3KfIWjCYWav1trSnZDSOZooRHfO
 WWwwqG5TUQys5Sv+D10PdDh1BmV1PkR0uQvqi3CJd4F1tM+ZGkEG/J9xbVfFsiF8+0dbqDPUQ
 hr3zgVglY92iRK6SwZ3FDgYMfVogf9R2bfVq1QDRbmGdrtFL2VujlHW7nH5WANGKBkOXxZHrO
 gXnN2qQQM31mucJGqTVaHLg+IF8tEGR7WvtN5gFD771I0OsvEOSfwY4xnWz6Z8mPCLoTrrfg0
 iO1f2ahEO0l71Q3MDRR9pChW632vnUMGqXR0Ky4OTVKsj1JqLoKg32dGg6Nf2QnNk4+i5Nn4N
 8P3pt9RnLY3nZ8uRAevHKgNdEPEzkueh4uRRA1fLHzn7oheQgyQ958Xc84M2+/zWIdm4pq7h/
 ReSWhlc/Z0PIHrf6SCL/pkAUlTZ0nXkqcG2+JlONuaSiCIQ1UBPDIwAPipVV24b3qpbmW4+uZ
 ELTyVt3T3AirdIi6KcrlMebb/OnK4+Dpa2LEw92WHUcZ8wj70YTk2UptblgI1j60iH9hZBR7V
 DB3kobMcaX8Q7kGMdND8zIaTooRs/2vF0yOcrx4+3ujrUla+IZhROs6oWdLsansep6RTDDz3R
 3oqTybQw5FsZaFfFrXLoFrDZGx9IkW9T7vaKNmv/iEf/bxmME60Q+D50eSBPH5cE5flykxY1y
 89ZLtDAK60bylXgCvCP2fF5he1cpwrsVM+CNavdYFN4bEulPNhEaj7Ri0q4m9ntK04XxaoFqh
 BWMSp+QkU2j1ZURv5T0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only x86 uses the 'time' syscall in vdso, so change that to
__kernel_old_time_t as a preparation for removing 'time_t' and
'__kernel_time_t' later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/vclock_gettime.c  | 6 +++---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/um/vdso/um_vdso.c            | 4 ++--
 lib/vdso/gettimeofday.c               | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index d9ff616bb0f6..7d70935b6758 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -15,7 +15,7 @@
 #include "../../../../lib/vdso/gettimeofday.c"
 
 extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
-extern time_t __vdso_time(time_t *t);
+extern __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
@@ -25,12 +25,12 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-time_t __vdso_time(time_t *t)
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	return __cvdso_time(t);
 }
 
-time_t time(time_t *t)	__attribute__((weak, alias("__vdso_time")));
+__kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias("__vdso_time")));
 
 
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 76e62bcb8d87..bba5bfdb2a56 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -194,7 +194,7 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 
 	case 1:
-		if (!write_ok_or_segv(regs->di, sizeof(time_t))) {
+		if (!write_ok_or_segv(regs->di, sizeof(__kernel_old_time_t))) {
 			ret = -EFAULT;
 			goto check_fault;
 		}
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 371724cf70da..2112b8d14668 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -37,7 +37,7 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-time_t __vdso_time(time_t *t)
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	long secs;
 
@@ -47,7 +47,7 @@ time_t __vdso_time(time_t *t)
 
 	return secs;
 }
-time_t time(time_t *t) __attribute__((weak, alias("__vdso_time")));
+__kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 45f57fd2db64..9ecfd3b547ba 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -164,10 +164,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 }
 
 #ifdef VDSO_HAS_TIME
-static __maybe_unused time_t __cvdso_time(time_t *time)
+static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	__kernel_old_time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
-- 
2.20.0

