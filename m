Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA7C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A2F20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfG0Vwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 17:52:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51199 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfG0Vwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 17:52:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrUcE-0001Yp-1b; Sat, 27 Jul 2019 23:52:34 +0200
Date:   Sat, 27 Jul 2019 23:52:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <alpine.DEB.2.21.1907272042310.1791@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907272153090.1791@nanos.tec.linutronix.de>
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de> <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com> <alpine.DEB.2.21.1907272042310.1791@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2019, Thomas Gleixner wrote:
> On Sat, 27 Jul 2019, Andy Lutomirski wrote:
> > 
> > I think it's getting quite late to start inventing new seccomp
> > features to fix this.  I think the right solution for 5.3 is to change
> > the 32-bit vdso fallback to use the old clock_gettime, i.e.
> > clock_gettime32.  This is obviously not an acceptable long-term
> > solution.
> 
> Sigh. I'll have a look....

Completely untested patch below.

For the record: I have to say that I hate it.

Just to be clear. Once a clever seccomp admin decides to enforce Y2038
compliance by filtering out the legacy syscalls this will force glibc into
the syscall slowpath directly because __vdso_clock_gettime64() is gone.

So this needs a proper secccomp solution soener than later.

The fallback change to the legacy syscall is on purpose conditional on
CONFIG_SECCOMP so those people who care can get access to
__vdso_clock_gettime64() nevertheless. 

Thanks,

	tglx

8<-----------------
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -27,7 +27,9 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_time;
 		__vdso_clock_getres;
+#ifndef CONFIG_SECCOMP
 		__vdso_clock_gettime64;
+#endif
 	};
 
 	LINUX_2.5 {
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -101,6 +101,7 @@ long clock_gettime_fallback(clockid_t _c
 {
 	long ret;
 
+#ifndef CONFIG_SECCOMP
 	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %[clock], %%ebx \n"
@@ -110,6 +111,36 @@ long clock_gettime_fallback(clockid_t _c
 		: "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
 		: "edx");
 
+#else
+	struct old_timespec32 tmpts;
+
+	/*
+	 * Using clock_gettime and not clock_gettime64 here is a
+	 * temporary workaround to pacify seccomp filters which are
+	 * unaware of the Y2038 safe variant.
+	 */
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (tmpts)
+		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (&tmpts)
+		: "edx");
+
+	/*
+	 * The core code will have to convert that back. A smart compiler
+	 * should notice and avoid the double conversion. If not, bad luck;
+	 * we we are not going to change the core code just to make seccomp
+	 * happy.
+	 */
+
+	if (!ret) {
+		_ts->tv_sec = tmpts.tv_sec;
+		_ts->tv_nsec = tmpts.tv_nsec;
+	}
+#endif
 	return ret;
 }
 
@@ -136,6 +167,7 @@ clock_getres_fallback(clockid_t _clkid,
 {
 	long ret;
 
+#ifndef CONFIG_SECCOMP
 	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %[clock], %%ebx \n"
@@ -144,7 +176,32 @@ clock_getres_fallback(clockid_t _clkid,
 		: "=a" (ret), "=m" (*_ts)
 		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
 		: "edx");
+#else
+	struct old_timespec32 tmpts;
+
+	/*
+	 * Using clock_getres and not clock_getres_time64 here is a
+	 * temporary workaround to pacify seccomp filters which are unaware
+	 * of the time64 variants. Technically there is no requirement to
+	 * use the 64bit variant here as the resolution is definitely not
+	 * affected by Y2038, but the end goal of Y2038 is to utilize the
+	 * new 64bit timespec variants for everything.
+	 */
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (tmpts)
+		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (&tmpts)
+		: "edx");
 
+	if (!ret) {
+		_ts->tv_sec = tmpts.tv_sec;
+		_ts->tv_nsec = tmpts.tv_nsec;
+	}
+#endif
 	return ret;
 }
 
