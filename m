Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BD8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h1nN6R3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfEUPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:09:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37690 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfEUPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:09:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so29911989edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kGFA98E8YUTXSd1vlNUtmMd7zWl23WEkLkg7eY2TneA=;
        b=h1nN6R3DwWW3hI2z4yWrg3b88MlSB3Sz1499ALECkxeB07XI3zHEBAfxyBAOAKpZyh
         ni58vX4bzcyK4Tl2UsniaPoSgsZ4HnhkTAi5IWMz7lhnWJWjI9uLkK9nOnpL65yX5eHq
         8ZEyiszfX5wwtsgQcu2IkWyr6Vm9K/+1pmV0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kGFA98E8YUTXSd1vlNUtmMd7zWl23WEkLkg7eY2TneA=;
        b=dnW5VNMzT+JH5HjJHXv1xJ46yAsigFtD2PYxbzF8Zdt20GyYEAywOCCpwjmzYSmb2X
         s3Y6eT4UIesz6KxLT15qqaeDbUWV91E50JHSIASx6zgyYvGw67gLl/ygegIPE6EqUsEB
         2IHOxq3CiDI3HHmbACvcE6G19BgipHaRXKsFJrs2vSN6iF37gDWJD+Kepbfx9fozK/rC
         QM3xYVa/uYA4dfMz1P/6125xdT4Urvt40Zxc67k2QW/RP6BPO60tX8ejDoi2qygYe6Yo
         9R+4cQZAJHZJT21PjZff7BQSGH9jZqB4q2397P0ua4VDgUBsyZuXGdUX+rHuCm9Gygkm
         kI2A==
X-Gm-Message-State: APjAAAVpf4EObPvTjVZ1SXBiyagIGgtlV1lNOvAH1TRoADhj6pE9ocCW
        IYDxOrRMJaDFm3zSGQWHKfA6Lg==
X-Google-Smtp-Source: APXvYqxBhBhjiZm6DIIVQclLcEYKPK25uT4p++L6X7xVUHvTJFqOSCuMzHWwvHIYKInLQrZSLpB5Zg==
X-Received: by 2002:a17:906:1545:: with SMTP id c5mr65212434ejd.135.1558451383140;
        Tue, 21 May 2019 08:09:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v2sm6280163eds.69.2019.05.21.08.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:09:42 -0700 (PDT)
Date:   Tue, 21 May 2019 17:09:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Message-ID: <20190521150939.GQ21222@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch>
 <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>
 <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:37:53AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.05.19 um 10:33 schrieb Thomas Zimmermann:
> > Hi
> > 
> > Am 20.05.19 um 10:21 schrieb Daniel Vetter:
> > ...
> >> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> >> index fc3d34a8ea5b..ae2db31eeba7 100644
> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1660,7 +1660,6 @@ MODULE_PARM_DESC(lockless_register_fb,
> >>  static int do_register_framebuffer(struct fb_info *fb_info)
> >>  {
> >>  	int i, ret;
> >> -	struct fb_event event;
> >>  	struct fb_videomode mode;
> >>  
> >>  	if (fb_check_foreignness(fb_info))
> >> @@ -1723,7 +1722,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
> >>  	fb_add_videomode(&mode, &fb_info->modelist);
> >>  	registered_fb[i] = fb_info;
> >>  
> >> -	event.info = fb_info;
> >>  	if (!lockless_register_fb)
> >>  		console_lock();
> >>  	else
> >> @@ -1732,9 +1730,8 @@ static int do_register_framebuffer(struct fb_info *fb_info)
> >>  		ret = -ENODEV;
> >>  		goto unlock_console;
> >>  	}
> >> -	ret = 0;
> >>  
> >> -	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
> >> +	ret = fbcon_fb_registered(fb_info);
> > 
> > What about backlight drivers? [1] Apparently these also use the
> > notifiers. [2] From my understanding, backlight drivers would stop
> > working with this change.
> 
> I just saw that backlight drivers only care about blanking and
> unblanking. Never mind then.

I did screw this up for one event for the mode changes. But should be
fixed in the next series.

I also added a patch to simplify the backlight/lcd notifier, since it
doesn't need to filter events anymore after this series - the only events
left are the ones backlight cares about.

Cheers, Daniel

> 
> Best regards
> Thomas
> 
> > 
> > Best regards
> > Thomas
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/backlight
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/backlight/backlight.c#n40
> > 
> >>  	unlock_fb_info(fb_info);
> >>  unlock_console:
> >>  	if (!lockless_register_fb)
> >> @@ -1771,7 +1768,6 @@ static int __unlink_framebuffer(struct fb_info *fb_info);
> >>  
> >>  static int do_unregister_framebuffer(struct fb_info *fb_info)
> >>  {
> >> -	struct fb_event event;
> >>  	int ret;
> >>  
> >>  	ret = unbind_console(fb_info);
> >> @@ -1789,9 +1785,8 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
> >>  	registered_fb[fb_info->node] = NULL;
> >>  	num_registered_fb--;
> >>  	fb_cleanup_device(fb_info);
> >> -	event.info = fb_info;
> >>  	console_lock();
> >> -	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
> >> +	fbcon_fb_unregistered(fb_info);
> >>  	console_unlock();
> >>  
> >>  	/* this may free fb info */
> >> diff --git a/include/linux/fb.h b/include/linux/fb.h
> >> index f52ef0ad6781..701abaf79c87 100644
> >> --- a/include/linux/fb.h
> >> +++ b/include/linux/fb.h
> >> @@ -136,10 +136,6 @@ struct fb_cursor_user {
> >>  #define FB_EVENT_RESUME			0x03
> >>  /*      An entry from the modelist was removed */
> >>  #define FB_EVENT_MODE_DELETE            0x04
> >> -/*      A driver registered itself */
> >> -#define FB_EVENT_FB_REGISTERED          0x05
> >> -/*      A driver unregistered itself */
> >> -#define FB_EVENT_FB_UNREGISTERED        0x06
> >>  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
> >>  #define FB_EVENT_GET_CONSOLE_MAP        0x07
> >>  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
> >> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> >> index f68a7db14165..94a71e9e1257 100644
> >> --- a/include/linux/fbcon.h
> >> +++ b/include/linux/fbcon.h
> >> @@ -4,9 +4,13 @@
> >>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE
> >>  void __init fb_console_init(void);
> >>  void __exit fb_console_exit(void);
> >> +int fbcon_fb_registered(struct fb_info *info);
> >> +void fbcon_fb_unregistered(struct fb_info *info);
> >>  #else
> >>  static inline void fb_console_init(void) {}
> >>  static inline void fb_console_exit(void) {}
> >> +static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
> >> +static inline void fbcon_fb_unregistered(struct fb_info *info) {}
> >>  #endif
> >>  
> >>  #endif /* _LINUX_FBCON_H */
> >>
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
> 




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
