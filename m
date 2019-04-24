Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9382175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dr2wERG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbfDXTfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:35:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46074 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:35:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id k92so16965471edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=34HyKZYcFbb5nEQjRsgdBKbjHsnJQoci/P5SFoI56j8=;
        b=dr2wERG/4PvII1wnk/c4kxg/3N0Lncv9fscdZt8iycCY12SGA1coKN78En2kc7SmA1
         VlP6Ejqwk+IEVWpFL9jUPPNFI41KBM+ckxpIw/xE286ELzXoiUeVlXWIfW7A+g0Tqxyg
         wa3/TWL7RuAtKNdWnBaXKbANt9axdbvIrnvxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=34HyKZYcFbb5nEQjRsgdBKbjHsnJQoci/P5SFoI56j8=;
        b=e4f7Ai3P+6Nj+7SvJSNS/xC6jTQSICIk+awmGhstxQ61rI3EKNhCikT/xOR2yORAgS
         MbPe1p7tvgNdjrQD/aivMSOKSDV1SUW6pbAPsO6sGmCV12uGiaDetLOooRZMXkE/IPv8
         OMUksHNP86ugZOgaS7U+VnvyDMv6KbaV/YU89orarevWNX1Q8h4WJkvrfoqdVCG3bvpY
         c9/wmbKq+bSbm8k/budNkSVB8I1SPrb+zbyJFKk6F9R4pKoOhEg9v1qae0b7kuc/fhq+
         +eflPeB+aIFlDkCCrgPftDQbStwl1quy20m/RbJvH1gc7Wmsk3SLpF9ytBEXh8L5YaK6
         ThyQ==
X-Gm-Message-State: APjAAAVW2gjxfHe/nHx8f+06AXvfJwmNWk1MC4522B3syHyZA0k8Jdzu
        PEzEpMSiNxqcwgROHFoxxXZr/NqzNRg=
X-Google-Smtp-Source: APXvYqznoceKvTWi158pxtrSIx+iwcKdNuyRthMmP5WoBsFx4jcd4Lyg0EP3dVN91XSDgqtZNICO+A==
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr6448345eja.255.1556134552894;
        Wed, 24 Apr 2019 12:35:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n64sm5536293edc.82.2019.04.24.12.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:35:51 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:35:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/doc: Allow new UAPI to be used once it's in the
 driver's -next.
Message-ID: <20190424193548.GT9857@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190424185617.16865-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424185617.16865-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:56:16AM -0700, Eric Anholt wrote:
> I was trying to figure out if it was permissible to merge the Mesa
> side of V3D's CSD support yet while it's in drm-misc-next but not
> drm-next, and developers on #dri-devel IRC had differing opinions of
> what the requirement was.  Propose a clarification here to see if Dave
> Airlie agrees.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> Personally, I thought the rule was "has to be in drm-next", but
> assuming our review processes aren't totally broken, this should be
> enough.

Yeah if you end up with a revert on your hands the process failed much
harder and you get to keep the pieces no matter what. Not sure we should
clarify whether you need a stable sha1 or not (helps with cross
referencing uapi header updates), but imo good as is. And matches what
I've been doing/recommending past few years.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  Documentation/gpu/drm-uapi.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index c9fd23efd957..8e5545dfbf82 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -92,8 +92,9 @@ leads to a few additional requirements:
>    requirements by doing a quick fork.
>  
>  - The kernel patch can only be merged after all the above requirements are met,
> -  but it **must** be merged **before** the userspace patches land. uAPI always flows
> -  from the kernel, doing things the other way round risks divergence of the uAPI
> +  but it **must** be merged to the driver's -next tree (as documented in
> +  MAINTAINERS) **before** the userspace patches land. uAPI always flows from
> +  the kernel, doing things the other way round risks divergence of the uAPI
>    definitions and header files.
>  
>  These are fairly steep requirements, but have grown out from years of shared
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
