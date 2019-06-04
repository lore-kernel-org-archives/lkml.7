Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B946C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4472473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFDOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:20:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfFDOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:20:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C1B341;
        Tue,  4 Jun 2019 07:20:48 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D303F690;
        Tue,  4 Jun 2019 07:20:48 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 9C49868256F; Tue,  4 Jun 2019 15:20:46 +0100 (BST)
Date:   Tue, 4 Jun 2019 15:20:46 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/arm/hdlcd: Actually validate CRTC modes
Message-ID: <20190604142046.GM15316@e110455-lin.cambridge.arm.com>
References: <9db0bac184d9fa69c4f65bf954ab59b53d431e15.1558111042.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9db0bac184d9fa69c4f65bf954ab59b53d431e15.1558111042.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 05:37:21PM +0100, Robin Murphy wrote:
> Rather than allowing any old mode through, then subsequently refusing
> unmatchable clock rates in atomic_check when it's too late to back out
> and pick a different mode, let's do that validation up-front where it
> will cause unsupported modes to be correctly pruned in the first place.
> 
> This also eliminates an issue whereby a perceived clock rate of 0 would
> cause atomic disable to fail and prevent the module from being unloaded.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch!

Best regards,
Liviu

> ---
> 
> This supersedes my previous patch here:
> https://patchwork.freedesktop.org/patch/288553/
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 0b2b62f8fa3c..ecac6fe0b213 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -186,20 +186,19 @@ static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
>  	clk_disable_unprepare(hdlcd->clk);
>  }
>  
> -static int hdlcd_crtc_atomic_check(struct drm_crtc *crtc,
> -				   struct drm_crtc_state *state)
> +static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
> +		const struct drm_display_mode *mode)
>  {
>  	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
> -	struct drm_display_mode *mode = &state->adjusted_mode;
>  	long rate, clk_rate = mode->clock * 1000;
>  
>  	rate = clk_round_rate(hdlcd->clk, clk_rate);
>  	if (rate != clk_rate) {
>  		/* clock required by mode not supported by hardware */
> -		return -EINVAL;
> +		return MODE_NOCLOCK;
>  	}
>  
> -	return 0;
> +	return MODE_OK;
>  }
>  
>  static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -220,7 +219,7 @@ static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
>  }
>  
>  static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
> -	.atomic_check	= hdlcd_crtc_atomic_check,
> +	.mode_valid	= hdlcd_crtc_mode_valid,
>  	.atomic_begin	= hdlcd_crtc_atomic_begin,
>  	.atomic_enable	= hdlcd_crtc_atomic_enable,
>  	.atomic_disable	= hdlcd_crtc_atomic_disable,
> -- 
> 2.21.0.dirty
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
