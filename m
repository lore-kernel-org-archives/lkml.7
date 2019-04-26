Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7614C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EE820679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfDZKBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:01:02 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:35224 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfDZKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:01:01 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 06:01:00 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 16202)
        id AD6682804B1; Fri, 26 Apr 2019 11:55:22 +0200 (CEST)
Date:   Fri, 26 Apr 2019 11:55:22 +0200
From:   Jan Hubicka <hubicka@ucw.cz>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, mliska@suse.cz
Subject: Re: Livepatch vs LTO
Message-ID: <20190426095522.wyymezuqzkdck6fm@kam.mff.cuni.cz>
References: <20190425152628.ogk4woi3omeocwly@treble>
 <alpine.LSU.2.21.1904261054240.27157@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1904261054240.27157@pobox.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [ adding CCs ]
> 
> On Thu, 25 Apr 2019, Josh Poimboeuf wrote:
> 
> > Hi all,
> > 
> > On IRC, Peter expressed some concern about -flive-patching, specifically
> > that the flag isn't compatible with LTO.
> > 
> > The upstream kernel currently doesn't support LTO, but Android is using
> > it with LLVM:
> > 
> >   https://source.android.com/devices/tech/debug/kcfi
> > 
> > And there seems to be progress being made in that direction for
> > upstream.
> > 
> > Live patching has at least the following issues with LTO:
> > 
> > - For source-based patch generation (klp-convert and friends), the GCC
> >   manual says that -flive-patching is incompatible with LTO.  Does
> >   anybody know if that's a hard incompatibility, or can it be fixed?
> 
> Honza could know more. It was either that LTO by itself complicates 
> things for live patching, or that LTO adds more optimizations which are 
> potentially unsafe.

The original patch, by Oracle, was disabling inlining of everyting else
than static functions and later it was strenghtened to disable all the
other inter-procedural optimization as well. With LTO this does not make
that much of sense because, based on linker resolution file, GCC will
turn non-static functions to static when it knows that non-LTO code will
not bind to it.  To make this work we would need to track what was
static originally and what not. But doing so would still prevent most of
LTO transforms because it is all about cross-module inlining and 
propagation and that all needs to be forbidden for this mode of live
patching to make sense.

So basically -flto -flive-patching=inline-only-static would be pretty
much equivalent of -ffunction-sections -fdata-section and enabling
removal of dead sections in the linker. Just slower at compile time.

The clone tracking logic is more compatible with LTO becuase it does not
prevent most optimizations.  I guess it could work and we probably want
to add support for it incrementally.
> 
> >   Also, what about the performance implications of this flag with LTO?
> >   Might they become more pronounced?
> 
> It could. Theoretically. The scope for optimizations would be much 
> broader.
> 
> >   Also I wonder if -fdump-ipa-clones works with LTO?
> 
> It should. According to Martin, there is (almost) nothing special about 
> LTO. Optimization infrastructure is the same, only the scope is not 
> limited to one translation unit.

Yes, you will likely get considerably more clones and inline copies to
care about while doing the live patch.  I would be interested to know
how well it work in practice. No idea if that would be a problem.

Honza
