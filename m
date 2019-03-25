Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78D42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YmujF8z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbfCYMMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:12:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38428 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfCYMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:12:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so8765339wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7oJ2BJ9gAnWC5l0oDNzudy1JGSpF+W2Z+dx7/swBhBI=;
        b=YmujF8z8ja/YFjxXEZ1e6e9Omt/NGXZoF7jS7jDGafTxmxT+36HQoAvyfaVzxTDCYB
         vIvFr3R+OJUYt5hzha5bBi5VbkdTZl2yE62wtQYYLT9TKKIA0qa7CN6Rp8jrrjnNQ30r
         C+dTYxrPc0iIw5P/PeLqnG5m1Ix4LDYxyz1TrIY55sKKO8o0lv8WlpzVHsGk/z1ajrHH
         7VIxFJd6HcAnRABw6Rb7chlz5TJ5gFIT0Th/D/YtqgC1Z36D4pDhT0ToLWLZ16FF1tqQ
         7KKJnPFN0eS9wusgMdw84Wunl3qLgVXAvyDS7z4uXx6w6j0iYSb/khGE3sPIZ3dpdiS/
         7TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7oJ2BJ9gAnWC5l0oDNzudy1JGSpF+W2Z+dx7/swBhBI=;
        b=NzKpqHeuNzKOqyfUQx3UVfSh8JnV5d6c0jcKxA1OLSbI4DttpU2f5sIaC6jTuoAuua
         pFPZaCoWjfNBrYJCEzuBf661GW2PjEaeejyXk+kjqh59KN1b8KahFuDZw9okPSkI6TJz
         +csh0CLZ5RgsRUF794f3UpJS5gZIzXZddSllvTTkjnjaS/5G7ac096ZkHrNQXlyRr4Rd
         8OpHHd5CYzRxWXR35R8Z3qKFXoQs852ydzUJG07ADJ2P16HIX0a4PETT82d0PveVGimP
         tPvRfhB5ERWnTXk3WeJm+9ewdTaAPwW2XPXm4MQ2abb2deYX+/fGy8PpZHQWc302JvZD
         2x+g==
X-Gm-Message-State: APjAAAXAqgXFPdvz3Z/3h8yrs6ppzmcuyUdrYgW9H6GxzK/2Ni2EA9LE
        YZGELZ+/+7lCVBBy0fEcAXkfKRzNtJEhZA==
X-Google-Smtp-Source: APXvYqwo/fHMLTpR0sXlXH0CmI/n6LPrQXevbEEOA3dyBdVWNSrVlW5Bd2PFNVV4KQ8EXUl4tr1jrw==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr4808840wmg.109.1553515930149;
        Mon, 25 Mar 2019 05:12:10 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h7sm18734126wmb.41.2019.03.25.05.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 05:12:09 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: disable SCDC configuration for
 invalid setups
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent.pinchart@ideasonboard.com, heiko@sntech.de, robh@kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
References: <CGME20190315095421epcas4p3321555f6918dc4e420acdbf23121338f@epcas4p3.samsung.com>
 <20190315095414.28520-1-narmstrong@baylibre.com>
 <6faa365e-2a4d-3666-b00f-79f36258106c@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c771a0a0-e62e-db7e-b3f7-6ff3f4a915d8@baylibre.com>
Date:   Mon, 25 Mar 2019 13:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6faa365e-2a4d-3666-b00f-79f36258106c@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 12:37, Andrzej Hajda wrote:
> On 15.03.2019 10:54, Neil Armstrong wrote:
>> This patch is an attempt to limit HDMI 2.0 SCDC setup when :
>> - the SoC embeds an HDMI 1.4 only controller
>> - the EDID supports SCDC but not scrambling
>> - the EDID supports SCDC scrambling but not for low TMDS bit rates,
>>   while only supporting low TMDS bit rates
>>
>> This to avoid communicating with the SCDC DDC slave uncessary, and
>> setting the DW-HDMI TMDS Scrambler setup when not supported by the
>> underlying hardware.
>>
>> Reported-by: Rob Herring <robh@kernel.org>
>> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>
>> Rob,
>>
>> this patch should also solve your issue with your 11' display, could you
>> test it ?
>> If this works, I will focus on the underlying issue where the RK3399 SoC
>> freezes in your setup.
>>
>> Thanks,
>> Neil
>>
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index a63e5f0dae56..db761329a1e3 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -1037,6 +1037,31 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>>  }
>>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>>  
>> +/* Filter out invalid setups to avoid configuring SCDC and scrambling */
>> +static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
>> +{
>> +	struct drm_display_info *display = &hdmi->connector.display_info;
>> +
>> +	/* Completely disable SCDC support for older controllers */
>> +	if (hdmi->version < 0x200a)
>> +		return false;
>> +
>> +	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
>> +	if (!display->hdmi.scdc.supported ||
>> +	    !display->hdmi.scdc.scrambling.supported)
>> +		return false;
>> +
>> +	/*
>> +	 * Disable if display only support low TMDS rates and scrambling
>> +	 * for low rates is not supported either
>> +	 */
>> +	if (!display->hdmi.scdc.scrambling.low_rates &&
>> +	    display->max_tmds_clock <= 340000)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  /*
>>   * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
>>   * - The Source shall suspend transmission of the TMDS clock and data
>> @@ -1055,7 +1080,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
>>  	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
>>  
>>  	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
>> -	if (hdmi->connector.display_info.hdmi.scdc.supported) {
>> +	if (dw_hdmi_support_scdc(hdmi)) {
>>  		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
>>  			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
>>  		else
>> @@ -1579,8 +1604,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>  
>>  	/* Set up HDMI_FC_INVIDCONF */
>>  	inv_val = (hdmi->hdmi_data.hdcp_enable ||
>> -		   vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>> -		   hdmi_info->scdc.scrambling.low_rates ?
>> +		   (dw_hdmi_support_scdc(hdmi) &&
>> +		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>> +		     hdmi_info->scdc.scrambling.low_rates)) ?
>>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
> 
> 
> The condition is hard to read, but I have no idea atm how make it
> compact and pretty :)

I made my best to make it barely readable...

We may need to reword this condition since on the DW-HMI in the Allwinner
H6, this is no more needed for scrambling !

> 
> Anyway:
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> 
> As I remember you can queue it to drm-misc, if not I can do it, just let
> me know.

I can and I'm queuing it right now, thanks for the review !

Neil

> 
> 
>  --
> Regards
> Andrzej
> 
> 
> 
>>  
>> @@ -1646,7 +1672,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>  	}
>>  
>>  	/* Scrambling Control */
>> -	if (hdmi_info->scdc.supported) {
>> +	if (dw_hdmi_support_scdc(hdmi)) {
>>  		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>>  		    hdmi_info->scdc.scrambling.low_rates) {
>>  			/*
> 
> 

