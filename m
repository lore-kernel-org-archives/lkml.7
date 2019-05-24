Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D7FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400162184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GNQTgYDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfEXIyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34307 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389276AbfEXIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so13375419eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABGB9ijMm74ausSbsUSG+r7Tgh81AzTQA2By7H3MqK0=;
        b=GNQTgYDY6sm5E5zjkJ0Kn/XOWHlMpo6i/R3x8ovu6wosBABDQbRZgVBLntyKZwLiiq
         x+gPkl1GfucNZDevkvM+T/jAQnsOyJOUyuwdg/AUB/8Shc5HxyKmANwmqiGcD7Qdmy1z
         7B9a0cd1+77NQ0KSgtL3PHNMXd6zzTNkddIJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABGB9ijMm74ausSbsUSG+r7Tgh81AzTQA2By7H3MqK0=;
        b=aTu4BUJK1yvPA5Cd+2WfUC89wxiI2zd9gkVC7b+HsNILAXuU6E3MZompWayiNnVYJX
         +Gk9xWD2/+nm8KU05Veax8z2fwLKjSD1T1ThZDh936sDxf2zCx4XcjULjYZ4PHIuFlCj
         oy6LWmT7GOJx7y5/tEE0kfMBo1SHsU7IQ8COC8E/U29aJeicCFhmkWDFjAQ+zIlvtWj6
         us6Am8B1zDH0f8EpY4BLQDW9DoHqDD6kcarJin64EJmZ1dyN387GSlsIAaZLSoMuxud7
         GEVwY4E6jL3rh3XS6lb9hao/I1k2/pGFCGD5oUiO+wwvlU7lftESzr/yZQzrr+ntoCcf
         BmeA==
X-Gm-Message-State: APjAAAWqX0U3Qsla2cECD+JgzojFVSD+zYyEf9zqR9dCkGyt2Ng+0pPC
        1cgjYASqA+lEtGhnMPQmC/ra9nnpKQo=
X-Google-Smtp-Source: APXvYqxrK2k830CxTedQPNxA9osvwGa55a2VhpiUTDxeATilqO8WeKG2KZd0G7Kz/oYMVB07ie1OnQ==
X-Received: by 2002:a50:8684:: with SMTP id r4mr103183089eda.98.1558688040683;
        Fri, 24 May 2019 01:54:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:53:59 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 00/33] fbcon notifier begone!
Date:   Fri, 24 May 2019 10:53:21 +0200
Message-Id: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I fixed the fbcon_exited mess that CI spotted (hopefully it works now, the
code is still rather brittle imo). Plus all the little nits 0day and
people found.

Maarten slapped an rb onto the entire pile, but I feel like enough has
changed that a 2nd look from him is warranted.

I also added a backlight patch on top, I think that nicely highlights how
the fb notifier is now only used for backlight notifications. Maybe we
could rename it as a follow-up to make that clear.

Oh and one rather badly looking thing: am200epd is abusing the notifier in
very interesting ways. I guess a proper fix would be to figure out where
the display boot memory reservation is some more direct way, instead of
listening to the fw fb driver. But that's definitely outside of my
knowledge, so I left it at a bunch of #ifdef and comments.

I think we also still need an ack from Greg KH for the vt and staging
bits.

As usual, comments, review and testing very much welcome.

btw for future plans: I think this is tricky enough (it's old code and all
that) that we should let this soak for 2-3 kernel releases. I think the
following would be nice subsequent cleanup/fixes:

- push the console lock completely from fbmem.c to fbcon.c. I think we're
  mostly there with prep, but needs to pondering of corner cases.

- move fbcon.c from using indices for tracking fb_info (and accessing
  registered_fbs without proper locking all the time) to real fb_info
  pointers with the right amount of refcounting. Mostly motivated by the
  fun I had trying to simplify fbcon_exit().

- make sure that fbcon call lock/unlock_fb when it calls fbmem.c
  functions, and sprinkle assert_lockdep_held around in fbmem.c. This
  needs the console_lock cleanups first.

But I think that's material for maybe next year or so.

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
  fbdev: unify unlink_framebuffer paths
  fbdev/sh_mob: Remove fb notifier callback
  fbdev: directly call fbcon_suspended/resumed
  fbcon: Call fbcon_mode_deleted/new_modelist directly
  fbdev: Call fbcon_get_requirement directly
  Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
  fbmem: pull fbcon_fb_blanked out of fb_blank
  fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
  fb: Flatten control flow in fb_set_var
  fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
  vgaswitcheroo: call fbcon_remap_all directly
  fbcon: Call con2fb_map functions directly
  fbcon: Document what I learned about fbcon locking
  staging/olpc_dcon: Add drm conversion to TODO
  backlight: simplify lcd notifier

 arch/arm/mach-pxa/am200epd.c                  |  13 +-
 drivers/gpu/vga/vga_switcheroo.c              |  11 +-
 drivers/media/pci/ivtv/ivtvfb.c               |   6 +-
 drivers/staging/fbtft/fbtft-core.c            |   4 +-
 drivers/staging/olpc_dcon/TODO                |   7 +
 drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
 drivers/tty/vt/vt.c                           |  18 +
 drivers/video/backlight/backlight.c           |   2 +-
 drivers/video/backlight/lcd.c                 |  12 -
 drivers/video/console/dummycon.c              |   6 +
 drivers/video/fbdev/aty/aty128fb.c            |  64 ---
 drivers/video/fbdev/aty/atyfb_base.c          |   3 +-
 drivers/video/fbdev/core/fbcmap.c             |   6 +-
 drivers/video/fbdev/core/fbcon.c              | 311 ++++++--------
 drivers/video/fbdev/core/fbcon.h              |   6 +-
 drivers/video/fbdev/core/fbmem.c              | 399 +++++++-----------
 drivers/video/fbdev/core/fbsysfs.c            |  20 +-
 drivers/video/fbdev/cyber2000fb.c             |   1 -
 drivers/video/fbdev/neofb.c                   |   9 +-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
 drivers/video/fbdev/sa1100fb.c                |  25 --
 drivers/video/fbdev/savage/savagefb_driver.c  |   9 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c        | 112 +----
 drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
 include/linux/console_struct.h                |   5 +-
 include/linux/fb.h                            |  45 +-
 include/linux/fbcon.h                         |  30 ++
 27 files changed, 394 insertions(+), 762 deletions(-)

-- 
2.20.1

