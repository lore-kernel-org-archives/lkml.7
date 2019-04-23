Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68237C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D385206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ASbERQ7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfDWMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:47:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36424 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:47:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id b1so8720145wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OOxVIw8xSNhgKH4B85MRZWxPL4a34cBEcrMIdeeNouY=;
        b=ASbERQ7h4CWM4w+ZBaf1fxIp6KdWq/B1tqckoU8xsz6rEv3BY1ZHe+9TkrfR0hisIV
         NmrcEECng978/NREDIR2oj9hJcwAvijxtilzMo3EsXrztv5x2yI+vOyboptaqDzrpTgE
         1Pq/Dis6qAgWR4iDBbaGG962FpepruMs5WNU/DG2NDw+MpL9rtRP57bjiSjLGulEZ/Ms
         K237h5okeDrDvY3uUDR/fYSUkkgxWpkV76UXaN2ZNVP7Bn2U6zqi04E5POfRIYW0hi9X
         yBueNQtp4byleqKj5aYBQQHsku99nlMg4t10LGIskIg1OvaL+iO4/SnnGF8EksPFoLOO
         393A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OOxVIw8xSNhgKH4B85MRZWxPL4a34cBEcrMIdeeNouY=;
        b=cSMD0BxO+qhWG8gtO5YjzoCuE05XBpSb0eg1JIpPEvxVaA9YG4HFwy9gAP/iIAZPhw
         oAru56/U9k2k4Cwv2rWNM9YpgMfArkjePRfPafgYwwsPEOqDVfAw3ZPhpSSMTg0v2VQ4
         fZehmCzerHqFzaJ0b1boCKAmrczON6PK/ACvRm+vGWzS2VBbMz7p+ecKtkRWqu0uiJaS
         +VMlcNT6FUjc/7e0pG0oDNkaYLWg6GbACGcOon55GBrGr2C36TJ9sOPZDX6N1mvDZL1r
         0PJ7DB79u62jgGPpoD5gJj4f38cwtbSVqOi+Jxqju9JzWplpROpnJTJVrZbZg3w24kCg
         N8Vw==
X-Gm-Message-State: APjAAAVM9RozQ/R2A+RJWPs+Cdv/ZDKjAhnCAfEU6IQckZ/bZWTQwMEM
        gClM2BS59ACT2bvu8brviNojtd0Htj4sng==
X-Google-Smtp-Source: APXvYqyYjuVnXh9i4Z5M/+S8gTBGZ/OND6gY4M4bbzvPa4qhCGtSiQ1BTPf+p4xvNvVNp73p0BQNaw==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr16988387wrv.163.1556023667880;
        Tue, 23 Apr 2019 05:47:47 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b3sm13179170wrx.57.2019.04.23.05.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 05:47:47 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix SCDC configuration for
 ddc-i2c-bus
To:     Jonas Karlman <jonas@kwiboo.se>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ab34c440-c5ad-3c21-9fc0-d7c24aad4c59@baylibre.com>
Date:   Tue, 23 Apr 2019 14:47:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2019 10:25, Jonas Karlman wrote:
> When ddc-i2c-bus property is used, a NULL pointer dereference is reported:
> 
> [   31.041669] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [   31.041671] pgd = 4d3c16f6
> [   31.041673] [00000008] *pgd=00000000
> [   31.041678] Internal error: Oops: 5 [#1] SMP ARM
> 
> [   31.041711] Hardware name: Rockchip (Device Tree)
> [   31.041718] PC is at i2c_transfer+0x8/0xe4
> [   31.041721] LR is at drm_scdc_read+0x54/0x84
> [   31.041723] pc : [<c073273c>]    lr : [<c05926c4>]    psr: 280f0013
> [   31.041725] sp : edffdad0  ip : 5ccb5511  fp : 00000058
> [   31.041727] r10: 00000780  r9 : edf91608  r8 : c11b0f48
> [   31.041728] r7 : 00000438  r6 : 00000000  r5 : 00000000  r4 : 00000000
> [   31.041730] r3 : edffdae7  r2 : 00000002  r1 : edffdaec  r0 : 00000000
> 
> [   31.041908] [<c073273c>] (i2c_transfer) from [<c05926c4>] (drm_scdc_read+0x54/0x84)
> [   31.041913] [<c05926c4>] (drm_scdc_read) from [<c0592858>] (drm_scdc_set_scrambling+0x30/0xbc)
> [   31.041919] [<c0592858>] (drm_scdc_set_scrambling) from [<c05cc0f4>] (dw_hdmi_update_power+0x1440/0x1610)
> [   31.041926] [<c05cc0f4>] (dw_hdmi_update_power) from [<c05cc574>] (dw_hdmi_bridge_enable+0x2c/0x70)
> [   31.041932] [<c05cc574>] (dw_hdmi_bridge_enable) from [<c05aed48>] (drm_bridge_enable+0x24/0x34)
> [   31.041938] [<c05aed48>] (drm_bridge_enable) from [<c0591060>] (drm_atomic_helper_commit_modeset_enables+0x114/0x220)
> [   31.041943] [<c0591060>] (drm_atomic_helper_commit_modeset_enables) from [<c05c3fe0>] (rockchip_atomic_helper_commit_tail_rpm+0x28/0x64)
> 
> hdmi->i2c may not be set when ddc-i2c-bus property is used in device tree.
> Fix this by using hdmi->ddc as the i2c adapter when calling drm_scdc_*().
> Also report that SCDC is not supported when there is no DDC bus.
> 
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 7a47c65d8ecb..fd1c319a4ee0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1046,6 +1046,10 @@ static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
>  	if (hdmi->version < 0x200a)
>  		return false;
>  
> +	/* Disable if no DDC bus */
> +	if (!hdmi->ddc)
> +		return false;
> +
>  	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
>  	if (!display->hdmi.scdc.supported ||
>  	    !display->hdmi.scdc.scrambling.supported)
> @@ -1683,13 +1687,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  			 * Source Devices compliant shall set the
>  			 * Source Version = 1.
>  			 */
> -			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
> +			drm_scdc_readb(hdmi->ddc, SCDC_SINK_VERSION,
>  				       &bytes);
> -			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
> +			drm_scdc_writeb(hdmi->ddc, SCDC_SOURCE_VERSION,
>  				min_t(u8, bytes, SCDC_MIN_SOURCE_VERSION));
>  
>  			/* Enabled Scrambling in the Sink */
> -			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
> +			drm_scdc_set_scrambling(hdmi->ddc, 1);
>  
>  			/*
>  			 * To activate the scrambler feature, you must ensure
> @@ -1705,7 +1709,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
>  			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
>  				    HDMI_MC_SWRSTZ);
> -			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
> +			drm_scdc_set_scrambling(hdmi->ddc, 0);
>  		}
>  	}
>  
> 

Nice catch !

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
