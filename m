Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DAE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391825AbfFKPtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:49:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbfFKPtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:49:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE83337;
        Tue, 11 Jun 2019 08:49:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888B63F246;
        Tue, 11 Jun 2019 08:49:05 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:49:03 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Allow assembly code to use BIT(), GENMASK(), etc.
 and clean-up arm64 header
Message-ID: <20190611154903.GH4324@fuggles.cambridge.arm.com>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
 <20190605073406.geesp3rbrxajmac6@mbp>
 <CAK7LNAQJPMsRtNRYUH+dib0ZMAPqOe5HO0UcAW7zRdjyWWyQWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQJPMsRtNRYUH+dib0ZMAPqOe5HO0UcAW7zRdjyWWyQWQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 06:01:10PM +0900, Masahiro Yamada wrote:
> On Wed, Jun 5, 2019 at 4:36 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Mon, May 27, 2019 at 05:34:10PM +0900, Masahiro Yamada wrote:
> > > Some in-kernel headers use _BITUL() instead of BIT().
> > >
> > >  arch/arm64/include/asm/sysreg.h
> > >  arch/s390/include/asm/*.h
> > >
> > > I think the reason is because BIT() is currently not available
> > > in assembly. It hard-codes 1UL, which is not available in assembly.
> > [...]
> > > Masahiro Yamada (2):
> > >   linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
> > >   arm64: replace _BITUL() with BIT()
> > >
> > >  arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
> > >  include/linux/bits.h            | 17 ++++---
> >
> > I'm not sure it's worth the hassle. It's nice to have the same BIT macro
> > but a quick grep shows arc, arm64, s390 and x86 using _BITUL. Maybe a
> > tree-wide clean-up would be more appropriate.
> 
> 
> I am happy to clean-up the others
> in the next development cycle
> once 1/2 lands in the mainline.
> 
> 
> Since there is no subsystem that
> takes care of include/linux/bits.h,
> I just asked Will to pick up both.
> I planed per-arch patch submission
> to reduce the possibility of merge conflict.
> 
> 
> If you guys are not willing to pick up them,
> is it better to send treewide conversion to Andrew?

I'm happy either way, so I've acked both of the patches.

Will
