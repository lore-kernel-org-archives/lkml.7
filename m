Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BC7218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XV2khi1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfCOPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:37:21 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38934 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCOPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:37:21 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2FFbAtr007656;
        Sat, 16 Mar 2019 00:37:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2FFbAtr007656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552664231;
        bh=ZEdTjakqCNd+HP+/dg7Be1HlMUf8Kb9Q/I6kUMSKaP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XV2khi1rNySEWVIKFkRMLpa0wBrGHicXMTxN2iuu4VGKUb9U588EbKKCwXtzxI9Jm
         ejyTWSZAISvyU1M486iEQGIt01ccM/YUyc4yo1w6LtOigzyAk/5ASq5Noc7cOO/1by
         ZY7Hl0IoURzbfnFHUZaoXj7PHznYTuyL3LNoEQ9SunehlYyPwkhmaVK4NltjWcmcmO
         awTg19zhpyqj3OKfIwg8gQGz9n3gPOK6gG9r/wm3W/DJ0CchlsE8gEZW7ZNdfO6Y1x
         3FbE7NfOzUUJV3e5NZjBbUSiqnZZnf+P1N8LQYOk62kkaSioxBEEPB9CZ/OVk0Vq4K
         3uMPBN2UWiP/g==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id u6so5626454vso.10;
        Fri, 15 Mar 2019 08:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUZUpWBaMr3tFufW4w7+VuxNAVj5NTRxfdxTZshqLRVh2rh8boP
        gngyxWvQQsDhvIJDL1d+SNSDeR11fq4KRJMMib4=
X-Google-Smtp-Source: APXvYqxSHur7Sczx4rlueSC/GeAHMzGRMvFOTS13mIifVAIp+KDLCQY7fcUm8BV8bYQwC34LGDtz76jrzhMHTtb17nM=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr2295343vso.179.1552664230043;
 Fri, 15 Mar 2019 08:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190314234159.191745-1-dianders@chromium.org> <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
In-Reply-To: <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Mar 2019 00:36:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com>
Message-ID: <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 12:27 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Fri, Mar 15, 2019 at 8:42 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > During a simple no-op (nothing changed) build I saw 39 invocations of
> > the C compiler with the argument "-print-file-name=include".  We don't
> > need to call the C compiler 39 times for this--one time will suffice.
> >
> > Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
> > this since there doesn't appear to be any reason it should be
> > recursively expanded.
> >
> > On my build this shaved ~400 ms off my "no-op" build.
> >
> > Note that the recursive expansion seems to date back to the (really
> > old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
> > It's a little unclear to me if the point of that patch was to switch
> > the variable to be recursively expanded (which it did) or to avoid
> > directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
> > someone else (out of tree?) was setting it.  I presume later since if
> > the only goal was to switch to recursive expansion the patch would
> > have just removed the ":".
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Applied to linux-kbuild.
> Thanks.


BTW, I noticed no one else
appends NOSTDINC_FLAGS.


So, does it make more sense to do as follows?


NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)






>
>
> > ---
> >
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 9ef547fc7ffe..3034ba66ad51 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -402,7 +402,7 @@ CHECK               = sparse
> >
> >  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> >                   -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
> > -NOSTDINC_FLAGS  =
> > +NOSTDINC_FLAGS :=
> >  CFLAGS_MODULE   =
> >  AFLAGS_MODULE   =
> >  LDFLAGS_MODULE  =
> > --
> > 2.21.0.360.g471c308f928-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
