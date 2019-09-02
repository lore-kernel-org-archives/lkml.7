Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CED21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GS/UWabS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfIBIFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:05:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:05:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so12939478wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fO/Fs9yhycLN56Ypumx1dDOmveWnwXs336ehWOSJQl8=;
        b=GS/UWabSrOopY6o0gIwaQ2w0Kz6bve0lYOWB2MoNuu14CycgzC6GFfHrArf3Vev8DL
         HHptHf4rOcJjdQOqLJMU5gGG8jZWnBMG2aXbqkeqZiJIH2sm3dl/glFEn07kgp+6KrHL
         Ghx1l/tdVvl/HsD8p2HGeegS0/7Za6f1e911k2iZJ7m81lc5ekmHK3cwWHzdlz+671RG
         QHKJYFkI4GlDacTSjS43sQ4RqPBipkwSRiSsXvXu44ZhQ32tLEGRZqmnRVEHChDoz8Ac
         kjLooKrtbFW6I5KhH2YZxDXWFTFxHp29e71Ymq+HPJSFU0H4JakGfdkWSfTqzf10MVsC
         MbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fO/Fs9yhycLN56Ypumx1dDOmveWnwXs336ehWOSJQl8=;
        b=kAcLGHLwmEFPL/3Jp3NEOsUIYnskxsazOGmbNj4gfscwqL8UgpyHaoPB0Bbcv6UHMO
         QVSjo86Ztp4dyLlPJ+BrAdbdL8serYKmGl0lLsGb4Qsy59lKlAIoIF+Y1dwgUEVltWJM
         FLnk2j7RG6LI8Kb7Hu3HbvofxuNMvjNg7lfhlxJLIAedGFwyLDV+Y9PZ4zYFAoSxAYcd
         +U4+ORqb/4oPffd/1LgQj/FHb1h8yIPEE2DVOREsFvCY9qUhiGNpeVJa9PgiBdol+wdH
         4POEKJHA6OLcqTsGFq3Gd9yMimVDwBY07bvp57zN1alpOAPOlUdQPYOHHOSoS9tJgX5/
         0Mig==
X-Gm-Message-State: APjAAAW4lvBoAmXoBfKx2vILfh5+fOYXkl0Ky9j/+msJl7VhdGhR60QJ
        FzE8t6J5GE+jrpQ1bS9xzta6XFC6TO0=
X-Google-Smtp-Source: APXvYqyk2RjxajEGOAwGyishWjOtiBsMjUX7blAN9b4Wfv3Cy2fbPxsmWwVbhFmA0cLkkHqsLH5zJw==
X-Received: by 2002:adf:cc84:: with SMTP id p4mr16899211wrj.201.1567411512816;
        Mon, 02 Sep 2019 01:05:12 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q15sm3982870wmb.28.2019.09.02.01.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 01:05:12 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm: dw-hdmi: extract dw_hdmi_connector_update_edid()
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
 <AM0PR06MB4004C3231CA859341E6CF8B9ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <179241b1-3f54-683d-036f-ae10f53935d7@baylibre.com>
Date:   Mon, 2 Sep 2019 10:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR06MB4004C3231CA859341E6CF8B9ACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On 01/09/2019 18:14, Jonas Karlman wrote:
> Extract code that updates EDID into a dw_hdmi_connector_update_edid()
> helper, it will be called from dw_hdmi_connector_detect().

Small nit, you should precise you add a bool to optionally add the modes.

Anyway:
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 521d689413c8..8ab214dc5ae7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2171,7 +2171,8 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
>  }
>  
> -static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> +static int dw_hdmi_connector_update_edid(struct drm_connector *connector,
> +					  bool add_modes)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>  					     connector);
> @@ -2190,7 +2191,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  		hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>  		drm_connector_update_edid_property(connector, edid);
>  		cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier, edid);
> -		ret = drm_add_edid_modes(connector, edid);
> +		if (add_modes)
> +			ret = drm_add_edid_modes(connector, edid);
>  		kfree(edid);
>  	} else {
>  		dev_dbg(hdmi->dev, "failed to get edid\n");
> @@ -2199,6 +2201,11 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> +static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> +{
> +	return dw_hdmi_connector_update_edid(connector, true);
> +}
> +
>  static void dw_hdmi_connector_force(struct drm_connector *connector)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> 

