Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C600C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817E22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpmcUD45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfHTRPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:15:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44149 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfHTRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:15:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so3061205plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZI5If9J9jwZ+aNJSf9GpR6A5shPqD+0/7szQP+tyGE=;
        b=DpmcUD45xuaEwBbWg93OIAUofL58edyNWb9vEtY9xgmR0WPPRNc+vujxMWWvexGUeM
         C/vJDA+Q3cpGyy/P2tSTnV8mSiYAJoTE2pLOClggHFJBNDapLM26NTNdb1LG57+BCYQm
         f1RLfXX5ichm1C+CaIXCAxdrd8kRHWdCz4lsnHeveBQJ895CqOthjHr5dAoNTStr0ilf
         d/VVylKro7tzqK/cU6qtK2KWmen3k2nQRFcl0V7hh9OCw9itTE6kFh/qfMJ+LzEoAzJH
         US+MDf1K9IR1QvE9laNMi3RmPa0qhhVviLIdJeXcUbyuSQRRIsTnaI+VMZaKD20WiTC5
         Rtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZI5If9J9jwZ+aNJSf9GpR6A5shPqD+0/7szQP+tyGE=;
        b=bkraTTKcpTiduj4Ogj93hOz2IxVHDuJngVQ8VQmSf59qLI5wqaF7zqsHQa7RSw3xNl
         TTOgzkhNBvUA0Up/eOxTfCNaH5RCNJg4hL5D+ovcZwkIy31vA8FdEWQZcNCKVFGOWhNM
         pXmMdpYk4zc1z1/qqUgY/VHoDHj40GpTlaif2KpXjWKYiJREJ9UVdsQtfGBgSTfuylSY
         UPS/G+3YDi3Tzk7NgVkDjTp5PqqEr8QTUmYUr5YKBfRa7LOxP+YsHhnbJUf0/DX/6ruP
         f+a/VrEZ9neGvQTXfCkmxlvdB13N1+uZet3fhLVVWiivPjkOX6IB+7ayxY5UuBBq0j3z
         T2cw==
X-Gm-Message-State: APjAAAX11VKY5M1IZaTUVew9UKx6r4gQla5cwGPeUOLQjITj+7w3f4XD
        fks1aGOkj7WnKl3SV5G/VnALXkRWxYHM1tmhx3cctQ==
X-Google-Smtp-Source: APXvYqx4J9x/srmWF/qgJMyHO8iY4EC8fRqGKKmz2M+EMGV4nEGFLN5a8OPxcrfOzUX+q7GYOR0bEgY4yfKhM1wRQg0=
X-Received: by 2002:a17:902:2bc7:: with SMTP id l65mr16896783plb.119.1566321316952;
 Tue, 20 Aug 2019 10:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190729211014.39333-1-ndesaulniers@google.com>
 <alpine.LFD.2.21.1907292302451.16059@eddie.linux-mips.org> <CAKwvOd==SCBrj=cZ7Ax5F87+-bPMS9AtGSxp+NWp_+yDCg4R-A@mail.gmail.com>
In-Reply-To: <CAKwvOd==SCBrj=cZ7Ax5F87+-bPMS9AtGSxp+NWp_+yDCg4R-A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Aug 2019 10:15:05 -0700
Message-ID: <CAKwvOdkXLhEuLiQ_ukE75zEg=Sw5-4BLHHCFqcZ0oyTEX3pWTQ@mail.gmail.com>
Subject: Re: [PATCH] mips: avoid explicit UB in assignment of mips_io_port_base
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Stephen Kitt <steve@sk2.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mips@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        regehr@cs.utah.edu, Philip Reames <listmail@philipreames.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Delva <adelva@google.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
Bumping this thread; we'd really like to be able to boot test another
ISA in our CI.  This lone patch is affecting our ability to boot.  Can
you please pick it up?
https://lore.kernel.org/lkml/20190729211014.39333-1-ndesaulniers@google.com/

