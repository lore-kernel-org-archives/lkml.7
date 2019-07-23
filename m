Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E2C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B51821926
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbfGWW71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:59:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41975 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfGWW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:59:27 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hq3kU-0007Uh-Nf; Wed, 24 Jul 2019 00:59:11 +0200
Date:   Wed, 24 Jul 2019 00:59:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <201907231437.DB20BEBD3@keescook>
Message-ID: <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de>
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net> <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook> <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <201907231437.DB20BEBD3@keescook>
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

On Tue, 23 Jul 2019, Kees Cook wrote:
> On Mon, Jul 22, 2019 at 04:47:36PM -0700, Andy Lutomirski wrote:
> > I don't love this whole concept, but I also don't have a better idea.
> 
> How about we revert the vDSO change? :P

Sigh. Add more special case code to the VDSO again?

> I keep coming back to using the vDSO return address as an indicator.
> Most vDSO calls don't make syscalls, yes? So they're normally
> unfilterable by seccomp.
> 
> What was the prior vDSO behavior?

The behaviour is pretty much the same as before:

  If the requested clock id is supported by the VDSO and the platform has a
  VDSO capable clocksource, everything is handled in user space.

  If either of the conditions is false, fall back to a syscall.

The implementation detail changed for 32bit (native and compat):

. The original VDSO used sys_clock_gettime() as fallback, the new one uses
  sys_clock_gettime64().

The reason is that we need to support 2038 safe vdso_clock_gettime64() for
32bit which requires to use sys_clock_gettime64() as fallback. So we use
the same fallback for the non 2038 safe vdso_clock_gettime() variant as
well to avoid having different implementations of the fallback code.

And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
deal with that in seccomp independently of the VDSO. It does not make sense
to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
both expose the same information, but the latter is y2038 safe.

So changing vdso back to the original fallback for 32bit (native and
compat) is just a temporary bandaid as seccomp needs to deal with the y2038
safe variant anyway.

Thanks,

	tglx


