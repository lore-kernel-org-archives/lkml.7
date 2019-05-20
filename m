Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6DB20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OWkQr9rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfETIWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43964 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so22503798edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJPBCrhSeCYaSH9F6UcUExEdsSLjSwQptqa3R/S5gDo=;
        b=OWkQr9rR7VJG+IgusEYX/ft1oKiDB1pCkBdMQY5rMfhIFUKTkY70KcXxSaEOeOyQCd
         5K7bFk6hwIS7lVBMmwizciSEmiX15qitorn+tmcaf10m35kpUubkF16q/P+fziCAmsHh
         9s5fYkl/JYG86U+9cnW7W2hnSycStsPXTTezk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJPBCrhSeCYaSH9F6UcUExEdsSLjSwQptqa3R/S5gDo=;
        b=aG8M38rbc7/xxo9Z4a0rTQz98eLt0x2dDoQzOwFXuEuQhkULd0ZeFNh6y2Zo2viZ7D
         IGWzQ2FfUtYGGT62p8FDn8yE+j/8qbyokDYdBo6Se8VxsB7Xy2BTDh3zgevAQAJnTWiL
         24PmopUPlrNRMdNBaQoyZ/3m6UZQ4D2nrE9fWTefq1eBXVlj5RYW+l/VrMhrUa7PTk8c
         Rp1L9+iQuAG+1CBddEXzjeCqRbc34c1NjeXmrE4p9xrznAUz8XD1pT9VoqC9cSbAigId
         zZZLNZuXCoDO8QJmMh7wXqjRgIOLZrEVBQEk9j8GJdApCtpbpZLmvpvc1bQp/2AOXLcK
         c3aw==
X-Gm-Message-State: APjAAAVDQV/BMSbEfoAoHU17iAqIQtgQxVS+B6I1nEmVLiEUZ+dggMBf
        WjCfHYXCL70MHhOetublDToeaySj0CU=
X-Google-Smtp-Source: APXvYqyPl1hBLIWddTOYJ+pAidiSHSdpRExce6ICtNe8a3RnzrveD2FxJiDiiOT5ZYzgu/0s56EBjg==
X-Received: by 2002:a50:9490:: with SMTP id s16mr74007144eda.260.1558340542484;
        Mon, 20 May 2019 01:22:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:21 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 00/33] fbcon notifier begone!
Date:   Mon, 20 May 2019 10:21:43 +0200
Message-Id: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series removes the fbcon notifier. It also contains the
beginnings of trying to understand how locking in this area works.

The super short summary of locking rules is that everything in fbcon needs
to be protected by the monolithic console_lock, including the setup code.
So not really an option to pull the kms modeset code out from underneath
that, at least not without rewriting half the console layer. Or I'm not
yet seeing clear enough.

The other side is that fbdev userspace access vs. fbcon locking is totally
broken.

For context of this series I'm just going to quote the commit message that
started this all:

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev
    
    There's a bunch of folks who're trying to make printk less
    contended and faster, but there's a problem: printk uses the
    console_lock, and the console lock has become the BKL for all things
    fbdev/fbcon, which in turn pulled in half the drm subsystem under that
    lock. That's awkward.
    
    There reasons for that is probably just a historical accident:
    
    - fbcon is a runtime option of fbdev, i.e. at runtime you can pick
      whether your fbdev driver instances are used as kernel consoles.
      Unfortunately this wasn't implemented with some module option, but
      through some module loading magic: As long as you don't load
      fbcon.ko, there's no fbdev console support, but loading it (in any
      order wrt fbdev drivers) will create console instances for all fbdev
      drivers.
    
    - This was implemented through a notifier chain. fbcon.ko enumerates
      all fbdev instances at load time and also registers itself as
      listener in the fbdev notifier. The fbdev core tries to register new
      fbdev instances with fbcon using the notifier.
    
    - On top of that the modifier chain is also used at runtime by the
      fbdev subsystem to e.g. control backlights for panels.
    
    - The problem is that the notifier puts a mutex locking context
      between fbdev and fbcon, which mixes up the locking contexts for
      both the runtime usage and the register time usage to notify fbcon.
      And at runtime fbcon (through the fbdev core) might call into the
      notifier from a printk critical section while console_lock is held.
    
    - This means console_lock must be an outer lock for the entire fbdev
      subsystem, which also means it must be acquired when registering a
      new framebuffer driver as the outermost lock since we might call
      into fbcon (through the notifier) which would result in a locking
      inversion if fbcon would acquire the console_lock from its notifier
      callback (which it needs to register the console).
    
    - console_lock can be held anywhere, since printk can be called
      anywhere, and through the above story, plus drm/kms being an fbdev
      driver, we pull in a shocking amount of locking hiercharchy
      underneath the console_lock. Which makes cleaning up printk really
      hard (not even splitting console_lock into an rwsem is all that
      useful due to this).
    
    There's various ways to address this, but the cleanest would be to
    make fbcon a compile-time option, where fbdev directly calls the fbcon
    register functions from register_framebuffer, or dummy static inline
    versions if fbcon is disabled. Maybe augmented with a runtime knob to
    disable fbcon, if that's needed (for debugging perhaps).
    
    But this could break some users who rely on the magic "loading
    fbcon.ko enables/disables fbdev framebuffers at runtime" thing, even
    if that's unlikely. Hence we must be careful:
    
    1. Create a compile-time dependency between fbcon and fbdev in the
    least minimal way. This is what this patch does.
    
    2. Wait at least 1 year to give possible users time to scream about
    how we broke their setup. Unlikely, since all distros make fbcon
    compile-in, and embedded platforms only compile stuff they know they
    need anyway. But still.
    
    3. Convert the notifier to direct functions calls, with dummy static
    inlines if fbcon is disabled. We'll still need the fb notifier for the
    other uses (like backlights), but we can probably move it into the fb
    core (atm it must be built-into vmlinux).
    
    4. Push console_lock down the call-chain, until it is down in
    console_register again.
    
    5. Finally start to clean up and rework the printk/console locking.
    
    For context of this saga see
    
    commit 50e244cc793d511b86adea24972f3a7264cae114
    Author: Alan Cox <alan@linux.intel.com>
    Date:   Fri Jan 25 10:28:15 2013 +1000
    
        fb: rework locking to fix lock ordering on takeover
    
    plus the pile of commits on top that tried to make this all work
    without terminally upsetting lockdep. We've uncovered all this when
    console_lock lockdep annotations where added in
    
    commit daee779718a319ff9f83e1ba3339334ac650bb22
    Author: Daniel Vetter <daniel.vetter@ffwll.ch>
    Date:   Sat Sep 22 19:52:11 2012 +0200
    
        console: implement lockdep support for console_lock
    
    On the patch itself:
    - Switch CONFIG_FRAMEBUFFER_CONSOLE to be a boolean, using the overall
      CONFIG_FB tristate to decided whether it should be a module or
      built-in.
    
    - At first I thought I could force the build depency with just a dummy
      symbol that fbcon.ko exports and fb.ko uses. But that leads to a
      module depency cycle (it works fine when built-in).
    
      Since this tight binding is the entire goal the simplest solution is
      to move all the fbcon modules (and there's a bunch of optinal
      source-files which are each modules of their own, for no good
      reason) into the overall fb.ko core module. That's a bit more than
      what I would have liked to do in this patch, but oh well.
    
    Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
    Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
    Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Reviewed-by: Sean Paul <seanpaul@chromium.org>
    Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Comments, review and testing much appreciated, as always.

