Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD72C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uZTWWqFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDIJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:01:17 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:54727 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDIJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:01:16 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3991932009527;
        Tue, 9 Apr 2019 18:01:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3991932009527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554800470;
        bh=uV840hlMmCm9z7nqOQ6xn6UBInSMmOukyeFySz6vLlc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uZTWWqFdTmu1yYi3/dUDNM+ZXcSHLpnjPZ15sU1kf6Yfbxwqn9cbH+Ga6IOsleG6K
         CTttg/Tp4romPKCnyiCrBXhuLwg/nUiJVAUtIi8zoLWdiYNqW9q9ipSpimHGhI9yHs
         XvhLstBQOGbp0VMNNk1tnTMr9XnCgFU9mie0FMcjE2B4q6pkUHYOo+8vL1RZgfktus
         tYtfsTnZHnxi9TPuuJrSf6cqajFbQEXCq18OIk9AS419kXOGYV8uV7YeZEcU4IYHMk
         iHh2XeaTfrjSjqKg3HrnBASdeGGXHMS0qFE+LOLwGSvdnVNrlEGeWMaCrGbDm5xctY
         yR8zmZzm3C5pw==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id s63so3686323vkg.10;
        Tue, 09 Apr 2019 02:01:10 -0700 (PDT)
X-Gm-Message-State: APjAAAWooRMJDJX2WpMelr/QrQpdikiHyfNJQF8vtKc4xJRfRREEskbo
        UvnTZf/Qa+v6AHfZprhv+dcUMSHfTl3XNroi+9w=
X-Google-Smtp-Source: APXvYqxNf08kDvt754MCkZ8RAVezpwHBYMBnh0vaK9NLS6srTTHKRWjHdx2n5KxnB35Sl7yN1K15Xlu9dwO0dMLeY4E=
X-Received: by 2002:a1f:1594:: with SMTP id 142mr18714478vkv.42.1554800469250;
 Tue, 09 Apr 2019 02:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0701MB2652FC3F5D8E46EA93AF033AFA5F0@HE1PR0701MB2652.eurprd07.prod.outlook.com>
 <CAK7LNAQEQyEyj_ozkARj8xjDf7EncHeBv0GY8xoP8e_Fn-qaag@mail.gmail.com> <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com>
In-Reply-To: <77e11884-f520-d983-3d33-ccc3043ba604@nokia.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Apr 2019 18:00:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
Message-ID: <CAK7LNAR_Py_4_pPEcxd7_ZpicoD6rnjb-iyq=_h893m=7q7kug@mail.gmail.com>
Subject: Re: [PATCH] modpost: make KBUILD_MODPOST_WARN also configurable for
 external modules
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Apr 8, 2019 at 5:03 PM Wiebe, Wladislav (Nokia - DE/Ulm)
<wladislav.wiebe@nokia.com> wrote:
>
> Hi!
>
> On 07.04.2019 11:04, Masahiro Yamada wrote:
> > (+CC Jonas Gorski)
> >
> >
> > On Tue, Mar 26, 2019 at 6:58 PM Wiebe, Wladislav (Nokia - DE/Ulm)
> > <wladislav.wiebe@nokia.com> wrote:
> >>
> >> Commit ea837f1c0503 ("kbuild: make modpost processing configurable")
> >> was intended to give KBUILD_MODPOST_WARN flexibility to be configurable.
> >> Right now KBUILD_MODPOST_WARN gets just ignored when KBUILD_EXTMOD is
> >> set which happens per default when building modules out of the tree.
> >>
> >> This change gives the opportunity to define module build behaving also
> >> in case of out of tree builds and default will become exit on error.
> >> Errors which can be detected by the build should be trapped out of the box
> >> there, unless somebody wants to notice broken stuff later at runtime.
> >
> > If an external module refers to a symbol
> > provided by another external module,
> > this patch will turn the warning into the error by default,
> > which is probably a bad idea.
>
> Indeed, exactly this should happen. You should fix your external module
> dependencies by providing their symbols. Please use e.g.
> KBUILD_EXTRA_SYMBOLS instead of converting errors to warning and hoping
> that things will work.

I know this option.
What I want to say is, this patch changes the behavior, and
may annoy some people.

> Or how do you want to make sure module A still
> delivers all symbols needed by module B after an update/changes?
> Manually comparing the logs after an update or waiting until it turns
> out broken during run-time? I wouldn't say this is a good idea :-)

OK, so the commit log should record both the behavior change
and workarounds.

- If an external module being built refers to symbols
  in another external module, Kbuild previously showed a warning,
  but going forward it will turn it into an error.

- To work around this, you should pass a symbol table via KBUILD_EXTRA_SYMBOLS,
  or KBUILD_EXTRA_SYMBOLS=1 to turn the error into a warning.


Thanks.

>
> > I suggested a desired change in the following.
> > https://patchwork.kernel.org/patch/9980691/
> >
> > I am poking Jonas Gorski
> > if he plans to send v2.
>
> I wouldn't vote for v2 based on explanation above.
>
> - Wladislav
>
> >
> >
> >> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> >> ---
> >>   scripts/Makefile.modpost | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> >> index 6b7f354f189a..fec6ec2ffa47 100644
> >> --- a/scripts/Makefile.modpost
> >> +++ b/scripts/Makefile.modpost
> >> @@ -78,7 +78,7 @@ modpost = scripts/mod/modpost                    \
> >>    $(if $(KBUILD_EXTRA_SYMBOLS), $(patsubst %, -e %,$(KBUILD_EXTRA_SYMBOLS))) \
> >>    $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
> >>    $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
> >> - $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
> >> + $(if $(KBUILD_MODPOST_WARN),-w)
> >>
> >>   MODPOST_OPT=$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
> >>
> >> --
> >> 2.19.2
> >
> >
> >


--
Best Regards
Masahiro Yamada
