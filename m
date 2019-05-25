Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3DC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72266216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfEYRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:01:02 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46722 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfEYRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:01:01 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3D9D92013A;
        Sat, 25 May 2019 19:00:56 +0200 (CEST)
Date:   Sat, 25 May 2019 19:00:54 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 25/33] fbmem: pull fbcon_fb_blanked out of fb_blank
Message-ID: <20190525170054.GA9076@ravnborg.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-26-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524085354.27411-26-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
        a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=LPur_4bgEY2nh4B5VZsA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Fri, May 24, 2019 at 10:53:46AM +0200, Daniel Vetter wrote:
> There's a callchain of:
> 
> fbcon_fb_blaned -> do_(un)blank_screen -> consw->con_blank
           ^^^^^^
Spelling error - as this is a callchain it would be good to have it
fixed.

Patch itself looks fine.

	Sam

> 	-> fbcon_blank -> fb_blank
> 
> Things don't go horribly wrong because the BKL console_lock safes the
> day, but that's about it. And the seeming recursion is broken in 2
> ways:
> - Starting from the fbdev ioctl we set FBINFO_MISC_USEREVENT, which
>   tells the fbcon_blank code to not call fb_blank. This was required
>   to not deadlock when recursing on the fb_notifier_chain mutex.
> - Starting from the con_blank hook we're getting saved by the
>   console_blanked checks in do_blank/unblank_screen. Or at least
>   that's my theory.
> 
> Anyway, recursion isn't awesome, so let's stop it. Breaking the
> recursion avoids the need to be in the FBINFO_MISC_USEREVENT critical
> section, so lets move it out of that too.
> 
> The astute reader will notice that fb_blank seems to require
> lock_fb_info(), which the fbcon code seems to ignore. I have no idea
> how to fix that problem, so let's keep ignoring it.
> 
> v2: I forgot the sysfs blanking code.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/video/fbdev/core/fbmem.c   | 4 +++-
>  drivers/video/fbdev/core/fbsysfs.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 9366fbe99a58..d6713dce9e31 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1068,7 +1068,6 @@ fb_blank(struct fb_info *info, int blank)
>  	event.data = &blank;
>  
>  	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
> -	fbcon_fb_blanked(info, blank);
>  
>  	if (info->fbops->fb_blank)
>   		ret = info->fbops->fb_blank(blank, info);
> @@ -1198,6 +1197,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		info->flags |= FBINFO_MISC_USEREVENT;
>  		ret = fb_blank(info, arg);
>  		info->flags &= ~FBINFO_MISC_USEREVENT;
> +
> +		/* might again call into fb_blank */
> +		fbcon_fb_blanked(info, arg);
>  		unlock_fb_info(info);
>  		console_unlock();
>  		break;
> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
> index 5f329278e55f..252d4f52d2a5 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
> +#include <linux/fbcon.h>
>  #include <linux/console.h>
>  #include <linux/module.h>
>  
> @@ -305,12 +306,15 @@ static ssize_t store_blank(struct device *device,
>  {
>  	struct fb_info *fb_info = dev_get_drvdata(device);
>  	char *last = NULL;
> -	int err;
> +	int err, arg;
>  
> +	arg = simple_strtoul(buf, &last, 0);
>  	console_lock();
>  	fb_info->flags |= FBINFO_MISC_USEREVENT;
> -	err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
> +	err = fb_blank(fb_info, arg);
>  	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
> +	/* might again call into fb_blank */
> +	fbcon_fb_blanked(fb_info, arg);
>  	console_unlock();
>  	if (err < 0)
>  		return err;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
