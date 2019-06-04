Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6005B2473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfFDOVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:21:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45108 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfFDOVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:21:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCFD2341;
        Tue,  4 Jun 2019 07:21:29 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC983F690;
        Tue,  4 Jun 2019 07:21:29 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id ED44168256F; Tue,  4 Jun 2019 15:21:27 +0100 (BST)
Date:   Tue, 4 Jun 2019 15:21:27 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/arm/hdlcd: Allow a bit of clock tolerance
Message-ID: <20190604142127.GN15316@e110455-lin.cambridge.arm.com>
References: <9db0bac184d9fa69c4f65bf954ab59b53d431e15.1558111042.git.robin.murphy@arm.com>
 <47fb141ddbf4cf256951758d2e7f90afb6507ded.1558111042.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47fb141ddbf4cf256951758d2e7f90afb6507ded.1558111042.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 05:37:22PM +0100, Robin Murphy wrote:
> On the Arm Juno platform, the HDLCD pixel clock is constrained to 250KHz
> resolution in order to avoid the tiny System Control Processor spending
> aeons trying to calculate exact PLL coefficients. This means that modes
> like my oddball 1600x1200 with 130.89MHz clock get rejected since the
> rate cannot be matched exactly. In practice, though, this mode works
> quite happily with the clock at 131MHz, so let's relax the check to
> allow a little bit of slop.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I've pull the two patches into my malidp-fixes branch and I will send a pull
request today.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index ecac6fe0b213..a3efa28436ea 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -193,7 +193,8 @@ static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
>  	long rate, clk_rate = mode->clock * 1000;
>  
>  	rate = clk_round_rate(hdlcd->clk, clk_rate);
> -	if (rate != clk_rate) {
> +	/* 0.1% seems a close enough tolerance for the TDA19988 on Juno */
> +	if (abs(rate - clk_rate) * 1000 > clk_rate) {
>  		/* clock required by mode not supported by hardware */
>  		return MODE_NOCLOCK;
>  	}
> -- 
> 2.21.0.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
