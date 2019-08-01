Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D094C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0282720644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="G3SrUa45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfHAOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:24:12 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44943 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfHAOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:24:11 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so26169708ywe.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YASKrLlbJRP8fvLhH4iPtQLrp26GJFL1b4mQHAA3AZs=;
        b=G3SrUa45PitiX3FLd4WSjcX0/D+PiaY3ftdOKTBVZWYrr05t6Z6UnYx8gHIv5sJto+
         aCH/f0iQR7qVNrhpKy4gGNgVHUVddCtXJfJ6G5eiNLeQmyBFyS+UCxErnVxgHyVOoaeB
         KeIOjIaizmbgQZPOcF/whbIjQ1fcRaRLiU33ofo953MELCgPiTphUff8t3Gd1M6ILcG3
         EGx3NN3+gzUPFQzJXVyps1G8XxykDIhvujKRCZmlQdvJlIboje1DtreCzOsY5h/o7CaE
         9JTHaJUUW/53+gdSWR3WTjlxCxO+u27XJ5mW2ayEn2CTXrJGaGE3GeicDecNjo6tfCZE
         wfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YASKrLlbJRP8fvLhH4iPtQLrp26GJFL1b4mQHAA3AZs=;
        b=rn8lj4oBilpzE1AJ6pATlZF5CyZ+Tef3EuRrsmF6hrXYLF+2JSgRJ4WKWwJHFbwIYs
         GPHzCAmVZJ1gYA4IiedQHgHN6Pv3eqmXbVuAwbcLOlXSeUUlhXemNZrB+E1PrK9d0s9p
         aQO/HZvzNiJl0dQBJslRPlliWdhBRBXayftQ8YtJZeehjpsSt3HZ87IO+Adww+V2t3Jv
         l5pDlNRSzysxCxbYyR9r+XygxYbFyyUenRqETX+gLyZ2bVU3bc2A6IP7gPRZQxxBkS9T
         384iY5sN+jwdY/rZ8hYVSe1MtgPWllpiCQjekzuPem9eU3ZPzNXiCqxm8X+he/jJ/+yd
         iMeg==
X-Gm-Message-State: APjAAAVUdQmJ9nWvUJGid8cxZUBASlKm7K3W4y9qvc6jrhhkSHV7Yunm
        uZU5rAzgTGf48baR9jRthiRooQ==
X-Google-Smtp-Source: APXvYqwX5+pgDm5RwnFmpQ4KELkPqv3W0V2bu85OXQs2pia4gyCUw5jUZwHp2+qbU88Muf0rrb0reg==
X-Received: by 2002:a81:2710:: with SMTP id n16mr74951691ywn.209.1564669451110;
        Thu, 01 Aug 2019 07:24:11 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id m124sm16302442ywc.51.2019.08.01.07.24.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:24:10 -0700 (PDT)
Date:   Thu, 1 Aug 2019 10:24:10 -0400
From:   Sean Paul <sean@poorly.run>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: msm: a6xx: Mark expected switch fall-through
Message-ID: <20190801142410.GU104440@art_vandelay>
References: <20190726112746.19410-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726112746.19410-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:27:46PM +0200, Anders Roxell wrote:
> When fall-through warnings was enabled by default the following warning
> was starting to show up:
> 
> ../drivers/gpu/drm/msm/adreno/a6xx_gpu.c: In function ‘a6xx_submit’:
> ../drivers/gpu/drm/msm/adreno/a6xx_gpu.c:116:7: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>     if (priv->lastctx == ctx)
>        ^
> ../drivers/gpu/drm/msm/adreno/a6xx_gpu.c:118:3: note: here
>    case MSM_SUBMIT_CMD_BUF:
>    ^~~~
> 
> Rework so that the compiler doesn't warn about fall-through.
> 
> Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Hi Anders,
Thank you for your patches. Jordan had previously sent the same fixes in
"drm/msm: Annotate intentional switch statement fall throughs" one day earlier
than yours, so I'll pick up that patch.

Thanks again!

Sean

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index be39cf01e51e..644a6ee53f05 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -115,6 +115,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
>  			if (priv->lastctx == ctx)
>  				break;
> +			/* Fall through */
>  		case MSM_SUBMIT_CMD_BUF:
>  			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
>  			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
