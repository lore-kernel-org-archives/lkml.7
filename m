Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2735C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7288F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551369580;
	bh=aFTm8FswU+rD52aqjwYGV7iVK6SZgsimXNyLHcpbRpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DFZ7d+nxp2+IDSzYxjYozuSnFe0kB5SU7P7r3do2ZBea2SjVM7lN20hnuTkhQ0V//
	 V0oScXI2muq8WbKbnDIsiEHXJuGGb3IrJp090WkeaDX1njfZBwDjHg9XHAzJs4dOJ2
	 n/h84c85tY7k4KAo0VFfskUouoLRWO0l+lyx8MMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfB1P7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:59:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38799 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfB1P7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:59:33 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so17416638edb.5;
        Thu, 28 Feb 2019 07:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5D2QMDutFUGJ1AbgQc468F84xPwM7FhWp31+MeV1/U=;
        b=ogG8i30u7TYbomGy/+8wsCzyahd7ekI3gM5x6wAi2O6sPpEEATjmH/NcfYuOxkyT1A
         lnbo0q+udIaQDEH+OWy6uorTBSiW6ptd2t9EY2GzsVK+6WsN+sJ1fRidWl9L90gqC6Gj
         Ov+sLMKCl+uj5sRZYgHpzz0QDhTkgEdUGbM43pW8csaqX+TzbMGticjn3hD/eE6rhWl+
         dKNy+Fxcwvf0hrIbw0LMtJ4vaN6CbJPcHbAlpEOJR5nZ1qq2Wky0ow8ThPR51TRH8L0S
         popAFhRB6NoxnyLIr+rrD+YbiC6WZbI2PoetmaAWZUMPfNXcCOGaES3s+XC2hcPCfbvo
         +95w==
X-Gm-Message-State: APjAAAWvovoiC4xMCrOZ8FADaMu/qxqXsJByzz6mDFE8Fro3ggTthksU
        QWDRt1mzx5NnNg0/csYozshczAf4GB/Tpm1zAoQaXQ==
X-Google-Smtp-Source: APXvYqwOyiVObY5qbn9dbufD06mSn8A85Det+YcbUXvud9o4AT9KoKijpnvw9kqcFA7SODPhc5mzsHb+RpV4a2Cu5PY=
X-Received: by 2002:a50:9e61:: with SMTP id z88mr287620ede.100.1551369571116;
 Thu, 28 Feb 2019 07:59:31 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <07d2908dc72bf964b27380999e1c826587d69136.1550545163.git.len.brown@intel.com>
 <20190220105542.GB17969@hirez.programming.kicks-ass.net> <CAJvTdK=+Lw1_WFE4_aGqxtRPK_JafmmzcmGSqScMOB4EK-xH5g@mail.gmail.com>
 <20190226135426.GU32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190226135426.GU32477@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 28 Feb 2019 10:59:19 -0500
Message-ID: <CAJvTdKk6B0rWMukNv3OKimSvbDqP+c83dTQpO4kFvbL7ETGPvg@mail.gmail.com>
Subject: Re: [PATCH 03/11] x86 topology: Add CPUID.1F multi-die/package support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 8:54 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > > It would've been nice to have the CPUID instruction 1F leaf reference
> > > 3B-3.9 in the SDM, and maybe mention this here too.
> >
> > I didn't mention SDM sections because they change -- leaving stale
> > pointers in our commit messages.  The SDM is re-published 4 times per
> > year.
>
> Yah, I know. Which is why I keep all SDMs. So if you say, book 3 section
> 8 of Jul'17, I can find it :-)

The SDM is like software -- usually (but not always) you are better
off with the latest version:-)

> > Cache enumeration in Leaf-4 is totally unchanged.
> > ACPI NUMA tables are totally unchanged.
>
> Sure; and yet Sub-NUMA-Clustering broke stuff in interesting ways. I'm
> trying to get a feel for how these levels will interact with all that.
>
> Before that SNC stuff, caches had never spanned NODEs (and I still
> think that is 'creative' at best).

Yeah, SNC is sort of a curve ball.  I guess it made enough stuff run better that
it is available as an option.  But it doesn't help everything, so it is disabled
by default...

I think from a scheduler point of view, sticking with the output of
CPUID.4 for the cache topology, and the ACPI tables for the
node topology/distances, is the right strategy.

> > From a scheduler point of view, imagine that a SKX system with 4 die
> > in 4 packages was mechanically re-designed so that those 4 die resided
> > in 2 double-sized packages.
> >
> > They may have tweaked the links between the die, but logically it is
> > identical and compatible, and the legacy kernel will function
> > properly.
>
> This example has LLC in die and yes that works.
>
> But I can imagine things like L2 in tile and L3 across tiles but within
> DIE and then it _might_ make sense to still consider the tile for
> scheduling.
>
> Another option is having the LLC off die; also not unheard of.
>
> And then there's many creative and slightly crazy ways this can all be
> combined :/

If any of those crazy things happen,  CPUID.B/CPUID.1F are not
going to help software understand it -- CPUID.4 and the NUMA tables
are the tool of choice.

> > So the effect of Leaf B,1F is that it defines the scope of MSRs.  eg.
> > what processors does a die-scope MSR cover.  That is why the rest of
> > the patch is about sysfs topology, and about package MSR scope.
> >
> > Yes, there will be more exotic MSR situations in future products --
> > the first ones are pretty simple -- something  called a
> > package-scope-MSR  in the SDM today becomes a die-scope-MSR in this
> > generation on a multi-die/package system.
>
> Yes :-(
>
> > It also reflects how many packages appear in sysfs, and this can
> > effect licensing of some kinds of software.
>
> That's just plain insanity and we should not let that affect our sysfs
> interfaces.

This change isn't made for compatibility with per-package licensing.
Indeed, vendors, who license  based on package-count need to
be made aware that on a system with multi-die/package, they'll
see their package count go _down_ as a result of this change.
Thankfully, I'm told that per-package licensing is quite rare --
most stuff that cares has moved to per-CPU.

I think a good semantic side effect of this series is that it
maintains the invariant that a physical package and a socket are synonymous.
While we don't use the word "socket" in Linux anymore, the industry
broadly assume that the two are synonyms.  And people expect that a
physical package really is a physical package -- you can see it,
buy it in a box, and hold it in your hand.

Functionally, the bottom line is that it allows software to discover topology
levels that previously needed to be discovered by looking up family/model,
in the past, which was sort of annoying.  The things that care are
things that care about MSR scope.   Thankfully, the list of things that care
about MSR scope is quite finite.

thanks,
-Len




--
Len Brown, Intel Open Source Technology Center
