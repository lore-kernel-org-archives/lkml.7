Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF26C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44199205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDJUIsw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfFKOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:16:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33998 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfFKOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:16:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so13275441wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0YZLFuV0RaYb6o6bXZ/cnhAHh94UytEXpdPz+Yf3c8=;
        b=oDJUIsw9l0pX/II6DR7SV+FJvz1OxhmA8zB+vi7ZXNXdNhzrUdL+fFoMRtm3NDAx+u
         /Vox1y2G+2W5ePrfQZUhhRTNhcQHf1xL70VRJoR6Rs/wAm7AOQ1XNKPaqN3axoQYBXCG
         qZW9VDT0Dmh7SYlZYY3wK6EKBpZqwuXg8OJGiNja7sJOHCjOJeF2pW1dI5pRjM2rQOfG
         duxaSAK1xj6we0iB7/1QCyPlLX/loOjpjWCRxcB5mFuiRyD4+1Qkkd+bl54Exvlj0al4
         n2TBbY7/9gj3XYpcByhHDLIqEbP5haZb9/E/4ySZpcRTgx/TobjSTJWzV+zJRdkKSXP1
         9XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0YZLFuV0RaYb6o6bXZ/cnhAHh94UytEXpdPz+Yf3c8=;
        b=rvq62CfJkaoinCfGbupRmhBNi3T1DOxs7G5xrxvepPk3Zun5xnhVp05tJepPTLw8j9
         Tkr7k12zdgWMiMk573rOLUR4ijWSLf1+tmX6q6DD/WbJzYBbvI3h0ed0Y01jzZRWFLJd
         34mRXOoeC+kx6Vx0VLfNWxV20aizzQqasRyNes20Z+teJqxNjxWvgPUD4jE3VaV4Ve7x
         p2xQeadRDLzVAiatdtW8qH+dXV6lJzlc1Y8wAeWUVnaK3kflacXVIFbk7zJA87BwEhH6
         /5N6jP2lS6UoRwWQpsAuxZ2b0YeISdWroxIH/SCxly80LZvLH4LIB+DlF0FqFQgHQ3tQ
         1pDw==
X-Gm-Message-State: APjAAAW0eRMgJ599z7cfFDwVh40079vZZfj62VrAne8eC9E8ibA7vLKc
        IcTMCFroWV442oYXEobdrHp+Eg==
X-Google-Smtp-Source: APXvYqy+KtdbDSGNz5zvKixfWB2k+49bbw7fcDg2K7++BSZL8Ez/8CCq+i11NIz5j8DUyelxkPSVmA==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr634760wrm.117.1560262598393;
        Tue, 11 Jun 2019 07:16:38 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i188sm2886210wma.27.2019.06.11.07.16.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 07:16:37 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:16:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, lee.jones@linaro.org
Subject: Re: [PATCH 00/33] fbcon notifier begone v3!
Message-ID: <20190611141635.rowolr37vhalophr@holly.lan>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
 <CGME20190606073852epcas2p27b586b93869a30e4658581c290960fee@epcas2p2.samsung.com>
 <CAKMK7uHneUFYPiRr10X9xfWTkGtaoQBB=niDMGkAgJ-fgo5=mA@mail.gmail.com>
 <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 12:07:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 6/6/19 9:38 AM, Daniel Vetter wrote:
> > Hi Bart,
> 
> Hi Daniel,
> 
> > On Tue, May 28, 2019 at 11:02:31AM +0200, Daniel Vetter wrote:
> >> Hi all,
> >>
> >> I think we're slowly getting there. Previous cover letters with more
> >> context:
> >>
> >> https://lists.freedesktop.org/archives/dri-devel/2019-May/218362.html
> >>
> >> tldr; I have a multi-year plan to improve fbcon locking, because the
> >> current thing is a bit a mess.
> >>
> >> Cover letter of this version, where I detail a bit more the details
> >> fixed in this one here:
> >>
> >> https://lists.freedesktop.org/archives/dri-devel/2019-May/218984.html
> >>
> >> Note that the locking plan in this one is already outdated, I overlooked a
> >> few fun issues around any printk() going back to console_lock.
> >>
> >> I think remaining bits:
> >>
> >> - Ack from Daniel Thompson for the backlight bits, he wanted to check the
> >>   big picture.
> > 
> > I think Daniel is still on vacation until next week or so.

Thanks for spotting that. As it happens the e-mail asking for extra detail
was just about the last thing I sent before going on holiday (exactly to
try and avoid round trips this wee ;-) ).


> > 
> >> - Hash out actual merge plan.
> > 
> > I'd like to stuff this into drm.git somehow, I guess topic branch works
> > too.
> 
> I would like to have topic branch for this patchset.

From a backlight perspective its Lee Jones who hoovers up the patches
and worries about hiding merge conflicts from Linus.

I'll let him follow up if needed but I suspect he'd like an immutable
branch to work from also.


Daniel.