Wrt long-term plans: I'm not sure where this will lead just yet, or
whether it'll lead anywhere at all. But I think removing the notifier
indirection is definitely a step into the right direction.

Cheers, Daniel

Daniel Vetter (33):
  dummycon: Sprinkle locking checks
  fbdev: locking check for fb_set_suspend
  vt: might_sleep() annotation for do_blank_screen
  vt: More locking checks
  fbdev/sa1100fb: Remove dead code
  fbdev/cyber2000: Remove struct display
  fbdev/aty128fb: Remove dead code
  fbcon: s/struct display/struct fbcon_display/
  fbcon: Remove fbcon_has_exited
  fbcon: call fbcon_fb_(un)registered directly
  fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
  fbdev/omap: sysfs files can't disappear before the device is gone
  fbdev: sysfs files can't disappear before the device is gone
  staging/olpc: lock_fb_info can't fail
  fbdev/atyfb: lock_fb_info can't fail
  fbdev: lock_fb_info cannot fail
  fbcon: call fbcon_fb_bind directly
  fbdev: make unregister/unlink functions not fail
  fbdev: unify unlink_framebufer paths
  fbdev/sh_mob: Remove fb notifier callback
  fbdev: directly call fbcon_suspended/resumed
  fbcon: Call fbcon_mode_deleted/new_modelist directly
  fbdev: Call fbcon_get_requirement directly
  Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
  fbcon: directly call fbcon_fb_blanked
  fbmem: pull fbcon_fb_blanked out of fb_blank
  fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
  fb: Flatten control flow in fb_set_var
  fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
  vgaswitcheroo: call fbcon_remap_all directly
  fbcon: Call con2fb_map functions directly
  fbcon: Document what I learned about fbcon locking
  staging/olpc_dcon: Add drm conversion to TODO

 drivers/gpu/vga/vga_switcheroo.c              |  11 +-
 drivers/staging/olpc_dcon/TODO                |   7 +
 drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
 drivers/tty/vt/vt.c                           |  18 +
 drivers/video/backlight/backlight.c           |   2 +-
 drivers/video/backlight/lcd.c                 |   2 -
 drivers/video/console/dummycon.c              |   6 +
 drivers/video/fbdev/aty/aty128fb.c            |  64 ---
 drivers/video/fbdev/aty/atyfb_base.c          |   3 +-
 drivers/video/fbdev/core/fbcmap.c             |   6 +-
 drivers/video/fbdev/core/fbcon.c              | 303 ++++++--------
 drivers/video/fbdev/core/fbcon.h              |   6 +-
 drivers/video/fbdev/core/fbmem.c              | 374 ++++++------------
 drivers/video/fbdev/core/fbsysfs.c            |  20 +-
 drivers/video/fbdev/cyber2000fb.c             |   1 -
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
 drivers/video/fbdev/sa1100fb.c                |  25 --
 drivers/video/fbdev/sh_mobile_lcdcfb.c        | 112 +-----
 drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
 include/linux/console_struct.h                |   5 +-
 include/linux/fb.h                            |  40 +-
 include/linux/fbcon.h                         |  30 ++
 22 files changed, 342 insertions(+), 725 deletions(-)

-- 
2.20.1

