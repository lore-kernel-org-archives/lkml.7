Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 23:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D87D20873
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 23:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJZXGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 19:06:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:55397 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfJZXGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 19:06:53 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9QN6B4B014950;
        Sat, 26 Oct 2019 18:06:11 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9QN69JB014947;
        Sat, 26 Oct 2019 18:06:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 26 Oct 2019 18:06:09 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        luto@kernel.org, vincenzo.frascino@arm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
Message-ID: <20191026230609.GY28442@gate.crashing.org>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr> <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de> <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr> <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de> <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr> <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 08:48:27PM +0200, Thomas Gleixner wrote:
> On Sat, 26 Oct 2019, Christophe Leroy wrote:
> Let's look at the code:
> 
> __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
> {
>         const struct vdso_data *vd = __arch_get_vdso_data();
> 
>         if (likely(tv != NULL)) {
> 		struct __kernel_timespec ts;
> 
>                 if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
>                         return gettimeofday_fallback(tv, tz);
> 
>                 tv->tv_sec = ts.tv_sec;
>                 tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
> 
> IIRC PPC did some magic math tricks to avoid that. Could you just for the
> fun of it replace this division with
> 
>        (u32)ts.tv_nsec >> 10;

On this particular CPU (the 885, right?) a division by 1000 is just 9
cycles.  On other CPUs it can be more, say 19 cycles like on the 750; not
cheap at all, but not hugely expensive either, comparatively.

(A 64/32->32 division is expensive on all 32-bit PowerPC: there is no
hardware help for it at all, so it's all done in software.)

Of course the compiler won't do a division by a constant with a division
instruction at all, so it's somewhat cheaper even, 5 or 6 cycles or so.

> One thing which might be worth to try as well is to mark all functions in
> that file as inline. The speedup by the do_hres() inlining was impressive
> on PPC.

The hand-optimised asm code will pretty likely win handsomely, whatever
you do.  Especially on cores like the 885 (no branch prediction, single
issue, small caches, etc.: every instruction counts).

Is there any reason to replace this hand-optimised code?  It was written
for exacty this reason?  These functions are critical and should be as
fast as possible.


Segher
