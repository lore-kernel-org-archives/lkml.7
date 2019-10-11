Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0235FECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD46206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfJKPdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:33:52 -0400
Received: from foss.arm.com ([217.140.110.172]:36002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfJKPdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:33:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8EF142F;
        Fri, 11 Oct 2019 08:33:51 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10853F68E;
        Fri, 11 Oct 2019 08:33:48 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:33:46 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Amit Kachhap <amit.kachhap@arm.com>,
        Paul Elliott <paul.elliott@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 08/12] arm64: BTI: Decode BYTPE bits when printing
 PSTATE
Message-ID: <20191011153346.GM27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-9-git-send-email-Dave.Martin@arm.com>
 <18c9318c-d122-b534-b526-318935d9e2cc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c9318c-d122-b534-b526-318935d9e2cc@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:31:02AM -0400, Richard Henderson wrote:
> On 10/10/19 2:44 PM, Dave Martin wrote:
> >  #define PSR_IL_BIT		(1 << 20)
> > -#define PSR_BTYPE_CALL		(2 << PSR_BTYPE_SHIFT)
> > +
> > +/* Convenience names for the values of PSTATE.BTYPE */
> > +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)
> 
> It'd be nice to sort this patch earlier, so that ...
> 
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index 4a3bd32..452ac5b 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -732,7 +732,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >  
> >  	if (system_supports_bti()) {
> >  		regs->pstate &= ~PSR_BTYPE_MASK;
> > -		regs->pstate |= PSR_BTYPE_CALL;
> > +		regs->pstate |= PSR_BTYPE_C;
> >  	}
> >  
> >  	if (ka->sa.sa_flags & SA_RESTORER)
> 
> ... setup_return does not need to be adjusted a second time.
> 
> I don't see any other conflicts vs patch 5.

Ack, looks like I mis-split this during rebase.

Will fix.

Cheers
---Dave
