Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5AFC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CE42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfD0Jyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:54:31 -0400
Received: from relay13.nicmail.ru ([195.208.6.7]:39062 "EHLO
        relay13.nicmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0Jyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:54:31 -0400
Received: from [109.70.25.215] (port=49504 helo=sghpc.hn.golosunov.pp.ru)
        by f17.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hKK2K-000JR2-6A; Sat, 27 Apr 2019 12:54:24 +0300
Received: from [5.164.181.148] (account sghpc@golosunov.pp.ru HELO sghpc.hn.golosunov.pp.ru)
        by proxy02.mail.nic.ru (Exim 5.55)
        with id 1hKK2K-0006Oi-0o; Sat, 27 Apr 2019 12:54:24 +0300
Received: from stepan by sghpc.hn.golosunov.pp.ru with local (Exim 4.89)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hKK2E-0007po-UT; Sat, 27 Apr 2019 13:54:19 +0400
Date:   Sat, 27 Apr 2019 13:54:18 +0400
From:   Stepan Golosunov <stepan@golosunov.pp.ru>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
Message-ID: <20190427095418.344yoomf5nwznatd@sghpc.golosunov.pp.ru>
References: <20190426142531.1378357-1-arnd@arndb.de>
 <20190427004653.3cecd1cb@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190427004653.3cecd1cb@jawa>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.04.2019 в 00:46:53 +0200 Lukasz Majewski написал:
> Hi Arnd,
> 
> > As Stepan Golosunov points out, we made a small mistake in the
> > get_timespec64() function in the kernel. It was originally added under
> > the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
> > and 64-bit architectures, but when I did the conversion, I only turned
> > it on for 32-bit ones.
> > 
> > The effect is that the get_timespec64() function never clears the
> > upper half of the tv_nsec field for 32-bit tasks in compat mode.
> > Clearing this is required for POSIX compliant behavior of functions
> > that pass a 'timespec' structure with a 64-bit tv_sec and a 32-bit
> > tv_nsec, plus uninitialized padding.

> At least for my setup (32bit ARM with 64 bit time support) this patch is
> not fixing anything.

The patch is not supposed to fix anything on 32-bit architectures as
in-kernel struct timespec64 has 32-bit tv_nsec there.  Thus truncation
should happen automatically.  I also missed that fact when I was
reading get_timespec64 code.

(I am wondering whether such trucation is undefined behaviour in C and
whether there should be sign-extension instead of zeroing-out for the
in_compat_syscall() case though.)

> > The easiest fix for linux-5.1 is to just make the Kconfig symbol
> > unconditional, as it was originally intended. As a follow-up,
> > we should remove any #ifdef CONFIG_64BIT_TIME completely.
> > 
> > Link:
> > https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
> > Cc: Lukasz Majewski <lukma@denx.de> Cc: Stepan Golosunov
> > <stepan@golosunov.pp.ru> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Please apply this one as a bugfix for 5.1
> > ---
> >  arch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 33687dddd86a..9092e0ffe4d3 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -764,7 +764,7 @@ config COMPAT_OLD_SIGACTION
> >  	bool
> >  
> >  config 64BIT_TIME
> > -	def_bool ARCH_HAS_64BIT_TIME
> > +	def_bool y
> >  	help
> >  	  This should be selected by all architectures that need to
> > support new system calls with a 64-bit time_t. This is relevant on
> > all 32-bit
