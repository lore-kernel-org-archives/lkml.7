Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F92ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F57820842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfJAN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:27:35 -0400
Received: from foss.arm.com ([217.140.110.172]:49660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388337AbfJAN1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:27:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D2B91000;
        Tue,  1 Oct 2019 06:27:34 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3973F534;
        Tue,  1 Oct 2019 06:27:33 -0700 (PDT)
Date:   Tue, 1 Oct 2019 14:27:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20191001132731.GG41399@arrakis.emea.arm.com>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:14:23PM +0100, Will Deacon wrote:
> On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 37c610963eee..0e5beb928af5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -110,7 +110,7 @@ config ARM64
> >  	select GENERIC_STRNLEN_USER
> >  	select GENERIC_TIME_VSYSCALL
> >  	select GENERIC_GETTIMEOFDAY
> > -	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
> > +	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT && COMPATCC_IS_ARM_GCC)
> >  	select HANDLE_DOMAIN_IRQ
> >  	select HARDIRQS_SW_RESEND
> >  	select HAVE_PCI
> > @@ -313,6 +313,9 @@ config KASAN_SHADOW_OFFSET
> >  	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
> >  	default 0xffffffffffffffff
> >  
> > +config COMPATCC_IS_ARM_GCC
> > +	def_bool $(success,$(COMPATCC) --version | head -n 1 | grep -q "arm-.*-gcc")
> 
> I've seen toolchains where the first part of the tuple is "armv7-", so they
> won't get detected here. However, do we really need to detect this? If
> somebody passes a duff compiler, then the build will fail in the same way as
> if they passed it to CROSS_COMPILE=.

Not sure what happens if we pass an aarch64 compiler. Can we end up with
a 64-bit compat vDSO?

-- 
Catalin
