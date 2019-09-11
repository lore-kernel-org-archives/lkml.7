Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD35C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4336021479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+nLvmJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfIKRDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:03:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42997 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfIKRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:03:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id w16so7016896uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=buUqc8ERVmqHmMW6WwjRVMJPzy7dr7EKMl9vRpwJpZM=;
        b=Z+nLvmJsUyDmb3Z8llyNwlmD2jVrnXGV2ode7JUJ0CBsoLN0QQqjF/H/3gDTLg6VDJ
         jXit3LAhfojKsULrELXKF1wwGBp8vNz5EVM7DcARGt0ByQSpvOJ48NQVf6fQWh/Zujp+
         cBblUSKAe177/psfJfCGsbkuJOHDOsO5Qb/yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=buUqc8ERVmqHmMW6WwjRVMJPzy7dr7EKMl9vRpwJpZM=;
        b=PRVKvj/2IAII+sdrw3p0JG0f1CEJ5qnb/GSN7ppLw5oHyFkJ4FuW2W3rOmrFqsOO8G
         KUVQsuBAj6cZKKYObN/hpqHjl8PbFIfLMI/vfFGF2QxOiK0aXMTbIIHQG2sZA08EWCya
         CacAWvOP/dO/TePmNQvI0KxNrvEpmCQI8RleTD764F9kjhuhv6gdSOL3L92ae6bKHKHv
         5YpMrTNyHY1n3myMi7FHdszze5TFj6vUOS/PR+s3EdQaXiAktJHoPP/VUTJucUWwukTd
         6o7Mg7yEKMjp2gZligmaGcfuVbYpWscUC/RCWiZ/Q+b0xr7ti04IzjUsGGhAW4jLoERr
         Tzpg==
X-Gm-Message-State: APjAAAXEYm5rH19HPqfiEj3aASbKmXU83BlnyQ/nxPZwBIh55MdRP9cz
        LCJpEsVbruDTyxqSrxYZGVMwJisDe2rFOQxuQjvYcBGsFVQZSw==
X-Google-Smtp-Source: APXvYqyHbuhYljIhllMZZXCEGHUZOYmQOMAogOruLFfO7e3oALf2ZphzQ2tT6Oy4Xky7aPF4tOyye2GIxWQClO2dXQ0=
X-Received: by 2002:ab0:604a:: with SMTP id o10mr4566868ual.105.1568221385686;
 Wed, 11 Sep 2019 10:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190911082646.134347-1-cychiang@chromium.org>
 <1e2ec69d-e42d-4e1b-7ce9-d1620cfbb4c9@baylibre.com> <10668907.r1TyVuJQb1@jernej-laptop>
