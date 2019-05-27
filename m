Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA3CC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F8E216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qt+GJqKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfE0GNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:13:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37373 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0GNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:13:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so24985283edw.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7H+ORXniLUXhza/9F/V7JlR5/dLzvYxJ/rvY50k/cqQ=;
        b=Qt+GJqKyBi7Z4GIlsDJm44jn9QgMDJoZbtJsoq2cecIpogAkNs6eVtLqUBQTPS89l8
         r9sJJ48UaZm44oPS8Er6slJi4lMpuBdas2bnXGPO7+bThZQwjg17Y8YowkS4Q+HAqt+R
         9yPRUlOQDQxLfIqvBMyFVB2/ar/Wmd1BfDzPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7H+ORXniLUXhza/9F/V7JlR5/dLzvYxJ/rvY50k/cqQ=;
        b=amDDq76PiPQWxMayOeFJJpgzB/QYUZidNklJ00f904dQf32DYwMWaYN0XpdjpHX4Fe
         SelG493zJ4iHBql+e5l0aSpGd8A8roKI2wdG9J46lzMnQWcqeFhbtFM+28H+2TiVJkF0
         tVVtxSr51JDrPa5bpD6DOxMGXESnkwFWPeeAAvgbccVnIgELPYWn8mgETdI77eecEiue
         JG+9Kt3BYD2Bakact5gtdKJ7AUowFEHwGfmD8Fy9LB9KZXesm9f49eGYHfoOrXREeeXT
         U2Cr48zDpW/5ZMRMMSj1BauJ8fKkcPoTly2ZQ2AB2A8I26yx7DAPqzDb0l8y6u6HuhXc
         ZiaQ==
X-Gm-Message-State: APjAAAVHzrQE2TVmurY0PlOZpC+2RwbC2F0dTc/BYuRzMV8TKBKNLR/R
        zYOWONT6Xgxs8GFPkCtvfWjcsQ==
X-Google-Smtp-Source: APXvYqyuoibuLqARzQXzG1SGagVDv3LZfHT6fRhglSZSYG2mqhYXxsrhbqeogYbGhbwy4FE9kaTkIQ==
X-Received: by 2002:a50:89e3:: with SMTP id h32mr59542599edh.51.1558937588733;
        Sun, 26 May 2019 23:13:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d90sm3001616edd.96.2019.05.26.23.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 23:13:08 -0700 (PDT)
Date:   Mon, 27 May 2019 08:13:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 11/33] fbdev/sh_mobile: remove
 sh_mobile_lcdc_display_notify
Message-ID: <20190527061306.GG21222@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-12-daniel.vetter@ffwll.ch>
 <20190525150159.GA27341@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525150159.GA27341@ravnborg.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 05:01:59PM +0200, Sam Ravnborg wrote:
> Hi Daniel
> 
> > It's dead code, and removing it avoids me having to understand
> > what it's doing with lock_fb_info.
> 
> I pushed the series through my build tests which include the sh
> architecture.
> 
> One error and one warning was triggered from sh_mobile_lcdcfb.c.
> The rest was fine.
> 
> The patch below removed the sole user of
> sh_mobile_lcdc_must_reconfigure() so this triggers a warning.
> 
> And I also get the following error:
> drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_fb_reconfig’:
> drivers/video/fbdev/sh_mobile_lcdcfb.c:1800:2: error: implicit declaration of function ‘fbcon_update_vcs’; did you mean ‘file_update_time’? [-Werror=implicit-function-declaration]
>   fbcon_update_vcs(info, true);
>   ^~~~~~~~~~~~~~~~
>   file_update_time
> 
> I did not check but assume the error was triggered in patch 28 where
> fbcon_update_vcs() in introduced.

Oops. Can I have your sob so I can squash this in?

Thanks, Daniel

