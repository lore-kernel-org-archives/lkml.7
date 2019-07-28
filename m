Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609FC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956F2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfG1KaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 06:30:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfG1KaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 06:30:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrgRN-0001VN-4d; Sun, 28 Jul 2019 12:30:09 +0200
Date:   Sun, 28 Jul 2019 12:30:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <CAK8P3a3_tki1mi4OjLJdaGLwVA7JE0wE1kczE_q7kEpr5e8sMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907281225410.1791@nanos.tec.linutronix.de>
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de> <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com> <CAK8P3a3_tki1mi4OjLJdaGLwVA7JE0wE1kczE_q7kEpr5e8sMQ@mail.gmail.com>
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

On Sun, 28 Jul 2019, Arnd Bergmann wrote:
> On Sat, Jul 27, 2019 at 7:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> lib/vdso/gettimeofday.c:
> static __maybe_unused int
> __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
> {
>         struct __kernel_timespec ts;
>         int ret;
> 
>         if (res == NULL)
>                 goto fallback;
> 
>         ret = __cvdso_clock_gettime(clock, &ts);
> 
>         if (ret == 0) {
>                 res->tv_sec = ts.tv_sec;
>                 res->tv_nsec = ts.tv_nsec;
>         }
> 
>         return ret;
> 
> fallback:
>         return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
> }
> 
> So we get an 'old_timespec32' pointer from user space, and cast
> it to __kernel_timespec in order to pass it to the low-level function
> that actually fills in the 64-bit structure.
>
> On a little-endian machine, the first four bytes are actually correct
> here, but this is followed by tv_nsec=0 and 8 more bytes that overwrite
> whatever comes after the user space 'timespec'. [I missed the
> typecast as an indication of a bug during my review, sorry about
> that].

Which is totally irrelevant because res is NULL and that NULL pointer check
should simply return -EFAULT, which is what the syscall fallback returns
because the pointer is NULL.

But that NULL pointer check is inconsistent anyway:

 - 64 bit does not have it and never had

 - the vdso is not capable of handling faults properly anyway. If the
   pointer is not valid, then it will segfault. So just preventing the
   segfault for NULL is silly.

I'm going to just remove it.

Thanks,

	tglx
