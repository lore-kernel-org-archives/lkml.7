Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E87222297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfdZuFVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbfHGQdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:33:21 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38591 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388680AbfHGQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:33:20 -0400
Received: by mail-ua1-f68.google.com with SMTP id j2so8439743uaq.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqwCuUb3824NjSlV2+AsrTycJRPhzIvIEnU7QoSRAQg=;
        b=sfdZuFVcKlzBkKxRpePhUULJN6CZvN7pT1eJO45Rr5oQgW0UItoswajIHXrFPBJaCg
         Zrt3Bn+P1P1kuXyKBfY6n++OGHAq4qCYv4lD5VbxT0xUcFWfn2Cu9+E2hy4onmfvkNtz
         Ps0g5obqwXc9YyYPWeEje00J3c8QIgXfycPbLTzGhE+RtiJRRPuWBhkRm8HAak4zJLm0
         NG91Qp2Cz4MxpXO7vp/iPXgfc/FaDFLJ1c6Px9vENweo2vNhl9odpumalMSdvDjus+Pv
         pS590+pBfoRopyl+yRlqLfXhP99+n+A3zPeLJbX+1jGqupL/DCg4PcegtoW+b5sI2ZZI
         XkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqwCuUb3824NjSlV2+AsrTycJRPhzIvIEnU7QoSRAQg=;
        b=olRYGkqByY3zNrUb/mxGcf56OKQ2qZlAd3H1XKF3Z3jsviUYm06U+SxtB5ZY3hRMGL
         HEBgG647xTHc2fDuiZKPOWI66mKuNYBiQ5vIxWp7CwohNVl9vxVocjjHhn6DYHA6aRFL
         ySWUTh0NcdfV+0ALMBpJDM90chHj4ai2noFs6aLmAGd1OU01zjx0U3scr9A8ZaPQZn5T
         OIPDH6rDjnQ4Gu7mB3VqH//JSiUZa+I1b/4l//iGB/4/8dHYpdjpwn3FGvtMdfXR8+NY
         EoBKpxRdaladh6+2uEN0aUxTERMcvj5UFLsYr+9nE5SbF/eFkLrnzmFxg8qvXGYWiZrP
         UwHw==
X-Gm-Message-State: APjAAAXqI9ZR8zbXtvyuQZmGWoGZvhxCHSETbJSZAQ/a8frH6cBkLIFY
        OU6l/gF9unPV601EQ1W612ZBkvMwTgbdUJzb7zHPKA==
X-Google-Smtp-Source: APXvYqwV+vUTxFOzNG1hQRbNg83yInzGpz3jt1R2oAaBMCNrBKlZPS6VruKmCKXsoaLNogat55WRdoSpFRMF0s1+p8Y=
X-Received: by 2002:ab0:6e2:: with SMTP id g89mr6425837uag.56.1565195598785;
 Wed, 07 Aug 2019 09:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190807095022.0314e2fc@canb.auug.org.au> <CAMn1gO6P_VfDRjGZb67ZS4Kh0wjTEQi0cbOkmibTokHQOgP7qw@mail.gmail.com>
 <20190807114614.ubzlkulk7aidws3p@willie-the-truck> <CAK7LNASr8mbGDbWikr2P8Pc_6WEpMyXuK-xkgypYOzkWw_6LUw@mail.gmail.com>
 <20190807152506.m2mzzjtb7kzjoiia@willie-the-truck>
