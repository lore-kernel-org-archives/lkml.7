Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35888C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155CA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfFQNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:33:27 -0400
Received: from foss.arm.com ([217.140.110.172]:50190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFQNd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:33:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A2CC28;
        Mon, 17 Jun 2019 06:33:26 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB533F246;
        Mon, 17 Jun 2019 06:33:26 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 260E9682413; Mon, 17 Jun 2019 14:33:25 +0100 (BST)
Date:   Mon, 17 Jun 2019 14:33:25 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
Message-ID: <20190617133325.GZ4173@e110455-lin.cambridge.arm.com>
References: <20190617125121.1414507-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617125121.1414507-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:51:04PM +0200, Arnd Bergmann wrote:
> clang points out a bug in the clock calculation on 32-bit, that leads
> to the clock_ratio always being zero:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:31:36: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         aclk = komeda_calc_aclk(kcrtc_st) << 32;
> 
> Move the shift into the division to make it apply on a 64-bit
> variable. Also use the more expensive div64_u64() instead of div_u64()
> to account for pxlclk being a 64-bit integer.
> 
> Fixes: a962091227ed ("drm/komeda: Add engine clock requirement check for the downscaling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch, I will pull it into the komeda tree.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index cafb4457e187..3f222f464eb2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -28,10 +28,9 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
>  	}
>  
>  	pxlclk = kcrtc_st->base.adjusted_mode.clock * 1000;
> -	aclk = komeda_calc_aclk(kcrtc_st) << 32;
> +	aclk = komeda_calc_aclk(kcrtc_st);
>  
> -	do_div(aclk, pxlclk);
> -	kcrtc_st->clock_ratio = aclk;
> +	kcrtc_st->clock_ratio = div64_u64(aclk << 32, pxlclk);
>  }
>  
>  /**
> -- 
> 2.20.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
