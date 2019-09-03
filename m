Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB5D21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kIYuXA48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfICJxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:53:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54382 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:53:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id k2so15951794wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3svFEUFdlGRo7s6oU/gAKMoNrDtitSPWMnmTngxdf5A=;
        b=kIYuXA48J8yijkoUvvwSReT8C7vDXIE1MLur0hYz+TkH/SXUuow+Z9RpdecahEHqfT
         gfMPla1YRabYeDgUmmlkI8D2h8jprn/SfljLi+ALfCaC5DkQKMTAK0wMqVl6du0USNUP
         8Q9gmtoY2VKhAzFr3dUpG6KeMi4nQnXYJ//3tyrry7WaQ5cA8e5yAWcsNuXjC2NU6cQ2
         OY1QInnD6h/5eRALoJF5X41M/S+WlVJY7NPvflic7F82lpWhjVR8SpEYC2f2fKFbBKRK
         V97d6ec4ppirWFT5oWkF04LkBSC7guAniEjV1TjuaQn/Ki9QMH3obFR5ePfsUn0aGeOl
         gcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3svFEUFdlGRo7s6oU/gAKMoNrDtitSPWMnmTngxdf5A=;
        b=g2W4FTS3ZAG3/EbuCdI5ZYRO/7N2P+PBdVkKEno4l1zlfdFB1r65Rh/kQeAzlQ4IZE
         wrZm+9YFU49BpIu68PTqpeAohVsuMIRiqO3o5d6aBU45raNlj5E7ljzpUAwZPNtc30fU
         EzrAH0IAJDlv6sTqADHGxW0lNG+sjidZICUG9pCBaBnf7VS/RwPKill48Peun5Yad73q
         pOta2b7ZX/N28QhEPbpN2FVonocN8rB2VrAxL/W8w+mOZkYaL2FYmk+bTiwKAjdjh+jF
         cHF9BwvoTvxa5rj5hIbTRnAV6oFNB+C/tvp4qa0nqLJszZMr1gE8mp5Qp/ZSFj0qRGOI
         pcWA==
X-Gm-Message-State: APjAAAWJ/lqmHtT2kC1ruGZ11HSTX0uuuIwZPPZgJsOBlrzvA6LD9zK7
        Fos2TNi+Z193HqDRBw0ZyGUTsw==
X-Google-Smtp-Source: APXvYqyTtwuHZrhUbdBQZ7Or0d1HOtYQZHQdZrPahyeZ5TF7qNJyfrFtU4pNalcJKWCYtGBlnIJk7Q==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr13960388wmi.12.1567504414674;
        Tue, 03 Sep 2019 02:53:34 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r18sm20184350wrx.36.2019.09.03.02.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 02:53:34 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status
 setting
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tzungbi@chromium.org,
        zhengxing@rock-chips.com, kuninori.morimoto.gx@renesas.com,
        a.hajda@samsung.com, airlied@linux.ie, kuankuan.y@gmail.com,
        jeffy.chen@rock-chips.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, cain.cai@rock-chips.com,
        linux-rockchip@lists.infradead.org, eddie.cai@rock-chips.com,
        Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        Yakir Yang <ykk@rock-chips.com>, enric.balletbo@collabora.com,
        dgreid@chromium.org, sam@ravnborg.org,
        linux-arm-kernel@lists.infradead.org
References: <20190903055103.134764-1-cychiang@chromium.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com>
Date:   Tue, 3 Sep 2019 11:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903055103.134764-1-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/09/2019 07:51, Cheng-Yi Chiang wrote:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> When transmitting IEC60985 linear PCM audio, we configure the
> Audio Sample Channel Status information of all the channel
> status bits in the IEC60958 frame.
> Refer to 60958-3 page 10 for frequency, original frequency, and
> wordlength setting.
> 
> This fix the issue that audio does not come out on some monitors
> (e.g. LG 22CV241)
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index bd65d0479683..34d46e25d610 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
>  	return n;
>  }
>  
> +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
> +{
> +	u8 aud_schnl_samplerate;
> +	u8 aud_schnl_8;
> +
> +	/* These registers are on RK3288 using version 2.0a. */
> +	if (hdmi->version != 0x200a)
> +		return;

Are these limited to the 2.0a version *in* RK3288, or 2.0a version on all
SoCs ?

> +
> +	switch (hdmi->sample_rate) {
> +	case 32000:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
> +		break;
> +	case 44100:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
> +		break;
> +	case 48000:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
> +		break;
> +	case 88200:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
> +		break;
> +	case 96000:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
> +		break;
> +	case 176400:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
> +		break;
> +	case 192000:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
> +		break;
> +	case 768000:
> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
> +		break;
> +	default:
> +		dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n",
> +			 hdmi->sample_rate);
> +		return;
> +	}
> +
> +	/* set channel status register */
> +	hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
> +		  HDMI_FC_AUDSCHNLS7);
> +
> +	/*
> +	 * Set original frequency to be the same as frequency.
> +	 * Use one-complement value as stated in IEC60958-3 page 13.
> +	 */
> +	aud_schnl_8 = (~aud_schnl_samplerate) <<
> +			HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
> +
> +	/* This means word length is 16 bit. Refer to IEC60958-3 page 12. */
> +	aud_schnl_8 |= 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
> +
> +	hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
> +}
> +
>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>  	unsigned long pixel_clk, unsigned int sample_rate)
>  {
> @@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>  	hdmi->audio_cts = cts;
>  	hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
>  	spin_unlock_irq(&hdmi->audio_lock);
> +
> +	hdmi_set_schnl(hdmi);
>  }
>  
>  static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
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
>  	HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
>  	HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
> +	HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
>  
>  /* HDMI_FC_AUDSCHNLS8 field values */
>  	HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,
> 

