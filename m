Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D30C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729721655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Y7IdqX5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEHOfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:35:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44545 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfEHOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:35:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so13013726qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3CqV7qK/MYg0m3+i2Zpuf5DMfjvdX/UQG8imkRgo8G4=;
        b=Y7IdqX5SwtfUZhMC8Omj7ZnkfOutLCTgi99GUmAKTzJeA+tn5upJO2YMtJb0gbCT1a
         Ya/o8+LtVpEmBSX5gjKepenV9kfHwcVWfzyayXiH44+BpddsoK3sYXfePk/hMIYzczhG
         +CvJaScO1luWaIia9bjHEy0+TBUkVdOsjNMYDGElJtShKGzwb27gOyMdwjb47LPkYyTm
         8ZexTO4FrY/srB6LmYc/uaSkgX2RjwKflAdPOrQJTgF6fW3zPbgKGrhnily+9FjTR8Qk
         MwwZAvQqflQk3f9w6dAdUGbRQNtW5lx9PmJ4K7tc7uXjedIVZlN3fHMs/juLzjmlEAco
         j1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3CqV7qK/MYg0m3+i2Zpuf5DMfjvdX/UQG8imkRgo8G4=;
        b=NrQLgkfyOrl4fveTF7QZasHqLLxsmyOovnZ2rYbihpfAbacITCRS8Nm3OoszwsR4HN
         2+l+yYl/TgSx0lHoq34t7bg5svXsBUB2sRD+4hGC/hWraPf+BtTXe9Ac4GgbpPs7wLDq
         e7gq+foROF/olV1lc1joHXghMwDMjrf9hMI5B+/5F6aUXfbU1gwn4ys7Xa/CwEwnUWev
         3nhnjyfA59GXGv5OVzuULwja65OAQ7yZPCMgfGDtGXTbNQQQGL+98iLrAOGifBfoaAXc
         yS88wV41B/2Syuh5xa9H0WwD/OxtkFE9h9xmJKAord2oWgw1UYpzCcNgiYUw+QmhLB6d
         XUfA==
X-Gm-Message-State: APjAAAV6rYQ5nThU6Z5XILDxaO/Hb1O3x/lAyTqi4zc8Kj46H2O95f0a
        UCocHlU5sgiLRnI/Bhm29C2YCw==
X-Google-Smtp-Source: APXvYqwRXPijPs76WYJinxhIWtACNjsBn+EyW7O54bxbDoCzWVQhJluAtNSkYy2fL/8CdskcCrCziQ==
X-Received: by 2002:ad4:51c2:: with SMTP id p2mr14418052qvq.64.1557326148469;
        Wed, 08 May 2019 07:35:48 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10775869qts.39.2019.05.08.07.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 07:35:47 -0700 (PDT)
Date:   Wed, 8 May 2019 10:35:46 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: No zap shader is not an error
Message-ID: <20190508143546.GJ17077@art_vandelay>
References: <20190508130726.27557-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508130726.27557-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:06:52AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Depending on platform firmware, a zap shader may not be required to take
> the GPU out of secure mode on boot, in which case we can just write
> RBBM_SECVID_TRUST_CNTL directly.  Which we *mostly* handled, but missed
> clearing 'ret' resulting that hw_init() returned an error on these
> devices.
> 
> Fixes: abccb9fe3267 drm/msm/a6xx: Add zap shader load
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index ec24508b9d68..e74dce474250 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -527,6 +527,7 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>  		dev_warn_once(gpu->dev->dev,
>  			"Zap shader not enabled - using SECVID_TRUST_CNTL instead\n");
>  		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
> +		ret = 0;
>  	}
>  
>  out:
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
