Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9943AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691C921734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="JYS8nhvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfEHU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:27:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33904 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfEHU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:27:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id j6so15615qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y1oAL2e+nDxNSlN8Pn+qOcIb2+7Ea2X17YXpRqljKsI=;
        b=JYS8nhvWxAfBtVu9xdrLwq3zymLBJolq7Z9h0ZdiIgsCPff2mlXK3P72whWTnh4qGo
         Ovg1aPAs0W8mSKgvaqdCikqOluGa84/dKcPAijH55blUXF4x6wpB06Gv7KbwF80938Wm
         XLa66QvaPs8fLJ/hTq3p38J3z9RxOCvASvTkW3wDhvZVGQRRP+YAd6Lo3RZywh5rIWIS
         +kpbU+4YKEaRU+N8OXKOx6Fx+ldPmplcErXwrt05qb3uuzpzvUSppLHPCPWX+4XRXvMP
         Iw5H+K1Em7mb34jBBW3APKQTwZr5vmROWfBMkWt6Ga/vrZ57PaRmMhjTJ88APBbAOYDj
         99+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y1oAL2e+nDxNSlN8Pn+qOcIb2+7Ea2X17YXpRqljKsI=;
        b=Ba+62hzDckEc1VdknHIjfu0Gc1AIY6L5jFKykeHZMGhMj0EPalay/UgRUUVoFhttvU
         2c6MetmWKBDd3KOGUK7hD/NNVMmoYbl8fGeRjzR34KDOBkBcKe+tYOHTCAn4db+IAdxE
         O9hQqxQcSBztBzx6vb0DOxXBqHxg5K6VcKORRr9K6U9BJbPZwCIvYVet65Xw/bqXNPgF
         w+RbkRabPjf6Xjtk7UCoBG6rRRlkRO+qtJhZ2kouKuexkabxfzRAJlbCowaVziML3D+J
         nCyYgvg9u5cHazTtkq3K/ybQFjB8LI6WJq9lWX7lhJffrdTmJlCbiC+U4fnWiRYk/XtV
         Y48Q==
X-Gm-Message-State: APjAAAV5j6k2Y7et8bIaJgx7nS5COl5Xrudq0EGbD0OG5YURfGWfRJaX
        8Mk+fHxNpEaUqazc+pEzRbf6XQ==
X-Google-Smtp-Source: APXvYqxI348a5G44Us1OX3HYd/MQ95CBhXbRtWT/DUszb4SCQek/YD2KQUahgddFgYiOum1m0aUGCA==
X-Received: by 2002:ad4:4587:: with SMTP id x7mr164380qvu.192.1557347243293;
        Wed, 08 May 2019 13:27:23 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id n66sm9721679qkc.36.2019.05.08.13.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:27:22 -0700 (PDT)
Date:   Wed, 8 May 2019 16:27:21 -0400
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
Message-ID: <20190508202721.GL17077@art_vandelay>
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

As discussed on IRC, I've stuffed this in -misc-next-fixes for the next PR I'm
sending out.

Sean

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
