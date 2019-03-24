Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484A20880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="onRPPSSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCXCXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 22:23:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47226 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfCXCXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 22:23:06 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2O2Mlk4009950
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:22:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2O2Mlk4009950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553394168;
        bh=0BKPm+Ru2fB4N9zmFWmWzKSFfEVtQHafBqKAxQzeOVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onRPPSSHX9ZE/KzpxyLC9fAXA85Uk+NGHHtvsH/O589i8cX6IjcrC11IeCSqYROgK
         HFPXMJ5X9+ebrZrGzrlEpM3PAvZ/iaAZcteWi3y50j86MNExVGGnzEz8NAtf3Pn9gH
         1mmB5R6sG1/LBurOOMKr6wx3SZ1IJNrMuRinAp1yC4vvOtinOPLC+fTSm9QHn7nYfa
         GbAYLOIdRWwT9ly9elRVyBvLvE0IE2wZoaYEGHDv/2NgwD30TieF08zKONhdD1rt7S
         rHu91yl4Ndiofn5FRmfthTevflWfM+7ozcZOkfIOwTrkEpwy39qbU0Hw4aNR9a4MAs
         7X4+T0PaZf9VA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id n4so3502622vsm.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 19:22:47 -0700 (PDT)
X-Gm-Message-State: APjAAAW9gD7Xb3yu0fA/CK4+wdBe/e7BzyFEmKW1x4JvSs0RmQWb2Bc7
        qzMjf6KqedwnmYO0oEuxC/4RYQ6Ll9r4o1FUbJo=
X-Google-Smtp-Source: APXvYqwyQQ7qpdwGNa6t9b28zF2o74k7PqH4tBAxOeuTnsfvVwD8Uuj+XqnxeG2QOsHtfkLiaswd9NKLSjWTUPrfsvk=
X-Received: by 2002:a67:f105:: with SMTP id n5mr11059166vsk.181.1553394166974;
 Sat, 23 Mar 2019 19:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190203084840.6113-1-vladimir.kondratiev@intel.com> <20190322155212.133029-1-andre.przywara@arm.com>
In-Reply-To: <20190322155212.133029-1-andre.przywara@arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 24 Mar 2019 11:22:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3Yf1_3L77VNjtcr5SP2eM0x19hid0J45PcHqf8Fwcwg@mail.gmail.com>
Message-ID: <CAK7LNAT3Yf1_3L77VNjtcr5SP2eM0x19hid0J45PcHqf8Fwcwg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: gitignore output directory
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 12:53 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> Hi,
>
> > When compiling into output directory using O=, many files
> > created under KBUILD_OUTPUT that git considers
> > as new ones; git clients, ex. "git gui" lists it, and it clutters
> > file list making it difficult to see what was really changed
> >
> > Generate .gitignore in output directory that ignores all
> > its content
>
> just found this when testing -rc1.
> Unfortunately this breaks my setup, because I keep a totally separate
> git repository in my build directories to track (various versions of)
> .config. So .gitignore there is carefully crafted to ignore most build
> artefacts, but not .config, for instance.
>
> I am not sure how git would interact with the build directory for you?
> Do you build into a subdirectory of the kernel tree?
>
> I was hoping that we would not overwrite unrelated files in directories
> outside of the kernel tree. In case this is about a subdirectory of the
> source tree, can we somehow check for this case?


I am not sure if it is worthwhile
adjusting the upstream kernel to
the workflow of an individual like this.

If it is, we could like this:

outputmakefile:
ifneq ($(KBUILD_SRC),)
        $(Q)ln -fsn $(srctree) source
        $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
        $(Q)test -e .gitignore || \
        { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
endif


> Cheers,
> Andre.
>
> >
> > Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 97ee0be24d52..d487fca342c4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -483,10 +483,13 @@ PHONY += outputmakefile
> >  # outputmakefile generates a Makefile in the output directory, if using a
> >  # separate output directory. This allows convenient use of make in the
> >  # output directory.
> > +# At the same time when output Makefile generated, generate .gitignore to
> > +# ignore whole output directory
> >  outputmakefile:
> >  ifneq ($(KBUILD_SRC),)
> >       $(Q)ln -fsn $(srctree) source
> >       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> > +     $(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> >  endif
> >
> >  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> > --
> > 2.17.1
>


-- 
Best Regards
Masahiro Yamada
