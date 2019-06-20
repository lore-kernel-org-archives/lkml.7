Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD572084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uE8giMKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfFTOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:38:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39821 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:38:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so3290578wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=84F5DiSwCj1bq1M9oHUVsIoup/IIz00R6LKFwxj2NhY=;
        b=uE8giMKgSRaSvV4qhfbWMmgLzo4ml0ApQUkOIVoUrCkbfUeyxierY4p46JsYAWGBJn
         HEpSQethwYEGHnsQ8qMUAGZCxJfuMO2q35mZO7iQt9cgIdOqeJ+3VIQ9M2tgwGJInugY
         g/jprxTyc5RTj892ke/n02G2CAIvpliYv8TsMqEeB63dAX+C9N7sDeXmFHQ0wqQiYh/V
         qNei5mLPGQH3e+LM9+94DL6Lq19glvTYEEt+B8nckGZK6XexlbmsueXMIxz6i7datxqX
         CGTDrMNCIfIqDuq9E4+VQ15u9fblt0YwLnZyeNST4aobnEKCpbqbVj9RB9mccDSwUitU
         qtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=84F5DiSwCj1bq1M9oHUVsIoup/IIz00R6LKFwxj2NhY=;
        b=cfI7vF9g5F42mfdFh7WpvbjzCnf0/ebEpzrbxuIutQTPu5rHJFMJCnX46zT3ZtXrzD
         LOowCSRgFoRpNDoalL/mC+wcr/8VhnHdAGfI9pPrFZdwujH+a1nzV5qz+toLHqS/EbwX
         GmEea+oj8IbGDM4QLsMi60jD58qNnpCkZ+daPMaBVSEFgMSz+yl/ky6I/U9K4M3utndj
         gmctGjMOgmblEOuoU4XF8mwySDuHIFXKgD8vS2qTAeRf6lBGH5fMYIyg//Zmr1+ApT/6
         8BhF01M+WhzqL2vcm+puqHoc60aIHV22ihzTALzkz00tC8U+A+84P8x9E+LeA0+dIYh+
         PeQg==
X-Gm-Message-State: APjAAAUpQi7T7f7k7yOR8YJJlZbBoJorpexIQMe6fS1SR5QrVEo3/Qd6
        lvMwfG2dNi6Xm4aMb21BOXnXXQ==
X-Google-Smtp-Source: APXvYqzdN3DPH16fU4LuWjfGpRAv2X8RP9tj7tg+kld5tKVSydK7wmpGDHQoyyz6aFaVMJNRJAIVQg==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr33817661wrq.35.1561041494969;
        Thu, 20 Jun 2019 07:38:14 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i25sm11262543wrc.91.2019.06.20.07.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:38:14 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Use automatic CTS generation mode
 when using non-AHB audio
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20190612085147.26971-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <eb54df7f-8009-032d-48fb-4eee6197a055@baylibre.com>
Date:   Thu, 20 Jun 2019 16:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612085147.26971-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

Gentle ping, do you think this could go in drm-misc-next for 5.3 ?

Thanks,
Neil

On 12/06/2019 10:51, Neil Armstrong wrote:
> When using an I2S source using a different clock source (usually the I2S
> audio HW uses dedicated PLLs, different from the HDMI PHY PLL), fixed
> CTS values will cause some frequent audio drop-out and glitches as
> reported on Amlogic, Allwinner and Rockchip SoCs setups.
> 
> Setting the CTS in automatic mode will let the HDMI controller generate
> automatically the CTS value to match the input audio clock.
> 
> The DesignWare DW-HDMI User Guide explains:
>   For Automatic CTS generation
>   Write "0" on the bit field "CTS_manual", Register 0x3205: AUD_CTS3
> 
> The DesignWare DW-HDMI Databook explains :
>   If "CTS_manual" bit equals 0b this registers contains "audCTS[19:0]"
>   generated by the Cycle time counter according to specified timing.
> 
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 44 +++++++++++++++--------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index c68b6ed1bb35..6458c3a31d23 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -437,8 +437,14 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
>  	/* nshift factor = 0 */
>  	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
>  
> -	hdmi_writeb(hdmi, ((cts >> 16) & HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
> -		    HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
> +	/* Use automatic CTS generation mode when CTS is not set */
> +	if (cts)
> +		hdmi_writeb(hdmi, ((cts >> 16) &
> +				   HDMI_AUD_CTS3_AUDCTS19_16_MASK) |
> +				  HDMI_AUD_CTS3_CTS_MANUAL,
> +			    HDMI_AUD_CTS3);
> +	else
> +		hdmi_writeb(hdmi, 0, HDMI_AUD_CTS3);
>  	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
>  	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
>  
> @@ -508,24 +514,32 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
>  {
>  	unsigned long ftdms = pixel_clk;
>  	unsigned int n, cts;
> +	u8 config3;
>  	u64 tmp;
>  
>  	n = hdmi_compute_n(sample_rate, pixel_clk);
>  
> -	/*
> -	 * Compute the CTS value from the N value.  Note that CTS and N
> -	 * can be up to 20 bits in total, so we need 64-bit math.  Also
> -	 * note that our TDMS clock is not fully accurate; it is accurate
> -	 * to kHz.  This can introduce an unnecessary remainder in the
> -	 * calculation below, so we don't try to warn about that.
> -	 */
> -	tmp = (u64)ftdms * n;
> -	do_div(tmp, 128 * sample_rate);
> -	cts = tmp;
> +	config3 = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
>  
> -	dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
> -		__func__, sample_rate, ftdms / 1000000, (ftdms / 1000) % 1000,
> -		n, cts);
> +	/* Only compute CTS when using internal AHB audio */
> +	if (config3 & HDMI_CONFIG3_AHBAUDDMA) {
> +		/*
> +		 * Compute the CTS value from the N value.  Note that CTS and N
> +		 * can be up to 20 bits in total, so we need 64-bit math.  Also
> +		 * note that our TDMS clock is not fully accurate; it is
> +		 * accurate to kHz.  This can introduce an unnecessary remainder
> +		 * in the calculation below, so we don't try to warn about that.
> +		 */
> +		tmp = (u64)ftdms * n;
> +		do_div(tmp, 128 * sample_rate);
> +		cts = tmp;
> +
> +		dev_dbg(hdmi->dev, "%s: fs=%uHz ftdms=%lu.%03luMHz N=%d cts=%d\n",
> +			__func__, sample_rate,
> +			ftdms / 1000000, (ftdms / 1000) % 1000,
> +			n, cts);
> +	} else
> +		cts = 0;
>  
>  	spin_lock_irq(&hdmi->audio_lock);
>  	hdmi->audio_n = n;
> 

