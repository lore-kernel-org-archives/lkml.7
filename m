Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA2C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CA52168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEYPCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 11:02:07 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37976 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfEYPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 11:02:07 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7C9228036E;
        Sat, 25 May 2019 17:02:02 +0200 (CEST)
Date:   Sat, 25 May 2019 17:01:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 11/33] fbdev/sh_mobile: remove
 sh_mobile_lcdc_display_notify
Message-ID: <20190525150159.GA27341@ravnborg.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-12-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524085354.27411-12-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=e5mUnYsNAAAA:8
        a=48fi2nN1bOFThYuLmmEA:9 a=FjwzjW-X6r35EzHo:21 a=pi2SNfIRU6eJWu1B:21
        a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

> It's dead code, and removing it avoids me having to understand
> what it's doing with lock_fb_info.

I pushed the series through my build tests which include the sh
architecture.

One error and one warning was triggered from sh_mobile_lcdcfb.c.
The rest was fine.

The patch below removed the sole user of
sh_mobile_lcdc_must_reconfigure() so this triggers a warning.

And I also get the following error:
drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_fb_reconfig’:
drivers/video/fbdev/sh_mobile_lcdcfb.c:1800:2: error: implicit declaration of function ‘fbcon_update_vcs’; did you mean ‘file_update_time’? [-Werror=implicit-function-declaration]
  fbcon_update_vcs(info, true);
  ^~~~~~~~~~~~~~~~
  file_update_time

I did not check but assume the error was triggered in patch 28 where
fbcon_update_vcs() in introduced.


Both are trivially fixed by appended patch.

	Sam

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index bb1a610d0363..b8454424910d 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/fbcon.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -533,25 +534,6 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
 }
 
-static bool
-sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
-				const struct fb_videomode *new_mode)
-{
-	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
-		ch->display.mode.xres, ch->display.mode.yres,
-		new_mode->xres, new_mode->yres);
-
-	/* It can be a different monitor with an equal video-mode */
-	if (fb_mode_is_equal(&ch->display.mode, new_mode))
-		return false;
-
-	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
-		ch->display.mode.yres, new_mode->yres);
-	ch->display.mode = *new_mode;
-
-	return true;
-}
-
 static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
 				    struct fb_info *info);
 

 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 63 --------------------------
>  drivers/video/fbdev/sh_mobile_lcdcfb.h |  5 --
>  2 files changed, 68 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index dc46be38c970..c5924f5e98c6 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -556,67 +556,6 @@ sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
>  static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
>  				    struct fb_info *info);
>  
> -static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
> -					 enum sh_mobile_lcdc_entity_event event,
> -					 const struct fb_videomode *mode,
> -					 const struct fb_monspecs *monspec)
> -{
> -	struct fb_info *info = ch->info;
> -	struct fb_var_screeninfo var;
> -	int ret = 0;
> -
> -	switch (event) {
> -	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
> -		/* HDMI plug in */
> -		console_lock();
> -		if (lock_fb_info(info)) {
> -
> -
> -			ch->display.width = monspec->max_x * 10;
> -			ch->display.height = monspec->max_y * 10;
> -
> -			if (!sh_mobile_lcdc_must_reconfigure(ch, mode) &&
> -			    info->state == FBINFO_STATE_RUNNING) {
> -				/* First activation with the default monitor.
> -				 * Just turn on, if we run a resume here, the
> -				 * logo disappears.
> -				 */
> -				info->var.width = ch->display.width;
> -				info->var.height = ch->display.height;
> -				sh_mobile_lcdc_display_on(ch);
> -			} else {
> -				/* New monitor or have to wake up */
> -				fb_set_suspend(info, 0);
> -			}
> -
> -
> -			unlock_fb_info(info);
> -		}
> -		console_unlock();
> -		break;
> -
> -	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
> -		/* HDMI disconnect */
> -		console_lock();
> -		if (lock_fb_info(info)) {
> -			fb_set_suspend(info, 1);
> -			unlock_fb_info(info);
> -		}
> -		console_unlock();
> -		break;
> -
> -	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> -		/* Validate a proposed new mode */
> -		fb_videomode_to_var(&var, mode);
> -		var.bits_per_pixel = info->var.bits_per_pixel;
> -		var.grayscale = info->var.grayscale;
> -		ret = sh_mobile_lcdc_check_var(&var, info);
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
>  /* -----------------------------------------------------------------------------
>   * Format helpers
>   */
> @@ -2540,8 +2479,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
>  	unsigned int max_size;
>  	unsigned int i;
>  
> -	ch->notify = sh_mobile_lcdc_display_notify;
> -
>  	/* Validate the format. */
>  	format = sh_mobile_format_info(cfg->fourcc);
>  	if (format == NULL) {
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
> index b8e47a8bd8ab..589400372098 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
> @@ -87,11 +87,6 @@ struct sh_mobile_lcdc_chan {
>  	unsigned long base_addr_c;
>  	unsigned int line_size;
>  
> -	int (*notify)(struct sh_mobile_lcdc_chan *ch,
> -		      enum sh_mobile_lcdc_entity_event event,
> -		      const struct fb_videomode *mode,
> -		      const struct fb_monspecs *monspec);
> -
>  	/* Backlight */
>  	struct backlight_device *bl;
>  	unsigned int bl_brightness;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