On Wed, Aug 7, 2019 at 2:12 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Sorry for the delayed response, literally sent the patch then went on vacation.
>
> On Mon, Jul 29, 2019 at 3:16 PM Maciej W. Rozycki <macro@linux-mips.org> wrote:
> >
> > On Mon, 29 Jul 2019, Nick Desaulniers wrote:
> >
> > > The code in question is modifying a variable declared const through
> > > pointer manipulation.  Such code is explicitly undefined behavior, and
> > > is the lone issue preventing malta_defconfig from booting when built
> > > with Clang:
> > >
> > > If an attempt is made to modify an object defined with a const-qualified
> > > type through use of an lvalue with non-const-qualified type, the
> > > behavior is undefined.
> > >
> > > LLVM is removing such assignments. A simple fix is to not declare
> > > variables const that you plan on modifying.  Limiting the scope would be
> > > a better method of preventing unwanted writes to such a variable.
>
> This is now documented in the LLVM release notes for Clang-9:
> https://github.com/llvm/llvm-project/commit/e39e79358fcdd5d8ad809defaa821f0bbfa809a5
>
> > >
> > > Further, the code in question mentions "compiler bugs" without any links
> > > to bug reports, so it is difficult to know if the issue is resolved in
> > > GCC. The patch was authored in 2006, which would have been GCC 4.0.3 or
> > > 4.1.1. The minimal supported version of GCC in the Linux kernel is
> > > currently 4.6.
> >
> >  It's somewhat older than that.  My investigation points to:
> >
> > commit c94e57dcd61d661749d53ee876ab265883b0a103
> > Author: Ralf Baechle <ralf@linux-mips.org>
> > Date:   Sun Nov 25 09:25:53 2001 +0000
> >
> >     Cleanup of include/asm-mips/io.h.  Now looks neat and harmless.
>
> Oh indeed, great find!
>
> So it looks to me like the order of events is:
> 1. https://github.com/jaaron/linux-mips-ip30/commit/c94e57dcd61d661749d53ee876ab265883b0a103
> in 2001 first introduces the UB.  mips_io_port_base is defined
> non-const in arch/mips/kernel/setup.c, but then declared extern const
> (and modified via UB) in include/asm-mips/io.h.  A setter is created,
> but not a getter (I'll revisit this below).  This appears to work (due
> to luck) for a few years until:
> 2. https://github.com/mpe/linux-fullhistory/commit/966f4406d903a4214fdc74bec54710c6232a95b8
> in 2006 adds a compiler barrier (reload all variables) and this
> appears to work.  The commit message mentions that reads after
> modification of the const variable were buggy (likely GCC started
> taking advantage of the explicit UB around this time as well).  This
> isn't a fix for UB (more thoughts below), but appears to work.
> 3. https://github.com/llvm/llvm-project/commit/b45631090220b732e614b5530bbd1d230eb9d38e
> in 2019 removes writes to const variables in LLVM as that's explicit
> UB.  We observe the boot failure in mips and narrow it down to this
> instance.
>
> I can see how throwing a compiler barrier in there made subsequent
> reads after UB writes appear to work, but that was more due to luck
> and implementation details of GCC than the heart of the issue (ie. not
> writing code that is explicitly undefined behavior)(and could change
> in future versions of GCC).  Stated another way, the fix for explicit
> UB is not hacks, but avoiding the UB by rewriting the problematic
> code.
>
> > However the purpose of the arrangement does not appear to me to be
> > particularly specific to a compiler version.
> >
> > > For what its worth, there was UB before the commit in question, it just
> > > added a barrier and got lucky IRT codegen. I don't think there's any
> > > actual compiler bugs related, just runtime bugs due to UB.
> >
> >  Does your solution preserves the original purpose of the hack though as
> > documented in the comment you propose to be removed?
>
> The function modified simply writes to a global variable.  It's not
> clear to my why the value about to be modified would EVER be loaded
> before modification.
>
> >  Clearly it was defined enough to work for almost 18 years, so it would be
> > good to keep the optimisation functionally by using different means that
> > do not rely on UB.
>
> "Defined enough" ???
> https://youtu.be/Aq_1l316ow8?t=17
>
> > This variable is assigned at most once throughout the
> > life of the kernel and then early on, so considering it r/w with all the
> > consequences for all accesses does not appear to me to be a good use of
> > it.
>
> Note: it's not possible to express the semantics of a "write once
> variable" in C short of static initialization (AFAIK, without explicit
> violation of UB, but Cunningham's Law may apply).
>
> (set_io_port_base is called in ~20 places)
>
> Thinking more about this while I was away, I think what this code has
> needed since 2001 is proper encapsulation.  If you want a variable
> that is written from one place only, but readable throughout, then the
> pattern I'd use is:
>
> 1. declare a getter in a .h file.
> 2. define/qualify `mips_io_port_base` as `static` and non-const in a
> .c file where it's modified.
> 3. define the getter and setter in the above .c file.
>
> That would rely on linkage to limit the visibility of the symbol for
> modification.  But, we'd then need to export the getter, vs the symbol
> itself.  There's also on the order of ~20 call sites that would need
> to be changed to invoke the getter rather than read the raw variable.
> Also, it's unlikely the getter gets inlined across translation units
> (short of LTO, which the mainline kernel doesn't support today).
>
> I think my patch here (https://lkml.org/lkml/2019/7/29/1636) is
> minimally and much less invasive.
>
> >  Maybe a piece of inline asm to hide the initialisation or suchlike then?
>
> I think that would still be UB as the definition would not be changed;
> you'd still be modifying a variable declared const.
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
