Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E2CC06516
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615821882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rKllUdZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfGDI3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:29:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44540 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGDI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:29:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x648TWe8122314;
        Thu, 4 Jul 2019 03:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562228972;
        bh=3egXhDb+0BEGsc9z+jUYoOJnG4f+8TqOeWKQ9O3F6XQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=rKllUdZGg7Y450IMxaVlJuNDJ41h3AOnnoxU+sk8hJhLSXRwRB2pmJSUkDomzG1hB
         /TUcbmAjmpwgOvF+LRgkqD74YnTmjSrIIOEi4O0kPF7YLvXk/vxIpNy5qjnWydybAa
         xsqYnWV2yrAOVdZPsOjL7iEYFjtZ16SKcfXiNpgM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x648TWg2016906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Jul 2019 03:29:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Jul
 2019 03:29:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Jul 2019 03:29:30 -0500
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x648TQhG094955;
        Thu, 4 Jul 2019 03:29:27 -0500
Subject: Re: [PATCH 3/3] drm/bridge: sii902x: make audio mclk optional
To:     Olivier Moysan <olivier.moysan@st.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <alexandre.torgue@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
References: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
 <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
From:   Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ac3cee7b-900a-45f6-b722-062e1d8b39d0@ti.com>
Date:   Thu, 4 Jul 2019 11:29:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1562082426-14876-4-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2019 18:47, Olivier Moysan wrote:
> The master clock on i2s bus is not mandatory,
> as sii902X internal PLL can be used instead.
> Make use of mclk optional.
> 
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>

Reviewed-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/bridge/sii902x.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 36acc256e67e..a08bd9fdc046 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -562,19 +562,21 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>  		}
>  	}
>  
> -	ret = clk_prepare_enable(sii902x->audio.mclk);
> -	if (ret) {
> -		dev_err(dev, "Enabling mclk failed: %d\n", ret);
> -		return ret;
> -	}
> +	if (sii902x->audio.mclk) {
> +		ret = clk_prepare_enable(sii902x->audio.mclk);
> +		if (ret) {
> +			dev_err(dev, "Enabling mclk failed: %d\n", ret);
> +			return ret;
> +		}
>  
> -	mclk_rate = clk_get_rate(sii902x->audio.mclk);
> +		mclk_rate = clk_get_rate(sii902x->audio.mclk);
>  
> -	ret = sii902x_select_mclk_div(&i2s_config_reg, params->sample_rate,
> -				      mclk_rate);
> -	if (mclk_rate != ret * params->sample_rate)
> -		dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
> -			mclk_rate, ret, params->sample_rate);
> +		ret = sii902x_select_mclk_div(&i2s_config_reg,
> +					      params->sample_rate, mclk_rate);
> +		if (mclk_rate != ret * params->sample_rate)
> +			dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
> +				mclk_rate, ret, params->sample_rate);
> +	}
>  
>  	mutex_lock(&sii902x->mutex);
>  
> @@ -640,7 +642,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>  	mutex_unlock(&sii902x->mutex);
>  
>  	if (ret) {
> -		clk_disable_unprepare(sii902x->audio.mclk);
> +		if (sii902x->audio.mclk)
> +			clk_disable_unprepare(sii902x->audio.mclk);
>  		dev_err(dev, "%s: hdmi audio enable failed: %d\n", __func__,
>  			ret);
>  	}
> @@ -659,7 +662,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>  
>  	mutex_unlock(&sii902x->mutex);
>  
> -	clk_disable_unprepare(sii902x->audio.mclk);
> +	if (sii902x->audio.mclk)
> +		clk_disable_unprepare(sii902x->audio.mclk);
>  }
>  
>  int sii902x_audio_digital_mute(struct device *dev, void *data, bool enable)
> @@ -752,9 +756,12 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  
>  	sii902x->audio.mclk = devm_clk_get(dev, "mclk");
>  	if (IS_ERR(sii902x->audio.mclk)) {
> -		dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
> -			__func__, PTR_ERR(sii902x->audio.mclk));
> -		return 0;
> +		if (PTR_ERR(sii902x->audio.mclk) != -ENOENT) {
> +			dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
> +				__func__, PTR_ERR(sii902x->audio.mclk));
> +			return PTR_ERR(sii902x->audio.mclk);
> +		}
> +		sii902x->audio.mclk = NULL;
>  	}
>  
>  	sii902x->audio.pdev = platform_device_register_data(
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
