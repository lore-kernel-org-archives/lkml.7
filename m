Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A4C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852902173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ih1HuuGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfGSNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:05:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41360 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:05:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so34412652eds.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Y5NlMhSpO0VyQx0ha3QqhFg3+xYgYUJ2KEPauiVoxY=;
        b=ih1HuuGtn1KrC32/4Glz27f/kABjff30TWWMylH5ohzHv458wMCCVyI5IH0pDOT4ZD
         aoI+8KpssatKdCdvWeqrn69QCNgrHF/LPyVttmhWgGS7HTSY5xeViY5asiPDUQoJMdYU
         CxY2/dTEXR2NFxLCrK2rQJQF4xZDUnNlAGTMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1Y5NlMhSpO0VyQx0ha3QqhFg3+xYgYUJ2KEPauiVoxY=;
        b=NGmY64f5Test+QCVQzYaqF3w/VceSa9bml+ScmJgpcGvm5Ol9LGWFZQHhs8pbZusHk
         KB0MiOICNDJYKED2BeAJjPCNG6fMieOwvMYOinJ9m8qk5XsBITKxJWmNxj3CHGXkk0fF
         BXPJsvu7eJf2H9FOGSbOkLVT0XMFhtZQS1uoIP/mbpGysrs9xa3unAzQk6YGq8F9NKin
         kN7Sj/TBhyVOT8f0Okfu5MFAU6tBCrMjC70M8ghREiagOr2STytnRweupC/BLigZNUs9
         LPorwDzipt7Y+H6Mj2pTDaabhfK62sBFEZ3+z962moYMO4z30BVFdDletQeBREsaz5xZ
         mhHw==
X-Gm-Message-State: APjAAAW8cV0/p9aOPcBXlmTFspI33Dd+TjyVs0nCCVF1d8gz5iGbWpAC
        gxiCL259F3xpzFMiZmV/p+o=
X-Google-Smtp-Source: APXvYqxPcBIc/kUti8pmP2meIW9/V9n5TtNotZwmEuAS3s2qNUF7hKzZkfvwNTTEOd1u4xQnQwRlhg==
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr40718573ejb.130.1563541499029;
        Fri, 19 Jul 2019 06:04:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q14sm6151066eju.47.2019.07.19.06.04.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 06:04:57 -0700 (PDT)
Date:   Fri, 19 Jul 2019 15:04:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>, james.qian.wang@arm.com,
        liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/komeda: remove set but not used variable 'old'
Message-ID: <20190719130455.GP15868@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        james.qian.wang@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190709135808.56388-1-yuehaibing@huawei.com>
 <20190718185150.GC15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718185150.GC15868@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 08:51:50PM +0200, Daniel Vetter wrote:
> On Tue, Jul 09, 2019 at 09:58:08PM +0800, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
> >  In function komeda_plane_atomic_duplicate_state:
> > drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
> >  warning: variable old set but not used [-Wunused-but-set-variable
> > 
> > It is not used since commit 990dee3aa456 ("drm/komeda:
> > Computing image enhancer internally")
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Queued for 5.3, thanks for your patch.

Correction, this doesn't even compile. Please compile-test patches before
submitting.

Thanks, Daniel

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > index c095af1..c1381ac 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -158,8 +158,6 @@ static void komeda_plane_reset(struct drm_plane *plane)
> >  static struct drm_plane_state *
> >  komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
> >  {
> > -	struct komeda_plane_state *new, *old;
> > -
> >  	if (WARN_ON(!plane->state))
> >  		return NULL;
> >  
> > @@ -169,8 +167,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
> >  
> >  	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
> >  
> > -	old = to_kplane_st(plane->state);
> > -
> >  	return &new->base;
> >  }
> >  
> > -- 
> > 2.7.4
> > 
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
