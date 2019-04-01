Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7FF21924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hjJxvs/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfDARNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33998 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbfDARNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so7949218oib.1;
        Mon, 01 Apr 2019 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9KG8YRsGRGrU2T58TvsypKkYeTkXfM4zE288zWPThs=;
        b=hjJxvs/wvcrWjAdsN1P7VS9K5C7ulw6tB4fUYHEB0wh86hBXHPJRCWMM/Fc+HU8UMk
         ZQA1Ikqz62U3StGyhS1Dy0+Ns9dFhslkMTP8w5Eexx51ofACfr+24qnloQu31bEbpZSI
         LYSqXgyijvJ7SltzHhLyF6CctlYgTtuZlTTQAYzEhfuzjmgaSAboYcLCmtusx2EZyP8L
         QzNz3lS99Jx3AZeEnTyYoFUKdFfsRI9CbEywAvr058lkeb1KpIbhs23OPnalvYtvUZs0
         S8xkA0fj6oBgps0jJOv9ZMiVLmjkBkTB52yP7J3wAK5wcWeWDbfPL6ivmIj+oeyTriCA
         86xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9KG8YRsGRGrU2T58TvsypKkYeTkXfM4zE288zWPThs=;
        b=L64p3kiuyB8WO9j2sebpQ2qeWcGzSd6YJPL7BchwUeYLpqxeEN86ZHa7GQ9IJk8dre
         Nq3b46Cb26J3QI8e6bzSkuHoHGJJj8+dW2g8zoJV62OurVCQQycPpyfmcNi5+SoOKAzJ
         bTtJbAWajC+C9lVFkaz8LX7wm4Ff2D7qgMa4Ii4JCQabvtr2T5PPYJ+EJrbCnND62/7p
         HyUphMmFRparYNryiXd8Nz//pt65ktkAgtqIoyDq/Qp4RGguj3OQWNrGiCIgsq4NLWOv
         tqa/QVEFY102O4Gcut/N4yFO5JXtSQmYc+5qn2hUPIPjx/Qm8M+ADz0Auh7yBciaUR+X
         gu5w==
X-Gm-Message-State: APjAAAVooOW9ShGwiE4pMmguYCA1ppkuLIOcgpniSL318tOodr/6Ur5m
        2y5YrGZ9s+KMYCD/TTztaXlALwB9REq3vpvWO4fbULE4
X-Google-Smtp-Source: APXvYqz0Zo1b/yxQsg5oeaOOOvDi5tYiySBQK96I/pncHVnMsjHJOyvO9dsGUWWxO661wefLruYAoSQe0CrODg+n2D4=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr13875749oif.140.1554138817395;
 Mon, 01 Apr 2019 10:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190329153325.23869-1-jbrunet@baylibre.com> <20190329153325.23869-2-jbrunet@baylibre.com>
 <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com>
 <3bef1bb26e9eff0cfc20cd4bb78a5d7cea4c5076.camel@baylibre.com>
 <CAFBinCCUrKGPWpTu_u3okaHVfMY4CN5F5qaRcKdTRbg35xrMEQ@mail.gmail.com> <63fc525faf2d82cb2436a17ab2206293aeef6c31.camel@baylibre.com>
In-Reply-To: <63fc525faf2d82cb2436a17ab2206293aeef6c31.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 Apr 2019 19:13:26 +0200
Message-ID: <CAFBinCB7iqg17-YM4R_X0UidxzAi7xH-jAKC05NnWw1zRaQm3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: meson: mpll: properly handle spread spectrum
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Apr 1, 2019 at 10:40 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat, 2019-03-30 at 16:56 +0100, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Sat, Mar 30, 2019 at 12:07 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > On Fri, 2019-03-29 at 20:39 +0100, Martin Blumenstingl wrote:
> > > > Hi Jerome,
> > > >
> > > > On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> > > > > fractional part of the divider but to the function called
> > > > > 'Spread Spectrum'.
> > > > >
> > > > > This function might be used to solve EM issues by adding a jitter on
> > > > > clock signal. This widens the signal spectrum and weakens the peaks in it.
> > > > >
> > > > > While spread spectrum might be useful for some application, it is
> > > > > problematic for others, such as audio.
> > > > >
> > > > > This patch introduce a new flag to the MPLL driver to enable (or not) the
> > > > > spread spectrum function.
> > > > >
> > > > > Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > ---
> > > > >  drivers/clk/meson/clk-mpll.c | 9 ++++++---
> > > > >  drivers/clk/meson/clk-mpll.h | 1 +
> > > > >  2 files changed, 7 insertions(+), 3 deletions(-)
> > > > >
>
> [...]
>
> > >
> > > Yes, none of our application require spread spectrum
> > thank you for the explanation. can you please add it to the patch description?
>
> I think I described spread spectrum already in the commit description.
I haven't been clear about this one -  let me do it better this time:
if you have to re-send the patches can you please add a note stating
that "none of our application require spread spectrum" to the
description so it's clear that you're disabling spread spectrum on
purpose.
your explanation about spread spectrum itself is perfectly fine


Regards
Martin
