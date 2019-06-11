Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F329C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA722080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fk+KKf4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbfFKPjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:39:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33564 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388362AbfFKPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:39:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so20793739edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCKJrlHJ2rcgM7LbwO8NTE67CMy/Nc+h2uBoKNkjaRk=;
        b=fk+KKf4/mJFPrmi+CjAX8He/QrYRyFausqaG8WXXLijeZtmoapPjbk8/3poke78a8d
         Cs5Ty7LPFsllXjnzAopJxRjbcUoJy42GhKnZDrvw+rgAEsjz0KRoHjfLowGKf1vDuoOl
         0rGSjXcQB/2YYSoTBUQdZ7WJRMW8xLzD8UGy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YCKJrlHJ2rcgM7LbwO8NTE67CMy/Nc+h2uBoKNkjaRk=;
        b=dFCu0Lnv5UVVjLvjaDUNEhA9p2jkXVdm0EMmIdE9qMDVUVbQ32bNqzqfXfVl9BNkFG
         klrwrhUS17tt4MUZ284X/fW41fjtxbQATeY7bgt1n1Q7YR/KCumpAyvxrIBd2bNFwQdP
         K0tWzNMwDqBUqPtfPBwMJaaeRSNmEOsApIk2G36eIFSDXql47lXNXxrUNcPni3kNm3wy
         EJjThg9qEuKmUDJKVqu4X/4mhkFLrB60AnCWCEkpHN4kU95b0yoZcuR2PoGxbj05i5lU
         iOkaYKFQZ59dGrATqLM0bCCxDapiibHkCUYF6dKnlB5zec+GSijRPndicfc+Hrje6p94
         KRLQ==
X-Gm-Message-State: APjAAAWGpPfl4btatc49hirapXuIl10pf+sokELWq5C0fVpYkpEiWOeA
        uDIbC9ZIN1kPEN/fAwgnCk15xg==
X-Google-Smtp-Source: APXvYqz88cWBUDjUoBHGn72GG1IyGH9mqwTxUwQrWTQmkl1DXXjou7JenyuL9kCKyi44a1l24BxmOA==
X-Received: by 2002:a17:906:8d8:: with SMTP id o24mr65720732eje.235.1560267558194;
        Tue, 11 Jun 2019 08:39:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b10sm2350986ejb.30.2019.06.11.08.39.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 08:39:17 -0700 (PDT)
Date:   Tue, 11 Jun 2019 17:39:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: Re: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Message-ID: <20190611153914.GF2458@phenom.ffwll.local>
Mail-Followup-To: Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
 <20190528090304.9388-25-daniel.vetter@ffwll.ch>
 <20190611140929.ufkz3rz3pjw75qgy@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611140929.ufkz3rz3pjw75qgy@holly.lan>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:09:29PM +0100, Daniel Thompson wrote:
> On Tue, May 28, 2019 at 11:02:55AM +0200, Daniel Vetter wrote:
> > This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.
> > 
> > The justification is that if hw blanking fails (i.e. fbops->fb_blank)
> > fails, then we still want to shut down the backlight. Which is exactly
> > _not_ what fb_blank() does and so rather inconsistent if we end up
> > with different behaviour between fbcon and direct fbdev usage. Given
> > that the entire notifier maze is getting in the way anyway I figured
> > it's simplest to revert this not well justified commit.
> > 
> > v2: Add static inline to the dummy version.
> > 
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: linux-fbdev@vger.kernel.org
> 
> This was the main patch where I wanted the bigger picture ;-) and TBH
> I'm still in two minds here. I don't personally view fbcon as
> inconsistent, more that, as an in-kernel service it might have to do
> more that something more complicated than freak out and let userspace
> decide what to do next.

I think the story is even worse, at least for drm-based drivers:

- We have the fbcon code here, which did something slightly different than
  fbdev modesets called through /dev/fb*.

- For most x86 drivers the expectations is that userspace handles the
  backlight over modesets (enabling/disabling as needed), and the rules
  for which backlight to pick extremely arcane: There's no link in sysfs
  or anywhere else from a drm connector to the corresponding backlight
  device.

- But some other drivers, mostly on the soc side, handle backlight
  enabling/disabling themselves, as part of the usual drm modeset
  sequence. And I suspect that at least some drm userspace more geared
  towards userspace doesn't bother handling the backlight on its own.

I don't have any plan yet how to get us out of this whole, but figured
this patch here should at least simplifiy things a bit.

Just fyi a bit more context here, I think there's more work to do :-/
-Daniel

