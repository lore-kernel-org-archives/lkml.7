Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019CAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A4520885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FwQxQt24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfKTQkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:40:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34547 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfKTQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:40:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so639427wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RB5ZmnOBrz94FKCQLZ2un9z7w5NJ9rHKH0gi3NUYCdU=;
        b=FwQxQt24Jex/90mCOVXSXgGXgkuL9kqqWTITnZct9eutLKM27hcW/dirO3XvCbvgh9
         CbXUHLTBJj0Ki+t2u6auH58+YDsOk4+S5XLzwNow31+dDru1ONoyrKgVzoCNPQIDtbyW
         MHFA96nAIk7st9CwiU5tHzG1hSgfWEwY7SKzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RB5ZmnOBrz94FKCQLZ2un9z7w5NJ9rHKH0gi3NUYCdU=;
        b=ZYmp8IEHKl3YVOgykE3qGuHFR9N3P5511+ErO18leyoSsqntfNA6PMrW7vzig0mrj+
         W/ImYk4dmO+gHKzE2pAvxBxBKYTZAVjYJwVGh5L93K9LxHMWbQV4yd0jyTNnNHHEf7e+
         8NWpME8J3nPR06/FEupzYJP5130sSTzHrR94oE4ibygnq2AJ2LgBY2Vd/U/B+MRv0ksY
         6KmLzxq7F7P5h2d0gBQZjt2UWOtUZy0xlc70IUhcd7JQiQK+MTzB7buaa/zGDEKZk7xF
         hk8416sUBJZJstYu9a3Q4DR6AZ7QIRharscHtCDy8qXgwASG2IUpQLd55kj+WUwFd42F
         D6mA==
X-Gm-Message-State: APjAAAXJVeAa2AaReoeFWDe+DCJUxLXBFXwRrk1vU2yz/K0k5Nucwb0Q
        bnHa6pmI/lJu92zl48MC7nvuQA==
X-Google-Smtp-Source: APXvYqzazHWNEpR6TDRVZdLb3zC82BtG8q56aJqXkTBYFpfvyUsFtFrKnrMMtTn/v7y7yNmvYXPxNg==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr4626118wrq.60.1574268018953;
        Wed, 20 Nov 2019 08:40:18 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id d7sm32334298wrx.11.2019.11.20.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:40:18 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:40:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: Fix Kconfig indentation
Message-ID: <20191120164016.GQ30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20191120133634.11601-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133634.11601-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:36:34PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

lima, mga200g and bridge patches also queued.
-Daniel

> ---
>  drivers/gpu/drm/bridge/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 34362976cd6f..176efa18e32c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -60,10 +60,10 @@ config DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL
>  	---help---
> -          This is a driver for the display bridges of
> -          GE B850v3 that convert dual channel LVDS
> -          to DP++. This is used with the i.MX6 imx-ldb
> -          driver. You are likely to say N here.
> +	  This is a driver for the display bridges of
> +	  GE B850v3 that convert dual channel LVDS
> +	  to DP++. This is used with the i.MX6 imx-ldb
> +	  driver. You are likely to say N here.
>  
>  config DRM_NXP_PTN3460
>  	tristate "NXP PTN3460 DP/LVDS bridge"
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
