Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210ABC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EE52173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sGTswi86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfDQS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:26:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44350 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfDQS0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:26:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so3094454wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=la7ztfbZTDiHYGYXUERkr7bmbktNQu8VIfVisqRnTVo=;
        b=sGTswi867/OmlG0RvsR+iJTiSk729hTtavxg0Or0zryYXlGOW0784hbcE+KJSAiCT8
         XAFvpwOIibV7VL1Nr5pDNMcu0W67qIPnoGPxYYEMO7ZSYToZUBsGLb249qrLsahuV7AM
         7hofNLvF3sZ3B8sL0I38hhG3UE4MuiiS7SOy6BbGPtfWydx5BgQ1yfcKEt5cqSSLRVri
         97itJGK8xazWVLM1S+XewJjy/NfXZUGNGHVKI12YTw52nqONU2AeebdvjBD7woEjnB3h
         tWdtaREYoSe2I6zGhHzDUh26fM4dIMhMNOHy7kvuH/Vmfnsz21shCHx8bAeXwwIE4LSU
         ca6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=la7ztfbZTDiHYGYXUERkr7bmbktNQu8VIfVisqRnTVo=;
        b=MMBQ+y2nzhd8A+w/C8YXe0yDYgzCEMW6ZtJ7T1A3GCRmBaUEDg4eQskI9f0aG3IdY8
         hVxBTAw1AGB0SCEQebHXrGpSFYsy29HMusbGXN9IzAddJkwc9N5hydHtAWC73PvhMZjq
         BmVnkH5hfeuXtH5vFZzwts8CboNIqvgYuHPW4lAIuyWAyY250KZ8FFiB8cp7YoDv1Dwc
         j4erwBCB70d8cHJdhJIYwkPe1xQObmEgTb5OaqQ2qUKwuI+zJfh54Mh5nfvzQVVJW3Kh
         ckhBfXOCUyd3rWnQ+JcMPR6YPRc4FVRsXDTwsCh5AeW6rFtoVQ5oN5U0ESjLt/82vNio
         xoWw==
X-Gm-Message-State: APjAAAWElKpRJtT9raVr3qeOtR5aLvTAX+cYFaiIquqoHCBfpw6xjmfT
        UaH6QurmS10XYBjVspumBHE2Bw==
X-Google-Smtp-Source: APXvYqxE8Elmis7xcARMPJTpe4deJ4vdaH2+6rQr1bnAyRbfHGL9777pltStiDBR5fI5pz+HNGpSiA==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr14511914wrx.115.1555525590318;
        Wed, 17 Apr 2019 11:26:30 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 61sm182853341wre.50.2019.04.17.11.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:26:29 -0700 (PDT)
Subject: Re: [PATCH -next] drm/meson: Make some functions static
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Yue Haibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
References: <20190413141455.34020-1-yuehaibing@huawei.com>
 <5CB5BB43.5040007@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <4195f74e-a531-c216-534f-a56786b88ce6@baylibre.com>
Date:   Wed, 17 Apr 2019 20:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CB5BB43.5040007@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 13:23, Neil Armstrong wrote:
> 
> 
> Le 13/04/2019 16:14, Yue Haibing a écrit :
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warnings:
>>
>> drivers/gpu/drm/meson/meson_viu.c:93:6: warning: symbol 'meson_viu_set_g12a_osd1_matrix' was not declared. Should it be static?
>> drivers/gpu/drm/meson/meson_viu.c:121:6: warning: symbol 'meson_viu_set_osd_matrix' was not declared. Should it be static?
>> drivers/gpu/drm/meson/meson_viu.c:190:6: warning: symbol 'meson_viu_set_osd_lut' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/gpu/drm/meson/meson_viu.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
>> index 0169c98..b590723 100644
>> --- a/drivers/gpu/drm/meson/meson_viu.c
>> +++ b/drivers/gpu/drm/meson/meson_viu.c
>> @@ -90,8 +90,8 @@ static int eotf_bypass_coeff[EOTF_COEFF_SIZE] = {
>>  	EOTF_COEFF_RIGHTSHIFT /* right shift */
>>  };
>>  
>> -void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
>> -				   bool csc_on)
>> +static void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv,
>> +					   int *m, bool csc_on)
>>  {
>>  	/* VPP WRAP OSD1 matrix */
>>  	writel(((m[0] & 0xfff) << 16) | (m[1] & 0xfff),
>> @@ -118,8 +118,8 @@ void meson_viu_set_g12a_osd1_matrix(struct meson_drm *priv, int *m,
>>  		priv->io_base + _REG(VPP_WRAP_OSD1_MATRIX_EN_CTRL));
>>  }
>>  
>> -void meson_viu_set_osd_matrix(struct meson_drm *priv,
>> -			      enum viu_matrix_sel_e m_select,
>> +static void meson_viu_set_osd_matrix(struct meson_drm *priv,
>> +				     enum viu_matrix_sel_e m_select,
>>  			      int *m, bool csc_on)
>>  {
>>  	if (m_select == VIU_MATRIX_OSD) {
>> @@ -187,10 +187,10 @@ void meson_viu_set_osd_matrix(struct meson_drm *priv,
>>  #define OSD_EOTF_LUT_SIZE 33
>>  #define OSD_OETF_LUT_SIZE 41
>>  
>> -void meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
>> -			   unsigned int *r_map, unsigned int *g_map,
>> -			   unsigned int *b_map,
>> -			   bool csc_on)
>> +static void
>> +meson_viu_set_osd_lut(struct meson_drm *priv, enum viu_lut_sel_e lut_sel,
>> +		      unsigned int *r_map, unsigned int *g_map,
>> +		      unsigned int *b_map, bool csc_on)
>>  {
>>  	unsigned int addr_port;
>>  	unsigned int data_port;
>>
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Applied to drm-misc-next, thanks
