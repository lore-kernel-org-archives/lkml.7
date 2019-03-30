Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA14C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EF92085A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BEY94n0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfC3P42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:56:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44336 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfC3P41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:56:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so3995872oib.11;
        Sat, 30 Mar 2019 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIydhpwZ/UxjYyTDP3PPEf0zfkdewWJwPqFZ/v/79lA=;
        b=BEY94n0eoFn1s+cHq5KP44we+NvzUlYvf9YH2cwq7yCYZlfC7UsCjqPrFwYvTkZEg2
         wxCswlaBcvqP9upZCdJnw2QulLzMOz9fy8+bQ4VaaGksn+4RZh39Nsf7/R3Ejpd3t2bz
         ZYJzSeYHapmH2ajrSd08WPYUXnFOZgzYcH0yeOfPReOPeQYT4rOpoWuzU60Zp8EHiJsP
         PT2U5i5Q5n0xvnQGPG0PCSJ8Nv1y7fUZyamcVceybXYfXtna7QHY0lJDswUapjhDBjKp
         esaWK7ouS2XoUWz82DL+goFr/i4XW0lUAy13yjuC2m4eq6RQN9DDNUcvZUU9ZY0zqD3O
         LKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIydhpwZ/UxjYyTDP3PPEf0zfkdewWJwPqFZ/v/79lA=;
        b=Us2BBnG44tP80SC5KEj8fssnPtdR5ASoIkzm6ZwKhmzGDPDcuWPMV24nmifnERAeQj
         7UM18lzMjfe1Dc/dsrBmxiX4C95Np3b8Z8VgHVmF+50M4Y+Ib07PU2itflgbF+b9s5Cx
         JCIiukSklfILyTnp0MkXYvRml46i0bciQgU9nnwG+GPlL9/Z7G6PZQVVYr8b/+63g36R
         QzYkCcbySZ1q18n/VElfJ74vK1fMQfWOWtoqgf2ZN0KDwg6P+slMyX/c/65pda3W1FYu
         lAC3Iz8lQDtF0JNwc0QzZxwb7l6j2lPgl4pWaMG/V8qRgzibXl7zOWC8wnBHvLvPQX0m
         eRYw==
X-Gm-Message-State: APjAAAXLcSY83j3vMOxKqai9sQxAkOuygHMoy37PtumOQF+6wz7LJ+Jo
        CiZSAT9kS4/5D7HBxDe8SZ9qk9Vk7UehFOz7jF02h8ZF
X-Google-Smtp-Source: APXvYqxLqmpxQyGLcoU4UOsKryx+jqssxxRw/EXko62N3CYmm9Ddn8CYYD8JgdOKLhfmNRj7IzX3TWlsju4eYcm25KY=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr7504730oif.140.1553961386667;
 Sat, 30 Mar 2019 08:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190329153325.23869-1-jbrunet@baylibre.com> <20190329153325.23869-2-jbrunet@baylibre.com>
 <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com> <3bef1bb26e9eff0cfc20cd4bb78a5d7cea4c5076.camel@baylibre.com>
In-Reply-To: <3bef1bb26e9eff0cfc20cd4bb78a5d7cea4c5076.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 30 Mar 2019 16:56:15 +0100
Message-ID: <CAFBinCCUrKGPWpTu_u3okaHVfMY4CN5F5qaRcKdTRbg35xrMEQ@mail.gmail.com>
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

On Sat, Mar 30, 2019 at 12:07 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Fri, 2019-03-29 at 20:39 +0100, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> > > fractional part of the divider but to the function called
> > > 'Spread Spectrum'.
> > >
> > > This function might be used to solve EM issues by adding a jitter on
> > > clock signal. This widens the signal spectrum and weakens the peaks in it.
> > >
> > > While spread spectrum might be useful for some application, it is
> > > problematic for others, such as audio.
> > >
> > > This patch introduce a new flag to the MPLL driver to enable (or not) the
> > > spread spectrum function.
> > >
> > > Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > >  drivers/clk/meson/clk-mpll.c | 9 ++++++---
> > >  drivers/clk/meson/clk-mpll.h | 1 +
> > >  2 files changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> > > index 64d31c8ba3d0..2d39a8bc367c 100644
> > > --- a/drivers/clk/meson/clk-mpll.c
> > > +++ b/drivers/clk/meson/clk-mpll.c
> > > @@ -141,9 +141,12 @@ static void mpll_init(struct clk_hw *hw)
> > >         /* Enable the fractional part */
> > >         meson_parm_write(clk->map, &mpll->sdm_en, 1);
> > >
> > > -       /* Set additional fractional part enable if required */
> > > -       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> > > -               meson_parm_write(clk->map, &mpll->ssen, 1);
> > > +       /* Set spread spectrum if possible */
> > > +       if (MESON_PARM_APPLICABLE(&mpll->ssen)) {
> > > +               unsigned int ss =
> > > +                       mpll->flags & CLK_MESON_MPLL_SPREAD_SPECTRUM ? 1 : 0;
> > > +               meson_parm_write(clk->map, &mpll->ssen, ss);
> > > +       }
> > this changes the "ssen" flag on all supported clocks from 1 (before
> > this patch) to 0 (after this patch).
> > is this on purpose and how does it affect existing clocks?
>
> Yes, none of our application require spread spectrum
thank you for the explanation. can you please add it to the patch description?

> The fact is that only 2 MPLL had this bit, mpll0 on gx (without effect) and
> mpll0 on axg: actually spread spectrum impacts mpll2, making it unusable, as
> explained in the related patch
>
> >
> > based on the original commit 1f737ffa13ef ("clk: meson: mpll: fix
> > mpll0 fractional part ignored") it seems that
> > CLK_MESON_MPLL_SPREAD_SPECTRUM should be set for mpll0 (at least on
> > GXBB and Meson8b)
> >
>
> There a patch specifically targeting gxbb.
I missed that, sorry for the noise

> I have checked on GXL and this bit had no effect (fractional part still on, no
> spread spectrum)
>
> So either we fixed something since then or I messed up when doing the patch
> initially.
>
> Feel free to cross check
I tried it on Meson8b and it seems that there's no difference. I've
done a bit of software archaeology:
$ grep -R mpll_cntl uboot-2015-01-15-23a3562521/ | grep "=" | head -n3
uboot-2015-01-15-23a3562521/board/amlogic/m8_k100_1G/firmware/timming.c:
       .mpll_cntl = 0x600009A9,        //2.5G, fixed
uboot-2015-01-15-23a3562521/board/amlogic/m8_k100_2G/firmware/timming.c:
       .mpll_cntl = 0x600009A9,        //2.5G, fixed
uboot-2015-01-15-23a3562521/board/amlogic/m8b_ft_v1/firmware/timming.c:
.mpll_cntl = 0x600009A9,        //2.5G, fixed

Ethernet is still working on my Odroid-C1, so you can add my:
Tested-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>


Regards
Martin
