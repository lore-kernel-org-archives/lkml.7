Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC27C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B02251A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TfONsWXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfGWJMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:12:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfGWJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:12:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so43131863edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUaLpMwjN+04mbedwWGjJycg6zciRce+Wx0QmHNnWG4=;
        b=TfONsWXYMwUcKzbOc8dKiNMQy8TYUdmIoQw/WUQlxLxyyqCngcQdKbl1KNZvwnRRmf
         V0Maw3YkBT1ufYSMhG0xxoGE+vXwEZjs2ykDFBEW8e+OelNOqTpqhvG0uYj8FmXI5E8H
         QEYLqpAvH3nB6cOCBYZ4iWkKi/bSmbObu2coI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CUaLpMwjN+04mbedwWGjJycg6zciRce+Wx0QmHNnWG4=;
        b=K2MgcpPfn2PepPuv7njSP432x6mXgQNVSKlgBZQiQby1FNlP9mIFPXeK7pZC/0/yyS
         FA22l2pqWRPn2V8qDcOZPf6swkaSTSgXqBdbJf6Q1qYYfq9OO9XbgSqAlk3ixDI6xQHe
         d0U0KkjX1kNfmOHYNBooOpcBG/8QhUdiDc8H6ieJEmij2MkqyIx+W7C5bSKyHH++og3X
         jcCdkzp3C/4d0dFf+m1+/TZ7/J88+FM8TJHEcljwqnGtBBo/alH9WbWhUUl0vXwA+mHZ
         UAyxQpww9HxOeeM3rOkgv53uOfJYt2Adn1O8r7rS0XkmgV/qxoJ4KNN9dKyBEJ3UGOJk
         +6ig==
X-Gm-Message-State: APjAAAUOCxHDsMi6PO0GssTNNYQXyQ3qJfW038/y/f9JHm6w9v3aalbg
        zh2CZDzW+rTSErjwX5gTTqM=
X-Google-Smtp-Source: APXvYqyaNJ3RQfSE2Pc1ybxHU3JCZh30J9KHaIqNg/prriesBVnHAogUbD1aX5HDn5wGSbe77/RVoQ==
X-Received: by 2002:a17:906:802:: with SMTP id e2mr56439719ejd.59.1563873123345;
        Tue, 23 Jul 2019 02:12:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j7sm12201109eda.97.2019.07.23.02.12.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:12:02 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:12:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     james.qian.wang@arm.com, liviu.dudau@arm.com,
        brian.starkey@arm.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch
Subject: Re: [PATCH v2 -next] drm/komeda: remove set but not used variable
 'old'
Message-ID: <20190723091200.GV15868@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        james.qian.wang@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190709135808.56388-1-yuehaibing@huawei.com>
 <20190722055627.38008-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722055627.38008-1-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:56:27PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
>  In function komeda_plane_atomic_duplicate_state:
> drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
>  warning: variable old set but not used [-Wunused-but-set-variable
> 
> It is not used since commit 990dee3aa456 ("drm/komeda:
> Computing image enhancer internally")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix compile err

Ok this one worked, applied.

Thanks, Daniel

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index c095af1..98e915e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -158,7 +158,7 @@ static void komeda_plane_reset(struct drm_plane *plane)
>  static struct drm_plane_state *
>  komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  {
> -	struct komeda_plane_state *new, *old;
> +	struct komeda_plane_state *new;
>  
>  	if (WARN_ON(!plane->state))
>  		return NULL;
> @@ -169,8 +169,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  
>  	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
>  
> -	old = to_kplane_st(plane->state);
> -
>  	return &new->base;
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
