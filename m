Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D6120870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UkLtuJqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfCYKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:22:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44037 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfCYKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:22:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so5304617wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tHA7tV9asEvjrWcZfPQYwPMquyudhnWUuWlK5p2/1NQ=;
        b=UkLtuJqKIawhW1lT6MbfkPZPY2KqSkJYCFM0VcbbEZNIOg4wXnqnfcbM9IruKP9oDD
         v52ykYsnb7IhwglDzuaMRxT4rZDffphKUwqVkawbVYi0jsULS73TiY8Fo/XPSfFY5YB0
         SfPeGbkdTUR7ByNReFaWUFL0ubIavJMKrgDoMU/rS/wXZQ3klJvtK0ayHQxwe8TsTqu3
         NfzQmoYp6OnyPZZ4pkUi93ex+fbn5+Yi2/upTkAwCWPZuKszfZvF5Rn4OQESBvdm2vJe
         rjAeqaNIy8iyJ0uoXDcbGa3+RzCctRTeMC2eUbhANRy7kedRUVOkdvTdcOytXYhiy4Ez
         2bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tHA7tV9asEvjrWcZfPQYwPMquyudhnWUuWlK5p2/1NQ=;
        b=BiF57/s9I81qh37RKqfq27YJ5O2LNbMSrjh0aRjxX2d+ywaIFAoTzpYWTOMs0cktLC
         lm3vZxN0Qs2VWOuAtrnQmgUlOx0KV/e+hbQjkhO6PDG9IKxjVba/6e5jDj/Z5lpNg/1s
         8pzaCJhpKooo3DOvsWEfd2fVJk8Ar/gLYZdk+wp5WJZz4ZDTEwBrwovlvrPufJaqaBkv
         yLxMW/3cCIo4WsjVVhmWdjsHX24CuvAk3GRfLmhzVdAmUT5ZhDX2nP1OMEOhhM3pnQDB
         PN8hRL+whnXVqY2/lizI6XKIEfK/xVlHm4p6Sk8r5Fbfo+4zIKUnBnCXTj+/CVC2J8/9
         bp9w==
X-Gm-Message-State: APjAAAWiNh0Tc7RUnIubF+gWmFDTEvpJYTDVR1//YFvNM0MapKsCvuk3
        T7Qp0l9t1s8GZHKAQKf5Hntojw==
X-Google-Smtp-Source: APXvYqyJHAeUrSXstycbF3liIzwkOTMhLfWDvtzVBK5bnmXBc/od3wPG8J6VmXrroG9NbBex2Qa4ag==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr16006798wru.81.1553509360128;
        Mon, 25 Mar 2019 03:22:40 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r9sm3309956wrv.82.2019.03.25.03.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:22:39 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: disable SCDC configuration for
 invalid setups
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
References: <20190315095414.28520-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c4032279-3cc5-aeb8-a255-2715bc130e11@baylibre.com>
Date:   Mon, 25 Mar 2019 11:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315095414.28520-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej, Laurent,

Gentle ping,
Did you have time to review this fix ?

Thanks !
Neil

On 15/03/2019 10:54, Neil Armstrong wrote:
> This patch is an attempt to limit HDMI 2.0 SCDC setup when :
> - the SoC embeds an HDMI 1.4 only controller
> - the EDID supports SCDC but not scrambling
> - the EDID supports SCDC scrambling but not for low TMDS bit rates,
>   while only supporting low TMDS bit rates
> 
> This to avoid communicating with the SCDC DDC slave uncessary, and
> setting the DW-HDMI TMDS Scrambler setup when not supported by the
> underlying hardware.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> 
> Rob,
> 
> this patch should also solve your issue with your 11' display, could you
> test it ?
> If this works, I will focus on the underlying issue where the RK3399 SoC
> freezes in your setup.
> 
> Thanks,
> Neil
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a63e5f0dae56..db761329a1e3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1037,6 +1037,31 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>  
> +/* Filter out invalid setups to avoid configuring SCDC and scrambling */
> +static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
> +{
> +	struct drm_display_info *display = &hdmi->connector.display_info;
> +
> +	/* Completely disable SCDC support for older controllers */
> +	if (hdmi->version < 0x200a)
> +		return false;
> +
> +	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
> +	if (!display->hdmi.scdc.supported ||
> +	    !display->hdmi.scdc.scrambling.supported)
> +		return false;
> +
> +	/*
> +	 * Disable if display only support low TMDS rates and scrambling
> +	 * for low rates is not supported either
> +	 */
> +	if (!display->hdmi.scdc.scrambling.low_rates &&
> +	    display->max_tmds_clock <= 340000)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
>   * - The Source shall suspend transmission of the TMDS clock and data
> @@ -1055,7 +1080,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
>  	unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
>  
>  	/* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
> -	if (hdmi->connector.display_info.hdmi.scdc.supported) {
> +	if (dw_hdmi_support_scdc(hdmi)) {
>  		if (mtmdsclock > HDMI14_MAX_TMDSCLK)
>  			drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
>  		else
> @@ -1579,8 +1604,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  
>  	/* Set up HDMI_FC_INVIDCONF */
>  	inv_val = (hdmi->hdmi_data.hdcp_enable ||
> -		   vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> -		   hdmi_info->scdc.scrambling.low_rates ?
> +		   (dw_hdmi_support_scdc(hdmi) &&
> +		    (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> +		     hdmi_info->scdc.scrambling.low_rates)) ?
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>  		HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
>  
> @@ -1646,7 +1672,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  	}
>  
>  	/* Scrambling Control */
> -	if (hdmi_info->scdc.supported) {
> +	if (dw_hdmi_support_scdc(hdmi)) {
>  		if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>  		    hdmi_info->scdc.scrambling.low_rates) {
>  			/*
> 

