Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B93C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE262087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDPRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:18:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDPRSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0AF80D;
        Tue, 16 Apr 2019 10:18:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC9F33F690;
        Tue, 16 Apr 2019 10:18:32 -0700 (PDT)
Date:   Tue, 16 Apr 2019 18:18:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190416171829.GD54708@lakrids.cambridge.arm.com>
References: <20190415143821.GA46880@beast>
 <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> On Mon, Apr 15, 2019 at 10:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Apr 15, 2019 at 07:38:21AM -0700, Kees Cook wrote:
> > > diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> > > index 43d8366c1e87..06d3987d1546 100644
> > > --- a/arch/arm64/include/asm/irqflags.h
> > > +++ b/arch/arm64/include/asm/irqflags.h
> > > @@ -43,7 +43,9 @@ static inline void arch_local_irq_enable(void)
> > >       asm volatile(ALTERNATIVE(
> > >               "msr    daifclr, #2             // arch_local_irq_enable\n"
> > >               "nop",
> > > +             DEFINE_MSR_S
> > >               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> > > +             UNDEFINE_MSR_S
> >
> > If we do need this, can we wrap this in a larger CPP macro that does the
> > whole sequence of defining, using, and undefining the asm macros?
> 
> I agree that would be cleaner.  For example, __mrs_s/__msr_s can
> ALMOST do this (be used in arch/arm64/include/asm/irqflags.h) except
> for the input/output constraints.  Maybe the constraints can be
> removed from the cpp macro definition, then the constraints be left to
> the macro expansion sites?  That way the DEFINE_MXX_S/UNDEFINE_MXX_S
> can be hidden in the cpp macro itself.

If those took the register template explicitly, i.e. something like:

	__mrs_s(SYS_ICC_PMR_EL1, "%x0") 

	__msr_s("%[whatever]", SYS_FOO)

... that would be more generally useful and clear, as they could be used
in larger asm sequences.

Thanks,
Mark.
