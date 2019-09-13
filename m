Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD3C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE74208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="usywg2vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfIMIqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:46:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40790 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIMIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:46:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id l3so8491066wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GzIH6oiBi70p/v479m1IVvyZsoprTy/n2kolGjI6PJ0=;
        b=usywg2vtWrZ3CrJygqz+cMxJ2GJfW/aKureTUYjWcVrLQM68WGD4li+WbML7/zP8fz
         H40NRgA455aa7v/qheQUrHVYvSDOPZv5Q2CH0i5Z/Gfs0o4C/PnuUQ5JqEUawUFpMRKv
         JwxVk8BB5qZ7UBELb5sf0YAY4f+BIC8smvYIAwF4p4CtXP/bR6orQOZqbKUflty6ZNG2
         Uojv/Dea+fFB3Xt/aFKzj7UXHcu0ht4ZIk6ZSDRq9naEclpxZsMmoQaPOgHWvlVXQA1I
         2+oGHR9s7oddt0Yg25NOOwuUpROl2xZPBW0Oo6XRuSqu9ghE5bXarvfN5IRLnwieORvt
         EIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GzIH6oiBi70p/v479m1IVvyZsoprTy/n2kolGjI6PJ0=;
        b=b5eO7Jzyt8tQJryeEhqwqo5ZMnp7L6GSBPO1gGRnTe/f+0jtxLiK9qPJ/3TDOH92Tq
         mKJiVdDvbZD19Skecw8j7o3F9I4ecup30P5XK8AL8ispbfVlLoJzBkenMH5T2Wt3Q4kM
         GJjDfAqKWIBWvBC7qc/tVUOybNUWy+jVNse+67+HdvDaa90nLCaW1p57Vta4RzAlYX2t
         WmnFbgbBfXr7CI9qg6ovNzZiCCcf10IzW4Nid+xxUaO2+czr1OKlRtncX6fgbEB2OChc
         Bq59CBZ9bOEFmOJ3rychL2BOqH2X25fClB6/NkGLuGfNGJU/OTBpApnl+vFP36PQOa3p
         L+sg==
X-Gm-Message-State: APjAAAUFrCw+gTOnF1nxlCReZqa6MVq09fgnyhuE1LcuTrGiWtA7lPzO
        4nJ9dlNCtT/XO/8i1JB0Tm2M5w==
X-Google-Smtp-Source: APXvYqxVYGDhAUAwh7E8NpBq7VN5JG7K5VF+vuH6zorXtEY/Q3wuVryYjx0GGDplWdj2bi67MkpnLg==
X-Received: by 2002:a5d:4444:: with SMTP id x4mr37232191wrr.11.1568364374507;
        Fri, 13 Sep 2019 01:46:14 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r18sm1990649wme.48.2019.09.13.01.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 01:46:13 -0700 (PDT)
Subject: Re: [PATCH v3] drm: bridge/dw_hdmi: add audio sample channel status
 setting
To:     Jonas Karlman <jonas@kwiboo.se>,
        Cheng-yi Chiang <cychiang@chromium.org>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        Xing Zheng <zhengxing@rock-chips.com>,
        "cain.cai@rock-chips.com" <cain.cai@rock-chips.com>,
        =?UTF-8?B?6JSh5p6r?= <eddie.cai@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        "kuankuan.y@gmail.com" <kuankuan.y@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Yakir Yang <ykk@rock-chips.com>
References: <20190911082646.134347-1-cychiang@chromium.org>
 <1e2ec69d-e42d-4e1b-7ce9-d1620cfbb4c9@baylibre.com>
 <10668907.r1TyVuJQb1@jernej-laptop>
 <CAFv8NwJGa0HXsnv2MvJhknpr9PxUL3jH2HZLSLiSD5s_nHiQhQ@mail.gmail.com>
 <HE1PR06MB4011478532D8E127697565EDACB30@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <5f8ec989-9f59-072f-20d4-4cb6ff76a5ac@baylibre.com>
