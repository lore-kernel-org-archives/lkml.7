Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3BC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050D220674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y1RxwfWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDLBxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:53:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:34269 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLBxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:53:08 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3C1qvgj006549;
        Fri, 12 Apr 2019 10:52:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3C1qvgj006549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555033979;
        bh=YW//+yHX89A+r7yyY4s1ei3ztZPoCqp2cO7RWcnpiRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y1RxwfWA6I3PwD6Ik3F1fZKyk93rnmW4/YKL/bGNeqDrk6WQl+nEy8/H1TriWXYNX
         l//GHoNWn8DkFsBWgTOtXsnhzld5UaAe0tXUWcfj9qvnXXWQeV8IYTALkLCOyskvAY
         RgZSvh7gP1rH2h4UmieKWC5noUKOX/psHJ5dhk7oOF2C7JZIv6YcLbJeCHt4X6VRUg
         //voQSYp7+TRtY1Ic4h/er9lvxdv+Lgccv5ywfjhdPDytMxDr+otG01eRrl+Lwf2sb
         Z/PsQhSz87pj+zbJLp/DxnXoD+7pEAd7nyUYUjBjkyBmhPtFBuMi0milSK/jg9kAYk
         KPyLhU3hc5D6Q==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id l17so2726226uar.4;
        Thu, 11 Apr 2019 18:52:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUTpizHrFykiiymWfY8uDt3VETF2SR60nDF77EpW+qox8HEDcRf
        VZtUsULfTXfKeRdYHjHdTF774nx7mSkMoi/mFvM=
X-Google-Smtp-Source: APXvYqyb7WzcxVpL3dTP1QDJgNk9U1ElDCec2HI4RAL6+duptWrz+8bpxDwjkpBbXJfeTnUVi+GZRWJH6wib6XP8VB4=
X-Received: by 2002:ab0:348a:: with SMTP id c10mr23454449uar.79.1555033977268;
 Thu, 11 Apr 2019 18:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
 <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com>
 <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com> <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
 <CAOiHx=nnz33DQhZO5o7vK2GBDcFO58D9_y7OgEodcUk4ZYs+KA@mail.gmail.com>
In-Reply-To: <CAOiHx=nnz33DQhZO5o7vK2GBDcFO58D9_y7OgEodcUk4ZYs+KA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Apr 2019 10:52:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmLSONRiEw1OAWwUrFKB_aSTT3-Z1q=f2FCyDJHc=xMQ@mail.gmail.com>
Message-ID: <CAK7LNARmLSONRiEw1OAWwUrFKB_aSTT3-Z1q=f2FCyDJHc=xMQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 7:31 PM Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> Hi,
>
> =E6=9C=AC=E5=BD=93=E3=81=AB=E7=94=B3=E3=81=97=E8=A8=B3=E3=81=82=E3=82=8A=
=E3=81=BE=E3=81=9B=E3=82=93, I got sidetracked and completely forgot about =
it. I
> actually still have my old tree with the suggested changes for v2.
>
> On Tue, 9 Apr 2019 at 11:01, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi.
> >
> > On Mon, Apr 8, 2019 at 5:03 PM Wiebe, Wladislav (Nokia - DE/Ulm)
> > <wladislav.wiebe@nokia.com> wrote:
> > >
> > > Hi!
> > >
> > > On 07.04.2019 11:04, Masahiro Yamada wrote:
> > > > (+CC Jonas Gorski)
> > > >
> > > >
> > > > On Tue, Mar 26, 2019 at 6:58 PM Wiebe, Wladislav (Nokia - DE/Ulm)
> > > > <wladislav.wiebe@nokia.com> wrote:
> > > >>
> > > >> Commit ea837f1c0503 ("kbuild: make modpost processing configurable=
")
> > > >> was intended to give KBUILD_MODPOST_WARN flexibility to be configu=
rable.
> > > >> Right now KBUILD_MODPOST_WARN gets just ignored when KBUILD_EXTMOD=
 is
> > > >> set which happens per default when building modules out of the tre=
e.
> > > >>
> > > >> This change gives the opportunity to define module build behaving =
also
> > > >> in case of out of tree builds and default will become exit on erro=
r.
> > > >> Errors which can be detected by the build should be trapped out of=
 the box
> > > >> there, unless somebody wants to notice broken stuff later at runti=
me.
> > > >
> > > > If an external module refers to a symbol
> > > > provided by another external module,
> > > > this patch will turn the warning into the error by default,
> > > > which is probably a bad idea.
> > >
> > > Indeed, exactly this should happen. You should fix your external modu=
le
> > > dependencies by providing their symbols. Please use e.g.
> > > KBUILD_EXTRA_SYMBOLS instead of converting errors to warning and hopi=
ng
> > > that things will work.
> >
> > I know this option.
> > What I want to say is, this patch changes the behavior, and
> > may annoy some people.
> >
> > > Or how do you want to make sure module A still
> > > delivers all symbols needed by module B after an update/changes?
> > > Manually comparing the logs after an update or waiting until it turns
> > > out broken during run-time? I wouldn't say this is a good idea :-)
> >
> > OK, so the commit log should record both the behavior change
> > and workarounds.
> >
> > - If an external module being built refers to symbols
> >   in another external module, Kbuild previously showed a warning,
> >   but going forward it will turn it into an error.
> >
> > - To work around this, you should pass a symbol table via KBUILD_EXTRA_=
SYMBOLS,
> >   or KBUILD_EXTRA_SYMBOLS=3D1 to turn the error into a warning.
>
> This sounds like a good middle ground. When you do the effort of
> setting KBUILD_EXTRA_SYMBOLS, you are likely interested in proper
> dependency resolution and being notified if it fails.
>
> I would probably still use KBUILD_MODPOST_WARN=3D0 to force the warnings
> as errors, to have it as the central switch for the behaviour. So the
> behaviour would then become
>
> - If KBUILD_MODPOST_WARN is set to any value, set -w accordingly
> - else, set -w only when building for an external module and
> KBUILD_EXTRA_SYMBOLS is empty
>
> or
>
> ifdef KBUILD_MODPOST_WARN
>     KBUILD_MODPOST_WARN:=3D$(filter-out 0,$(KBUILD_MODPOST_WARN))
> else
>     KBUILD_MODPOST_WARN:=3D$(if $(KBUILD_EXTMOD),$(if $(KBUILD_EXTRA_SYMB=
OLS),,1))
> endif


Sorry, I think this is too complicated.

I applied this since it is simple.
https://patchwork.kernel.org/patch/10895465/



--=20
Best Regards
Masahiro Yamada
