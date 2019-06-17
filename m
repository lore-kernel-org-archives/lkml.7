Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754AF208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfFQQp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:45:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:45:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D108028;
        Mon, 17 Jun 2019 09:45:56 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A1343F718;
        Mon, 17 Jun 2019 09:45:55 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:45:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
Message-ID: <20190617164553.GI30800@fuggles.cambridge.arm.com>
References: <20190617104237.2082388-1-arnd@arndb.de>
 <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com>
 <20190617161330.GD30800@fuggles.cambridge.arm.com>
 <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:32:16PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Jun 2019 at 18:13, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Jun 17, 2019 at 02:21:46PM +0200, Arnd Bergmann wrote:
> > > On Mon, Jun 17, 2019 at 1:26 PM Will Deacon <will.deacon@arm.com> wrote:
> > > > On Mon, Jun 17, 2019 at 12:42:11PM +0200, Arnd Bergmann wrote:
> > > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > > index 07f238ef47ae..2aba07cccf50 100644
> > > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > > @@ -400,6 +400,9 @@ static int __init sve_sysctl_init(void) { return 0; }
> > > > >  #define ZREG(sve_state, vq, n) ((char *)(sve_state) +                \
> > > > >       (SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
> > > > >
> > > > > +#ifdef __GENKSYMS__
> > > > > +typedef __u64 __uint128_t[2];
> > > > > +#endif
> > > >
> > > > I suspect I need to figure out what genksyms is doing, but I'm nervous
> > > > about exposing this as an array type without understanding whether or
> > > > not that has consequences for its operation.
> > >
> > > The entire point is genksyms is to ensure that types of exported symbols
> > > are compatible. To do this, it has a limited parser for C source code that
> > > understands the basic types (char, int, long, _Bool, etc) and how to
> > > aggregate them into structs and function arguments. This process has
> > > always been fragile, and it clearly breaks when it fails to understand a
> > > particular type.
> >
> > Ok, but the patch that appears to cause this problem doesn't change the
> > type of anything we're exporting. The symbol in your log is
> > "kernel_neon_begin" which is:
> >
> >         void kernel_neon_begin(void);
> >
> > so I'm still fairly confused about the problem. In fact, even if I create
> > a silly:
> >
> >         void will_kernel_neon_begin(__uint128_t);
> >
> > function, then somehow I see it being processed:
> >
> >         __crc_will_kernel_neon_begin = 0x5401d250;
> >
> > Is there some way that your passing '-w' to genksyms?
> >
> 
> The problem is not about the types we're *exporting*. Genksyms just
> gives up halfway through the file, as soon as it encounters something
> it doesn't like, and any symbol that hasn't been encountered yet at
> that point will not have a crc generated for it.

Hmm, but it appears to be either working or failing silently for me, which
doesn't match what Arnd is seeing. I'd prefer to fix genksyms but I'm not
happy touching it if I can't show it's broken to begin with. If I pass '-w'
I see it barfing on all sorts of random stuff, for example the static_assert
in include/linux/fs.h:

	static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);

Will