Date:   Fri, 13 Sep 2019 10:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR06MB4011478532D8E127697565EDACB30@HE1PR06MB4011.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 08:37, Jonas Karlman wrote:
> On 2019-09-11 19:02, Cheng-yi Chiang wrote:
>> On Thu, Sep 12, 2019 at 12:54 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>>> Dne sreda, 11. september 2019 ob 18:23:59 CEST je Neil Armstrong napisal(a):
>>>> On 11/09/2019 10:26, Cheng-Yi Chiang wrote:
>>>>> From: Yakir Yang <ykk@rock-chips.com>
>>>>>
>>>>> When transmitting IEC60985 linear PCM audio, we configure the
>>>>> Aduio Sample Channel Status information in the IEC60958 frame.
>>>>> The status bit is already available in iec.status of hdmi_codec_params.
>>>>>
>>>>> This fix the issue that audio does not come out on some monitors
>>>>> (e.g. LG 22CV241)
>>>>>
>>>>> Note that these registers are only for interfaces:
>>>>> I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
>>>>> (AHBAUDDMA).
>>>>> For S/PDIF interface this information comes from the stream.
>>>>>
>>>>> Currently this function dw_hdmi_set_channel_status is only called
>>>>> from dw-hdmi-i2s-audio in I2S setup.
>>>>>
>>>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>>>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>>>>> ---
>>>>>
>>>>> Change from v2 to v3:
>>>>> 1. Reuse what is already set in iec.status in hw_param.
>>>>> 2. Remove all useless definition of registers and values.
>>>>> 3. Note that the original sampling frequency is not written to
>>>>>
>>>>>    the channel status as we reuse create_iec958_consumer in pcm_iec958.c.
>>>>>    Without that it can still play audio fine.
>>>>>
>>>>>  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 20 +++++++++++++++++++
>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  2 ++
>>>>>  include/drm/bridge/dw_hdmi.h                  |  1 +
>>>>>  4 files changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
>>>>> 34d8e837555f..20f4f92dd866 100644
>>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>>>> @@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev,
>>>>> void *data,>
>>>>>     }
>>>>>
>>>>>     dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
>>>>>
>>>>> +   dw_hdmi_set_channel_status(hdmi, hparms->iec.status);
>>>>>
>>>>>     dw_hdmi_set_channel_count(hdmi, hparms->channels);
>>>>>     dw_hdmi_set_channel_allocation(hdmi, hparms-
>>>> cea.channel_allocation);
>>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>>>> bd65d0479683..aa7efd4da1c8 100644
>>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>>> @@ -582,6 +582,26 @@ static unsigned int hdmi_compute_n(unsigned int freq,
>>>>> unsigned long pixel_clk)>
>>>>>     return n;
>>>>>
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * When transmitting IEC60958 linear PCM audio, these registers allow to
>>>>> + * configure the channel status information of all the channel status
>>>>> + * bits in the IEC60958 frame. For the moment this configuration is only
>>>>> + * used when the I2S audio interface, General Purpose Audio (GPA),
>>>>> + * or AHB audio DMA (AHBAUDDMA) interface is active
>>>>> + * (for S/PDIF interface this information comes from the stream).
>>>>> + */
>>>>> +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
>>>>> +                           u8 *channel_status)
>>>>> +{
>>>>> +   /*
>>>>> +    * Set channel status register for frequency and word length.
>>>>> +    * Use default values for other registers.
>>>>> +    */
>>>>> +   hdmi_writeb(hdmi, channel_status[3], HDMI_FC_AUDSCHNLS7);
>>>>> +   hdmi_writeb(hdmi, channel_status[4], HDMI_FC_AUDSCHNLS8);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
>>>>> +
>>>>>
>>>>>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>>>>>
>>>>>     unsigned long pixel_clk, unsigned int sample_rate)
>>>>>
>>>>>  {
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h index
>>>>> 6988f12d89d9..fcff5059db24 100644
>>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>>>>> @@ -158,6 +158,8 @@
>>>>>
>>>>>  #define HDMI_FC_SPDDEVICEINF                    0x1062
>>>>>  #define HDMI_FC_AUDSCONF                        0x1063
>>>>>  #define HDMI_FC_AUDSSTAT                        0x1064
>>>>>
>>>>> +#define HDMI_FC_AUDSCHNLS7                      0x106e
>>>>> +#define HDMI_FC_AUDSCHNLS8                      0x106f
>>>>>
>>>>>  #define HDMI_FC_DATACH0FILL                     0x1070
>>>>>  #define HDMI_FC_DATACH1FILL                     0x1071
>>>>>  #define HDMI_FC_DATACH2FILL                     0x1072
>>>>>
>>>>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>>>>> index cf528c289857..4b3e863c4f8a 100644
>>>>> --- a/include/drm/bridge/dw_hdmi.h
>>>>> +++ b/include/drm/bridge/dw_hdmi.h
>>>>> @@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool
>>>>> hpd, bool rx_sense);>
>>>>>  void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
>>>>>  void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
>>>>>
>>>>> +void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi, u8
>>>>> *channel_status);
>>>>>
>>>>>  void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int
>>>>>  ca);
>>>>>  void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
>>>>>  void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>>>> Looks fine for me:
>>>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>> Jonas ? Jernej ? Russell ?
>>> Patch itself is fine, I'm just wondering if more information should be copied
>>> from status array to registers. But I think they are not 1:1 mapping so some
>>> more work would be needed. Anyway, patch is:
>> Hi Jernej,
>> Yes you are right. I was thinking about the same thing.
>> But there are also some fields in the IEC60958 spec not mapped to the
>> registers on dw-hdmi.
>> So I ended up just writing the two registers in the original ykk's
>> patch, and ignoring "original sampling frequency" like pcm_iec958.
>> It turns out that audio plays fine on my LG monitor. So I suggest we
>> can keep this patch as simple as it is, and add more register setting
>> if we find issue.
>> Thanks!
> 
> In my old multi-channel lpcm patch [1] I only wrote sample rate to FC_AUDSCHNLS7.
> This is much cleaner and simpler, and setting FC_AUDSCHNLS8 does not cause any
> problems when I tested on ASUS Tinker Board S (RK3288).
> 
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> 
> 
> [1] https://github.com/Kwiboo/linux-rockchip/commit/4af9ebc567ccf0a0851fa260097021c27aebbb6b

Thanks Jonas, Jernej,

Applying now.

Neil

> 
> Regards,
> Jonas
> 
>>
>>>
>>> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>>
>>> Best regards,
>>> Jernej
>>>
>>>> If it's ok for you I'll apply it.
>>>>
>>>> Neil
>>>>

