Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C4C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB79214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392767AbfETRUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:20:15 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:52065 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733069AbfETRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:20:14 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 424FE2008D;
        Mon, 20 May 2019 19:20:10 +0200 (CEST)
Date:   Mon, 20 May 2019 19:20:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 27/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Message-ID: <20190520172008.GB27230@ravnborg.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-28-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520082216.26273-28-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
        a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=bDN84i_9AAAA:8 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=MCcOG3vBCl0DkZwRRUMA:9 a=QEXdDO2ut3YA:10
        a=J2PsDwZO0S0EpbpLmD-j:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

> With the recursion broken in the previous patch we can drop the
> FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
> prevention was it's only job.
> 
When grepping for FBINFO_MISC_USEREVENT I get a few hits not addressed
in the patch below:

drivers/video/fbdev/core/fbcon.c:                       if (!(info->flags & FBINFO_MISC_USEREVENT))
drivers/video/fbdev/core/fbmem.c:                       if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
drivers/video/fbdev/core/fbmem.c:                               info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbmem.c:               info->flags |= FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbmem.c:               info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbmem.c:               info->flags |= FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbmem.c:               info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |= FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |= FBINFO_MISC_USEREVENT;
drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/ps3fb.c:                            info->flags |= FBINFO_MISC_USEREVENT;
drivers/video/fbdev/ps3fb.c:                            info->flags &= ~FBINFO_MISC_USEREVENT;
drivers/video/fbdev/sh_mobile_lcdcfb.c:  * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
include/linux/fb.h:#define FBINFO_MISC_USEREVENT          0x10000 /* event request

The use in ps3fb looks like a candidate for removal and this file is not
touch in this patch series, so I guess I did not miss it.

As I did not apply the full series maybe some of the other users was
already taken care of.


	Sam

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c   | 5 ++---
>  drivers/video/fbdev/core/fbmem.c   | 3 ---
>  drivers/video/fbdev/core/fbsysfs.c | 2 --
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index f85d794a3bee..c1a7476e980f 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2382,9 +2382,8 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
>  			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
>  			ops->cursor_flash = (!blank);
>  
> -			if (!(info->flags & FBINFO_MISC_USEREVENT))
> -				if (fb_blank(info, blank))
> -					fbcon_generic_blank(vc, info, blank);
> +			if (fb_blank(info, blank))
> +				fbcon_generic_blank(vc, info, blank);
>  		}
>  
>  		if (!blank)
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 7f95c7e80155..65a075ccac4a 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1194,10 +1194,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  	case FBIOBLANK:
>  		console_lock();
>  		lock_fb_info(info);
> -		info->flags |= FBINFO_MISC_USEREVENT;
>  		ret = fb_blank(info, arg);
> -		info->flags &= ~FBINFO_MISC_USEREVENT;
> -
>  		/* might again call into fb_blank */
>  		fbcon_fb_blanked(info, arg);
>  		unlock_fb_info(info);
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index 252d4f52d2a5..882b471d619e 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -310,9 +310,7 @@ static ssize_t store_blank(struct device *device,
>  
>  	arg = simple_strtoul(buf, &last, 0);
>  	console_lock();
> -	fb_info->flags |= FBINFO_MISC_USEREVENT;
>  	err = fb_blank(fb_info, arg);
> -	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
>  	/* might again call into fb_blank */
>  	fbcon_fb_blanked(fb_info, arg);
>  	console_unlock();
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
