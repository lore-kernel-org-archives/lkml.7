Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD25C3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F0206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a6trZidW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfICSAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:00:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45762 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfICSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:00:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id l16so143966wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=37SefE7uDW3/2543D3S+Jjxtsd+Rc7zPMQ8aAVy3HYY=;
        b=a6trZidWLAU9k7WRqdOQkCp9IdBEaDzcgHqsL+Wg97VV82pRlcP/uF/Jq3uAPV0B21
         sZ+2b9hn6RiyX3XhHnNaYqno6BP9dPMStmpZMAYVv2v7nCf5yt2ZtVJi6APjmy0gHVQu
         1V6ubbF5EwXHl+ub5YSr/oDKcc1c8VXqK5hcGcaAckmrT5y6UIoQnVsLWcYtWJC6JidG
         FzCF4eFaQM9DbZDOPe+qkEimC5KRhKwxWihBUoTwqPMYKrhGm3uVpICEIMWurhFwuftm
         OpxFJ+ksniPK9AfZAMnAMDM55S36oWoCjHAIY8pb1TZAHL1cYwHhZZprWAXlO0QHKBsL
         nTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=37SefE7uDW3/2543D3S+Jjxtsd+Rc7zPMQ8aAVy3HYY=;
        b=qYWkNK2LXEJyp6hYnyXb0aRR5s8quX1DVUcBrDOWdqKvPRIcLu0DoJW9uTafigwPNg
         QChrDiblkaF/DI47DB79xwXq0j3wrSQQquqUVBJTdHm9NnWKKd3oRClhcGbCBgyOoOw+
         tjBq9FgnuQPS0wYv9A0TRIpVzcYtlba22bR3CQwo54RpGj6pKJ5TA1cozRCH6JxLJVcu
         UCqS4fPeXhWKeEcDCxl46x1dMaDsWqSIDgxyuX/9w8y9M0e6Ixll1sjwxdbJSmBjtrnm
         6M7W2Yccg31OJPwWL2VtWeTGVzyAGVoKGAF9lTiuYiXmrNzNrasI6kLKLdqUQEmklYdg
         PfNA==
X-Gm-Message-State: APjAAAW/kJfnKj9URB+ItEeDEYN2gJ4g4Dj76368pSsGQypaCWG44Ti/
        7ZzvkRQvaMJSNtplCB2S1vN1hQ==
X-Google-Smtp-Source: APXvYqxw3MV79DlvDFQWO4+qFsE5JSOgoXa8EiuxVbez3UimtQqAtUACsAkfp1LMmbPSsVF3pmpGBw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr2224852wrx.309.1567533636499;
        Tue, 03 Sep 2019 11:00:36 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id v6sm473623wma.24.2019.09.03.11.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:00:35 -0700 (PDT)
Subject: Re: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status
 setting
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>
References: <20190903055103.134764-1-cychiang@chromium.org>
 <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com>
