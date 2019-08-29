Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3412B2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Way9cSCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfH2WQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:16:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45323 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfH2WQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:16:52 -0400
Received: by mail-io1-f65.google.com with SMTP id t3so10033329ioj.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiH72N61VDWmVxItzkF6zksnlwjwA2NHJACDtY2Xycg=;
        b=Way9cSCIYfArenznA8oYHlnHTJabAbfOvU8IBuvW3W6wFHlllPVoSIv2T/WNlJ0q6e
         SoUznNz9PMqM6gzVg33TP/25HbF7F99Rzcq7p8kxHA9bjWkVaWA3Kmw0x8gROWIYNNGo
         szQWao+/UlAj8ndbqomemYcpAzbSPosUn43N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiH72N61VDWmVxItzkF6zksnlwjwA2NHJACDtY2Xycg=;
        b=egM7pHOk7w2tuf8Y0kQEUkQlYdTLwly3U1Aba7QggI/qY2bR6cYUH/a/siYt7HVN7Y
         5yac4L3RQHxnM2aHNHmXCfffxi3he5O8i7FXKfKWMly2zzzkTLVKAB3wvx90ImsVTG6F
         wZ9sxTfJUsK+XzBNJPbrIQ9YTVleMYaW7MvIkX1s7GbjS2soo8aymCLny0c64R5cbpgh
         K40O9A0r9e+/Ta6eSPCYqUsNGjkjokN00qJXVpl28q14PFmnLk5YkCIDfLaCOTUGQBxf
         XwrF7FGz3bMQxCYZgPopNxQvTi+IX0JWKph+Ckguh9jwD8ko2UTU3I9cZeMDA5CXGIJi
         ZHuA==
X-Gm-Message-State: APjAAAVQJvtOndSQJ/HZEpKAjIPXJdGjSXcRRfQVUib7skcsqZpVwLHB
        vHfBnCGYOJZ2qUi8hDcS3ZJYKmFh8JM=
X-Google-Smtp-Source: APXvYqw2bGu2xmV/tWBjPHvtwpcGLhh/+ZHkO4cABohvVxRqQ5sxAyqqMJ/LdNwyOoTOUVmKOFGjNg==
X-Received: by 2002:a6b:6c09:: with SMTP id a9mr9399466ioh.27.1567117010551;
        Thu, 29 Aug 2019 15:16:50 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id b17sm3540348ioh.6.2019.08.29.15.16.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 15:16:49 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id j4so10050383iog.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:16:48 -0700 (PDT)
X-Received: by 2002:a6b:d006:: with SMTP id x6mr13702031ioa.218.1567117008526;
 Thu, 29 Aug 2019 15:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190829042957.150929-1-cychiang@chromium.org>
In-Reply-To: <20190829042957.150929-1-cychiang@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Aug 2019 15:16:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xb_SkUTkVRpOX7B+B0AdT3cOB+JamNyXzq_UQK3mvz1A@mail.gmail.com>
Message-ID: <CAD=FV=Xb_SkUTkVRpOX7B+B0AdT3cOB+JamNyXzq_UQK3mvz1A@mail.gmail.com>
Subject: Re: [PATCH] drm: dw-hdmi-i2s: enable audio clock in audio_startup
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kuninori.morimoto.gx@renesas.com, Sam Ravnborg <sam@ravnborg.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        =?UTF-8?B?6YOR5YW0?= <zhengxing@rock-chips.com>,
        =?UTF-8?B?6JSh6Im65Lyf?= <cain.cai@rock-chips.com>,
        Eddie Cai <eddie.cai@rock-chips.com>,
        =?UTF-8?B?6ZmI5riQ6aOe?= <jeffy.chen@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 28, 2019 at 9:30 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> In the designware databook, the sequence of enabling audio clock and
> setting format is not clearly specified.
> Currently, audio clock is enabled in the end of hw_param ops after
> setting format.
>
> On some monitors, there is a possibility that audio does not come out.
> Fix this by enabling audio clock in audio_startup ops
> before hw_param ops setting format.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 5cbb71a866d5..08b4adbb1ddc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -69,6 +69,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
>         hdmi_write(audio, conf0, HDMI_AUD_CONF0);
>         hdmi_write(audio, conf1, HDMI_AUD_CONF1);
>
> +       return 0;
> +}
> +
> +static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
> +{
> +       struct dw_hdmi_i2s_audio_data *audio = data;
> +       struct dw_hdmi *hdmi = audio->hdmi;
> +
>         dw_hdmi_audio_enable(hdmi);
>
>         return 0;
> @@ -105,6 +113,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>  }
>
>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> +       .audio_startup = dw_hdmi_i2s_audio_startup,
>         .hw_params      = dw_hdmi_i2s_hw_params,
>         .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
>         .get_dai_id     = dw_hdmi_i2s_get_dai_id,
> --

I am no expert on audio stuff, but this seems sane to me.  If you
happened to spin it for another reason, it might seem slightly nicer
to put the setting of ".audio_startup" adjacent to the setting of
".audio_shutdown" in the struct.

I have tested your patch on Chrome OS 4.19 and it definitely fixes the
problems I saw.  Chrome OS 4.19 is a little different than upstream
and I'm not setup to test HDMI audio directly on upstream, but I did
at least confirm that my problem _wasn't_ magically fixed by any of
these patches that I found upstream (I picked them into my tree and
still saw the problem):

fc1ca6e01d0a drm/bridge: dw-hdmi-i2s: add .get_eld support
43e88f670a5e drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
46cecde310bb drm/bridge: dw-hdmi-i2s: reset audio fifo before applying
new params
0c6098859176 drm/bridge: dw-hdmi-i2s: set the channel allocation
17a1e555b608 drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
da5f5bc92f49 drm/bridge: dw-hdmi: set channel count in the infoframes
2a2a3d2ff799 drm/bridge: dw-hdmi: move audio channel setup out of ahb
8067f62bccaf drm/bridge: dw-hdmi-i2s: support more i2s format

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