> 
> 
> Both are trivially fixed by appended patch.
> 
> 	Sam
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index bb1a610d0363..b8454424910d 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -15,6 +15,7 @@
>  #include <linux/ctype.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> +#include <linux/fbcon.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -533,25 +534,6 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
>  		ch->tx_dev->ops->display_off(ch->tx_dev);
>  }
>  
> -static bool
> -sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
> -				const struct fb_videomode *new_mode)
> -{
> -	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
> -		ch->display.mode.xres, ch->display.mode.yres,
> -		new_mode->xres, new_mode->yres);
> -
> -	/* It can be a different monitor with an equal video-mode */
> -	if (fb_mode_is_equal(&ch->display.mode, new_mode))
> -		return false;
> -
> -	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
> -		ch->display.mode.yres, new_mode->yres);
> -	ch->display.mode = *new_mode;
> -
> -	return true;
> -}
> -
>  static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
>  				    struct fb_info *info);
>  
> 
>  
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/video/fbdev/sh_mobile_lcdcfb.c | 63 --------------------------
> >  drivers/video/fbdev/sh_mobile_lcdcfb.h |  5 --
> >  2 files changed, 68 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> > index dc46be38c970..c5924f5e98c6 100644
> > --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> > @@ -556,67 +556,6 @@ sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
> >  static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
> >  				    struct fb_info *info);
> >  
> > -static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
> > -					 enum sh_mobile_lcdc_entity_event event,
> > -					 const struct fb_videomode *mode,
> > -					 const struct fb_monspecs *monspec)
> > -{
> > -	struct fb_info *info = ch->info;
> > -	struct fb_var_screeninfo var;
> > -	int ret = 0;
> > -
> > -	switch (event) {
> > -	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
> > -		/* HDMI plug in */
> > -		console_lock();
> > -		if (lock_fb_info(info)) {
> > -
> > -
> > -			ch->display.width = monspec->max_x * 10;
> > -			ch->display.height = monspec->max_y * 10;
> > -
> > -			if (!sh_mobile_lcdc_must_reconfigure(ch, mode) &&
> > -			    info->state == FBINFO_STATE_RUNNING) {
> > -				/* First activation with the default monitor.
> > -				 * Just turn on, if we run a resume here, the
> > -				 * logo disappears.
> > -				 */
> > -				info->var.width = ch->display.width;
> > -				info->var.height = ch->display.height;
> > -				sh_mobile_lcdc_display_on(ch);
> > -			} else {
> > -				/* New monitor or have to wake up */
> > -				fb_set_suspend(info, 0);
> > -			}
> > -
> > -
> > -			unlock_fb_info(info);
> > -		}
> > -		console_unlock();
> > -		break;
> > -
> > -	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
> > -		/* HDMI disconnect */
> > -		console_lock();
> > -		if (lock_fb_info(info)) {
> > -			fb_set_suspend(info, 1);
> > -			unlock_fb_info(info);
> > -		}
> > -		console_unlock();
> > -		break;
> > -
> > -	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> > -		/* Validate a proposed new mode */
> > -		fb_videomode_to_var(&var, mode);
> > -		var.bits_per_pixel = info->var.bits_per_pixel;
> > -		var.grayscale = info->var.grayscale;
> > -		ret = sh_mobile_lcdc_check_var(&var, info);
> > -		break;
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> >  /* -----------------------------------------------------------------------------
> >   * Format helpers
> >   */
> > @@ -2540,8 +2479,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
> >  	unsigned int max_size;
> >  	unsigned int i;
> >  
> > -	ch->notify = sh_mobile_lcdc_display_notify;
> > -
> >  	/* Validate the format. */
> >  	format = sh_mobile_format_info(cfg->fourcc);
> >  	if (format == NULL) {
> > diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
> > index b8e47a8bd8ab..589400372098 100644
> > --- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
> > +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
> > @@ -87,11 +87,6 @@ struct sh_mobile_lcdc_chan {
> >  	unsigned long base_addr_c;
> >  	unsigned int line_size;
> >  
> > -	int (*notify)(struct sh_mobile_lcdc_chan *ch,
> > -		      enum sh_mobile_lcdc_entity_event event,
> > -		      const struct fb_videomode *mode,
> > -		      const struct fb_monspecs *monspec);
> > -
> >  	/* Backlight */
> >  	struct backlight_device *bl;
> >  	unsigned int bl_brightness;
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
