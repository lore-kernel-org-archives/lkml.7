Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A070218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGZNPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:15:35 -0400
Received: from foss.arm.com ([217.140.110.172]:43366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGZNPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:15:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B04337;
        Fri, 26 Jul 2019 06:15:34 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359573F694;
        Fri, 26 Jul 2019 06:15:34 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id E0CB4680121; Fri, 26 Jul 2019 14:15:32 +0100 (BST)
Date:   Fri, 26 Jul 2019 14:15:32 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Initialize and enable output polling on
 Komeda
Message-ID: <20190726131532.GP15612@e110455-lin.cambridge.arm.com>
References: <1564128018-22921-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564128018-22921-1-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:00:29AM +0000, Lowry Li (Arm Technology China) wrote:
> Initialize and enable output polling on Komeda.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 1462bac..26f2919 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_probe_helper.h>
>  
>  #include "komeda_dev.h"
>  #include "komeda_framebuffer.h"
> @@ -331,6 +332,8 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
>  	if (err)
>  		goto uninstall_irq;
>  
> +	drm_kms_helper_poll_init(drm);

Most of the drivers call this before registering the driver. But this is all
moot because I can't apply the patch on top of drm-misc-next, so not having
full context of what komeda_kms_attach looks like in your tree.

Best regards,
Liviu

> +
>  	return kms;
>  
>  uninstall_irq:
> @@ -348,6 +351,7 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm = &kms->base;
>  	struct komeda_dev *mdev = drm->dev_private;
>  
> +	drm_kms_helper_poll_fini(drm);
>  	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
>  	drm_irq_uninstall(drm);
> -- 
> 1.9.1
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
