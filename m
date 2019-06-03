Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCBAC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D73827DD1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5LBwXeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfFCIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:54:24 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40655 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFCIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:54:24 -0400
Received: by mail-vk1-f193.google.com with SMTP id s16so1321236vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wdJEk7xoPcDvx0rL8FHQp9oPvWZRTtNsGybP0RtSagY=;
        b=M5LBwXeW8e3O+PDSsi9zCXscQ8y1vbRUSJsU1dQVFrSJjRzc0XEsTIijLOFvdIySua
         +OCo46JIId3hfB8wKxv+MCF7fVRzIDejRA2kyMLDpDQwCzug1Ciird69sGvwMmk1d8Mo
         XsEJ3E2hVFq6TKZA01pfKGQ+jF0WA1WjOA96Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wdJEk7xoPcDvx0rL8FHQp9oPvWZRTtNsGybP0RtSagY=;
        b=IjslDn+fZQL0ve1hToPEqnB9pTAjV0lEKD5MNci6ZFpYadqI7BEvEnL/gImuySo5by
         R2g0FPnMZvFVMu+yFNhwDE5cPWEQONwaJMpyQtrcMXWMo57otRfwnlIn7K8xw5uyyH/S
         RCsiZzaxwoHnkrx3RnvE1uE8dS4A6iSo1trQryGR7W/ThZCN5WcQCkrneNnt2N7dnc5B
         phpTMdvwqAsPYwVKcVUyCWBYjodWVf/ti/srWNNHj4AO7+Zd/UUME8WCFipl/33toFzE
         B6MNqG24Ok0Zx+/EAbROt3gekZA0+Dacz1E2XNEZMb4u1nnJb+D8FUqDuyXeac1Q8rf1
         QVfQ==
X-Gm-Message-State: APjAAAV0s/HDzHjGdzRyyLeWM1gmPF5QEk4lDfmkB5+PtP77JDV/JjyP
        eEUbxoI8O/orSmVDIUwtbwJoOIKWsDfp3MoGt7DgJg==
X-Google-Smtp-Source: APXvYqzW5LQtHHySgqxIQwZwXTkV349/aO/EZ86HUpABwdgeY6YY1BGiVYaBh3z0RzEL+55rfLwERjYPN8UokbeRX/Y=
X-Received: by 2002:a1f:a003:: with SMTP id j3mr5105438vke.74.1559552062071;
 Mon, 03 Jun 2019 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190603043251.226549-1-cychiang@chromium.org>
 <20190603043251.226549-3-cychiang@chromium.org> <20190603100301.00d68690@xxx>
