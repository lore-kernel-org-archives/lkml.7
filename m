Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E64C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268EC218A0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KkEIBUsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfGVMkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:40:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42843 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfGVMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:40:54 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so43162728iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrE6s2h20GCl+rLX0hg+6OeuG0aEM8ydNp/hg7tCFuU=;
        b=KkEIBUsPQH9wQ3swuClHuM7GN0XhmTsJ5NmOoIdXj37+HXj9DPqouBjxZAs3qktNin
         BeYncFw8NiHDxYlexrkt6n2N/8L2XP1+0KrslG1nPRPQ1EneTud1CdzhD6lWTC+9pBXc
         L3N5b0L36v0oB0M56PH1Ikjb9ODvVrCWq+yd0UwWoecfV9o9GF18TT5WkM30tQ3QuWKu
         qg0zwWskSNg5zOHBC0WCu6faskHePoPIt3DA0a7aP8qgH/swZiruJooFG3PlSBL4a/DF
         LV/NFKcqWjVs7DSRF/r4YHbqM2PyipHp8gUvMaOOLaR5+rdelIPjT0XnqCKTNjFWIGWS
         rxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrE6s2h20GCl+rLX0hg+6OeuG0aEM8ydNp/hg7tCFuU=;
        b=f9WYRXilqGKw/mNIVhiVXxR/1mKNc4x3hbqZSvcR1Tjtc1fIV9bRXVxzkshoaCK7Db
         hw8FvjWZb/4lummqYXRHpA6caGrXtnieVuPkZYW48Tey+OHiQ9XAnimGVxDmScS8BE2u
         LuasZE1wCMgFq0Q3XXEONLUgNdj9b4K1VEovO8lfIEk96LJegh44uEAWitPJ80Cu9NYN
         yW+pIFB1LQV9frocT6Jjy1blytx+BoJm4v9ERVi3cClVrvrojF1QDweenpc8My7stg45
         Bc2B4FQ+fnPB/hDoqMKfR/y3x/i4CMB3juPAg9y/dqK5bwMbQ/CmN3RmudT5tkLqh2it
         d+cg==
X-Gm-Message-State: APjAAAU+9JhmVvZJh56QA0JlecZ7p73O1MDg91W/dGgKXU//kBacsqJD
        MriDeg4PkubgpXcFYhEclizFzXYBBCNEHOWD6ecXlQ==
X-Google-Smtp-Source: APXvYqy32EUfLcRGX9TBzkZWay6adgQ/5A3/tB0Lu9tMw5ICtPZDMLKTLajAslBevAyXeS7OCenm//y3SOV2Ym/cQVU=
X-Received: by 2002:a5e:a712:: with SMTP id b18mr63545556iod.220.1563799254007;
 Mon, 22 Jul 2019 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190711082936.8706-1-brgl@bgdev.pl> <20190711082936.8706-2-brgl@bgdev.pl>
 <CAMuHMdUp3YMMzhYRBnHFDrf3w7GDK8HY5aAXdjVZ_oMd_n6xdQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUp3YMMzhYRBnHFDrf3w7GDK8HY5aAXdjVZ_oMd_n6xdQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 22 Jul 2019 14:40:42 +0200
Message-ID: <CAMRc=McbADdFSkkm1smJmki+wmz2GFah+vv86ECWeHFHCCNHRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: em: use a helper variable for &pdev->dev
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 11 lip 2019 o 10:48 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
>
> On Thu, Jul 11, 2019 at 10:29 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Instead of always dereferencing &pdev->dev, just assign a helper local
> > variable of type struct device * and use it where applicable.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Applied for next.
