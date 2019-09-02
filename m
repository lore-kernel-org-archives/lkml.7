Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB0C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C782220820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aIdG133M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfIBIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:07:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbfIBIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:07:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so1537806wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dcnwYP0l9ZZMKxGuHDXzwQdyhtArK//FoNqgnDXsr3M=;
        b=aIdG133MUwsuhfSLBa8fqn5EFclmRAPM0CnjV3oZTSa5E2c0Yz+hr27csv0yqo7TFL
         b8X8SF5d13aJ7QrpTS2UmJYT6C+0FFO0StQtRrMfnZd9koiMSzJ9eo2O5sbQaKTYNi3Z
         Z4okF48F8CMgldf7kxGmZLv8ityUqE4lfSXeClNkmIVCPeem7X1xL/NhJJAFsf5yjEjn
         12OPCmBOKyVuYV1cGfxNzeaJc/XXjDr23Ubu93wSJEGztEhwLOdUx/5KWLBgc9He4L2w
         esfvGuC9PX0wE9Eu6fjegI0J9F6ut3kokYjBbSHTepCTsCyWDol3zwhh9xvpaSAHA14Q
         pjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dcnwYP0l9ZZMKxGuHDXzwQdyhtArK//FoNqgnDXsr3M=;
        b=S4fvHJT1xveKR0bhMj+rCrcVIFaGbSypzrKSnDmZGvEP1RT/3o7RzioVJHYOh5tTfl
         9zvxkRESG0i3W/GXS/AwzWpqUpu8PjwjAKWKmFydXK57kf1dAw2rPNqcN0W505wwL3wl
         SZ6liGdkTzpRfGW6V60hv2s04X9SYxGwTbQnpiVqh+0t2fioIx+jILP9SuuNqNxIK3FW
         E5YOcpes4kkuuPdOmRGGhl1hj0oWz5pavPY+2232l9yo5ySNWFbRPFYBAkxB0/IYoUqJ
         snCpqdKs4S5nBSACr7/pWu3S6OlSX9nZFKumUSqtxy+72nDy95BomCvw1kX8D/tkKw6f
         IajQ==
X-Gm-Message-State: APjAAAU/PoMGJ40AbcTH9T4SluX2WYumM8C7d3T6mcbAAYxk0R7NPnhC
        gAt1reA+m85wb7UlGEddYIHXvpjDnZ8=
X-Google-Smtp-Source: APXvYqzAvvUBONvEDmDvUqv1/+iLEqZrBYcDKiQqW1eeu+Gdc6DVbQnQZQGK+/MONug2WHiNQjE4Ow==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr18972277wme.29.1567411675221;
        Mon, 02 Sep 2019 01:07:55 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a16sm5757322wmg.5.2019.09.02.01.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 01:07:54 -0700 (PDT)
Subject: Re: [PATCH 4/5] Revert "drm/edid: make drm_edid_to_eld() static"
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
 <AM0PR06MB4004968EE64C136494040B7AACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c24fbace-3772-b50c-23da-5af35a6ac70f@baylibre.com>
Date:   Mon, 2 Sep 2019 10:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR06MB4004968EE64C136494040B7AACBF0@AM0PR06MB4004.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2019 18:14, Jonas Karlman wrote:
> drm_edid_to_eld() is needed to update stale connector ELD on HPD event.
> 
> This reverts part of commit 79436a1c9bcc ("drm/edid: make drm_edid_to_eld() static").

Why not a full revert ?

The documentation revert seems also relevant now

Neil

> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/drm_edid.c | 5 +++--
>  include/drm/drm_edid.h     | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 82a4ceed3fcf..47c409af0903 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4069,7 +4069,7 @@ static void clear_eld(struct drm_connector *connector)
>  	connector->audio_latency[1] = 0;
>  }
>  
> -/*
> +/**
>   * drm_edid_to_eld - build ELD from EDID
>   * @connector: connector corresponding to the HDMI/DP sink
>   * @edid: EDID to parse
> @@ -4077,7 +4077,7 @@ static void clear_eld(struct drm_connector *connector)
>   * Fill the ELD (EDID-Like Data) buffer for passing to the audio driver. The
>   * HDCP and Port_ID ELD fields are left for the graphics driver to fill in.
>   */
> -static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
> +void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  {
>  	uint8_t *eld = connector->eld;
>  	u8 *cea;
> @@ -4162,6 +4162,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  	DRM_DEBUG_KMS("ELD size %d, SAD count %d\n",
>  		      drm_eld_size(eld), total_sad_count);
>  }
> +EXPORT_SYMBOL(drm_edid_to_eld);
>  
>  /**
>   * drm_edid_to_sad - extracts SADs from EDID
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index b9719418c3d2..49987818fe23 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -337,6 +337,7 @@ struct drm_connector;
>  struct drm_connector_state;
>  struct drm_display_mode;
>  
> +void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid);
>  int drm_edid_to_sad(struct edid *edid, struct cea_sad **sads);
>  int drm_edid_to_speaker_allocation(struct edid *edid, u8 **sadb);
>  int drm_av_sync_delay(struct drm_connector *connector,
> 

