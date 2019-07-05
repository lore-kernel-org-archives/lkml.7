Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB0C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EF621852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn5+GLp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGEHJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:09:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45144 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGEHJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:09:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so8079390otq.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HA1gRJUU1q/vq10J2Cj5qnKuph6mRHyYxPoVAGdEoY=;
        b=Hn5+GLp28rD0iRoGwRHbRq7GRqhDGFy99Nq0elsuKdVJNwUHVcdvJRg+gisPdFcpAZ
         qEdsBQ/afocCCAKXjvk+7j6rsUbqRcawLyzd70CSM0IbNIX9k0WdbOckw9qauhSBUKbs
         KsS8UCyQhKHpbg2mJG97lYMWJdWnZIc9xlhH1aPkk/x65Lyq+DEu9zuQz3itB4uXU5Jx
         Wp2757OkuQRX27nYk26bC5yZaCPgQVKegnpuEwUi3IhMmeam8wEmZq0QBjIAZzjRK2Vy
         J6XUiGXIqYCImxBzdj/5HNLtVcjYug3zt2+FpURR/lYSVsNYx9z7L0YratiSYcZPpaf3
         EX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HA1gRJUU1q/vq10J2Cj5qnKuph6mRHyYxPoVAGdEoY=;
        b=B8v99x6nP1S6YxTAX+AlauccBYAEKAUC9M7FqSUUnkvOsEpNPmPgUiKNfDgpMzq+y4
         5PssRqTiQ/JovC7Tke4g9uTQ5YCkvj0F+RDgMEeD0hgeuYpeXflnxClt1Ul7oeat7fZD
         sp1mxmJl93/RX6kS+aLtNZELSBODoT7Ubr4NyZxeI+RiKxSGPaaxHwEFzsGgLmn2G9T3
         I48P3NLLVNPsp1VvjYQh/mJp0Jsq6sxOvsL4uB2gONf6YOhXhLFzyawM3rLb1PpROxZN
         zow5psElH9T+ViZDZMJb0jKq9kBmpt8/qicfeSiJz0y03EUbvkIvIrCCTOrIXuvGDSGZ
         d+9w==
X-Gm-Message-State: APjAAAUStaKAzOJdhKmIeAjByXuKU/3SMMXLbAF8Nv2mdYLeLkKELWjA
        wWyUe6ZmZZmePOUeL7aF+stdofjfSq0HRO4rwsRGLpDM2S7rNA==
X-Google-Smtp-Source: APXvYqx8fFkXm04Sl60WDxMfdqFj9kg/zYj7b4ElJ1xZR84JewuoulDPbrbiGgNIHjmSgRkaFR30qgpyyakxkZEcxHc=
X-Received: by 2002:a9d:6195:: with SMTP id g21mr1790572otk.103.1562310559416;
 Fri, 05 Jul 2019 00:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org> <20190705042623.129541-3-cychiang@chromium.org>
In-Reply-To: <20190705042623.129541-3-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 5 Jul 2019 15:09:08 +0800
Message-ID: <CA+Px+wWwudeG5BLOkgcq_sJqfTxmre1O=XqU8OM6oqC966TUuQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm: bridge: dw-hdmi: Report connector status using callback
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> index 63b5756f463b..f523c590984e 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> @@ -2,6 +2,8 @@
>  #ifndef DW_HDMI_AUDIO_H
>  #define DW_HDMI_AUDIO_H
>
> +#include <sound/hdmi-codec.h>
> +
>  struct dw_hdmi;
>
>  struct dw_hdmi_audio_data {
> @@ -17,6 +19,7 @@ struct dw_hdmi_i2s_audio_data {
>
>         void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
>         u8 (*read)(struct dw_hdmi *hdmi, int offset);
> +       int (*set_plugged_cb)(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn);
>  };
>
>  #endif
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 5cbb71a866d5..7b93cf05c985 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -104,10 +104,20 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>         return -EINVAL;
>  }
>
> +static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
> +                                      hdmi_codec_plugged_cb fn)
> +{
> +       struct dw_hdmi_i2s_audio_data *audio = data;
> +       struct dw_hdmi *hdmi = audio->hdmi;
> +
> +       return audio->set_plugged_cb(hdmi, fn);
> +}
> +
The first parameter dev could be removed.  Not used.

>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
>         .hw_params      = dw_hdmi_i2s_hw_params,
>         .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
>         .get_dai_id     = dw_hdmi_i2s_get_dai_id,
> +       .hook_plugged_cb = dw_hdmi_i2s_hook_plugged_cb,
>  };
>
>  static int snd_dw_hdmi_probe(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 045b1b13fd0e..c69a399fc7ca 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -26,6 +26,8 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/bridge/dw_hdmi.h>
>
> +#include <sound/hdmi-codec.h>
> +
>  #include <uapi/linux/media-bus-format.h>
>  #include <uapi/linux/videodev2.h>
>
> @@ -185,6 +187,9 @@ struct dw_hdmi {
>         void (*disable_audio)(struct dw_hdmi *hdmi);
>
>         struct cec_notifier *cec_notifier;
> +
> +       hdmi_codec_plugged_cb plugged_cb;
> +       enum drm_connector_status last_connector_result;
>  };
>
>  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> @@ -209,6 +214,17 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
>         return val;
>  }
>
> +static int hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn)
> +{
> +       mutex_lock(&hdmi->mutex);
> +       hdmi->plugged_cb = fn;
> +       if (hdmi->audio && !IS_ERR(hdmi->audio))
I would expect if IS_ERR(hdmi->audio), then this should not be called
(i.e. should exit somewhere earlier).

> +               fn(hdmi->audio,
> +                  hdmi->last_connector_result == connector_status_connected);
> +       mutex_unlock(&hdmi->mutex);
> +       return 0;
> +}
> +
>  static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
>  {
>         regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
> @@ -2044,6 +2060,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
>         struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>                                              connector);
> +       enum drm_connector_status result;
>
>         mutex_lock(&hdmi->mutex);
>         hdmi->force = DRM_FORCE_UNSPECIFIED;
> @@ -2051,7 +2068,20 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>         dw_hdmi_update_phy_mask(hdmi);
>         mutex_unlock(&hdmi->mutex);
>
> -       return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +       result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +
> +       mutex_lock(&hdmi->mutex);
> +       if (result != hdmi->last_connector_result) {
> +               dev_dbg(hdmi->dev, "read_hpd result: %d", result);
> +               if (hdmi->plugged_cb && hdmi->audio && !IS_ERR(hdmi->audio)) {
Share the same concern above.
