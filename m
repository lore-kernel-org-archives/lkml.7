Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JyY6MKaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfDOJaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:30:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44013 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDOJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:30:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so3839704edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5l4pZfeYVCgIufgTo6R8psP3r9rSQEmmZLpDCPOtF0s=;
        b=JyY6MKajUN9BMEB1et36TqA0OvogqYiKBxW2KDPayhIU0V2Oe1VKtP+WuCKSs8EmkD
         MEQvRpTYdC6zBHyPerWEfSHs8GlguDJJFlHv88Ny4MFiKYnQdMSFbo5oZ7nIt/WUXhVr
         kFRxGGlRYmaUQJ2eoqMYu7QsYXDDqGuOaGD5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5l4pZfeYVCgIufgTo6R8psP3r9rSQEmmZLpDCPOtF0s=;
        b=GQMXfeJCKZ8osG1frSDXFpHJtWpnZwLCmJ0KofmlGf3rN+zE9VgUiExD2RIvCTGoMJ
         n21gnCR5D6Xj8u6k/33yn/1XcK4vZfv9JeYdUM4xAc7TJAtnfDJkhonvkvuj2fBwbwuA
         IzCmcWfFkVKpnJ136se0e5JkvV3iKCX2+AxYDlz2sE8OU2ZVt/6oA43FvOVl2r/g3QQO
         8Jq8JEbrrhJwSpO+EtCQo9wfibDmGz+WiwabWHsSAdo02RPzT8qK7aWpHkYZmVvVPam7
         1OQkqzieOdHcHGZKXgXUDgnwnrnqdkbuFn+3xd7MBTQwyOuqOO/JM2Tn+KiigMdkdM9z
         oKYg==
X-Gm-Message-State: APjAAAXyZCEEyFXd/Iet3PzKqXO19qes6ALlFnRGA3SmE5bxvD3G7wzN
        THn3m97axZtEJODLMtndHHnaVFVID9k=
X-Google-Smtp-Source: APXvYqwOSqT+IrQ5iPzw+48vIYBra1hbx2/VCsTpdUnPeEnhUhNo5RGi49w2A6C+5dXOkiKn/2uBAQ==
X-Received: by 2002:a17:906:b84c:: with SMTP id ga12mr37748570ejb.253.1555320615142;
        Mon, 15 Apr 2019 02:30:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j12sm1155842eda.71.2019.04.15.02.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:30:14 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:30:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joel Stanley <joel@jms.id.au>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] drm: aspeed: Clean up Kconfig options
Message-ID: <20190415093012.GX2665@phenom.ffwll.local>
Mail-Followup-To: Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>, Andrew Jeffery <andrew@aj.id.au>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20190405081117.27339-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405081117.27339-1-joel@jms.id.au>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 06:41:17PM +1030, Joel Stanley wrote:
> The GFX IP is inside of the ASPEED BMC SoC so there is little use
> enabling it on a kernel that does not support ASPEED.
> 
> When building with COMPILE_TEST the architecture many not have CMA
> support, so to avoid breaking the build we only select these options if
> the architecture supports the contiguous allocator.
> 
> I suspect the DRM_PANEL came from a cut/paste error.
> 
> Fixes: 4f2a8f5898ec ("drm: Add ASPEED GFX driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Iirc you have commit rights, right?
-Daniel
> ---
> This fixes the powerpc next-20190405 build. Sorry Stephen!
> 
> v2: Clean up as well as fix the build
> v1: https://lore.kernel.org/lkml/20190405052830.27899-1-joel@jms.id.au/
> 
>  drivers/gpu/drm/aspeed/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
> index 42b74d18a41b..cccab520e02f 100644
> --- a/drivers/gpu/drm/aspeed/Kconfig
> +++ b/drivers/gpu/drm/aspeed/Kconfig
> @@ -1,11 +1,11 @@
>  config DRM_ASPEED_GFX
>  	tristate "ASPEED BMC Display Controller"
>  	depends on DRM && OF
> +	depends on (COMPILE_TEST || ARCH_ASPEED)
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
> -	select DRM_PANEL
> -	select DMA_CMA
> -	select CMA
> +	select DMA_CMA if HAVE_DMA_CONTIGUOUS
> +	select CMA if HAVE_DMA_CONTIGUOUS
>  	select MFD_SYSCON
>  	help
>  	  Chose this option if you have an ASPEED AST2500 SOC Display
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