Cc:     alsa-devel@alsa-project.org, tzungbi@chromium.org,
        zhengxing@rock-chips.com, kuninori.morimoto.gx@renesas.com,
        a.hajda@samsung.com, airlied@linux.ie, kuankuan.y@gmail.com,
        jeffy.chen@rock-chips.com, dianders@chromium.org,
        cain.cai@rock-chips.com, linux-rockchip@lists.infradead.org,
        eddie.cai@rock-chips.com, Laurent.pinchart@ideasonboard.com,
        daniel@ffwll.ch, Yakir Yang <ykk@rock-chips.com>,
        enric.balletbo@collabora.com, dgreid@chromium.org,
        sam@ravnborg.org, linux-arm-kernel@lists.infradead.org
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <d8a80ba5-dd2b-f84d-bbfc-9dd5ccbc26e9@baylibre.com>
Date:   Tue, 3 Sep 2019 20:00:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <e1c3483c-baa6-c726-e547-fadf40d259f4@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 03/09/2019 à 11:53, Neil Armstrong a écrit :
> Hi,
> 
> On 03/09/2019 07:51, Cheng-Yi Chiang wrote:
>> From: Yakir Yang <ykk@rock-chips.com>
>>
>> When transmitting IEC60985 linear PCM audio, we configure the
>> Audio Sample Channel Status information of all the channel
>> status bits in the IEC60958 frame.
>> Refer to 60958-3 page 10 for frequency, original frequency, and
>> wordlength setting.
>>
>> This fix the issue that audio does not come out on some monitors
>> (e.g. LG 22CV241)
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 +++++++++++++++++++++++
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
>>  2 files changed, 79 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index bd65d0479683..34d46e25d610 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
>>  	return n;
>>  }
>>  
>> +static void hdmi_set_schnl(struct dw_hdmi *hdmi)
>> +{
>> +	u8 aud_schnl_samplerate;
>> +	u8 aud_schnl_8;
>> +
>> +	/* These registers are on RK3288 using version 2.0a. */
>> +	if (hdmi->version != 0x200a)
>> +		return;
> 
> Are these limited to the 2.0a version *in* RK3288, or 2.0a version on all
> SoCs ?

After investigations, Amlogic sets these registers on their 2.0a version
aswell, and Jernej (added in Cc) reported me Allwinner sets them on their
< 2.0a and > 2.0a IPs versions.

Can you check on the Rockchip IP versions in RK3399 ?

For reference, the HDMI 1.4a IP version allwinner setups is:
https://github.com/Allwinner-Homlet/H3-BSP4.4-linux/blob/master/drivers/video/fbdev/sunxi/disp2/hdmi/hdmi_bsp_sun8iw7.c#L531-L539
(registers a "scrambled" but a custom bit can reset to the original mapping,
0x1066 ... 0x106f)

Neil

> 
>> +
>> +	switch (hdmi->sample_rate) {
>> +	case 32000:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
>> +		break;
>> +	case 44100:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
>> +		break;
>> +	case 48000:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
>> +		break;
>> +	case 88200:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
>> +		break;
>> +	case 96000:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
>> +		break;
>> +	case 176400:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
>> +		break;
>> +	case 192000:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
>> +		break;
>> +	case 768000:
>> +		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
>> +		break;
>> +	default:
>> +		dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n",
>> +			 hdmi->sample_rate);
>> +		return;
>> +	}
>> +
>> +	/* set channel status register */
>> +	hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
>> +		  HDMI_FC_AUDSCHNLS7);
>> +
>> +	/*
>> +	 * Set original frequency to be the same as frequency.
>> +	 * Use one-complement value as stated in IEC60958-3 page 13.
>> +	 */
>> +	aud_schnl_8 = (~aud_schnl_samplerate) <<
>> +			HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
>> +
>> +	/* This means word length is 16 bit. Refer to IEC60958-3 page 12. */
>> +	aud_schnl_8 |= 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
>> +
>> +	hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
>> +}
>> +
>>  static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>>  	unsigned long pixel_clk, unsigned int sample_rate)
>>  {
>> @@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>>  	hdmi->audio_cts = cts;
>>  	hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
>>  	spin_unlock_irq(&hdmi->audio_lock);
>> +
>> +	hdmi_set_schnl(hdmi);
>>  }
>>  
>>  static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> index 6988f12d89d9..619ebc1c8354 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
>> @@ -158,6 +158,17 @@
>>  #define HDMI_FC_SPDDEVICEINF                    0x1062
>>  #define HDMI_FC_AUDSCONF                        0x1063
>>  #define HDMI_FC_AUDSSTAT                        0x1064
>> +#define HDMI_FC_AUDSV                           0x1065
>> +#define HDMI_FC_AUDSU                           0x1066
>> +#define HDMI_FC_AUDSCHNLS0                      0x1067
>> +#define HDMI_FC_AUDSCHNLS1                      0x1068
>> +#define HDMI_FC_AUDSCHNLS2                      0x1069
>> +#define HDMI_FC_AUDSCHNLS3                      0x106a
>> +#define HDMI_FC_AUDSCHNLS4                      0x106b
>> +#define HDMI_FC_AUDSCHNLS5                      0x106c
>> +#define HDMI_FC_AUDSCHNLS6                      0x106d
>> +#define HDMI_FC_AUDSCHNLS7                      0x106e
>> +#define HDMI_FC_AUDSCHNLS8                      0x106f
>>  #define HDMI_FC_DATACH0FILL                     0x1070
>>  #define HDMI_FC_DATACH1FILL                     0x1071
>>  #define HDMI_FC_DATACH2FILL                     0x1072
>> @@ -706,6 +717,15 @@ enum {
>>  /* HDMI_FC_AUDSCHNLS7 field values */
>>  	HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
>>  	HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
>> +	HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
>>  
>>  /* HDMI_FC_AUDSCHNLS8 field values */
>>  	HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,
>>
> 
