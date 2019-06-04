Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EAA243BD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb7rXrst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfFDJi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:38:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39375 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfFDJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:38:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so15773688ljf.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0p+QUllSWbb6IfUF0ciw23eu7sV22MgW/puri+CeCb8=;
        b=hb7rXrstdGiY0ZZmC64PPrQM9dGTY90IFqakAW521v6oSsVaMiEpNOt0P7/j+7n3UX
         O+nDNuDF0FYbZGt99SJEUsSmdIoJ2Kk2NrLkTioEmtnpJEOh4Po1rvl01QWxxrSrRxdR
         XFFYxf0/ZMZn3n6HFDTMfZo4MvruNCPuvTHveQ7j/XHxJHJKtpdQSD04RDwB00gPez+3
         s5wY1nShIzKhSm8UM3RDNcSH3hRzxCfYu6QLMFOYF9dNzosrIJhpto3Ja3/hjf3s8N2u
         ZZnBsuzUvjBdDBI/9pU8zPJZMwexgGG5bQZUll9aCD8xW9vvtNz3zRqkxhuwXAEzZMe4
         NhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0p+QUllSWbb6IfUF0ciw23eu7sV22MgW/puri+CeCb8=;
        b=fHA8OJ1lBSVZIY9VcLAy9yAnPKdT02QImOQMjVy0FL9ghsE3IUMZw1W0xVjCKa74/q
         rIbPssCWWx75/UKSHMa1rcQo+7R7oksFjQ/6ZT4U5kd3cJzi0eBgKSwqakp01A61Onr1
         w3Ec4oHJF7+uxulbt0ne/0uuf27y1tZp+iq15nc5JqsGNkNVT+UexblaVG+OHApjyB62
         EG2joxhKgqnN4dUBqcwaZZvPD9K8OYtt3jD/ey6wEFVIg8XMB+NVYOoeMZ3IbxtV9rgv
         lJo3uwhCBEBVnVLT9yZzwAAe9/WXdrp3bEsADjNci4Ox3p3aQvv3jcx/Lm6GwKC/HvYC
         T6xg==
X-Gm-Message-State: APjAAAVJW80nstM8KYkl4kkKbFZ6sWxbYAJkzXQZDwK4hOHkvnHIApyy
        YPWYD/4jp1GPdYLcfpPt+Nj4J01ko0zi9r5rCYk=
X-Google-Smtp-Source: APXvYqz8Fs0Utf9F/Lt7HEIPoitdiihSHsfsz4RU7NzGx/GZSyGjwih6it3Mw6Vl6Uxgf1A2UiY2hXFXe+AbfJ0cl9A=
X-Received: by 2002:a2e:28d:: with SMTP id y13mr16086475lje.177.1559641136069;
 Tue, 04 Jun 2019 02:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-7-codekipper@gmail.com>
 <20190604075840.kquy3zcuckuzmvzr@flea> <CAEKpxB=RdYF9eEvAJ+R7sT6OtdtBWjhMM1am+EhaN=9ZO9Gd2A@mail.gmail.com>
 <CAP03XepJVPge5sz4WcmK8pp2jHAPJdGb6v6A3R0DzSf5O6qj-g@mail.gmail.com>
In-Reply-To: <CAP03XepJVPge5sz4WcmK8pp2jHAPJdGb6v6A3R0DzSf5O6qj-g@mail.gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 4 Jun 2019 11:38:44 +0200
Message-ID: <CAEKpxBmxAQKgDhvjpczAWwNtNhYRs07wjMSnr8nqHk1XxMT=nw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
To:     Christopher Obbard <chris@64studio.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
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

On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris@64studio.com> wrote:
>
> On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper@gmail.com> wrote:
> >
> > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.com wrote:
> > > > From: Marcus Cooper <codekipper@gmail.com>
> > > >
> > > > The i2s block supports multi-lane i2s output however this functionality
> > > > is only possible in earlier SoCs where the pins are exposed and for
> > > > the i2s block used for HDMI audio on the later SoCs.
> > > >
> > > > To enable this functionality, an optional property has been added to
> > > > the bindings.
> > > >
> > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > >
> > > I'd like to have Mark's input on this, but I'm really worried about
> > > the interaction with the proper TDM support.
> > >
> > > Our fundamental issue is that the controller can have up to 8
> > > channels, but either on 4 lines (instead of 1), or 8 channels on 1
> > > (like proper TDM) (or any combination between the two, but that should
> > > be pretty rare).
> >
> > I understand...maybe the TDM needs to be extended to support this to consider
> > channel mapping and multiple transfer lines. I was thinking about the later when
> > someone was requesting support on IIRC a while ago, I thought masking might
> > of been a solution. These can wait as the only consumer at the moment is
> > LibreELEC and we can patch it there.
>
> Hi Marcus,
>
> FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> transfer lines which are called serializers.
> Maybe this can help with inspiration?
> see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/ti/davinci-mcasp.c
> sample DTS:
>
> &mcasp0 {
>     #sound-dai-cells = <0>;
>     status = "okay";
>     pinctrl-names = "default";
>     pinctrl-0 = <&mcasp0_pins>;
>
>     op-mode = <0>;
>     tdm-slots = <8>;
>     serial-dir = <
>         2 0 1 0
>         0 0 0 0
>         0 0 0 0
>         0 0 0 0
>     >;
>     tx-num-evt = <1>;
>     rx-num-evt = <1>;
> };
>
>
> Cheers!

