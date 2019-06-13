Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FEFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC3A20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392517AbfFMQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbfFMQ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:29:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B293EF;
        Thu, 13 Jun 2019 09:29:28 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ED963F694;
        Thu, 13 Jun 2019 09:29:28 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 4867E682577; Thu, 13 Jun 2019 17:29:27 +0100 (BST)
Date:   Thu, 13 Jun 2019 17:29:27 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2] drm/komeda: Make Komeda interrupts shareable
Message-ID: <20190613162927.GS4173@e110455-lin.cambridge.arm.com>
References: <20190613151257.32297-1-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613151257.32297-1-ayan.halder@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:13:10PM +0100, Ayan Halder wrote:
> Komeda interrupts may be shared with other hardware blocks.
> One needs to use devm_request_irq() with IRQF_SHARED to create a shared
>  interrupt handler.
> As a result of not using drm_irq_install() api, one needs to set
> "(struct drm_device *)->irq_enabled = true/false" to enable/disable
> vblank interrupts.
> 
> Changes from v1:-
> 1. Squashed the following two patches into one (as the second patch is a
> consequence of the first one):-
>    drm/komeda: Avoid using DRIVER_IRQ_SHARED
>    drm/komeda: Enable/Disable vblank interrupts
> 2. Fixed the commit message (as pointed by Daniel Vetter)
> 3. Removed calls to 'drm_irq_uninstall()' as we are no longer using
> drm_irq_install()
> 4. Removed the struct member 'komeda_kms_driver.irq_handler' as it is not
> used anywhere.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 86f6542afb40..bb2bffc0e022 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -58,7 +58,6 @@ static struct drm_driver komeda_kms_driver = {
>  	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
>  			   DRIVER_PRIME | DRIVER_HAVE_IRQ,
>  	.lastclose			= drm_fb_helper_lastclose,
> -	.irq_handler			= komeda_kms_irq_handler,
>  	.gem_free_object_unlocked	= drm_gem_cma_free_object,
>  	.gem_vm_ops			= &drm_gem_cma_vm_ops,
>  	.dumb_create			= komeda_gem_cma_dumb_create,
> @@ -194,23 +193,26 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  
>  	drm_mode_config_reset(drm);
>  
> -	err = drm_irq_install(drm, mdev->irq);
> +	err = devm_request_irq(drm->dev, mdev->irq,
> +			       komeda_kms_irq_handler, IRQF_SHARED,
> +			       drm->driver->name, drm);
>  	if (err)
>  		goto cleanup_mode_config;
>  
>  	err = mdev->funcs->enable_irq(mdev);
>  	if (err)
> -		goto uninstall_irq;
> +		goto cleanup_mode_config;
> +
> +	drm->irq_enabled = true;
>  
>  	err = drm_dev_register(drm, 0);
>  	if (err)
> -		goto uninstall_irq;
> +		goto cleanup_mode_config;
>  
>  	return kms;
>  
> -uninstall_irq:
> -	drm_irq_uninstall(drm);
>  cleanup_mode_config:
> +	drm->irq_enabled = false;
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  free_kms:
> @@ -223,9 +225,9 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm = &kms->base;
>  	struct komeda_dev *mdev = drm->dev_private;
>  
> +	drm->irq_enabled = false;
>  	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
> -	drm_irq_uninstall(drm);
>  	component_unbind_all(mdev->dev, drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  	drm_mode_config_cleanup(drm);
> -- 
> 2.21.0
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