In-Reply-To: <10668907.r1TyVuJQb1@jernej-laptop>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Thu, 12 Sep 2019 01:02:38 +0800
Message-ID: <CAFv8NwJGa0HXsnv2MvJhknpr9PxUL3jH2HZLSLiSD5s_nHiQhQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm: bridge/dw_hdmi: add audio sample channel status setting
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        dri-devel@lists.freedesktop.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yakir Yang <ykk@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 12:54 AM Jernej =C5=A0krabec <jernej.skrabec@siol.n=
et> wrote:
>
> Dne sreda, 11. september 2019 ob 18:23:59 CEST je Neil Armstrong napisal(=
a):
> > On 11/09/2019 10:26, Cheng-Yi Chiang wrote:
> > > From: Yakir Yang <ykk@rock-chips.com>
> > >
> > > When transmitting IEC60985 linear PCM audio, we configure the
> > > Aduio Sample Channel Status information in the IEC60958 frame.
> > > The status bit is already available in iec.status of hdmi_codec_param=
s.
> > >
> > > This fix the issue that audio does not come out on some monitors
> > > (e.g. LG 22CV241)
> > >
> > > Note that these registers are only for interfaces:
> > > I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
> > > (AHBAUDDMA).
> > > For S/PDIF interface this information comes from the stream.
> > >
> > > Currently this function dw_hdmi_set_channel_status is only called
> > > from dw-hdmi-i2s-audio in I2S setup.
> > >
> > > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >
> > > Change from v2 to v3:
> > > 1. Reuse what is already set in iec.status in hw_param.
> > > 2. Remove all useless definition of registers and values.
> > > 3. Note that the original sampling frequency is not written to
> > >
> > >    the channel status as we reuse create_iec958_consumer in pcm_iec95=
8.c.
> > >    Without that it can still play audio fine.
> > >
> > >  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 20 +++++++++++++++++=
++
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  2 ++
> > >  include/drm/bridge/dw_hdmi.h                  |  1 +
> > >  4 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> > > 34d8e837555f..20f4f92dd866 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > > @@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *d=
ev,
> > > void *data,>
> > >     }
> > >
> > >     dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
> > >
> > > +   dw_hdmi_set_channel_status(hdmi, hparms->iec.status);
> > >
> > >     dw_hdmi_set_channel_count(hdmi, hparms->channels);
> > >     dw_hdmi_set_channel_allocation(hdmi, hparms-
> >cea.channel_allocation);
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > > bd65d0479683..aa7efd4da1c8 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > @@ -582,6 +582,26 @@ static unsigned int hdmi_compute_n(unsigned int =
freq,
> > > unsigned long pixel_clk)>
> > >     return n;
> > >
> > >  }
> > >
> > > +/*
> > > + * When transmitting IEC60958 linear PCM audio, these registers allo=
w to
> > > + * configure the channel status information of all the channel statu=
s
> > > + * bits in the IEC60958 frame. For the moment this configuration is =
only
> > > + * used when the I2S audio interface, General Purpose Audio (GPA),
> > > + * or AHB audio DMA (AHBAUDDMA) interface is active
> > > + * (for S/PDIF interface this information comes from the stream).
> > > + */
> > > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> > > +                           u8 *channel_status)
> > > +{
> > > +   /*
> > > +    * Set channel status register for frequency and word length.
> > > +    * Use default values for other registers.
> > > +    */
> > > +   hdmi_writeb(hdmi, channel_status[3], HDMI_FC_AUDSCHNLS7);
> > > +   hdmi_writeb(hdmi, channel_status[4], HDMI_FC_AUDSCHNLS8);
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
> > > +
> > >
> > >  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
> > >
> > >     unsigned long pixel_clk, unsigned int sample_rate)
> > >
> > >  {
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
> > > 6988f12d89d9..fcff5059db24 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> > > @@ -158,6 +158,8 @@
> > >
> > >  #define HDMI_FC_SPDDEVICEINF                    0x1062
> > >  #define HDMI_FC_AUDSCONF                        0x1063
> > >  #define HDMI_FC_AUDSSTAT                        0x1064
> > >
> > > +#define HDMI_FC_AUDSCHNLS7                      0x106e
> > > +#define HDMI_FC_AUDSCHNLS8                      0x106f
> > >
> > >  #define HDMI_FC_DATACH0FILL                     0x1070
> > >  #define HDMI_FC_DATACH1FILL                     0x1071
> > >  #define HDMI_FC_DATACH2FILL                     0x1072
> > >
> > > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdm=
i.h
> > > index cf528c289857..4b3e863c4f8a 100644
> > > --- a/include/drm/bridge/dw_hdmi.h
> > > +++ b/include/drm/bridge/dw_hdmi.h
> > > @@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi,=
 bool
> > > hpd, bool rx_sense);>
> > >  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate=
);
> > >  void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cn=
t);
> > >
> > > +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi, u8
> > > *channel_status);
> > >
> > >  void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned i=
nt
> > >  ca);
> > >  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
> > >  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
> >
> > Looks fine for me:
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> >
> > Jonas ? Jernej ? Russell ?
>
> Patch itself is fine, I'm just wondering if more information should be co=
pied
> from status array to registers. But I think they are not 1:1 mapping so s=
ome
> more work would be needed. Anyway, patch is:

Hi Jernej,
Yes you are right. I was thinking about the same thing.
But there are also some fields in the IEC60958 spec not mapped to the
registers on dw-hdmi.
So I ended up just writing the two registers in the original ykk's
patch, and ignoring "original sampling frequency" like pcm_iec958.
It turns out that audio plays fine on my LG monitor. So I suggest we
can keep this patch as simple as it is, and add more register setting
if we find issue.
Thanks!

>
>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Best regards,
> Jernej
>
> >
> > If it's ok for you I'll apply it.
> >
> > Neil
>
>
>
>