Thanks, this looks good.
CK
>
> > Do you have any ideas Master?
> > CK
> > >
> > > You're trying to do the first one, and I'm trying to do the second one.
> > >
> > > There's a number of assumptions later on that will break the TDM case,
> > > see below for examples
> > >
> > > > ---
> > > >  sound/soc/sunxi/sun4i-i2s.c | 44 ++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 39 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > > index bca73b3c0d74..75217fb52bfa 100644
> > > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > > @@ -23,7 +23,7 @@
> > > >
> > > >  #define SUN4I_I2S_CTRL_REG           0x00
> > > >  #define SUN4I_I2S_CTRL_SDO_EN_MASK           GENMASK(11, 8)
> > > > -#define SUN4I_I2S_CTRL_SDO_EN(sdo)                   BIT(8 + (sdo))
> > > > +#define SUN4I_I2S_CTRL_SDO_EN(lines)         (((1 << lines) - 1) << 8)
> > > >  #define SUN4I_I2S_CTRL_MODE_MASK             BIT(5)
> > > >  #define SUN4I_I2S_CTRL_MODE_SLAVE                    (1 << 5)
> > > >  #define SUN4I_I2S_CTRL_MODE_MASTER                   (0 << 5)
> > > > @@ -355,14 +355,23 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> > > >       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > > >       int sr, wss, channels;
> > > >       u32 width;
> > > > +     int lines;
> > > >
> > > >       channels = params_channels(params);
> > > > -     if (channels != 2) {
> > > > +     if ((channels > dai->driver->playback.channels_max) ||
> > > > +             (channels < dai->driver->playback.channels_min)) {
> > > >               dev_err(dai->dev, "Unsupported number of channels: %d\n",
> > > >                       channels);
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > +     lines = (channels + 1) / 2;
> > > > +
> > > > +     /* Enable the required output lines */
> > > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > > +                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > > > +                        SUN4I_I2S_CTRL_SDO_EN(lines));
> > > > +
> > >
> > > This has the assumption that each line will have 2 channels, which is wrong.
> > >
> > > >       if (i2s->variant->is_h3_i2s_based) {
> > > >               regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
> > > >                                  SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> > > > @@ -373,8 +382,19 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> > > >       }
> > > >
> > > >       /* Map the channels for playback and capture */
> > > > -     regmap_field_write(i2s->field_txchanmap, 0x76543210);
> > > >       regmap_field_write(i2s->field_rxchanmap, 0x00003210);
> > > > +     regmap_field_write(i2s->field_txchanmap, 0x10);
> > > > +     if (i2s->variant->is_h3_i2s_based) {
> > > > +             if (channels > 2)
> > > > +                     regmap_write(i2s->regmap,
> > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
> > > > +             if (channels > 4)
> > > > +                     regmap_write(i2s->regmap,
> > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
> > > > +             if (channels > 6)
> > > > +                     regmap_write(i2s->regmap,
> > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
> > > > +     }
> > >
> > > And this creates a mapping matching that.
> > >
> > > >       /* Configure the channels */
> > > >       regmap_field_write(i2s->field_txchansel,
> > > > @@ -1057,9 +1077,10 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
> > > >  static int sun4i_i2s_probe(struct platform_device *pdev)
> > > >  {
> > > >       struct sun4i_i2s *i2s;
> > > > +     struct snd_soc_dai_driver *soc_dai;
> > > >       struct resource *res;
> > > >       void __iomem *regs;
> > > > -     int irq, ret;
> > > > +     int irq, ret, val;
> > > >
> > > >       i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> > > >       if (!i2s)
> > > > @@ -1126,6 +1147,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
> > > >       i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> > > >       i2s->capture_dma_data.maxburst = 8;
> > > >
> > > > +     soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> > > > +                            sizeof(*soc_dai), GFP_KERNEL);
> > > > +     if (!soc_dai) {
> > > > +             ret = -ENOMEM;
> > > > +             goto err_pm_disable;
> > > > +     }
> > > > +
> > > > +     if (!of_property_read_u32(pdev->dev.of_node,
> > > > +                               "allwinner,playback-channels", &val)) {
> > > > +             if (val >= 2 && val <= 8)
> > > > +                     soc_dai->playback.channels_max = val;
> > > > +     }
> > > > +
> > >
> > > I'm not quite sure how this works.
> > >
> > > of_property_read_u32 will return 0, so you will enter in the
> > > condition. But what happens if the property is missing?
> > >
> > > Maxime
> > >
> > > --
> > > Maxime Ripard, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CAEKpxB%3DRdYF9eEvAJ%2BR7sT6OtdtBWjhMM1am%2BEhaN%3D9ZO9Gd2A%40mail.gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
