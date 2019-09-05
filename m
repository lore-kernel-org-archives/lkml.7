Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C9A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WvjhViaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfIEJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:46:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33673 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfIEJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:46:07 -0400
Received: by mail-ua1-f66.google.com with SMTP id g11so575538uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvRuIiqr/iKDV9aDWNlA8RrVDzREyScOlO/Z/R/SMk4=;
        b=WvjhViaVgl8x/auA7N3QoKa0pWASaXMpbqUiOjnZ1p3FYEgVVpJk0NHs6ARa3J/Mxc
         XbKEEFE7HfHLJL9pmMO/200PoywVrY3+4VKXW1BHqK01NlXD7cac0nZ89ATICbDRVbNB
         u+NLABTZnHIlKpb9pp2K/1XSrdisQsUgmUjeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvRuIiqr/iKDV9aDWNlA8RrVDzREyScOlO/Z/R/SMk4=;
        b=pDdW/zxV23naISXHnYeKbsPk0sUDReuXA5jrjwu2giABTHxkfe7SouL/pUnOS9sHFA
         6GDmWEcBvVCdC8kQxmXEDz8LKYefcoX2iB6ik7Wo5r/2nSu+hbY8CbCCISg8qfXiVjjV
         UW864Ib1IXz4E8s9MuxmlZiq0rAIoPvaQf8YQ7yeQNtJapZPRIZ9B2DEUaXU9oB1H+R8
         1LCANIh+tUgyCvIog9A9fwqfCRcsanQ+QSxJHDg8E40MJsXTRTcFSLaiCTqg3+JqSNFe
         GP4AHcxIVH8pdPcVE65k2DvEq9+femaC6KJnDgk0SYceuObfdtvix517/cY/FEud2hpa
         gw5A==
X-Gm-Message-State: APjAAAWwLtJRkgdi81nNV3KvvU/RjFhfqgezqWCQKH1ijG4Whxbp9m3l
        2dwYnXofCRCYzHe8WCRWbzSqrdDGnpGSAE3kYqzGO1aLWbnjiw==
X-Google-Smtp-Source: APXvYqwTvrQBn97z7rYT9ixy7UM/J7TliVkIaqrac8Xre+AMHO1uYOYzHMZzz7mlfTa7CsgN/vA8J0CGaj70IMm0CYI=
X-Received: by 2002:a9f:2924:: with SMTP id t33mr921037uat.69.1567676765459;
 Thu, 05 Sep 2019 02:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190905094325.33156-1-cychiang@chromium.org>
In-Reply-To: <20190905094325.33156-1-cychiang@chromium.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Thu, 5 Sep 2019 17:45:38 +0800
Message-ID: <CAFv8NwJ_3OQgNsim74u-Z3UHyY4OyTJ8Y8JeBSx9m0aWvnmNZA@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge/dw_hdmi: add audio sample channel status setting
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yakir Yang <ykk@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise.
Removed original author ykk@rock-chips.com from the thread because
that mail is obsolete.
Yakir is now using kuankuan.y@gmail.com.


