Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8292082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q+4IxAAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfC1JHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:07:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64578 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1JHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:07:53 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2S97igc007686;
        Thu, 28 Mar 2019 18:07:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2S97igc007686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553764065;
        bh=3bDIfX+L5sckcIiwtIDlSwaXrG62U/yYHqZIY/99zr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q+4IxAAHcUyI3asaONQpYeoezzvUhSeamPL97T+2ocg+Refnt7C7asF2qA/kdnNgL
         R8oME7ZSFmF3/idGmd5bXnlSd8HmEoz5/XnjThiRILY2ssSIvV7SuHiI1N94DLFku0
         SxkQFuFFC610GJwuCzNTlN4/Squj35zE3SZLcMreG3ZJog0P0FWrlSsDLNI7iSERiW
         eBlTA+3LDhD2UDuARm+aPj8zexo/gKvnGi2Oeuy6bhPU+Po6zHVQtaYbLstEmjxrJv
         CQfXHpp8XDHX/6xk4YnAIwsBc9A7UACETS/6mFaVWR8K1W/bUpqGuFsgs6xbXOGNex
         IxBcb/QbjwC2A==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id d5so1252509uan.6;
        Thu, 28 Mar 2019 02:07:44 -0700 (PDT)
X-Gm-Message-State: APjAAAUiM4XuUxWzhA9ika49fc3J2WZjvqywrwrVyG024SpmAR8Xdy83
        BgVKgSuWC6jZSTQgEmyZUqqeQdem0Rx6BC5eEXE=
X-Google-Smtp-Source: APXvYqztWJGfsfcAY6YC1CU9Lh8dKK1iTnAPlk3l7khJmevsBsqYrCZCvVDyWKKvCS0FmXwPeGlIaeVbE/ZooGhDJ6Q=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr13596078ual.95.1553764063904;
 Thu, 28 Mar 2019 02:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <1553574418-21033-1-git-send-email-yamada.masahiro@socionext.com> <20190327192021.5d676019@donnerap.cambridge.arm.com>
In-Reply-To: <20190327192021.5d676019@donnerap.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Mar 2019 18:07:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQp2=EBU1ejZ8CDoo6Qbkii+ide+1V=Up26uTKyUwdWCA@mail.gmail.com>
Message-ID: <CAK7LNAQp2=EBU1ejZ8CDoo6Qbkii+ide+1V=Up26uTKyUwdWCA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: do not overwrite .gitignore in output directory
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:20 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 26 Mar 2019 13:26:58 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> Masahiro,
>
> > Commit 3a51ff344204 ("kbuild: gitignore output directory") seemed to
> > bother people who version-control output directories.
>
> Thanks a lot for the patch, that works for me.
>
> > Andre Przywara says:
> > "Unfortunately this breaks my setup, because I keep a totally separate
> > git repository in my build directories to track (various versions of)
> > .config. So .gitignore there is carefully crafted to ignore most build
> > artefacts, but not .config, for instance."
> >
> > Link: https://lkml.org/lkml/2019/3/22/1819
> > Reported-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>


Applied to linux-kbuild/fixes.



> Cheers,
> Andre.
>
> > ---
> >
> >  Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 5fe5431..70fc778 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -499,7 +499,8 @@ outputmakefile:
> >  ifneq ($(KBUILD_SRC),)
> >       $(Q)ln -fsn $(srctree) source
> >       $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
> > -     $(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> > +     $(Q)test -e .gitignore || \
> > +     { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> >  endif
> >
> >  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>


-- 
Best Regards
Masahiro Yamada
