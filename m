Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A3C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B677F2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569939644;
	bh=24fhhR5+md0mOeWNqDkBGyechQDCTAZku95IGy5Kpq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pgEu3AC/JELXJAnEOvwxnJiwHKwoKKxEWIcgD3lBLSeQJO0Va5p9GVIbvQgU9yhZE
	 pP6Sz/rfaX4aQmCOvbdRnRchnsS3Dp8qk8ecfxrj3Kn8165rcuYi7d+tul6FjhOpH6
	 EGC6aVFpsAaoZaKOLRh9wZ2WlrBNLOFzY+j7qY8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfJAOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388512AbfJAOUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:20:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DA421855;
        Tue,  1 Oct 2019 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569939643;
        bh=24fhhR5+md0mOeWNqDkBGyechQDCTAZku95IGy5Kpq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jdn5igzjnGX4prnKpEQ8P1d+jyX9se7sEYUPNxIR9MYZeZqVKZAfyH6mXOH4fCNEh
         JjHQv7fjkLwYVD0zlQkch0rQghb8GHS4zeKXGu65/O8F9Ed+EJFms67kJfX9Kicc7Y
         a2kAezvPOFD0qedCPm1KM0ntFTjOY3NWCCk9gXa8=
Date:   Tue, 1 Oct 2019 15:20:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
 <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:20:35PM +0100, Vincenzo Frascino wrote:
> On 10/1/19 2:27 PM, Catalin Marinas wrote:
> > On Tue, Oct 01, 2019 at 02:14:23PM +0100, Will Deacon wrote:
> >> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> >>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >>> index 37c610963eee..0e5beb928af5 100644
> >>> --- a/arch/arm64/Kconfig
> >>> +++ b/arch/arm64/Kconfig
> >>> @@ -110,7 +110,7 @@ config ARM64
> >>>  	select GENERIC_STRNLEN_USER
> >>>  	select GENERIC_TIME_VSYSCALL
> >>>  	select GENERIC_GETTIMEOFDAY
> >>> -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
> >>> +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_ARM_GCC)
> >>>  	select HANDLE_DOMAIN_IRQ
> >>>  	select HARDIRQS_SW_RESEND
> >>>  	select HAVE_PCI
> >>> @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
> >>>  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
> >>>  	default 0xffffffffffffffff
> >>>  
> >>> +config COMPATCC_IS_ARM_GCC
> >>> +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
> >>
> >> I've seen toolchains where the first part of the tuple is "armv7-", so they
> >> won't get detected here. However, do we really need to detect this? If
> >> somebody passes a duff compiler, then the build will fail in the same way as
> >> if they passed it to CROSS_COMPILE=.
> > 
> > Not sure what happens if we pass an aarch64 compiler. Can we end up with
> > a 64-bit compat vDSO?
> > 
> 
> I agree with Catalin here. The problem is not only when you pass and aarch64
> toolchain but even an x86 and so on.

I disagree. What happens if you do:

$ make ARCH=arm64 CROSS_COMPILE=x86_64-linux-gnu-

on your x86 box?

> If the problem is related to armv7- we can change the rule as "arm.*-gcc" which
> should detect them as well. Do you know what is the triple that an armv7-
> toolchain prints?

'fraid not, since I don't have one to hand. I think you'd end up matching
arm*-gcc, which is pretty broad.

Will