In-Reply-To: <20190603100301.00d68690@xxx>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 3 Jun 2019 16:53:55 +0800
Message-ID: <CAFv8Nw+g2SZ00FTH969AbpPBBm_jeN9C-7_Mz5Vr7xc+qs0UfQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/7] ASoC: hdmi-codec: use HDMI state
 notifier to add jack support
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org,
        Dylan Reid <dgreid@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, tzungbi@chromium.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 3:59 PM Amadeusz S=C5=82awi=C5=84ski
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> On Mon,  3 Jun 2019 12:32:46 +0800
> Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> >
> > Use HDMI connection / disconnection notifications to update an ALSA
> > jack object. Also make a copy of the ELD block after every change.
> >
> > This was posted by Philipp Zabel at
> >
> > https://patchwork.kernel.org/patch/9430747/
> >
> > Modified by Cheng-Yi Chiang:
> > - Fix the conflict of removed hdmi_codec_remove ops.
> > - Other minor fix for the conflict with latest hdmi-codec on ASoC
> >   for-next tree.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> > The original patch is at https://patchwork.kernel.org/patch/9430747/
> > I could not find the LKML link for the patch.
> >
> >  include/sound/hdmi-codec.h    |   7 +++
> >  sound/soc/codecs/Kconfig      |   1 +
> >  sound/soc/codecs/hdmi-codec.c | 104
> > +++++++++++++++++++++++++++++++++- 3 files changed, 110
> > insertions(+), 2 deletions(-)
> >
> > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > index 9483c55f871b..4fa39c93363f 100644
> > --- a/include/sound/hdmi-codec.h
> > +++ b/include/sound/hdmi-codec.h
> > @@ -107,6 +107,13 @@ struct hdmi_codec_pdata {
> >       void *data;
> >  };
> >
> > +struct snd_soc_component;
> > +struct snd_soc_jack;
> > +
> > +int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> > +                            struct snd_soc_jack *jack,
> > +                            struct device *dev);
> > +
> >  #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
> >
> >  #endif /* __HDMI_CODEC_H__ */
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 8f577258080b..f5f6dd04234c 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -639,6 +639,7 @@ config SND_SOC_HDMI_CODEC
> >       select SND_PCM_ELD
> >       select SND_PCM_IEC958
> >       select HDMI
> > +     select HDMI_NOTIFIERS
> >
> >  config SND_SOC_ES7134
> >         tristate "Everest Semi ES7134 CODEC"
> > diff --git a/sound/soc/codecs/hdmi-codec.c
> > b/sound/soc/codecs/hdmi-codec.c index 6a0cc8d7e141..fe796a7475a5
> > 100644 --- a/sound/soc/codecs/hdmi-codec.c
> > +++ b/sound/soc/codecs/hdmi-codec.c
> > @@ -12,9 +12,12 @@
> >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.       See
> > the GNU
> >   * General Public License for more details.
> >   */
> > +#include <linux/hdmi-notifier.h>
> >  #include <linux/module.h>
> > +#include <linux/notifier.h>
> >  #include <linux/string.h>
> >  #include <sound/core.h>
> > +#include <sound/jack.h>
> >  #include <sound/pcm.h>
> >  #include <sound/pcm_params.h>
> >  #include <sound/soc.h>
> > @@ -282,6 +285,13 @@ struct hdmi_codec_priv {
> >       struct snd_pcm_chmap *chmap_info;
> >       unsigned int chmap_idx;
> >       struct mutex lock;
> > +     struct snd_soc_jack *jack;
> > +     /* Lock to protect setting and getting eld. */
> > +     struct mutex eld_lock;
> > +     struct device *dev;
> > +     struct hdmi_notifier *notifier;
> > +     struct notifier_block nb;
> > +     unsigned int jack_status;
> >  };
> >
> >  static const struct snd_soc_dapm_widget hdmi_widgets[] =3D {
> > @@ -308,7 +318,9 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol
> > *kcontrol, struct snd_soc_component *component =3D
> > snd_kcontrol_chip(kcontrol); struct hdmi_codec_priv *hcp =3D
> > snd_soc_component_get_drvdata(component);
> > +     mutex_lock(&hcp->eld_lock);
> >       memcpy(ucontrol->value.bytes.data, hcp->eld,
> > sizeof(hcp->eld));
> > +     mutex_unlock(&hcp->eld_lock);
> >
> >       return 0;
> >  }
> > @@ -393,7 +405,7 @@ static int hdmi_codec_startup(struct
> > snd_pcm_substream *substream, struct snd_soc_dai *dai)
> >  {
> >       struct hdmi_codec_priv *hcp =3D snd_soc_dai_get_drvdata(dai);
> > -     int ret =3D 0;
> > +     int ret;
> >
> >       ret =3D mutex_trylock(&hcp->lock);
> >       if (!ret) {
> > @@ -408,9 +420,9 @@ static int hdmi_codec_startup(struct
> > snd_pcm_substream *substream, }
> >
> >       if (hcp->hcd.ops->get_eld) {
> > +             mutex_lock(&hcp->eld_lock);
> >               ret =3D hcp->hcd.ops->get_eld(dai->dev->parent,
> > hcp->hcd.data, hcp->eld, sizeof(hcp->eld));
> > -
> >               if (!ret) {
> >                       ret =3D
> > snd_pcm_hw_constraint_eld(substream->runtime, hcp->eld);
>
> Seems to me like you missed unlock here. There is return inside this
> if().
>

Thanks for checking!
The latest patch on hdmi-codec.c on ASoC tree has a change to replace
that return to goto err.

https://patchwork.kernel.org/patch/10930875/

My patch is based on that so it should be okay.
Thanks!

> > @@ -419,6 +431,7 @@ static int hdmi_codec_startup(struct
> > snd_pcm_substream *substream, }
> >               /* Select chmap supported */
> >               hdmi_codec_eld_chmap(hcp);
> > +             mutex_unlock(&hcp->eld_lock);
> >       }
> >       return 0;
> >
> > @@ -747,6 +760,77 @@ static const struct snd_soc_component_driver
> > hdmi_driver =3D { .non_legacy_dai_naming        =3D 1,
> >  };
> >
> > +static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> > +                                unsigned int jack_status)
> > +{
> > +     if (!hcp->jack)
> > +             return;
> > +
> > +     if (jack_status !=3D hcp->jack_status) {
> > +             snd_soc_jack_report(hcp->jack, jack_status,
> > SND_JACK_LINEOUT);
> > +             hcp->jack_status =3D jack_status;
> > +     }
> > +}
> > +
> > +static int hdmi_codec_notify(struct notifier_block *nb, unsigned
> > long event,
> > +                          void *data)
> > +{
> > +     struct hdmi_codec_priv *hcp =3D container_of(nb, struct
> > hdmi_codec_priv,
> > +                                                nb);
> > +     struct hdmi_notifier *n =3D data;
> > +
> > +     if (!hcp->jack)
> > +             return NOTIFY_OK;
> > +
> > +     switch (event) {
> > +     case HDMI_NEW_ELD:
> > +             mutex_lock(&hcp->eld_lock);
> > +             memcpy(hcp->eld, n->eld, sizeof(hcp->eld));
> > +             mutex_unlock(&hcp->eld_lock);
> > +             /* fall through */
> > +     case HDMI_CONNECTED:
> > +             hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
> > +             break;
> > +     case HDMI_DISCONNECTED:
> > +             hdmi_codec_jack_report(hcp, 0);
> > +             break;
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +/**
> > + * hdmi_codec_set_jack_detect - register HDMI state notifier callback
> > + * @component: the hdmi-codec instance
> > + * @jack: ASoC jack to report (dis)connection events on
> > + * @dev: hdmi_notifier device, usually HDMI_TX or CEC device
> > + */
> > +int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> > +                            struct snd_soc_jack *jack,
> > +                            struct device *dev)
> > +{
> > +     struct hdmi_codec_priv *hcp =3D
> > snd_soc_component_get_drvdata(component);
> > +     int ret;
> > +
> > +     hcp->notifier =3D hdmi_notifier_get(dev);
> > +     if (!hcp->notifier)
> > +             return -ENOMEM;
> > +
> > +     hcp->jack =3D jack;
> > +     hcp->nb.notifier_call =3D hdmi_codec_notify;
> > +     ret =3D hdmi_notifier_register(hcp->notifier, &hcp->nb);
> > +     if (ret)
> > +             goto err_notifier_put;
> > +
> > +     return 0;
> > +
> > +err_notifier_put:
> > +     hdmi_notifier_put(hcp->notifier);
> > +     hcp->notifier =3D NULL;
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
> > +
> >  static int hdmi_codec_probe(struct platform_device *pdev)
> >  {
> >       struct hdmi_codec_pdata *hcd =3D pdev->dev.platform_data;
> > @@ -774,6 +858,7 @@ static int hdmi_codec_probe(struct
> > platform_device *pdev)
> >       hcp->hcd =3D *hcd;
> >       mutex_init(&hcp->lock);
> > +     mutex_init(&hcp->eld_lock);
> >
> >       daidrv =3D devm_kcalloc(dev, dai_count, sizeof(*daidrv),
> > GFP_KERNEL); if (!daidrv)
> > @@ -797,6 +882,20 @@ static int hdmi_codec_probe(struct
> > platform_device *pdev) __func__, ret);
> >               return ret;
> >       }
> > +
> > +     hcp->dev =3D dev;
> > +
> > +     return 0;
> > +}
> > +
> > +static int hdmi_codec_remove(struct platform_device *pdev)
> > +{
> > +     struct hdmi_codec_priv *hcp =3D platform_get_drvdata(pdev);
> > +
> > +     if (hcp->notifier) {
> > +             hdmi_notifier_unregister(hcp->notifier, &hcp->nb);
> > +             hdmi_notifier_put(hcp->notifier);
> > +     }
> >       return 0;
> >  }
> >
> > @@ -805,6 +904,7 @@ static struct platform_driver hdmi_codec_driver =3D
> > { .name =3D HDMI_CODEC_DRV_NAME,
> >       },
> >       .probe =3D hdmi_codec_probe,
> > +     .remove =3D hdmi_codec_remove,
> >  };
> >
> >  module_platform_driver(hdmi_codec_driver);
>
