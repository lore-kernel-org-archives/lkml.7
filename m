Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C626F2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G9skQ3aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGQIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:14:03 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38792 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:14:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so15850634vso.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOxb5tg5seSjtQqIorgKM+Di7ixuS6uqfAgdFu5RpzA=;
        b=G9skQ3aRbgwXpozrH+1DO97KndwvPNLHeERqMmQDZWWaONNCADEoaOMvPkA0sFj53o
         phoK8JUmNVcvN1zKr+0kawyF+mSilxU7i4gtAoMto3xyO9TQG5uMPuI/UfH3wukUoDOc
         j6XhR7QyCsO7y931Q57UTyK2rbsj1P5my0hS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOxb5tg5seSjtQqIorgKM+Di7ixuS6uqfAgdFu5RpzA=;
        b=A8Y5Dr5vYYFiPbzNgCPwHLAlX4yRz98rFTvCHjAm1KXarkl2LM2UkiPP7pPNlVfxOP
         1Pb6b9W5EXvssNL5YlhzwBVJro2EG2LtlKSqHPfyFW0CrojB8BUGe9QJCWHz5pSRWyd4
         vdAMKr3mkkOgGnrG3k/peAN2JZfl7Hb84GYfMmFuTHaXbrQ2VL188UCZr1ZXFfcDwJ4C
         ggr9E33s2Ccg2IHHeSiTtA36JAAmY8yo0PyoKdhGVB3mce9cfVsK+LZe6cMQUhdKVUKL
         juK9/XuUfpwPmECB817wlaYshpxZqFGGDVpLyY0e1Ow0UWT1kWVSuWuLINWbfFqTmi6Y
         WuHQ==
X-Gm-Message-State: APjAAAXPtr7krIAOZcdkppcBao24cSULI2u0Z2b2/bSQl4o7uLGGStID
        I/TXpCe2cMb65lOKivo5zMsw5RLxzQFdAAp7jZ17iw==
X-Google-Smtp-Source: APXvYqwumLX15i5KhdhsUxIfW0Chce/ceicYE3QuO3Xntx39jQED40S5LxMsWwDhbGTmvCiWV49cMhif6dAhO+pZRnI=
X-Received: by 2002:a67:eb12:: with SMTP id a18mr1522512vso.119.1563351241789;
 Wed, 17 Jul 2019 01:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-6-cychiang@chromium.org>
 <CA+Px+wXK9gJKZwzsG8BXh1gmoEyscxtMzB_VCrHz-nenBEL9AQ@mail.gmail.com>
In-Reply-To: <CA+Px+wXK9gJKZwzsG8BXh1gmoEyscxtMzB_VCrHz-nenBEL9AQ@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 17 Jul 2019 16:13:35 +0800
Message-ID: <CAFv8NwKJ4SEbN34EyS7wA33z9+bCCM2mzQRUBfDLr9Vg5CP9jQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] ASoC: rockchip_max98090: Add HDMI jack support
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:16 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 7:58 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> > index c82948e383da..c81c4acda917 100644
> > --- a/sound/soc/rockchip/rockchip_max98090.c
> > +++ b/sound/soc/rockchip/rockchip_max98090.c
> > +static struct snd_soc_jack rk_hdmi_jack;
> > +
> > +static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> > +{
> > +       struct snd_soc_card *card = runtime->card;
> > +       struct snd_soc_component *component = runtime->codec_dai->component;
> > +       int ret;
> > +
> > +       /* enable jack detection */
> > +       ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> > +                                   &rk_hdmi_jack, NULL, 0);
> > +       if (ret) {
> > +               dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
> > +}
> In the patch, you should select SND_SOC_HDMI_CODEC, because the patch
> uses hdmi_codec_set_jack_detect which depends on hdmi-codec.c.
Thanks! I'll fix in v5.
