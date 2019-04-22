Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FBC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FB720685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDVJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:22:14 -0400
Received: from relay03.nicmail.ru ([195.208.3.4]:61090 "EHLO
        relay03.nicmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfDVJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:22:14 -0400
X-Greylist: delayed 895 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 05:22:13 EDT
Received: from [109.70.25.186] (port=54594 helo=sghpc.hn.golosunov.pp.ru)
        by f19.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hIUux-000NPk-Ck; Mon, 22 Apr 2019 12:07:16 +0300
Received: from [46.0.38.82] (account sghpc@golosunov.pp.ru HELO sghpc.hn.golosunov.pp.ru)
        by proxy07.mail.nic.ru (Exim 5.55)
        with id 1hIUux-0000tC-Rl; Mon, 22 Apr 2019 12:07:15 +0300
Received: from stepan by sghpc.hn.golosunov.pp.ru with local (Exim 4.89)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hIUut-0002Yb-0e; Mon, 22 Apr 2019 13:07:11 +0400
Date:   Mon, 22 Apr 2019 13:07:10 +0400
From:   Stepan Golosunov <stepan@golosunov.pp.ru>
To:     Lukasz Majewski <lukma@denx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>, libc-alpha@sourceware.org,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] y2038: linux: Provide __clock_settime64
 implementation
Message-ID: <20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru>
References: <20190414220841.20243-1-lukma@denx.de>
 <20190414220841.20243-4-lukma@denx.de>
 <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru>
 <20190420132112.131f449b@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190420132112.131f449b@jawa>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.04.2019 в 13:21:12 +0200 Lukasz Majewski написал:
> Hi Stepan,
> 
> > 15.04.2019 в 00:08:38 +0200 Lukasz Majewski написал:
> > > +# if defined __NR_clock_settime64
> > > +  /* Make sure that passed __timespec64 struct pad is 0.  */
> > > +  struct __timespec64 ts = *tp;
> > > +  ts.tv_pad = 0;
> > > +  return INLINE_SYSCALL_CALL (clock_settime64, clock_id, &ts);  
> > 
> > Isn't kernel supposed to zero out padding on its own?
> > At least comment in kernel's get_timespec64 says so:
> > 
> > 	/* Zero out the padding for 32 bit systems or in compat mode
> > */ if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
> > 		kts.tv_nsec &= 0xFFFFFFFFUL;
> > 
> 
> For ARM (and x86) 32 bit machines I do use following syscalls (like
> clock_settime64):
> https://elixir.bootlin.com/linux/v5.1-rc4/source/arch/arm/tools/syscall.tbl#L420
> 
> which are providing 64 bit time support on 32 bit systems.
> 
> Yes. In those systems the upper part (32 bits) of tv_nsec is cleared up
> with mask in the kernel.

Is it? The kernel (5.1-rc6) code looks to me like

	/* Zero out the padding for 32 bit systems or in compat mode */
	if (false && false)
		kts.tv_nsec &= 0xFFFFFFFFUL;

in 32-bit kernels. And like

	if (false && true)
		kts.tv_nsec &= 0xFFFFFFFFUL;

for COMPAT syscalls in 64-bit kernels.

It should probably be changed into

	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
		kts.tv_nsec &= 0xFFFFFFFFUL;

(Or into something like

	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall() && !COMPAT_USE_64BIT_TIME)
		kts.tv_nsec &= 0xFFFFFFFFUL;

if x32 should retain 64-bit tv_nsec.)

> However, I would prefer not to pass random data
> to the kernel, and hence I do clear it up explicitly in glibc.

If the kernel does not ignore padding on its own, then zeroing it out
is required everywhere timespec is passed to kernel, including via
code not known to glibc. (Does anyone promise that there won't be any
ioctls that accept timespec, for example?) That seems to be
error-prone (and might requre copying larger structes).

On the other hand, if kernel 5.1+ ignores padding as intended there is
no need to create additional copy of structs in glibc code that calls
into clock_settime64 (or into timer_settime64 that accepts larger
struct, for example).

> > The code looks buggy though. It fails to zero out the padding in
> > 32-bit kernels.
> 
> For the 32 bit systems without Y2038 support enabled in glibc - the
> clock_settime would be used, which corresponds to sys_clock_settime32()
> in the kernel.

I am talking about kernels with Y2038 support.

> > That part is probably broken since
> > 98f76206b3350 ("compat: Cleanup in_compat_syscall() callers").
> > 
> > And, hmm, is CONFIG_64BIT_TIME enabled anywhere?

I guess that the remaining CONFIG_64BIT_TIME in kernel should be
replaced with CONFIG_COMPAT_32BIT_TIME or removed.