> However... since I'm struggling to make up my mind, I can't think of
> many products that would ship reliant exclusively on fbcon *and* this
> patch is more about fbcon than backlight then I figure that, from a
> backlight perspective:
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> Daniel.
> 
> 
> > ---
> >  drivers/video/backlight/backlight.c |  2 +-
> >  drivers/video/fbdev/core/fbcon.c    | 14 +-------------
> >  drivers/video/fbdev/core/fbmem.c    |  1 +
> >  include/linux/fb.h                  |  4 +---
> >  include/linux/fbcon.h               |  2 ++
> >  5 files changed, 6 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> > index 1ef8b6fd62ac..5dc07106a59e 100644
> > --- a/drivers/video/backlight/backlight.c
> > +++ b/drivers/video/backlight/backlight.c
> > @@ -47,7 +47,7 @@ static int fb_notifier_callback(struct notifier_block *self,
> >  	int fb_blank = 0;
> >  
> >  	/* If we aren't interested in this event, skip it immediately ... */
> > -	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
> > +	if (event != FB_EVENT_BLANK)
> >  		return 0;
> >  
> >  	bd = container_of(self, struct backlight_device, fb_notif);
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index ef69bd4ad343..a4617067ff24 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2350,8 +2350,6 @@ static int fbcon_switch(struct vc_data *vc)
> >  static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
> >  				int blank)
> >  {
> > -	struct fb_event event;
> > -
> >  	if (blank) {
> >  		unsigned short charmask = vc->vc_hi_font_mask ?
> >  			0x1ff : 0xff;
> > @@ -2362,13 +2360,6 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
> >  		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
> >  		vc->vc_video_erase_char = oldc;
> >  	}
> > -
> > -
> > -	lock_fb_info(info);
> > -	event.info = info;
> > -	event.data = &blank;
> > -	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
> > -	unlock_fb_info(info);
> >  }
> >  
> >  static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
> > @@ -3240,7 +3231,7 @@ int fbcon_fb_registered(struct fb_info *info)
> >  	return ret;
> >  }
> >  
> > -static void fbcon_fb_blanked(struct fb_info *info, int blank)
> > +void fbcon_fb_blanked(struct fb_info *info, int blank)
> >  {
> >  	struct fbcon_ops *ops = info->fbcon_par;
> >  	struct vc_data *vc;
> > @@ -3344,9 +3335,6 @@ static int fbcon_event_notify(struct notifier_block *self,
> >  		con2fb = event->data;
> >  		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
> >  		break;
> > -	case FB_EVENT_BLANK:
> > -		fbcon_fb_blanked(info, *(int *)event->data);
> > -		break;
> >  	case FB_EVENT_REMAP_ALL_CONSOLE:
> >  		idx = info->node;
> >  		fbcon_remap_all(idx);
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index ddc0c16b8bbf..9366fbe99a58 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1068,6 +1068,7 @@ fb_blank(struct fb_info *info, int blank)
> >  	event.data = &blank;
> >  
> >  	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
> > +	fbcon_fb_blanked(info, blank);
> >  
> >  	if (info->fbops->fb_blank)
> >   		ret = info->fbops->fb_blank(blank, info);
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 0d86aa31bf8d..1e66fac3124f 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -137,12 +137,10 @@ struct fb_cursor_user {
> >  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
> >  #define FB_EVENT_SET_CONSOLE_MAP        0x08
> > -/*      A hardware display blank change occurred */
> > +/*      A display blank is requested       */
> >  #define FB_EVENT_BLANK                  0x09
> >  /*      Private modelist is to be replaced */
> >  #define FB_EVENT_MODE_CHANGE_ALL	0x0B
> > -/*	A software display blank change occurred */
> > -#define FB_EVENT_CONBLANK               0x0C
> >  /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
> >  #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
> >  /*      A hardware display blank early change occurred */
> > diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> > index 305e4f2eddac..d67d7ec51ef9 100644
> > --- a/include/linux/fbcon.h
> > +++ b/include/linux/fbcon.h
> > @@ -14,6 +14,7 @@ int fbcon_mode_deleted(struct fb_info *info,
> >  void fbcon_new_modelist(struct fb_info *info);
> >  void fbcon_get_requirement(struct fb_info *info,
> >  			   struct fb_blit_caps *caps);
> > +void fbcon_fb_blanked(struct fb_info *info, int blank);
> >  #else
> >  static inline void fb_console_init(void) {}
> >  static inline void fb_console_exit(void) {}
> > @@ -27,6 +28,7 @@ static inline int fbcon_mode_deleted(struct fb_info *info,
> >  static inline void fbcon_new_modelist(struct fb_info *info) {}
> >  static inline void fbcon_get_requirement(struct fb_info *info,
> >  					 struct fb_blit_caps *caps) {}
> > +static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
> >  #endif
> >  
> >  #endif /* _LINUX_FBCON_H */
> > -- 
> > 2.20.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
