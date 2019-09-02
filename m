Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB9AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5572C2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u9jT5UnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfIBIFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:05:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:05:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so13013174wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/pHVxf6N6S+S04cnwPxjOpZs7BM1gCEC9ZFkDTl0jF4=;
        b=u9jT5UnLQyRqYSLrxnWhzLF0nhlJYyWXtoWuLljFjdxiaK97CwZYpMt3cGQCQejA/D
         9cvNAxpg8X1NVCWqk2pN1jBcP5+4/N4B6sKhfpt4HdwEUJviwMozkbcXuCgPLy+l5sxp
         ah8XWrwofB+Zy3z7QRDEZvTVdXmPWgtq/6bYCk3KVL9sse+sxAAuQCBv4jbYcBlfVhBT
         SYjPoYEHCxmS/lIOFPqXSZVC74vsiJwvfPdT6zE4xwvinoo5Uv/vK1oG35xfaphk2Ulb
         sG0C175Zt8BgFOEszFzDEEdNNDGWWTFcnUF7p3lMIIRngTG9UzW3bPnZbFmg99J6i4Pa
         nu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/pHVxf6N6S+S04cnwPxjOpZs7BM1gCEC9ZFkDTl0jF4=;
        b=T+dX7vMnGcB4ft17i9v0co3/ZlcwBZkzNBZWCA4yyj/GqxbD2p8c4R5TZ2JtSJS5kp
         9MX9BDVYosngyz4WgXCxkLht+FfwsCf2kWhhpG5j7I1tgCmtojFdPqDIdIxWf4NOlCP8
         cmAra3yGr1u83PKgiSEzLPxczWaCX0aUF7fuCm4bnC7YXmHnPIKyZ2xYjscNITxw2voQ
         dQwEVGwr8hvwv4sYm3/hRWsZX4GEOItuEwyc5sMe7hSggW4019iv9F8Ht9bLhwWbGGWu
         akh9RYUhJOKfTgOrHLvuhzMpERpldGQMpF0QwjvvJwGHYfk/LBVVZyggNVTMNKKjxNHK
         z11g==
X-Gm-Message-State: APjAAAUKFmgNyQQLvNgopg1Nrl/uYD3QA+ZWD6+LN7yMoih8G51f1Ywe
        PX4l44OMADszuot5wDY55rzeFhBsjSM=
X-Google-Smtp-Source: APXvYqzbEBakAHIj7NXCsZoF0XmYVixKPzIsRXJ1EELGxPZ0QjqpJ6WcT4Ey1s11OsWxNG8N+jMQ7Q==
X-Received: by 2002:adf:9050:: with SMTP id h74mr34146710wrh.191.1567411528226;
        Mon, 02 Sep 2019 01:05:28 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o22sm5746140wra.96.2019.09.02.01.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 01:05:27 -0700 (PDT)
Subject: Re: [PATCH 2/5] drm: dw-hdmi: move dw_hdmi_connector_detect()
To:     Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM0PR06MB40049562E295DD62302C8DB7ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
 <20190901161426.1606-1-jonas@kwiboo.se>
 <AM0PR06MB400415A45BFD6956950D9251ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <3fcff58c-de58-31e9-26cb-6699eca610e7@baylibre.com>
Date:   Mon, 2 Sep 2019 10:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR06MB400415A45BFD6956950D9251ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2019 18:14, Jonas Karlman wrote:
> Move dw_hdmi_connector_detect() it will call dw_hdmi_connector_update_edid().
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 30 +++++++++++------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 8ab214dc5ae7..91d86ddd6624 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2156,21 +2156,6 @@ static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
>  					  hdmi->rxsense);
>  }
>  
> -static enum drm_connector_status
> -dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> -{
> -	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> -					     connector);
> -
> -	mutex_lock(&hdmi->mutex);
> -	hdmi->force = DRM_FORCE_UNSPECIFIED;
> -	dw_hdmi_update_power(hdmi);
> -	dw_hdmi_update_phy_mask(hdmi);
> -	mutex_unlock(&hdmi->mutex);
> -
> -	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> -}
> -
>  static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
>  					  bool add_modes)
>  {
> @@ -2201,6 +2186,21 @@ static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
>  	return ret;
>  }
>  
> +static enum drm_connector_status
> +dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> +					     connector);
> +
> +	mutex_lock(&hdmi->mutex);
> +	hdmi->force = DRM_FORCE_UNSPECIFIED;
> +	dw_hdmi_update_power(hdmi);
> +	dw_hdmi_update_phy_mask(hdmi);
> +	mutex_unlock(&hdmi->mutex);
> +
> +	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +}
> +
>  static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  {
>  	return dw_hdmi_connector_update_edid(connector, true);
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
