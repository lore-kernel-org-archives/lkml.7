Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73399C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C527222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gFKlDB2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfHGQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:10:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55037 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbfHGQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:10:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so596652wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hlSWtDwSPE4Pmk3/sDtCGZsiLitnnV87ZRM8NGe3v3M=;
        b=gFKlDB2ITdLj68HNtJKA2pzG2/Sim66z+OkDewePPW0xFca+Yj18mNmLivQa1a2pf+
         47Hk5UfXXtSgliEy6sngG2otKJhcNGuFPjitwUhLB5HcRRLrQvjWQmmHzRRN0bD5MeDt
         5sP9oBoqmwhChotBfZ6QMi4hR4qt3TdUWAIRnpNdnGNW4rOYlpQ68ChOTdVOSM6qBAPc
         K6ax84orouPXP0Mr6Vhuqu6MEgqtnLXP+HVFGHevRd6Pe7miu7tsagEVCZ1Xo/a+sgkg
         7lj0GSylVy8BfjNg++PxZ8ebOq0wedQqb+MkhALM1YPg5Vihk/dyMY/UY4fqCLXyGH8t
         X+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hlSWtDwSPE4Pmk3/sDtCGZsiLitnnV87ZRM8NGe3v3M=;
        b=NCwXaI+aKMn+7aAS0sApIhYTEzh5N/iNVt4M7CshEIKOfkZYM59iNLfateOb4e8OBp
         2GRwGuSmc+jPpT4605Rmwi6SNvepZU5wQQGPsP3I++jEkDIk0Hrvf46onwVt8ho4j/VU
         EDeNkhsp/82xUExQOa06eSONbdwIU4LBaEn3ehFpT7VOaL9GU8hLG3BTdKjdWIhj0xht
         WL/UiMRSy391JpA61ZtzUh0DG86YehyZ3/tLkX1R0mkT4bFTDYaQZOBfKr5X0UeW7mZS
         QuG2sK9monGtti3xJA+mfsvtW3B7tduMB7l5OfaUbLqdYmNtVfAUsLPvG4LDCEwwhiNH
         R22A==
X-Gm-Message-State: APjAAAWQTBqj0zai82KrJWqDhOQqnUFtJ7S8xtSg6CyU8lV9qhC+gFsK
        x+xT5dTVSMQZRqgo0YUblRKqsA==
X-Google-Smtp-Source: APXvYqynud8VhJ6A2hlYKAMd6gZnDv/ct0dk8RTh9P8YL0GThFsRGcFMNp8+zILRF+Zn5Y5aHxQP0w==
X-Received: by 2002:a1c:3d82:: with SMTP id k124mr669567wma.17.1565194247593;
        Wed, 07 Aug 2019 09:10:47 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g19sm161684633wrb.52.2019.08.07.09.10.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 09:10:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "linux-amlogic\@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
In-Reply-To: <HE1PR06MB40117A899E057B36BE461B8EACD40@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <20190805134102.24173-1-jbrunet@baylibre.com> <20190805134102.24173-9-jbrunet@baylibre.com> <HE1PR06MB40117A899E057B36BE461B8EACD40@HE1PR06MB4011.eurprd06.prod.outlook.com>
Date:   Wed, 07 Aug 2019 18:10:45 +0200
Message-ID: <1jy305negq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Aug 2019 at 14:57, Jonas Karlman <jonas@kwiboo.se> wrote:

> On 2019-08-05 15:41, Jerome Brunet wrote:
>> Provide the eld to the generic hdmi-codec driver.
>> This will let the driver enforce the maximum channel number and set the
>> channel allocation depending on the hdmi sink.
>>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  1 +
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 10 ++++++++++
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
>> index 63b5756f463b..cb07dc0da5a7 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
>> @@ -14,6 +14,7 @@ struct dw_hdmi_audio_data {
>>  
>>  struct dw_hdmi_i2s_audio_data {
>>  	struct dw_hdmi *hdmi;
>> +	u8 *eld;
>>  
>>  	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
>>  	u8 (*read)(struct dw_hdmi *hdmi, int offset);
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>> index b8ece9c1ba2c..14d499b344c0 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>> @@ -121,6 +121,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
>>  	dw_hdmi_audio_disable(hdmi);
>>  }
>>  
>> +static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
>> +			       size_t len)
>> +{
>> +	struct dw_hdmi_i2s_audio_data *audio = data;
>> +
>> +	memcpy(buf, audio->eld, min(sizeof(audio->eld), len));
>
> Above sizeof does not work as intended, sizeof(audio->eld) is probably the size of a pointer and not MAX_ELD_BYTES (128),
> resulting in only part of the ELD gets copied to buf.

Silly ... thanks for pointing this out. I'll respin

>
>
> Thanks for reworking dw-hdmi multi channel lpcm support!, this works on Rockchip for most parts.
> Without the [1] patch (reset cts+n after clock is enabled) audio sometime stay silent when switching between e.g. 2ch 44.1khz and 6ch 48khz tracks.
> It is not fully clear to me why reset cts+n helps, if that have
> negative affects on other platforms or if there is another way to
> solve loosing audio.

I did not see that issue my self but I guess could propose this change ?

>
> I also have a small issue with the channel allocation being selected by hdmi-codec, my soundbar reports LPCM 6.1ch instead of LPCM 7.1ch when I play a 7.1ch speaker test clip.
> I have a hdmi-codec patch to fix selection of channel allocation in
> queue.

Yes, I know there is still a few problems around that and stale eld.
But those problem are not really coming from the i2s interface of the
dw-hdmi itself and should be dealt with separatly.

This is just the beginning ;)

>
>
> For patch 1-7:
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
>
> [1] https://github.com/Kwiboo/linux-rockchip/commit/c0839e874f843ad173ddde958303d6878394ef92
>
> Regards,
> Jonas
>
>> +	return 0;
>> +}
>> +
>>  static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>>  				  struct device_node *endpoint)
>>  {
>> @@ -144,6 +153,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
>>  	.hw_params	= dw_hdmi_i2s_hw_params,
>>  	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
>> +	.get_eld	= dw_hdmi_i2s_get_eld,
>>  	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
>>  };
>>  
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index bed4bb017afd..8df69c9dbfad 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2797,6 +2797,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  		struct dw_hdmi_i2s_audio_data audio;
>>  
>>  		audio.hdmi	= hdmi;
>> +		audio.eld	= hdmi->connector.eld;
>>  		audio.write	= hdmi_writeb;
>>  		audio.read	= hdmi_readb;
>>  		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
