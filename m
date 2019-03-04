Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A889206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="NjIMqtKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCDVBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:01:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41984 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCDVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:01:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so6686055qtg.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kjIyvTZTWr1h4eM/+Z/GerxN8L+TTFDhvAihL9ve7hs=;
        b=NjIMqtKWQlgZaJ03iUPJmvT9W54F6Dx0Sfs/g1WnV7lkHyr/KThVdqTe5qvF+TOY/1
         a9V9S9uk/0lgMh/sG6HKqzt96JfDX5cOctK+IP6P8pR/1OSL2bmtcIxiLWcMAcih+VH3
         hSmftOVfE9AclIIeZzv5zPD1Tye9oBS14kgEoA1AfEz1Q9Hw0DpwJE45s/SmGuEx/od+
         3/p+mWrItp4QDLXGyH4FXRb1eei8ASo6ybVA/axctTefbgEOMX1A8QLE9fUI5mhyhWPH
         7RJQYxVt+sC7y7bu4wD+impMcruL+XOJiTNTM631dKgHaevZUjGz5bzJEkdHurMpx9GK
         /8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kjIyvTZTWr1h4eM/+Z/GerxN8L+TTFDhvAihL9ve7hs=;
        b=F8Mzk/cC3caf1rPafnxkKGXwcuanIE2TnulOzOLyw6h5DP51K1zsQPTzHpilVFB5jb
         wys8oX4x5ZCsOkaPiUN15vCqU59oyDCxJH1MfUeHPb1JIAlv0CZdq5nVND/y0BhjL/FA
         wr8u2bcnRfgFH+23TrisXFG3XP5tQFymKo6FS4dQsKzcSHoFnYpsTm25PMZrjCWiL6Zz
         B185puc2tkh7CpUs9CjErmovl+rTaoNTZFfTAQ3QYrhIN2uiuK/2vJ7H0AgPtVcrfSlu
         //ApfS1SF4pKW0tsZoXqHgrSUW3TKcPCcnQu6HsHXsUsyC1mSbDI9UucvR1qK/9K1BwD
         4qsA==
X-Gm-Message-State: APjAAAU3VYFEslvqdPts0fEYk+Vsh03F8Dx5clDJ/VBIgtSeAAvms2+e
        Ecpri6xBUw5YcNOet1kFYQtA7w==
X-Google-Smtp-Source: APXvYqwO8HulYBGbvyWaWNi9bwcP1+3osH/LSnaX+FJLAFrzSZTg6SeQOuxCDPpQeH2sP67HoC/54w==
X-Received: by 2002:a0c:d968:: with SMTP id t37mr15874037qvj.195.1551733298172;
        Mon, 04 Mar 2019 13:01:38 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s47sm3682653qtj.34.2019.03.04.13.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 13:01:37 -0800 (PST)
Date:   Mon, 4 Mar 2019 16:01:36 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH RESEND] drm/msm: Truncate the buffer object name if the
 copy from user failed
Message-ID: <20190304210136.GC114153@art_vandelay>
References: <1550601619-31051-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550601619-31051-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:40:19AM -0700, Jordan Crouse wrote:
> (Resend since there was a compile error that I forgot to commit before sending)
> 
> If there is a error while doing a copy_from_user() for MSM_INFO_SET_NAME
> make sure to truncate the object name so that there isn't a chance that
> we'll have random data in the string.
> 
> This is on top of [1] reported and fixed by Dan Carpenter.
> 
> [1] https://patchwork.freedesktop.org/series/56656/
> 
> Fixes: f05c83e77460 ("drm/msm: add uapi to get/set debug name")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
>  drivers/gpu/drm/msm/msm_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 87eae44..906b2bb 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -852,8 +852,11 @@ static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
>  			break;
>  		}
>  		if (copy_from_user(msm_obj->name, u64_to_user_ptr(args->value),
> -				   args->len))
> +				   args->len)) {
> +			msm_obj->name[0] = '\0';
>  			ret = -EFAULT;
> +			break;
> +		}
>  		msm_obj->name[args->len] = '\0';
>  		for (i = 0; i < args->len; i++) {
>  			if (!isprint(msm_obj->name[i])) {
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
