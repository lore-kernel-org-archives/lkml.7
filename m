Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hkUGAWYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFGOoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:44:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45840 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfFGOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:44:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so1580084oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/YG1pNvMhtPq+4D/wbH72srnMWO5h0vGaK5D7ISjxM=;
        b=hkUGAWYiwktyF8XAUCRFTlr4xI1gbzfNuHnL0ZqV5wgdQRoVHoHBe17OW7ICbSF8+G
         S3ubc5pB3To8JxlIx+K78TmL0YjqIkQ3qYe2A3H9VFxJ79fYxq/GFKTijf7DCWWHkw9/
         EbaBsS2uMISNW1W4S9xao+K8J0akEMyZ/HaMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/YG1pNvMhtPq+4D/wbH72srnMWO5h0vGaK5D7ISjxM=;
        b=ieE3eSQU0RcJXvM1BR3UW1BCEZKecqajjsK+WdeVyRpX2hSYQ5pziN/L0wQYy/Q74n
         ZfGVWon7oIr7WuwYoCymYvYt/8c2pO1+nL4bbJ2c3PWfr7WAsNVE+Q4Rr3qm+AvNMQs3
         HANvhVZpcNHdKZuA06/rDX0AaDayrmTntlIH4TAjtIk4LTLm9Qd+cGCiWZqV415DSPpZ
         Vu7Nf29RUCH5mfRSG+wXz2Kh5G6hb8eCUKu7uxU66j8wBB/q/4eepFWDKknES/CT5iKQ
         I+Z4/11k6kbtc7d3p7gbeSnrmd/CZ/0FuIRU9cB4BnLNlmyArc3Okpbq/xYMyvo2kI2F
         WHXw==
X-Gm-Message-State: APjAAAXuCUMNcKlcVtsbPAeTtHvayp9A/JD7L4S7qHVAtHr4Q9flk/50
        JwqqIlk6u6dB3bSPFtm/0VukPOOTtJ73idGJ+CBh2A==
X-Google-Smtp-Source: APXvYqyWzzjaSAsBe1eXBlUeemEQQMcPTFSvrjgyAA6IyzSW6eAQ89KOXjY91ifZBRMzVd+/veIXrDJHvZ3uiLJsYls=
X-Received: by 2002:aca:62c2:: with SMTP id w185mr4176522oib.110.1559918646230;
 Fri, 07 Jun 2019 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch> <CGME20190606073852epcas2p27b586b93869a30e4658581c290960fee@epcas2p2.samsung.com>
 <CAKMK7uHneUFYPiRr10X9xfWTkGtaoQBB=niDMGkAgJ-fgo5=mA@mail.gmail.com> <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
In-Reply-To: <f848b4de-abab-116f-ad68-23348f1a4b76@samsung.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 7 Jun 2019 16:43:54 +0200
Message-ID: <CAKMK7uFpOVGm1TEJfbPM14joPRqgYha5c_xDng+MOOusMc1Hdw@mail.gmail.com>
Subject: Re: [PATCH 00/33] fbcon notifier begone v3!
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 12:07 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
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
> >
> >> - Hash out actual merge plan.
> >
> > I'd like to stuff this into drm.git somehow, I guess topic branch works
> > too.
>
> I would like to have topic branch for this patchset.

Do you plan to prep that, or should I? Doesn't really matter to me,
and assuming Daniel Thompson doesn't have any last minute concerns
should still be enough time to get it all sorted and have a few weeks
of testing left before the merge window.

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

Fully agreed, no need to rush anything here. For the drm-misc account
you need to request an SSH legacy account here by filing a issue:

https://gitlab.freedesktop.org/freedesktop/freedesktop/issues/new

Select the "New SSH account" template, it has instructions with
everything that's needed.

For the getting started howto, see
https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

If that all looks good and you're set up I think best to test-drive
the entire process with the MAINTAINERS patch to change the git repo
for 5.4.

Cheers, Daniel


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



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
