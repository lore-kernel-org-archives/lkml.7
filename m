Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED5208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfFQR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:26:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfFQR0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:26:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D841628;
        Mon, 17 Jun 2019 10:26:23 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94A93F246;
        Mon, 17 Jun 2019 10:26:22 -0700 (PDT)
Date:   Mon, 17 Jun 2019 18:26:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190617172620.GK30800@fuggles.cambridge.arm.com>
References: <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
 <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com>
 <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com>
 <201906150654.FF4400F7C8@keescook>
 <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
 <201906161429.BCE1083@keescook>
 <CAKv+Gu_8ibO4D01DZv6KjL2GnvKuVBVnt=doxkN0w=4utJ7NvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_8ibO4D01DZv6KjL2GnvKuVBVnt=doxkN0w=4utJ7NvQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:33:19PM +0200, Ard Biesheuvel wrote:
> On Sun, 16 Jun 2019 at 23:31, Kees Cook <keescook@chromium.org> wrote:
> > On Sat, Jun 15, 2019 at 04:18:21PM +0200, Ard Biesheuvel wrote:
> > > Yes, I am using the same saturation point as x86. In this example, I
> > > am not entirely sure I understand why it matters, though: the atomics
> > > guarantee that the write by CPU2 fails if CPU1 changed the value in
> > > the mean time, regardless of which value it wrote.
> > >
> > > I think the concern is more related to the likelihood of another CPU
> > > doing something nasty between the moment that the refcount overflows
> > > and the moment that the handler pins it at INT_MIN/2, e.g.,
> > >
> > > > CPU 1                   CPU 2
> > > > inc()
> > > >   load INT_MAX
> > > >   about to overflow?
> > > >   yes
> > > >
> > > >   set to 0
> > > >                          <insert exploit here>
> > > >   set to INT_MIN/2
> >
> > Ah, gotcha, but the "set to 0" is really "set to INT_MAX+1" (not zero)
> > if you're using the same saturation.
> >
> 
> Of course. So there is no issue here: whatever manipulations are
> racing with the overflow handler can never result in the counter to
> unsaturate.
> 
> And actually, moving the checks before the stores is not as trivial as
> I thought, E.g., for the LSE refcount_add case, we have
> 
>         "       ldadd           %w[i], w30, %[cval]\n"                  \
>         "       adds            %w[i], %w[i], w30\n"                    \
>         REFCOUNT_PRE_CHECK_ ## pre (w30))                               \
>         REFCOUNT_POST_CHECK_ ## post                                    \
> 
> and changing this into load/test/store defeats the purpose of using
> the LSE atomics in the first place.
> 
> On my single core TX2, the comparative performance is as follows
> 
> Baseline: REFCOUNT_TIMING test using REFCOUNT_FULL (LSE cmpxchg)
>       191057942484      cycles                    #    2.207 GHz
>       148447589402      instructions              #    0.78  insn per
> cycle
> 
>       86.568269904 seconds time elapsed
> 
> Upper bound: ATOMIC_TIMING
>       116252672661      cycles                    #    2.207 GHz
>        28089216452      instructions              #    0.24  insn per
> cycle
> 
>       52.689793525 seconds time elapsed
> 
> REFCOUNT_TIMING test using LSE atomics
>       127060259162      cycles                    #    2.207 GHz

Ok, so assuming JC's complaint is valid, then these numbers are compelling.
In particular, my understanding of this thread is that your optimised
implementation doesn't actually sacrifice any precision; it just changes
the saturation behaviour in a way that has no material impact. Kees, is that
right?

If so, I'm not against having this for arm64, with the premise that we can
hide the REFCOUNT_FULL option entirely given that it would only serve to
confuse if exposed.

Will
