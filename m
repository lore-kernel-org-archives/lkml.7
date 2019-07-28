Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5002077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1P1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:27:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33100 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1P11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:27:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so42502185qkc.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 08:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F35K+zfag4ltzyCsUASdf81c+ysiklIJwp6fDU8GkBg=;
        b=V7hrk/1IHBGxJbsyQBGs9oVwcMOEI00tc9ygXi/AWIp7RYi6FXRuseqE9MOQUxfAhl
         ejy6lFvcSpSeoQ/HP8hA2AlQ6Gi9iA/12GTiKnbUVQphxBNMnpOUoApbh77wiHRv8PAq
         bYPRe63dDHMrXjZK/Tb7FuD++NP4/rdKXkd+mSnp7zbmDRDGBSaWFDNYjWb2F4YMONwp
         IkXU4QUUiNKhOKnE+Jpf4QuxUWCWB4rt8Fbh+LQw42eP9+/sZi3MqbDlmc+/QV9hbVaJ
         RWOM51kgxgymkr9Doo+bQq2ccfVgpkX58HFBLEUWDiW7TwRxDcXKxXNo2SPgFNaEhUOa
         I8ig==
X-Gm-Message-State: APjAAAWJxecD3KrOYlCiNHRyxFvUy6rt5KEQnUAJGPcgOHkcJ+n8Dtg+
        s4K1P+6wYQIRvsvRK97fxU1Hq/lP5Sp6XRodang=
X-Google-Smtp-Source: APXvYqw6+D27uAOCGRjn7qjS0hMSrUs+qwZOguAPKuhEO7YfPihCE7pkfWb6ewDj2Zi0ubfJ7XpvIeo29ncfT6rLQl0=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr67603060qka.138.1564327646458;
 Sun, 28 Jul 2019 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
 <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
 <CAK8P3a3_tki1mi4OjLJdaGLwVA7JE0wE1kczE_q7kEpr5e8sMQ@mail.gmail.com> <alpine.DEB.2.21.1907281225410.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907281225410.1791@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Jul 2019 17:27:10 +0200
Message-ID: <CAK8P3a0dC5ti8nVMK8-NmmTYeEfKPdLpVf0zrQEnq76fUvh1oA@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 28 Jul 2019, Arnd Bergmann wrote:
> > On Sat, Jul 27, 2019 at 7:53 PM Andy Lutomirski <luto@kernel.org> wrote:

> Which is totally irrelevant because res is NULL and that NULL pointer check
> should simply return -EFAULT, which is what the syscall fallback returns
> because the pointer is NULL.
>
> But that NULL pointer check is inconsistent anyway:
>
>  - 64 bit does not have it and never had
>
>  - the vdso is not capable of handling faults properly anyway. If the
>    pointer is not valid, then it will segfault. So just preventing the
>    segfault for NULL is silly.
>
> I'm going to just remove it.

Ah, you are right, I misread.

Anyway, if we want to keep the traditional behavior and get fewer surprises
for users of seccomp and anything else that might observe clock_gettime
behavior, below is how I'd do it. (not even build tested, x86-only. I'll
send a proper patch if this is where we want to take it).

        Arnd

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h
b/arch/x86/include/asm/vdso/gettimeofday.h
index ae91429129a6..f7b6a50d4811 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -70,6 +70,13 @@ long clock_gettime_fallback(clockid_t _clkid,
struct __kernel_timespec *_ts)
        return ret;
 }

+
+static __always_inline
+long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+       return -ENOSYS;
+}
+
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
                           struct timezone *_tz)
@@ -97,7 +104,7 @@ long clock_getres_fallback(clockid_t _clkid, struct
__kernel_timespec *_ts)
 #else

 static __always_inline
-long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+long clock_gettime_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
        long ret;

@@ -113,6 +120,23 @@ long clock_gettime_fallback(clockid_t _clkid,
struct __kernel_timespec *_ts)
        return ret;
 }

+static __always_inline
+long clock_gettime32_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+       long ret;
+
+       asm (
+               "mov %%ebx, %%edx \n"
+               "mov %[clock], %%ebx \n"
+               "call __kernel_vsyscall \n"
+               "mov %%edx, %%ebx \n"
+               : "=a" (ret), "=m" (*_ts)
+               : "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
+               : "edx");
+
+       return ret;
+}
+
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
                           struct timezone *_tz)
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 2d1c1f241fd9..3b3dab53d611 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -18,6 +18,7 @@
  *   clock_mode.
  * - gettimeofday_fallback(): fallback for gettimeofday.
  * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_gettime_fallback(): fallback for clock_gettime32.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
 #ifdef ENABLE_COMPAT_VDSO
@@ -51,7 +52,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
                ns = vdso_ts->nsec;
                last = vd->cycle_last;
                if (unlikely((s64)cycles < 0))
-                       return clock_gettime_fallback(clk, ts);
+                       return -ENOSYS;

                ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
                ns >>= vd->shift;
@@ -81,15 +82,15 @@ static void do_coarse(const struct vdso_data *vd,
clockid_t clk,
        } while (unlikely(vdso_read_retry(vd, seq)));
 }

-static __maybe_unused int
-__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+static int
+__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 {
        const struct vdso_data *vd = __arch_get_vdso_data();
        u32 msk;

        /* Check for negative values or invalid clocks */
        if (unlikely((u32) clock >= MAX_CLOCKS))
-               goto fallback;
+               return -EINVAL;

        /*
         * Convert the clockid to a bitmask and use it to check which
@@ -105,7 +106,15 @@ __cvdso_clock_gettime(clockid_t clock, struct
__kernel_timespec *ts)
                return do_hres(&vd[CS_RAW], clock, ts);
        }

-fallback:
+       return -EINVAL;
+}
+
+static __maybe_unused int
+__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+       if (!__cvdso_clock_gettime_common(clock, ts))
+               return 0;
+
        return clock_gettime_fallback(clock, ts);
 }

@@ -113,22 +122,14 @@ static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
        struct __kernel_timespec ts;
-       int ret;
-
-       if (res == NULL)
-               goto fallback;
-
-       ret = __cvdso_clock_gettime(clock, &ts);

-       if (ret == 0) {
+       if (!__cvdso_clock_gettime_common(clock, &ts)) {
                res->tv_sec = ts.tv_sec;
                res->tv_nsec = ts.tv_nsec;
+               return 0;
        }

-       return ret;
-
-fallback:
-       return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
+       return clock_gettime32_fallback(clock, res);
 }

 static __maybe_unused int
