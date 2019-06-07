Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64520C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F39721019
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZfHB7PA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfFGIJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:09:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39417 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:09:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so1172370wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ap0XAetM+pT0J8lzDb15ksHa3sKJqhSdyqZL0XBCEG4=;
        b=ZfHB7PA9Hz6ves72j99VkQp94oROxR3wx2SUlb3gGT3XFITeqkXSLhQ5tkbK3Vxr7X
         vQHIGyuVgENQcIqma1vXhRpu8pSfMWPbSYnNJiJfFzxci9Dvkups+OE6dW8oRbc8UJLB
         Fg4kHSC2AcerCfBDhoEg3tEJ/YcxsbSJwFO21JcKC9dyHxlF73CJtez6rvZ0W5W2yncp
         Msb9YgCmuwmbTGgRbsqYj/rlkslBn2ASoplqc9a3QBSHrMkb/CzQZ8zoeJNJD74v6/jp
         4WsVRVE1AkZh/1KBSAV7DW1tYMu9155X/5MuNmQnJVqW+e26vssRF+Tjar8J1wEGIbk5
         jMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ap0XAetM+pT0J8lzDb15ksHa3sKJqhSdyqZL0XBCEG4=;
        b=a4BvJ1rn9ZEWRv06INp98pk4RwiVje9BKeSsUS4yNf0u8dYj4LmsvLwf3L+R1NexK6
         +9LVhtmQbgJWba/GheVmjwTJqKQufd6uLzBNSVH8E7+MjZoWHmZ7kNMg6dhZlBjPcQVo
         dnLtYlR7Ctl3OwYlX58yUNzLXBQPScNHn6vQQJfAMb1ZprgIXEntUO4uaCVIiaDRl+bx
         mwLar1fsu4ABmnz0XyTNQcRT8+cwIEHhcoaEMSb85Hz8KdTp5yHyCdOnRUsea639PCvZ
         LSqDFJfCnSdyU2+QJNvjq0XGNrsg2Jt7H9Nzn6OD1ddflWpf3xGAd4MkUmkeKw3Ax5sW
         KuiA==
X-Gm-Message-State: APjAAAXAUkhA6Tdh/SGp0JfmPnjMJc//Qo9EJ9iGFIU/BIlJdJCGA/zV
        gHI6Z85v3QIkkcuuEaGD2TAASnbDemvL+A==
X-Google-Smtp-Source: APXvYqxP6A+8A3KS84/Et4P9G/ZJC2IBacGunUaWZeHsk1vVP/T5CFd8ysxnZm05uOsKCYWFFibizg==
X-Received: by 2002:adf:aa09:: with SMTP id p9mr11794798wrd.59.1559894973940;
        Fri, 07 Jun 2019 01:09:33 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r9sm1114935wrq.0.2019.06.07.01.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:09:33 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix G12A HDMI PLL settings for 4K60 1000/1001
 variations
To:     Kevin Hilman <khilman@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190605125320.8708-1-narmstrong@baylibre.com>
 <7hh892fzgj.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <abf63289-dd97-75d7-d3ae-e41e171d59cc@baylibre.com>
Date:   Fri, 7 Jun 2019 10:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7hh892fzgj.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2019 18:30, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> The Amlogic G12A HDMI PLL needs some specific settings to lock with
>> different fractional values for the 5,4GHz mode.
>>
>> Handle the 1000/1001 variation fractional case here to avoid having
>> the PLL in an non lockable state.
>>
>> Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_vclk.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
>> index 44250eff8a3f..83fc2fc82001 100644
>> --- a/drivers/gpu/drm/meson/meson_vclk.c
>> +++ b/drivers/gpu/drm/meson/meson_vclk.c
>> @@ -553,8 +553,17 @@ void meson_hdmi_pll_set_params(struct meson_drm *priv, unsigned int m,
>>  
>>  		/* G12A HDMI PLL Needs specific parameters for 5.4GHz */
>>  		if (m >= 0xf7) {
>> -			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4, 0xea68dc00);
>> -			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5, 0x65771290);
>> +			if (frac < 0x10000) {
>> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
>> +							0x6a685c00);
>> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
>> +							0x11551293);
>> +			} else {
>> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL4,
>> +							0xea68dc00);
>> +				regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL5,
>> +							0x65771290);
>> +			}
>>  			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL6, 0x39272000);
>>  			regmap_write(priv->hhi, HHI_HDMI_PLL_CNTL7, 0x55540000);
>>  		} else {
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Applied to drm-misc-fixes

> 
> nit: this is continuing with more magic constants, and it would be nice
> to have them converted to #define'd bitfields.  But since that isn't a
> new problem in this patch, it's fine to cleanup later.

Yep, it's on our to priority.

Neil


> 
> Kevin
> 

