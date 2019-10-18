Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B592CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193C6222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407747AbfJRJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:49:33 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60164 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2391488AbfJRJtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:49:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1790492;
        Fri, 18 Oct 2019 02:49:08 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26FD3F6C4;
        Fri, 18 Oct 2019 02:49:08 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 81002682189; Fri, 18 Oct 2019 10:49:07 +0100 (BST)
Date:   Fri, 18 Oct 2019 10:49:07 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, malidp@foss.arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/arm: make undeclared items static
Message-ID: <20191018094907.66ghzs3qiyelibzh@e110455-lin.cambridge.arm.com>
References: <20191017111756.12861-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017111756.12861-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:17:55PM +0100, Ben Dooks (Codethink) wrote:
> Make the following items static to avoid clashes with
> other parts of the kernel (dev_attr_core_id) or just
> silence the following sparse warning:
> 
> drivers/gpu/drm/arm/malidp_drv.c:371:24: warning: symbol 'malidp_fb_create' was not declared. Should it be static?
> drivers/gpu/drm/arm/malidp_drv.c:494:6: warning: symbol 'malidp_error_stats_dump' was not declared. Should it be static?
> drivers/gpu/drm/arm/malidp_drv.c:668:1: warning: symbol 'dev_attr_core_id' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the patch! As a side note: the dim tool that we use in the DRM subsystem
flags your S-o-b as being different from author, due to "(Codethink)" addition in the
email name.

Best regards,
Liviu

> ---
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: malidp@foss.arm.com
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> .. (open list)
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 333b88a5efb0..18ca43c9cef4 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -368,7 +368,7 @@ malidp_verify_afbc_framebuffer(struct drm_device *dev, struct drm_file *file,
>  	return false;
>  }
>  
> -struct drm_framebuffer *
> +static struct drm_framebuffer *
>  malidp_fb_create(struct drm_device *dev, struct drm_file *file,
>  		 const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
> @@ -491,9 +491,9 @@ void malidp_error(struct malidp_drm *malidp,
>  	spin_unlock_irqrestore(&malidp->errors_lock, irqflags);
>  }
>  
> -void malidp_error_stats_dump(const char *prefix,
> -			     struct malidp_error_stats error_stats,
> -			     struct seq_file *m)
> +static void malidp_error_stats_dump(const char *prefix,
> +				    struct malidp_error_stats error_stats,
> +				    struct seq_file *m)
>  {
>  	seq_printf(m, "[%s] num_errors : %d\n", prefix,
>  		   error_stats.num_errors);
> @@ -665,7 +665,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
>  	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
>  }
>  
> -DEVICE_ATTR_RO(core_id);
> +static DEVICE_ATTR_RO(core_id);
>  
>  static int malidp_init_sysfs(struct device *dev)
>  {
> -- 
> 2.23.0
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
