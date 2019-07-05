Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A96BC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249FE218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlCq+DE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGEHfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:35:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33406 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfGEHfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:35:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so3269476vsj.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DICfq5XTcQzxq11n/NHs27mGioZf4mAb5LvXEz+xYZo=;
        b=YlCq+DE8tSdVqwbF3dpt0TH/SmtFyBBicmFzm5tIOkFu9Btry9eggH7ZbR7zIsjneP
         vl5S6rdRmPU2O0sguGIJrqbsKGX1U2kmIJ3+JV7oWErOccYdO7obFudkwSYRDf4dH5nu
         cljbA5+v7H9LJh5TheVtDJLkkn8k5OS1t+mj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DICfq5XTcQzxq11n/NHs27mGioZf4mAb5LvXEz+xYZo=;
        b=r9DXjKbsDelG08Jl6v6uH3kDUeOlI/DYsd08N2JkBduU1J9oINln4uUHVvTAxHxupZ
         +mF+XYrZ09e17ILFIC6i49xkmwCIZz1Bks3zwmXQWNuryW2p1AJCA8iTzfk/zssVTj3r
         IoMJk35EVOtZZIgXy3T81GJnfeMcv1CwKXmBAxDZrhiG90WUnMqjGcBmBDOpj3yNhiIf
         X2WV/qgFeRzp4ZZ3hGxWgfs8nWXSdL+b6rOSEj4XEIy7LvW6t3BDJs8ogsRZEk6ibaQe
         I1PyuA+7ZOW5ZMPOctJMlppPRkbC8uozZy6t6GI2zyMmsepcYcH3GsvWY3PKh5gkWTgO
         E7CQ==
X-Gm-Message-State: APjAAAW7ltbw//lxWYfUSOFeRoG+BAPA8hLxQFMhg4JaLoaNkoDI/xPV
        g9rFcf/qvffOIFSAoaY5wU7iDPvmQisNHb3XmPtQ+g==
X-Google-Smtp-Source: APXvYqzc+pyNbVyeJdIdT5O/oHPA0+Ko7qWiAF8npTA/knIhPiNLZILpC61LRZIQfdUztKYjkkq02bq7H2jdTEwOT38=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr1309522vsr.9.1562312148663;
 Fri, 05 Jul 2019 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org> <CA+Px+wWwudeG5BLOkgcq_sJqfTxmre1O=XqU8OM6oqC966TUuQ@mail.gmail.com>
In-Reply-To: <CA+Px+wWwudeG5BLOkgcq_sJqfTxmre1O=XqU8OM6oqC966TUuQ@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 5 Jul 2019 15:35:22 +0800
Message-ID: <CAFv8NwJBSvN-7LRX8ZMOQ4hwQ1NA9y09L0tGOyCDvsXRbADUSA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm: bridge: dw-hdmi: Report connector status using callback
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
        Doug Anderson <dianders@chromium.org>,
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

On Fri, Jul 5, 2019 at 3:09 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > index 63b5756f463b..f523c590984e 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > @@ -2,6 +2,8 @@
> >  #ifndef DW_HDMI_AUDIO_H
> >  #define DW_HDMI_AUDIO_H
> >
> > +#include <sound/hdmi-codec.h>
> > +
> >  struct dw_hdmi;
> >
> >  struct dw_hdmi_audio_data {
> > @@ -17,6 +19,7 @@ struct dw_hdmi_i2s_audio_data {
> >
> >         void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
> >         u8 (*read)(struct dw_hdmi *hdmi, int offset);
> > +       int (*set_plugged_cb)(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn);
> >  };
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > index 5cbb71a866d5..7b93cf05c985 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -104,10 +104,20 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> >         return -EINVAL;
> >  }
> >
> > +static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
> > +                                      hdmi_codec_plugged_cb fn)
> > +{
> > +       struct dw_hdmi_i2s_audio_data *audio = data;
> > +       struct dw_hdmi *hdmi = audio->hdmi;
> > +
> > +       return audio->set_plugged_cb(hdmi, fn);
> > +}
> > +
> The first parameter dev could be removed.  Not used.
>
Hi Tzungbi, thanks for the review.

I am not sure about this one.
I think it depends on the DRM driver so I need to keep both..
E.g.
drivers/gpu/drm/rockchip/cdn-dp-core.c
it needs dev to access the required data.
You can check this patch:

"efc9194bcff8  ASoC: hdmi-codec: callback function will be called with
private data"

It explains that some cases use *dev, some cases use *data.

> >  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> >         .hw_params      = dw_hdmi_i2s_hw_params,
> >         .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
> >         .get_dai_id     = dw_hdmi_i2s_get_dai_id,
> > +       .hook_plugged_cb = dw_hdmi_i2s_hook_plugged_cb,
> >  };
> >
> >  static int snd_dw_hdmi_probe(struct platform_device *pdev)
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 045b1b13fd0e..c69a399fc7ca 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -26,6 +26,8 @@
> >  #include <drm/drm_probe_helper.h>
> >  #include <drm/bridge/dw_hdmi.h>
> >
> > +#include <sound/hdmi-codec.h>
> > +
> >  #include <uapi/linux/media-bus-format.h>
> >  #include <uapi/linux/videodev2.h>
> >
> > @@ -185,6 +187,9 @@ struct dw_hdmi {
> >         void (*disable_audio)(struct dw_hdmi *hdmi);
> >
> >         struct cec_notifier *cec_notifier;
> > +
> > +       hdmi_codec_plugged_cb plugged_cb;
> > +       enum drm_connector_status last_connector_result;
> >  };
> >
> >  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> > @@ -209,6 +214,17 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
> >         return val;
> >  }
> >
> > +static int hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn)
> > +{
> > +       mutex_lock(&hdmi->mutex);
> > +       hdmi->plugged_cb = fn;
> > +       if (hdmi->audio && !IS_ERR(hdmi->audio))
> I would expect if IS_ERR(hdmi->audio), then this should not be called
> (i.e. should exit somewhere earlier).
>
ACK. I should fix that.
Thanks!
> > +               fn(hdmi->audio,
> > +                  hdmi->last_connector_result == connector_status_connected);
> > +       mutex_unlock(&hdmi->mutex);
> > +       return 0;
> > +}
> > +
> >  static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
> >  {
> >         regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
> > @@ -2044,6 +2060,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >  {
> >         struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> >                                              connector);
> > +       enum drm_connector_status result;
> >
> >         mutex_lock(&hdmi->mutex);
> >         hdmi->force = DRM_FORCE_UNSPECIFIED;
> > @@ -2051,7 +2068,20 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >         dw_hdmi_update_phy_mask(hdmi);
> >         mutex_unlock(&hdmi->mutex);
> >
> > -       return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> > +       result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> > +
> > +       mutex_lock(&hdmi->mutex);
> > +       if (result != hdmi->last_connector_result) {
> > +               dev_dbg(hdmi->dev, "read_hpd result: %d", result);
> > +               if (hdmi->plugged_cb && hdmi->audio && !IS_ERR(hdmi->audio)) {
> Share the same concern above.
ACK