In-Reply-To: <20190807152506.m2mzzjtb7kzjoiia@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 7 Aug 2019 09:33:07 -0700
Message-ID: <CAMn1gO65tjqHgWsX_gTB9eaerFRevWtWd6dkkEoHnjo+BG1m=w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm64 tree
To:     Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 8:25 AM Will Deacon <will@kernel.org> wrote:
>
> Hello Masahiro,
>
> On Wed, Aug 07, 2019 at 11:43:02PM +0900, Masahiro Yamada wrote:
> > On Wed, Aug 7, 2019 at 8:46 PM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Aug 06, 2019 at 07:34:36PM -0700, Peter Collingbourne wrote:
> > > > We're setting NM to something else based on a config option, which I
> > > > presume sets up some sort of circular dependency that confuses
> > > > Kconfig. Removing this fragment of the makefile (or appending
> > > > --synthetic unconditionally) also makes the problem go away.
> >
> > Exactly. This makes a circular dependency.
> > Kconfig determines the environment variable 'NM' has been changed,
> > and re-runs.
> >
> > > Yes, I think you're right. The lack of something like KBUILD_NMFLAGS means
> > > that architectures are forced to override NM entirely if they want to pass
> > > any specific options. Making that conditional on a Kconfig option appears
> > > to send the entire thing recursive.
> >
> > Adding KBUILD_NMFLAGS is probably the right thing to do.
> > (Is there somebody who wants to volunteer for this?)
>
> I don't think so ;) We don't do this for many other tools, and there's only
> this one case that really seems to require it.
>
> > But, for this particular case, I vote for
> > the entire removal of --synthetic.
> >
> > This dates back to 2004, and the commit message
> > did not clearly explain why it was needed.
> >
> > The PowerPC maintainers should re-evaluate
> > whether or not this flag is necessary.
> >
> > ppc32 is working without --synthetic,
> > so probably ppc64 would be ...
>
> Again, this is up to the PPC maintainers.
>
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d96127ebc44e..a38027a06b79 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -31,7 +31,7 @@ config CC_HAS_ASM_GOTO
> > >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> > >
> > >  config TOOLS_SUPPORT_RELR
> > > -       def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
> > > +       def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(CROSS_COMPILE)nm" "OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
> > >
> > >  config CC_HAS_WARN_MAYBE_UNINITIALIZED
> > >         def_bool $(cc-option,-Wmaybe-uninitialized)
> >
> > Maybe,
> >
> > def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "OBJCOPY=$(OBJCOPY)"
> > $(srctree)/scripts/tools-support-relr.sh)
> >
> > will work.
>
> Oh yes, I prefer that. I've included the updated patch below, and I'll
> put it into -next shortly so that we resolve the build breakage. Hopefully
> we'll have a better fix once the ozlabs folks wake up.
>
> > Or more simply
> >
> > def_bool $(success,$(srctree)/scripts/tools-support-relr.sh)
> >
> > CC, LD, OBJCOPY, NM are environment variables,
> > so I think tools-support-relr.sh can directly use them.
>
> Maybe, but the other scripts invoked here tend to pass $(CC) through as
> an argument, and that helps with your observation below...:
>
> > However, this bypasses the detection of environment variable changes.
> > If a user passes NM= from the command line, Kconfig will no longer
> > notice the change of NM.
>
> ... but since my proposal also breaks this, then I think your idea of just
> dropping $NM for now is best.

Thanks Will, that sounds good to me as well. I verified that it fixes
the hang in ppc64 on my end, and that we can still produce RELR
relocations on arm64 by passing in llvm-nm as $NM.

> Will
>
> --->8
>
> From 71c67a31f09fa8fdd1495dffd96a5f0d4cef2ede Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Wed, 7 Aug 2019 12:48:33 +0100
> Subject: [PATCH] init/Kconfig: Fix infinite Kconfig recursion on PPC
>
> Commit 5cf896fb6be3 ("arm64: Add support for relocating the kernel with
> RELR relocations") introduced CONFIG_TOOLS_SUPPORT_RELR, which checks
> for RELR support in the toolchain as part of the kernel configuration.
> During this procedure, "$(NM)" is invoked to see if it supports the new
> relocation format, however PowerPC conditionally overrides this variable
> in the architecture Makefile in order to pass '--synthetic' when
> targetting PPC64.
>
> This conditional override causes Kconfig to recurse forever, since
> CONFIG_TOOLS_SUPPORT_RELR cannot be determined without $(NM) being
> defined, but that in turn depends on CONFIG_PPC64:
>
>   $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
>   scripts/kconfig/conf  --syncconfig Kconfig
>   scripts/kconfig/conf  --syncconfig Kconfig
>   scripts/kconfig/conf  --syncconfig Kconfig
>   [...]
>
> In this particular case, it looks like PowerPC may be able to pass
> '--synthetic' unconditionally to nm or even drop it altogether. While
> that is being resolved, let's just bodge the RELR check by picking up
> $(NM) directly from the environment in whatever state it happens to be
> in.
>
> Cc: Peter Collingbourne <pcc@google.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Tested-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Peter Collingbourne <pcc@google.com>

Peter
