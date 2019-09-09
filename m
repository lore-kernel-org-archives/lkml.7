Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEFEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1D216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ncSysLKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbfIIC1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:27:20 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33717 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbfIIC1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 22:27:20 -0400
Received: by mail-vk1-f196.google.com with SMTP id q186so2402382vkb.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 19:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DlBOWaJvgAFxAq8YU/ciVFFCV7ApXr2I8KRLK8ZtzPA=;
        b=ncSysLKLyIAhQ71PXVkSVjMTudin3YXppGvEAVzXyj8rHd8xQ/oYYaJcE+NLmE47Zu
         kHltzU7x2c6dZK1yD2/80DwX9D5Qk1+OQH3B8Zb0M9B8vrRVsjWi6/ZQhCaj4fV0tBnu
         BqfMJaN7qSMdCNK9YuL9zxs6BKoN2KEDNCprE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DlBOWaJvgAFxAq8YU/ciVFFCV7ApXr2I8KRLK8ZtzPA=;
        b=tSxN7nSX5VigXrG3kkDpoLml4GkbDlLuXRjJm40t9Lkba33mE+DeeOBdqgIof279xH
         ehvAaMDJL37EQihQsjG8t2r6XzuMjHaSQ3NMyP98g1lArXTfafVL/coA5wZ4gfA0+m54
         5sXQjhvbgOu8Rd4SAknECQ0kMrRJXwk5K7sPLr/HJBoizKHTY0ALjoXJqW00uilsRYJ7
         11yEdGtSk1afJdT7sXXddykoH6CTUBeLw6L8lqmoE+vZiBeZFz1YPn4tcx+0r/FgZ9eE
         7Rhdo2k9dzvRZn2m4+5jQex5J9bVZrS5LCTeutoa+u13A4rnSmj6FiWBaJ2OX93mzcMY
         AeLQ==
X-Gm-Message-State: APjAAAUlOPMVvcCgm+YmoV11MkoVQKEBDaQdw1JLmHASsShUJpJtLwGX
        MupqdvZr3W9ETGtknVkXxR7EW+ChZR+GnIv/EwneYg==
X-Google-Smtp-Source: APXvYqx+aqzbt8euzFQ1/r9sVFTKMWudP/lP9Qz4EerlZX+oy8zzuL84Cv2bF6eW3bUbibTj9r7O31v+diaRaL0Nl3o=
X-Received: by 2002:a1f:9893:: with SMTP id a141mr9826856vke.75.1567996037775;
 Sun, 08 Sep 2019 19:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190905094325.33156-1-cychiang@chromium.org> <7000610.EoTGzQ87Ws@jernej-laptop>
In-Reply-To: <7000610.EoTGzQ87Ws@jernej-laptop>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 9 Sep 2019 10:26:51 +0800
Message-ID: <CAFv8NwKFtTvscJoBg55tPs49HHpX_K8-9cC63J6WJ2p15K3bRg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge/dw_hdmi: add audio sample channel status setting
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kuninori.morimoto.gx@renesas.com, sam@ravnborg.org,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Xing Zheng <zhengxing@rock-chips.com>, cain.cai@rock-chips.com,
        =?UTF-8?B?6JSh5p6r?= <eddie.cai@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, kuankuan.y@gmail.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Yakir Yang <ykk@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 2:18 AM Jernej =C5=A0krabec <jernej.skrabec@siol.net=