> 
> > Long term I think we need to reconsider how we handle fbdev, at least the
> > core/fbcon pieces. Since a few years all the work in that area has been
> > motivated by drm, and pushed by drm contributors. Having that maintained
> > in a separate tree that doesn't regularly integrate imo doesn't make much
> > sense, and we ended up merging almost everything through some drm tree.
> > That one time we didn't (for some panel rotation stuff) it resulted in
> > some good suprises.
> > 
> > I think best solution is if we put the core and fbcon bits into drm-misc,
> > as group maintained infrastructure piece. All the other gfx infra pieces
> > are maintained in there already too. You'd obviously get commit rights.
> > I think that would include
> > - drivers/video/fbdev
> > - drivers/video/*c
> > - drivers/video/console
> 
> Sounds fine to me.
> 
> > I don't really care about what happens with the actual fbdev drivers
> > (aside from the drm one in drm_fb_helper.c, but that's already maintained
> > as part of drm). I guess we could also put those into drm-misc, or as a
> > separate tree, depending what you want.
> > 
> > Thoughts?
> 
> I would like to handle fbdev changes for v5.3 merge window using fbdev
> tree but after that everything (including changes to fbdev drivers) can go
> through drm-misc tree.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > Cheers, Daniel
> > 
> > 
> >>
> >> I'm also cc'ing the entire pile to a lot more people on request.
> >>
> >> Thanks, Daniel
> >>
> >> Daniel Vetter (33):
> >>   dummycon: Sprinkle locking checks
> >>   fbdev: locking check for fb_set_suspend
> >>   vt: might_sleep() annotation for do_blank_screen
> >>   vt: More locking checks
> >>   fbdev/sa1100fb: Remove dead code
> >>   fbdev/cyber2000: Remove struct display
> >>   fbdev/aty128fb: Remove dead code
> >>   fbcon: s/struct display/struct fbcon_display/
> >>   fbcon: Remove fbcon_has_exited
> >>   fbcon: call fbcon_fb_(un)registered directly
> >>   fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
> >>   fbdev/omap: sysfs files can't disappear before the device is gone
> >>   fbdev: sysfs files can't disappear before the device is gone
> >>   staging/olpc: lock_fb_info can't fail
> >>   fbdev/atyfb: lock_fb_info can't fail
> >>   fbdev: lock_fb_info cannot fail
> >>   fbcon: call fbcon_fb_bind directly
> >>   fbdev: make unregister/unlink functions not fail
> >>   fbdev: unify unlink_framebuffer paths
> >>   fbdev/sh_mob: Remove fb notifier callback
> >>   fbdev: directly call fbcon_suspended/resumed
> >>   fbcon: Call fbcon_mode_deleted/new_modelist directly
> >>   fbdev: Call fbcon_get_requirement directly
> >>   Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
> >>   fbmem: pull fbcon_fb_blanked out of fb_blank
> >>   fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
> >>   fb: Flatten control flow in fb_set_var
> >>   fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
> >>   vgaswitcheroo: call fbcon_remap_all directly
> >>   fbcon: Call con2fb_map functions directly
> >>   fbcon: Document what I learned about fbcon locking
> >>   staging/olpc_dcon: Add drm conversion to TODO
> >>   backlight: simplify lcd notifier
> >>
> >>  arch/arm/mach-pxa/am200epd.c                  |  13 +-
> >>  drivers/gpu/vga/vga_switcheroo.c              |  11 +-
> >>  drivers/media/pci/ivtv/ivtvfb.c               |   6 +-
> >>  drivers/staging/fbtft/fbtft-core.c            |   4 +-
> >>  drivers/staging/olpc_dcon/TODO                |   7 +
> >>  drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
> >>  drivers/tty/vt/vt.c                           |  18 +
> >>  drivers/video/backlight/backlight.c           |   2 +-
> >>  drivers/video/backlight/lcd.c                 |  12 -
> >>  drivers/video/console/dummycon.c              |   6 +
> >>  drivers/video/fbdev/aty/aty128fb.c            |  64 ---
> >>  drivers/video/fbdev/aty/atyfb_base.c          |   3 +-
> >>  drivers/video/fbdev/core/fbcmap.c             |   6 +-
> >>  drivers/video/fbdev/core/fbcon.c              | 313 ++++++--------
> >>  drivers/video/fbdev/core/fbcon.h              |   6 +-
> >>  drivers/video/fbdev/core/fbmem.c              | 399 +++++++-----------
> >>  drivers/video/fbdev/core/fbsysfs.c            |  20 +-
> >>  drivers/video/fbdev/cyber2000fb.c             |   1 -
> >>  drivers/video/fbdev/neofb.c                   |   9 +-
> >>  .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
> >>  drivers/video/fbdev/sa1100fb.c                |  25 --
> >>  drivers/video/fbdev/savage/savagefb_driver.c  |   9 +-
> >>  drivers/video/fbdev/sh_mobile_lcdcfb.c        | 132 +-----
> >>  drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
> >>  include/linux/console_struct.h                |   5 +-
> >>  include/linux/fb.h                            |  45 +-
> >>  include/linux/fbcon.h                         |  30 ++
> >>  27 files changed, 396 insertions(+), 782 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
> > 
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
