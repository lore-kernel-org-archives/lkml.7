Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EADC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EEC2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfEIP1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:27:33 -0400
Received: from foss.arm.com ([217.140.101.70]:44358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIP1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:27:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E09374;
        Thu,  9 May 2019 08:27:32 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30093F6C4;
        Thu,  9 May 2019 08:27:32 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 16712682412; Thu,  9 May 2019 16:27:31 +0100 (BST)
Date:   Thu, 9 May 2019 16:27:31 +0100
From:   "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [v1] drm/arm/mali-dp: Add a loop around the second set CVAL and
 try 5 times
Message-ID: <20190509152730.GP15144@e110455-lin.cambridge.arm.com>
References: <20190508105956.6107-1-wen.he_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508105956.6107-1-wen.he_1@nxp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:58:18AM +0000, Wen He wrote:
> This patch trying to fix monitor freeze issue caused by drm error
> 'flip_done timed out' on LS1028A platform. this set try is make a loop
> around the second setting CVAL and try like 5 times before giveing up.
> 
> Signed-off-by: Liviu <liviu.Dudau@arm.com>
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will pull this into my mali-dp tree and send it as fixes after v5.2-rc1.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 21725c9b9f5e..18cb7f134f4e 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -192,6 +192,7 @@ static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
>  {
>  	struct drm_device *drm = state->dev;
>  	struct malidp_drm *malidp = drm->dev_private;
> +	int loop = 5;
>  
>  	malidp->event = malidp->crtc.state->event;
>  	malidp->crtc.state->event = NULL;
> @@ -206,8 +207,18 @@ static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
>  			drm_crtc_vblank_get(&malidp->crtc);
>  
>  		/* only set config_valid if the CRTC is enabled */
> -		if (malidp_set_and_wait_config_valid(drm) < 0)
> +		if (malidp_set_and_wait_config_valid(drm) < 0) {
> +			/*
> +			 * make a loop around the second CVAL setting and
> +			 * try 5 times before giving up.
> +			 */
> +			while (loop--) {
> +				if (!malidp_set_and_wait_config_valid(drm))
> +					break;
> +			}
>  			DRM_DEBUG_DRIVER("timed out waiting for updated configuration\n");
> +		}
> +
>  	} else if (malidp->event) {
>  		/* CRTC inactive means vblank IRQ is disabled, send event directly */
>  		spin_lock_irq(&drm->event_lock);
> -- 
> 2.17.1
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