> wrote:
>
> Dne =C4=8Detrtek, 05. september 2019 ob 11:43:25 CEST je Cheng-Yi Chiang
> napisal(a):
> > From: Yakir Yang <ykk@rock-chips.com>
> >
> > When transmitting IEC60985 linear PCM audio, we configure the
> > Aduio Sample Channel Status information of all the channel
> > status bits in the IEC60958 frame.
> > Refer to 60958-3 page 10 for frequency, original frequency, and
> > wordlength setting.
> >
> > This fix the issue that audio does not come out on some monitors
> > (e.g. LG 22CV241)
> >
> > Note that these registers are only for interfaces:
> > I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
> > (AHBAUDDMA).
> > For S/PDIF interface this information comes from the stream.
> >
> > Currently this function dw_hdmi_set_channel_status is only called
> > from dw-hdmi-i2s-audio in I2S setup.
> >
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  Original patch by Yakir Yang is at
> >
> >  https://lore.kernel.org/patchwork/patch/539653/
> >
> >  Change from v1 to v2:
> >  1. Remove the version check because this will only be called by
> >     dw-hdmi-i2s-audio, and the registers are available in I2S setup.
> >  2. Set these registers in dw_hdmi_i2s_hw_params.
> >  3. Fix the sample width setting so it can use 16 or 24 bits.
> >
> >  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 70 +++++++++++++++++++
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     | 20 ++++++
> >  include/drm/bridge/dw_hdmi.h                  |  2 +
> >  4 files changed, 93 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> > 34d8e837555f..b801a28b0f17 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev=
,
> > void *data, }
> >
> >       dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
> > +     dw_hdmi_set_channel_status(hdmi, hparms->sample_width);
> >       dw_hdmi_set_channel_count(hdmi, hparms->channels);
> >       dw_hdmi_set_channel_allocation(hdmi, hparms-
> >cea.channel_allocation);
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > bd65d0479683..d1daa369c8ae 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -582,6 +582,76 @@ static unsigned int hdmi_compute_n(unsigned int fr=
eq,
> > unsigned long pixel_clk) return n;
> >  }
> >
> > +/*
> > + * When transmitting IEC60958 linear PCM audio, these registers allow =
to
> > + * configure the channel status information of all the channel status
> > + * bits in the IEC60958 frame. For the moment this configuration is on=
ly
> > + * used when the I2S audio interface, General Purpose Audio (GPA),
> > + * or AHB audio DMA (AHBAUDDMA) interface is active
> > + * (for S/PDIF interface this information comes from the stream).
> > + */
> > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> > +                             unsigned int sample_width)
> > +{
> > +     u8 aud_schnl_samplerate;
> > +     u8 aud_schnl_8;
> > +     u8 word_length_bits;
> > +
> > +     switch (hdmi->sample_rate) {
> > +     case 32000:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> > +             break;
> > +     case 44100:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> > +             break;
> > +     case 48000:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> > +             break;
> > +     case 88200:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> > +             break;
> > +     case 96000:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> > +             break;
> > +     case 176400:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_176K4=
;
> > +             break;
> > +     case 192000:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> > +             break;
> > +     case 768000:
> > +             aud_schnl_samplerate =3D HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> > +             break;
> > +     default:
> > +             dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)
> \n",
> > +                      hdmi->sample_rate);
> > +             return;
> > +     }
> > +
> > +     /* set channel status register */
> > +     hdmi_modb(hdmi, aud_schnl_samplerate,
> HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
> > +               HDMI_FC_AUDSCHNLS7);
> > +
> > +     /*
> > +      * Set original frequency to be the same as frequency.
> > +      * Use one-complement value as stated in IEC60958-3 page 13.
> > +      */
> > +     aud_schnl_8 =3D (~aud_schnl_samplerate) <<
> > +                     HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> > +
> > +     /*
> > +      * Refer to IEC60958-3 page 12. We can accept 16 bits or 24 bits.
> > +      * Otherwise, set the register to 0t o indicate using default
> value.
>
> Nit: "0t 0" -> "0 to"
>
> With that fixed, this patch is:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Best regards,
> Jernej
Hi Jernej,
Thank you for reviewing the patch.
But as Russell pointed in the next mail,
I will update in v3 to make this patch much more simpler.

>
> > +      */
> > +     word_length_bits =3D (sample_width =3D=3D 16) ? 0x2 :
> > +                         ((sample_width =3D=3D 24) ? 0xb : 0);
> > +
> > +     aud_schnl_8 |=3D word_length_bits <<
> HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
> > +
> > +     hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
> > +
> >  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> >       unsigned long pixel_clk, unsigned int sample_rate)
> >  {
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> > 6988f12d89d9..619ebc1c8354 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > @@ -158,6 +158,17 @@
> >  #define HDMI_FC_SPDDEVICEINF                    0x1062
> >  #define HDMI_FC_AUDSCONF                        0x1063
> >  #define HDMI_FC_AUDSSTAT                        0x1064
> > +#define HDMI_FC_AUDSV                           0x1065
> > +#define HDMI_FC_AUDSU                           0x1066
> > +#define HDMI_FC_AUDSCHNLS0                      0x1067
> > +#define HDMI_FC_AUDSCHNLS1                      0x1068
> > +#define HDMI_FC_AUDSCHNLS2                      0x1069
> > +#define HDMI_FC_AUDSCHNLS3                      0x106a
> > +#define HDMI_FC_AUDSCHNLS4                      0x106b
> > +#define HDMI_FC_AUDSCHNLS5                      0x106c
> > +#define HDMI_FC_AUDSCHNLS6                      0x106d
> > +#define HDMI_FC_AUDSCHNLS7                      0x106e
> > +#define HDMI_FC_AUDSCHNLS8                      0x106f
> >  #define HDMI_FC_DATACH0FILL                     0x1070
> >  #define HDMI_FC_DATACH1FILL                     0x1071
> >  #define HDMI_FC_DATACH2FILL                     0x1072
> > @@ -706,6 +717,15 @@ enum {
> >  /* HDMI_FC_AUDSCHNLS7 field values */
> >       HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET =3D 4,
> >       HDMI_FC_AUDSCHNLS7_ACCURACY_MASK =3D 0x30,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_MASK =3D 0x0f,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_192K =3D 0xe,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 =3D 0xc,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_96K =3D 0xa,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_768K =3D 0x9,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 =3D 0x8,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_32K =3D 0x3,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_48K =3D 0x2,
> > +     HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 =3D 0x0,
> >
> >  /* HDMI_FC_AUDSCHNLS8 field values */
> >       HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK =3D 0xf0,
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.=
h
> > index cf528c289857..12144d2f80f4 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -156,6 +156,8 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, b=
ool
> > hpd, bool rx_sense);
> >
> >  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
> >  void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt)=
;
> > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> > +                             unsigned int sample_width);
> >  void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int=
 ca);
> > void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
> >  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>
>
>
>
