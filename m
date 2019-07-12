Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD5C742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9BC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZWCRPdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGLKin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:38:43 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39978 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGLKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:38:42 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so3811739uad.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFlnVgtsH1wq+XzR7Jf0TraeqzPpP2anw1H9Vmw2tvM=;
        b=ZZWCRPdCfXzrnVtRzZdwa1ITRmB3qxf5geOYMDfWQUsSK85+lC95yAWwXfIWtojj3Z
         +U5nZwLyKEoHiF/KfrDvTV3RQwC3bWT6oq5DVauijG88SJsDnIFShBwLwjLw75Qqi3Pw
         uvgV0slD6iFweegv0PnpZ9YeoJUKQTa3aoJqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFlnVgtsH1wq+XzR7Jf0TraeqzPpP2anw1H9Vmw2tvM=;
        b=fUaoVCUBHS0zdp7JhYQLnuvuJ8iux2WGf/Cz0CKGUFuUxNJD2ohS+isDrBIzCkdSGg
         JAGISvg+hmJNIUsgy3X5O2F/JOp8BM02RUJu3OiZS7L8MldwUnaPl+SEuJLOt1mZZ4Dk
         j5D7JmnBbDIjWFs5aSeimPb51B3gHs8+MbYjnVfwBlDKei8EG0UzsbvoAB6caCMpJVCh
         rOqmLgtPV8dge64zjmOjLjecyMjTBeHkuM7RQPm96cqqObK8z5XvMdfzsahNQPU6SDlB
         7bT0Lad2G72HH0Xd2NqFRbIcj1Ev4/uVDMX48fin7A6k9/o9wj3Brv49spNqemFSJY28
         WJvg==
X-Gm-Message-State: APjAAAWWqxJu6iCeOtEAJD9BtT3yImu1tjksZ51Qev/tpllXempp1NbI
        Jh8rwP3y/6b8vO3KhUQQc/43zOAC4RKV8Y4ZrjWUjEmuS6I=
X-Google-Smtp-Source: APXvYqwr8ViLkFyuDpuZsdv+4CeIPeQhpf+eg0vAcxLw4Fe8TNWMbS82tIBGOSDng7L1p4Sa5VlGPV5eMJFqWsRho94=
X-Received: by 2002:a9f:3605:: with SMTP id r5mr8414289uad.131.1562927921086;
 Fri, 12 Jul 2019 03:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190712100443.221322-1-cychiang@chromium.org> <20190712100443.221322-6-cychiang@chromium.org>
In-Reply-To: <20190712100443.221322-6-cychiang@chromium.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 12 Jul 2019 18:38:14 +0800
Message-ID: <CAFv8NwKOhAz4B1da5MarXkVfavya6AYsvURa1Tq4LW=_nyZjiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] FROMLIST: ASoC: rockchip_max98090: Add HDMI jack support
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 6:06 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> In machine driver, create a jack and let hdmi-codec report jack status.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  sound/soc/rockchip/rockchip_max98090.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> index c82948e383da..c81c4acda917 100644
> --- a/sound/soc/rockchip/rockchip_max98090.c
> +++ b/sound/soc/rockchip/rockchip_max98090.c
> @@ -134,6 +134,25 @@ enum {
>         DAILINK_HDMI,
>  };
>
> +static struct snd_soc_jack rk_hdmi_jack;
> +
> +static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +       struct snd_soc_card *card = runtime->card;
> +       struct snd_soc_component *component = runtime->codec_dai->component;
> +       int ret;
> +
> +       /* enable jack detection */
> +       ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> +                                   &rk_hdmi_jack, NULL, 0);
> +       if (ret) {
> +               dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> +               return ret;
> +       }
> +
> +       return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
> +}
> +
>  /* max98090 and HDMI codec dai_link */
>  static struct snd_soc_dai_link rk_dailinks[] = {
>         [DAILINK_MAX98090] = {
> @@ -151,6 +170,7 @@ static struct snd_soc_dai_link rk_dailinks[] = {
>                 .ops = &rk_aif1_ops,
>                 .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>                         SND_SOC_DAIFMT_CBS_CFS,
> +               .init = rk_hdmi_init,
>                 SND_SOC_DAILINK_REG(hdmi),
>         }
>  };
> --
> 2.22.0.510.g264f2c817a-goog
>

Sorry for the wrong title.
I forgot to remove FROMLIST in the title.
I'll wait for comments on other patches and fix the title in v4.
Thanks!