On Thu, Sep 5, 2019 at 5:43 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> From: Yakir Yang <ykk@rock-chips.com>
>
> When transmitting IEC60985 linear PCM audio, we configure the
> Aduio Sample Channel Status information of all the channel
> status bits in the IEC60958 frame.
> Refer to 60958-3 page 10 for frequency, original frequency, and
> wordlength setting.
>
> This fix the issue that audio does not come out on some monitors
> (e.g. LG 22CV241)
>
> Note that these registers are only for interfaces:
> I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
> (AHBAUDDMA).
> For S/PDIF interface this information comes from the stream.
>
> Currently this function dw_hdmi_set_channel_status is only called
> from dw-hdmi-i2s-audio in I2S setup.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Original patch by Yakir Yang is at
>
>  https://lore.kernel.org/patchwork/patch/539653/
>
>  Change from v1 to v2:
>  1. Remove the version check because this will only be called by
>     dw-hdmi-i2s-audio, and the registers are available in I2S setup.
>  2. Set these registers in dw_hdmi_i2s_hw_params.
>  3. Fix the sample width setting so it can use 16 or 24 bits.
>
>  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 70 +++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     | 20 ++++++
>  include/drm/bridge/dw_hdmi.h                  |  2 +
>  4 files changed, 93 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 34d8e837555f..b801a28b0f17 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
>         }
>
>         dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
> +       dw_hdmi_set_channel_status(hdmi, hparms->sample_width);
>         dw_hdmi_set_channel_count(hdmi, hparms->channels);
>         dw_hdmi_set_channel_allocation(hdmi, hparms->cea.channel_allocation);
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index bd65d0479683..d1daa369c8ae 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -582,6 +582,76 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
>         return n;
>  }
>
> +/*
> + * When transmitting IEC60958 linear PCM audio, these registers allow to
> + * configure the channel status information of all the channel status
> + * bits in the IEC60958 frame. For the moment this configuration is only
> + * used when the I2S audio interface, General Purpose Audio (GPA),
> + * or AHB audio DMA (AHBAUDDMA) interface is active
> + * (for S/PDIF interface this information comes from the stream).
> + */
> +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> +                               unsigned int sample_width)
> +{
> +       u8 aud_schnl_samplerate;
> +       u8 aud_schnl_8;
> +       u8 word_length_bits;
> +
> +       switch (hdmi->sample_rate) {
> +       case 32000:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> +               break;
> +       case 44100:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> +               break;
> +       case 48000:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> +               break;
> +       case 88200:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> +               break;
> +       case 96000:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> +               break;
> +       case 176400:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
> +               break;
> +       case 192000:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> +               break;
> +       case 768000:
> +               aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> +               break;
> +       default:
> +               dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n",
> +                        hdmi->sample_rate);
> +               return;
> +       }
> +
> +       /* set channel status register */
> +       hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
> +                 HDMI_FC_AUDSCHNLS7);
> +
> +       /*
> +        * Set original frequency to be the same as frequency.
> +        * Use one-complement value as stated in IEC60958-3 page 13.
> +        */
> +       aud_schnl_8 = (~aud_schnl_samplerate) <<
> +                       HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> +
> +       /*
> +        * Refer to IEC60958-3 page 12. We can accept 16 bits or 24 bits.
> +        * Otherwise, set the register to 0t o indicate using default value.
> +        */
> +       word_length_bits = (sample_width == 16) ? 0x2 :
> +                           ((sample_width == 24) ? 0xb : 0);
> +
> +       aud_schnl_8 |= word_length_bits << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
> +
> +       hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
> +
>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>         unsigned long pixel_clk, unsigned int sample_rate)
>  {
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 6988f12d89d9..619ebc1c8354 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -158,6 +158,17 @@
>  #define HDMI_FC_SPDDEVICEINF                    0x1062
>  #define HDMI_FC_AUDSCONF                        0x1063
>  #define HDMI_FC_AUDSSTAT                        0x1064
> +#define HDMI_FC_AUDSV                           0x1065
> +#define HDMI_FC_AUDSU                           0x1066
> +#define HDMI_FC_AUDSCHNLS0                      0x1067
> +#define HDMI_FC_AUDSCHNLS1                      0x1068
> +#define HDMI_FC_AUDSCHNLS2                      0x1069
> +#define HDMI_FC_AUDSCHNLS3                      0x106a
> +#define HDMI_FC_AUDSCHNLS4                      0x106b
> +#define HDMI_FC_AUDSCHNLS5                      0x106c
> +#define HDMI_FC_AUDSCHNLS6                      0x106d
> +#define HDMI_FC_AUDSCHNLS7                      0x106e
> +#define HDMI_FC_AUDSCHNLS8                      0x106f
>  #define HDMI_FC_DATACH0FILL                     0x1070
>  #define HDMI_FC_DATACH1FILL                     0x1071
>  #define HDMI_FC_DATACH2FILL                     0x1072
> @@ -706,6 +717,15 @@ enum {
>  /* HDMI_FC_AUDSCHNLS7 field values */
>         HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
>         HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
> +       HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
>
>  /* HDMI_FC_AUDSCHNLS8 field values */
>         HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index cf528c289857..12144d2f80f4 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -156,6 +156,8 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
>
>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
>  void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
> +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
> +                               unsigned int sample_width);
>  void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int ca);
>  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
>  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
> --
> 2.23.0.187.g17f5b7556c-goog
>
