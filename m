Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E065B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfH0IBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:01:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34014 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfH0IB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:01:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so30181854edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aj/M9A/pRvOgZCbXpj3T4Q2/WP9XPh0HT/hjIq8gM3E=;
        b=QSDGwyxNHHUYOjpW6sbfhQoUe3eUaSrbKrGRtAJ7OwOrcTm3muArxhLX4Ikes9k9XC
         RVdXmPtXUC5AvFn7J3keNKOvWnYx8tnJGZb0QFR0RF2//8/43k18+H8npeVUEL2+wKWC
         hsyJGwYM3BdXYq7LlAd3PdUzHLGF3e1BEhQa9gBvAJmSbd2Fk2I3x+4GKOIoKZMVEQ6o
         nbRTGjD5eMw0xWd8jr81ujsOyYxIrpL0YkD43pmjA3nthrY94l157bthg/gtmGto/j+W
         wKcqksSyRLTv1A5Fv6dgLpnd2lxRAFvxOj0OJTMMBLD9UCEEVCT05VX4P6x5B5ZC3pso
         FWpQ==
X-Gm-Message-State: APjAAAXGjqgYQnPbRCJ+kFhmbIIGS/QQ4QNE+FdM5uZ+V0OrRvCfJIl4
        PTY5YOtaXBUWC2iVNbu4vrXiGfCepL0=
X-Google-Smtp-Source: APXvYqz6mo9OGn3SqY+n6Xm8Kw1IOxcRf00+S41QLxhpkGkSUI9+kiYfabBDqwxDK8roWWud1ayKFQ==
X-Received: by 2002:a17:906:185b:: with SMTP id w27mr13771081eje.203.1566892884629;
        Tue, 27 Aug 2019 01:01:24 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id f6sm1798675edn.63.2019.08.27.01.01.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:01:24 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id c3so17764149wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:01:23 -0700 (PDT)
X-Received: by 2002:adf:e941:: with SMTP id m1mr2132834wrn.279.1566892883607;
 Tue, 27 Aug 2019 01:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-2-codekipper@gmail.com>
 <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com> <CAEKpxBmCg4AkqKM-O3C76gto+mPWyEdDbviAmRJ8PxLOOMTJ7w@mail.gmail.com>
In-Reply-To: <CAEKpxBmCg4AkqKM-O3C76gto+mPWyEdDbviAmRJ8PxLOOMTJ7w@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 16:01:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VNZ0oyD_760uNccwJb7MKngSooWB72M+d1DfT4-djog@mail.gmail.com>
Message-ID: <CAGb2v64VNZ0oyD_760uNccwJb7MKngSooWB72M+d1DfT4-djog@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap
 for A83T
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:55 PM Code Kipper <codekipper@gmail.com> wrote:
>
> On Tue, 27 Aug 2019 at 06:13, Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Aug 27, 2019 at 2:07 AM <codekipper@gmail.com> wrote:
> > >
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > The regmap configuration is set up for the legacy block on the
> > > A83T whereas it uses the new block with a larger register map.
> >
> > Looking at the code Allwinner previously released [1], that doesn't seem to be
> > the case. Keep in mind that the register map shown in the user manual is for
> > the TDM interface, which we don't actually support right now.
>
> Should it matter what we support right now?, the block according to the user
> manual shows the bigger range. I don't have a A83T device and from what I

There are a total of four I2S controllers on the A83T. Currently three of them
are listed in the dtsi file, which are _not_ the one shown in the user manual.
The one shown is the fourth one, which is the TDM controller.

It's not like we haven't seen this before. IIRC the A64 also had two variants
of the I2S interface. The one coupled with the audio codec was different from
the others.

> gather not many users do. But the compatible for the H3 has been removed
> and replaced with the settings for the A83T which also has default settings in
> registers further up than SUNXI_RXCHMAP.

I'll sync up with Maxime on this.

> >
> > The file shows the base address as 0x01c22800, and the last defined register
> > is SUNXI_RXCHMAP at 0x3c.
> >
> > The I2S driver [2] also shows that it is the old register map size, but with
> > TX_FIFO and INT_STA swapped around. This might mean that it would need a
> > separate regmap_config, as the read/write callbacks need to be changed to
> > fit the swapped registers.
> >
> > Finally, the TDM driver [3], which matches the TDM section in the manual, shows
> > a larger register map.
> >
> > A83T is SUN8IW6, while SUN8IW7 refers to the H3.
>
> Since when have we trusted Allwinner code?, the TDM labelled block
> clearly supports

Since they haven't listed the I2S block in the user manual, so that is what we
have to go by.

The TDM section in the user manual only lists the block at 0x1c23000. The memory
map says DAUDIO-[012] for addresses 0x1c22000, 0x1c22400, 0x1c22800, and TDM for
address 0x1c23000. One would assume this meant these are somewhat different.

> I2S. The biggest use case for this block is getting HDMI audio working
> on the newer

I understand that.

> devices(LibreELEC nightlies has a user base of over 300) and I've tested this on
> numerous set ups over the last couple of years.

Tested on the H3, correct?

> Failing that reverting (3e9acd7ac693: "ASoC: sun4i-i2s: Remove
> duplicated quirks structure")
> would help.

I'll take a look. IIRC it worked with the old layout, with the two registers
swapped, playing standard 48 KHz / 16 bit audio when I added supported for
the A83T. Then again maybe the stars were perfectly aligned. At the very least
we could separate A83T and H3 as you suggested.

ChenYu


> BR,
> CK
> >
> > ChenYu
> >
> > [1] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.h
> > [2] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/i2s0/sunxi-i2s0.h
> > [3] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/daudio0/sunxi-daudio0.h
> >
> > > Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > ---
> > >  sound/soc/sunxi/sun4i-i2s.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > index 57bf2a33753e..34575a8aa9f6 100644
> > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > @@ -1100,7 +1100,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
> > >  static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
> > >         .has_reset              = true,
> > >         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> > > -       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> > > +       .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
> > >         .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> > >         .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
> > >         .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> > > --
> > > 2.23.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190826180734.15801-2-codekipper%40gmail.com.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CAEKpxBmCg4AkqKM-O3C76gto%2BmPWyEdDbviAmRJ8PxLOOMTJ7w%40mail.gmail.com.
