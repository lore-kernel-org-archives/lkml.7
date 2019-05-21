Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D057C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01678217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfEUK4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:56:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:56971 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfEUK4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:56:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 03:56:34 -0700
X-ExtLoop1: 1
Received: from asaudi-mobl.ger.corp.intel.com (HELO [10.249.47.52]) ([10.249.47.52])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2019 03:56:31 -0700
Subject: Re: [PATCH 29/33] fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with
 direct calls
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>, Peter Rosin <peda@axentia.se>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-30-daniel.vetter@ffwll.ch>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <b91a6f78-43c2-796c-62f1-f84f2973c174@linux.intel.com>
Date:   Tue, 21 May 2019 12:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520082216.26273-30-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 20-05-2019 om 10:22 schreef Daniel Vetter:
> Create a new wrapper function for this, feels like there's some
> refactoring room here between the two modes.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/lcd.c          |  2 --
>  drivers/video/fbdev/core/fbcon.c       | 15 +++++++++------
>  drivers/video/fbdev/core/fbmem.c       | 13 ++-----------
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 11 +----------
>  include/linux/fb.h                     |  4 ----
>  include/linux/fbcon.h                  |  2 ++
>  6 files changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index 4b40c6a4d441..16298041b141 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -32,8 +32,6 @@ static int fb_notifier_callback(struct notifier_block *self,
>  	/* If we aren't interested in this event, skip it immediately ... */
>  	switch (event) {
>  	case FB_EVENT_BLANK:
> -	case FB_EVENT_MODE_CHANGE:
> -	case FB_EVENT_MODE_CHANGE_ALL:
>  	case FB_EARLY_EVENT_BLANK:
>  	case FB_R_EARLY_EVENT_BLANK:
>  		break;

Below it performs a call to set_mode() if it's none of the blanking events; it can be removed. :)

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c1a7476e980f..8cc62d340387 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3005,6 +3005,15 @@ static void fbcon_set_all_vcs(struct fb_info *info)
>  		fbcon_modechanged(info);
>  }
>  
> +
> +void fbcon_update_vcs(struct fb_info *info, bool all)
> +{
> +	if (all)
> +		fbcon_set_all_vcs(info);
> +	else
> +		fbcon_modechanged(info);
> +}
> +
>  int fbcon_mode_deleted(struct fb_info *info,
>  		       struct fb_videomode *mode)
>  {
> @@ -3314,12 +3323,6 @@ static int fbcon_event_notify(struct notifier_block *self,
>  	int idx, ret = 0;
>  
>  	switch(action) {
> -	case FB_EVENT_MODE_CHANGE:
> -		fbcon_modechanged(info);
> -		break;
> -	case FB_EVENT_MODE_CHANGE_ALL:
> -		fbcon_set_all_vcs(info);
> -		break;
>  	case FB_EVENT_SET_CONSOLE_MAP:
>  		/* called with console lock held */
>  		con2fb = event->data;
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index cbd58ba8a59d..55b88163edc2 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1039,17 +1039,8 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  	    !list_empty(&info->modelist))
>  		ret = fb_add_videomode(&mode, &info->modelist);
>  
> -	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
> -		struct fb_event event;
> -		int evnt = (activate & FB_ACTIVATE_ALL) ?
> -			FB_EVENT_MODE_CHANGE_ALL :
> -			FB_EVENT_MODE_CHANGE;
> -
> -		info->flags &= ~FBINFO_MISC_USEREVENT;
> -		event.info = info;
> -		event.data = &mode;
> -		fb_notifier_call_chain(evnt, &event);
> -	}
> +	if (!ret && (flags & FBINFO_MISC_USEREVENT))
> +		fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
>  
>  	return ret;
>  }
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 0d7a044852d7..bb1a610d0363 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1776,8 +1776,6 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
>  	struct sh_mobile_lcdc_chan *ch = info->par;
>  	struct fb_var_screeninfo var;
>  	struct fb_videomode mode;
> -	struct fb_event event;
> -	int evnt = FB_EVENT_MODE_CHANGE_ALL;
>  
>  	if (ch->use_count > 1 || (ch->use_count == 1 && !info->fbcon_par))
>  		/* More framebuffer users are active */
> @@ -1799,14 +1797,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
>  		/* Couldn't reconfigure, hopefully, can continue as before */
>  		return;
>  
> -	/*
> -	 * fb_set_var() calls the notifier change internally, only if
> -	 * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
> -	 * user event, we have to call the chain ourselves.
> -	 */
> -	event.info = info;
> -	event.data = &ch->display.mode;
> -	fb_notifier_call_chain(evnt, &event);
> +	fbcon_update_vcs(info, true);
>  }
>  
>  /*
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 4b9b882f8f52..54d6bee09121 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -124,16 +124,12 @@ struct fb_cursor_user {
>   * Register/unregister for framebuffer events
>   */
>  
> -/*	The resolution of the passed in fb_info about to change */ 
> -#define FB_EVENT_MODE_CHANGE		0x01
>  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
>  #define FB_EVENT_GET_CONSOLE_MAP        0x07
>  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
>  #define FB_EVENT_SET_CONSOLE_MAP        0x08
>  /*      A display blank is requested       */
>  #define FB_EVENT_BLANK                  0x09
> -/*      Private modelist is to be replaced */
> -#define FB_EVENT_MODE_CHANGE_ALL	0x0B
>  /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
>  #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
>  /*      A hardware display blank early change occurred */
> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> index 90e196c835dd..daaa97b0c9e6 100644
> --- a/include/linux/fbcon.h
> +++ b/include/linux/fbcon.h
> @@ -15,6 +15,7 @@ void fbcon_new_modelist(struct fb_info *info);
>  void fbcon_get_requirement(struct fb_info *info,
>  			   struct fb_blit_caps *caps);
>  void fbcon_fb_blanked(struct fb_info *info, int blank);
> +void fbcon_update_vcs(struct fb_info *info, bool all);
>  #else
>  static inline void fb_console_init(void) {}
>  static inline void fb_console_exit(void) {}
> @@ -29,6 +30,7 @@ void fbcon_new_modelist(struct fb_info *info) {}
>  void fbcon_get_requirement(struct fb_info *info,
>  			   struct fb_blit_caps *caps) {}
>  void fbcon_fb_blanked(struct fb_info *info, int blank) {}
> +void fbcon_update_vcs(struct fb_info *info, bool all) {}
>  #endif
>  
>  #endif /* _LINUX_FBCON_H */


