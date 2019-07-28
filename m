Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A760FC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EFC2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfG1J6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:58:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43524 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfG1J6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:58:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so12550799qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 02:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgCTbuELxfZzxTSEknSndN9sTLLuOVb2vt6aeuNUBPg=;
        b=EGSpe367S6+uVbAREiugKiX0FaDGPBwwp4aooLrTemY5MKdbDUjER8czEU08//2vNn
         YrPc5zkbxUsTObyHsvvVFUg1OR/iJqsbfNBgrF5ysAozyrAKDiI5Al9hqpgtrJsXebrr
         bJ6p9qKfq5a9HcExNNPhyeQQ1ei2uHxG/Mh9lGFTg8oKm3eskQbXgMAeQD8q9Z7EnQsD
         xonGYQa5v7rOf9uhel4vIPUoabrrWbKO83h9ZNttJjitkm8Er/7LNk8PSuA2Cyjn3FrF
         pH5B48+BYCRoUnYrV9zVg4ozlvmK0FUomtIyLEAWeHLqOzikZnbT7CEMzP8iISYYOsfw
         J8Jw==
X-Gm-Message-State: APjAAAWUbc6LGhWkgRGXGUmFAuciQ69dVJNr00Sw8yKBHEn9XHjWb6mT
        Gp6qFM7KD/SxhrniGvMlUI+VS6+uip58OF0W5sw=
X-Google-Smtp-Source: APXvYqzOMSm1KAVJxcgrEGtIEaAvPRlkKIEXQlqGBWWQpklW+GTFVj/ccnHEPROD0CHq/ls+gGjR3kKPWZhHsZdGkL0=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr71591396qtd.18.1564307895541;
 Sun, 28 Jul 2019 02:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
 <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com>
 <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
 <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
In-Reply-To: <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Jul 2019 11:57:58 +0200
Message-ID: <CAK8P3a3_tki1mi4OjLJdaGLwVA7JE0wE1kczE_q7kEpr5e8sMQ@mail.gmail.com>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace on i386
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 7:53 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 11:01 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Wed, Jul 24, 2019 at 01:56:34AM +0200, Thomas Gleixner wrote:
> > > On Tue, 23 Jul 2019, Kees Cook wrote:
> > >
> > > > On Wed, Jul 24, 2019 at 12:59:03AM +0200, Thomas Gleixner wrote:
> > > > > And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
> > > > > deal with that in seccomp independently of the VDSO. It does not make sense
> > > > > to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
> > > > > both expose the same information, but the latter is y2038 safe.
> > > >
> > > > Okay, so combining Andy's ideas on aliasing and "more seccomp flags",
> > > > we could declare that clock_gettime64() is not filterable on 32-bit at
> > > > all without the magic SECCOMP_IGNORE_ALIASES flag or something. Then we
> > > > would alias clock_gettime64 to clock_gettime _before_ the first evaluation
> > > > (unless SECCOMP_IGNORE_ALIASES is set)?
> > > >
> > > > (When was clock_gettime64() introduced? Is it too long ago to do this
> > > > "you can't filter it without a special flag" change?)
> > >
> > > clock_gettime64() and the other sys_*time64() syscalls which address the
> > > y2038 issue were added in 5.1
> >
> > Paul Bolle pointed out that this regression showed up in v5.3-rc1, not
> > v5.2.  In Paul's case, systemd-journal is failing.
>
> I think it's getting quite late to start inventing new seccomp
> features to fix this.  I think the right solution for 5.3 is to change
> the 32-bit vdso fallback to use the old clock_gettime, i.e.
> clock_gettime32.  This is obviously not an acceptable long-term
> solution.

I think there is something else wrong with the fallback path, it seems
to pass the wrong structure in some cases:

arch/x86/include/asm/vdso/gettimeofday.h vdso32:

static __always_inline
long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
{
        long ret;

        asm (
                "mov %%ebx, %%edx \n"
                "mov %[clock], %%ebx \n"
                "call __kernel_vsyscall \n"
                "mov %%edx, %%ebx \n"
                : "=a" (ret), "=m" (*_ts)
                : "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
                : "edx");

        return ret;
}

arch/x86/include/asm/vdso/gettimeofday.h vdso64:
static __always_inline
long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
{
        long ret;

        asm ("syscall" : "=a" (ret), "=m" (*_ts) :
             "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts) :
             "rcx", "r11");

        return ret;
}


lib/vdso/gettimeofday.c:
static __maybe_unused int
__cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
{
        struct __kernel_timespec ts;
        int ret;

        if (res == NULL)
                goto fallback;

        ret = __cvdso_clock_gettime(clock, &ts);

        if (ret == 0) {
                res->tv_sec = ts.tv_sec;
                res->tv_nsec = ts.tv_nsec;
        }

        return ret;

fallback:
        return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
}

So we get an 'old_timespec32' pointer from user space, and cast
it to __kernel_timespec in order to pass it to the low-level function
that actually fills in the 64-bit structure.

On a little-endian machine, the first four bytes are actually correct
here, but this is followed by tv_nsec=0 and 8 more bytes that overwrite
whatever comes after the user space 'timespec'. [I missed the
typecast as an indication of a bug during my review, sorry about
that].

I think adding a clock_gettime32_fallback() function that calls
__NR_clock_gettime is both the simplest fix for this bug, and
the least ugly way to handle it in the long run.

We also need to decide what to do about __cvdso_clock_gettime32()
once we add a compile-time option to make all time32 syscalls
to return an error. Returning -ENOSYS from the clock_gettime32()
fallback is probably a good idea, but for consistency the
__vdso_clock_gettime() call should either always return the
same in that configuration, or be left out from the vdso build
endirely.

       Arnd
