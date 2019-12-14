Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A1EC2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C9C21655
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FE+LH7VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLNAHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:07:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLNAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:07:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so593425wrq.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 16:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=geIx/nWQ0BpqVGVQsVk8KzxkfCCv3NpUyxjodfVFmZc=;
        b=FE+LH7VGWD2YVnwVryc8AR/nUGMxZvoq5poiP1yIRfG/jwEEV8Lu4LmBbRXf7o8H2U
         RkoXCnPbo7CxnwZUca1iBsJGPp999jHsgOVDhAuQr+gcH/xf6a4QyTBvCsx6VZ2lb+Oo
         dlfw7jlyAuMoQfz0wzDD/M+5nZeE/AN2w7yQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=geIx/nWQ0BpqVGVQsVk8KzxkfCCv3NpUyxjodfVFmZc=;
        b=bCg3ySRQrbqR7yIvQSEwnQi76wdnvtlj6q/qaTl7nKU8m65bfp8iRA1d+SmcO1v3D3
         nzlBg6teBi+todzus1fehceMJlZCREmoqiZu/9v1NBSW+jOU6iod9tvs+1stY/hLTbAb
         XIie2+idaisRfqylkFWO1Vg3GPyA1GojLrcbnDr9bVoe3zPtsSInMov75KPEgpNj+H+K
         Scceqseo6ugXSiwn0x625SqeXwBWP6e7FjpqWa0XPRXUKMHZ2AbOwiEtbmT64Ibz0aFK
         MlQsENcJ2H9+IMjjER2vFZvptsZCG+rxdzOjuwWTO47k+j+YRYXhfcDbk5i/b6450XM8
         NCjw==
X-Gm-Message-State: APjAAAV2O7DPs7BIhFWiMKZqof7242WzD/78QNjr+8zQ6TNkeOGaXCBc
        N+cC+LiR++McRmZ2rVM1YLmoRA==
X-Google-Smtp-Source: APXvYqwxYCWfJRRSj199aMaUgb0YJevPf0BbXzzQoVl+o2Z1ZWFUB4UHGK3BMt+ufjNs8HxlASLylw==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr15468210wrv.302.1576282061890;
        Fri, 13 Dec 2019 16:07:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id s10sm11760046wrw.12.2019.12.13.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 16:07:41 -0800 (PST)
Date:   Sat, 14 Dec 2019 01:07:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, bjorn.andersson@linaro.org,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 9/9] drm/bridge: ti-sn65dsi86: Skip non-standard DP rates
Message-ID: <20191214000738.GP624164@phenom.ffwll.local>
Mail-Followup-To: Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>, robdclark@chromium.org,
        linux-arm-msm@vger.kernel.org, seanpaul@chromium.org,
        bjorn.andersson@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20191213234530.145963-1-dianders@chromium.org>
 <20191213154448.9.I1791f91dd22894da04f86699a7507d101d4385bc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213154448.9.I1791f91dd22894da04f86699a7507d101d4385bc@changeid>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 03:45:30PM -0800, Douglas Anderson wrote:
> The bridge chip supports these DP rates according to TI's spec:
> * 1.62 Gbps (RBR)
> * 2.16 Gbps
> * 2.43 Gbps
> * 2.7 Gbps (HBR)
> * 3.24 Gbps
> * 4.32 Gbps
> * 5.4 Gbps (HBR2)
> 
> As far as I can tell, only RBR, HBR, and HBR2 are part of the DP spec.
> If other rates work then I believe it's because the sink has allowed
> bending the spec a little bit.

I think you need to look at the eDP spec. And filter this stuff correctly
(there's more fields there for these somewhat irky edp timings). Simply
not using them works, but it's defeating the point of having these
intermediate clocks for edp panels.
-Daniel

> 
> I hoped that we could tell which rates would work and which rates
> didn't work based on whether link training passed or not.
> Unfortunately this wasn't so good on at least one panel hooked up to
> the bridge (AUO B116XAK01).  On that panel with 24 bpp configured:
> * 1.62: too small for 69500 kHz at 24 bpp
> * 2.16: link training failed
> * 2.43: link training passed, but garbage on screen
> * 2.7:  joy and happiness
> 
> Let's bypass all non-standard rates, which makes this panel happy
> working.  I'll still keep the code organized in such a way where it
> _could_ try the other rates, though, on the assumption that eventually
> someone will find a way to make use of them.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index cc8bef172f69..cb774ee536cd 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -454,6 +454,15 @@ static const unsigned int ti_sn_bridge_dp_rate_lut[] = {
>  	0, 1620, 2160, 2430, 2700, 3240, 4320, 5400
>  };
>  
> +/**
> + * A table indicating which of the rates in ti_sn_bridge_dp_rate_lut
> + * is as per the DP spec (AKA a standard) as opposed to an intermediate
> + * rate.
> + */
> +static const bool ti_sn_bridge_dp_rate_standard[] = {
> +	false, true, false, false, true, false, false, true
> +};
> +
>  static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn_bridge *pdata)
>  {
>  	unsigned int bit_rate_khz, dp_rate_mhz;
> @@ -660,6 +669,18 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
>  	for (dp_rate_idx = ti_sn_bridge_calc_min_dp_rate_idx(pdata);
>  	     dp_rate_idx <= max_dp_rate_idx;
>  	     dp_rate_idx++) {
> +		/*
> +		 * To be on the safe side, we'll skip all non-standard
> +		 * rates and move up to the next standard one.  This is
> +		 * because some panels will pass link training with a non-
> +		 * standard rate but just show garbage.  If the non-standard
> +		 * rates are useful we should figure out how to enable them
> +		 * through querying the panel, having a per-panel whitelist,
> +		 * or adding a DT property.
> +		 */
> +		if (!ti_sn_bridge_dp_rate_standard[dp_rate_idx])
> +			continue;
> +
>  		ret = ti_sn_link_training(pdata, dp_rate_idx, &last_err_str);
>  		if (!ret)
>  			break;
> -- 
> 2.24.1.735.g03f4e72817-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
