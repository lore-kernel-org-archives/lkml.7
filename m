Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D983C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B3E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EDRSj31v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfDYGdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:33:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43767 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:33:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id j20so18105848edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTXAn44dgnwewbD4nK7WAUQTcmfHFtSEHSbl2pwtu9U=;
        b=EDRSj31vMOFXNyb8XVsy/YF9OT+wqWM9aE8btD01ljieX/7sKM1w24V+RIQL1b7pIX
         4KMw3UrefJnqTEF0WM/QTf7dVqUXn/Bj8elVCkyeZBDZ2U3F0sLYPNMp4/H2gHDm6HRN
         gxpygBgo/zftUY/xLVMQJ+jwGa4cB9R7f1fpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=eTXAn44dgnwewbD4nK7WAUQTcmfHFtSEHSbl2pwtu9U=;
        b=GDhlZxCkBWHuR9HoygCKcIPnnPFhu8bD90mkV59w3xI9R2IIHEgcr+3nIO3zciF/T6
         KE+TvhHI27Yktjcw53ZJf/wykfvvRd2tbBDKp5TSky2GmZ4sE/cia/V9ivP7wiWtxV3A
         +Z73bH8be7INSHUoKTpFj4YjWJmeasCq8j2R4d//1W4FwU08tdCbgTEO4mzl1lOxrtnf
         B/85YdP9nfBKGc/CmWNaa58XuBqg8shPUjoyJwSjLCeAuwBxuERVM4PzuLzQJcXxyZ8D
         NvZRtgm3TfiUzmRfWBZIrcIcQ+mcy3YNwaXp55Jc0igF75s2QDvz4fnNCWpLRNG1bTjy
         KS7Q==
X-Gm-Message-State: APjAAAUnKlGxFRjrVfmPem2B1LouZ0iDpvRZyrYcB7Z29aM54/EgiA6X
        m6j9v8a1vwEPj/5pYxzTba6U1UBPoJs=
X-Google-Smtp-Source: APXvYqydfA9fO6kOVOO2fdBjASaDnCkEwiYlF3YM7u0t3RmFdZXIrO6oULLsOIKDd1+x1ii3pzTVsg==
X-Received: by 2002:a17:906:e285:: with SMTP id gg5mr18600568ejb.229.1556174008233;
        Wed, 24 Apr 2019 23:33:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q1sm3873975ejx.81.2019.04.24.23.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 23:33:27 -0700 (PDT)
Date:   Thu, 25 Apr 2019 08:33:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] drm/doc: Allow new UAPI to be used once it's in
 drm-next/drm-misc-next.
Message-ID: <20190425063321.GX9857@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CAPM=9tw59Z7FRM-7-_VChOO__1+ahNhSs6=AceV7biasHjWKqg@mail.gmail.com>
 <20190424220638.16222-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424220638.16222-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:06:38PM -0700, Eric Anholt wrote:
> I was trying to figure out if it was permissible to merge the Mesa
> side of V3D's CSD support yet while it's in drm-misc-next but not
> drm-next, and developers on #dri-devel IRC had differing opinions of
> what the requirement was.
> 
> v2: Restrict to just drm-next or drm-misc-next on airlied's request.

Personally I think that's a bit too strict (if people want to screw up,
they will be able to anyway). But since I'm all for clearer rules where
possible, this has my support too.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  Documentation/gpu/drm-uapi.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index c9fd23efd957..b7a96dc02d21 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -92,9 +92,9 @@ leads to a few additional requirements:
>    requirements by doing a quick fork.
>  
>  - The kernel patch can only be merged after all the above requirements are met,
> -  but it **must** be merged **before** the userspace patches land. uAPI always flows
> -  from the kernel, doing things the other way round risks divergence of the uAPI
> -  definitions and header files.
> +  but it **must** be merged to either drm-next or drm-misc-next **before** the
> +  userspace patches land. uAPI always flows from the kernel, doing things the
> +  other way round risks divergence of the uAPI definitions and header files.
>  
>  These are fairly steep requirements, but have grown out from years of shared
>  pain and experience with uAPI added hastily, and almost always regretted about
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
