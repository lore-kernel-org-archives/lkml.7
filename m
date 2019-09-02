Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C514C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F021874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 02:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPR+RAf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfIBCHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 22:07:25 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39269 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfIBCHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 22:07:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id y62so8269853vsb.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SteZi7Jc1Qj/ZWEovebsg0xMt+f3c5vmQftu053JsS8=;
        b=lPR+RAf4lLbHFKrG7BKbpxKO2o5PIV6QPEk5yeLJsGuOupELQ4EX6PQ2n7tlyefFjX
         5TueBZwuZlQptLjVpdiWoRTQzixxBywwaHL2Q/9NxpVlWZua4yL5HvNYQaptM2F6I5gj
         urBmtznxWX5SXt9UN7RdKLsmNWsgswpCy+GTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SteZi7Jc1Qj/ZWEovebsg0xMt+f3c5vmQftu053JsS8=;
        b=dM0bXVecqcFVXAA2e4Xf21ibUknJPAhwAxImEs/iVfSkfTOlIuDKgio14N3ppz/iJ0
         ggPSHFiLaamzZFUqnnP8X1/NmBzqHQ9cG9aNhYSqVm3lA+09B6HOmEpTi91Zlvk+JltW
         tg2fTIUTYkVDUqVVgeWWBgQBW8ZVNSox8RcAL9THCCnsJR0eeG9TF42eRr+ypek7Xiuj
         DqWxIJX66oAe41DYc7KpktyoU2YkLFSJxveizpzGrIzGRbqEvO2J+Mcw2lqUy9SFQhsB
         5VucTpObdDOP0pYqmr0bdFHjMd2JGJnS6Ggj1/C6FyI+c4qLl+f4Bz4nkj9v/6qDXyfF
         /EFg==
X-Gm-Message-State: APjAAAWcB1yldT5Sp/A7+yMNmL1zvUhU1jvA7qN1pAoa0xHMBOztEsiv
        r9Pw/EKkEKKlnOu/J8pkDRXipVoDzpem2RA5fXSX3g==
X-Google-Smtp-Source: APXvYqygVljSvGbaEG8FKuJz0otOZOZdwZTpv0TbVOTes8YfHOyxR97RLOewIUCIM3Ih7DIGVB5YrjsGpPU2Agxjvyo=
X-Received: by 2002:a67:de08:: with SMTP id q8mr4571764vsk.119.1567390042918;
 Sun, 01 Sep 2019 19:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190829042957.150929-1-cychiang@chromium.org> <HE1PR06MB4011FA45247F186BB83DFF04ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB4011FA45247F186BB83DFF04ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 2 Sep 2019 10:06:55 +0800
Message-ID: <CAFv8NwLq-cJqj0MB=rzKuqr3g0n3Y-nHor4w8ntiFXytoHpdLw@mail.gmail.com>
Subject: Re: [PATCH] drm: dw-hdmi-i2s: enable audio clock in audio_startup
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "cain.cai@rock-chips.com" <cain.cai@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "eddie.cai@rock-chips.com" <eddie.cai@rock-chips.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "dgreid@chromium.org" <dgreid@chromium.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 6:04 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-08-29 06:29, Cheng-Yi Chiang wrote:
> > In the designware databook, the sequence of enabling audio clock and
> > setting format is not clearly specified.
> > Currently, audio clock is enabled in the end of hw_param ops after
> > setting format.
> >
> > On some monitors, there is a possibility that audio does not come out.
> > Fix this by enabling audio clock in audio_startup ops
> > before hw_param ops setting format.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > index 5cbb71a866d5..08b4adbb1ddc 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -69,6 +69,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
> >       hdmi_write(audio, conf0, HDMI_AUD_CONF0);
> >       hdmi_write(audio, conf1, HDMI_AUD_CONF1);
> >
> > +     return 0;
> > +}
> > +
> > +static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
> > +{
> > +     struct dw_hdmi_i2s_audio_data *audio = data;
> > +     struct dw_hdmi *hdmi = audio->hdmi;
> > +
> >       dw_hdmi_audio_enable(hdmi);
> >
> >       return 0;
> > @@ -105,6 +113,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> >  }
> >
> >  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> > +     .audio_startup = dw_hdmi_i2s_audio_startup,
>
> A small white space nit, there should be a tab and not space to align the equal sign above.

ACK. Will fix in v2.
>
> Also this patch do not cleanly apply to drm-misc-next or linux-next after
> fc1ca6e01d0a "drm/bridge: dw-hdmi-i2s: add .get_eld support" was merged.

ACK. Will rebase in v2.
>
>
>
>
> This patch does fix an issue I have observed on my Rockchip devices where audio would not always
> came out after switching between audio streams having different rate and channels parameters.
> I used to carry [1] to fix that issue, but this seems like a more sane fix.
>
> [1] https://github.com/Kwiboo/linux-rockchip/commit/4862e4044532b8b480fa3a0faddc197586623808
>
> With above fixed,
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>


Thanks a lot!

>
>
> Regards,
> Jonas
>
> >       .hw_params      = dw_hdmi_i2s_hw_params,
> >       .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
> >       .get_dai_id     = dw_hdmi_i2s_get_dai_id,
>
