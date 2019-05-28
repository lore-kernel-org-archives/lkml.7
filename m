Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6D2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFC208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZbvA8JMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE1JDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34529 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfE1JDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so30685393eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgSXKnnbthFa+BVtr8CIKNdBRHzhOkAmepQQupXINAw=;
        b=ZbvA8JMDPA8UKWkVW0fDPJYPgNM/qme0D2u3OuCEQgzZDEHOZHaesbUUUW9pc6eOXX
         Pra5QPai2Eftegqz/RD6sKf8inVzLSC2i1Kt7V2g0dQOXZhc3S9C1yChRVYjuyk3ravr
         ptG87vU+ZbFxA4tWVN8f3JcptvdIXBAlxjUeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgSXKnnbthFa+BVtr8CIKNdBRHzhOkAmepQQupXINAw=;
        b=g7bHV94Kc7wpSX45/UQnYsABj5oSo5glPCJ/jcAO7S88lyTRl6ScElwmGygXcvLURU
         YN34PtDx0+bVb5W7FmoQKyOiR/e24PX+Oq6lcUJjZDklWpUnh1BmhyIHbZeGTbjyI55m
         5N4glOpOKxIsC5YaaAD4bBNop1v8P/YVBnuBAqHgUE/+OvL2TaBisjlZ/19KCE5pF+iR
         9I7UP27YCm79vXMtChDhqkrDpK6x63jEPrxhSfz75CaThrc5Kcqw5rWXeL5amOJBXJ+l
         0Oa9XLMwl4EBBxNfZsAD3NthvoVMOggmNzbKlWykD5b22lSIIsI74afCClEVFEtEbcpy
         PPkg==
X-Gm-Message-State: APjAAAVVlvKM7M2TyACqH1nLOZKX0H+Z9gP2ODsAF6B39JqW7b5nr5y9
        rZXyjRsDmx5FR2J08QrgOcghI6lhIIo=
X-Google-Smtp-Source: APXvYqxFKg5PoHISf+/wwlWefI+MAwlWhDiGjXDcxrr5Tnt58NGG9OppyNgoo9Eac+/2sKa3Knstmg==
X-Received: by 2002:a50:ac68:: with SMTP id w37mr3821095edc.282.1559034190494;
        Tue, 28 May 2019 02:03:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:09 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 00/33] fbcon notifier begone v3!
Date:   Tue, 28 May 2019 11:02:31 +0200
Message-Id: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think we're slowly getting there. Previous cover letters with more
context:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218362.html

tldr; I have a multi-year plan to improve fbcon locking, because the
current thing is a bit a mess.

Cover letter of this version, where I detail a bit more the details
fixed in this one here:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218984.html

Note that the locking plan in this one is already outdated, I overlooked a
few fun issues around any printk() going back to console_lock.

I think remaining bits:

- Ack from Daniel Thompson for the backlight bits, he wanted to check the
  big picture.

- Hash out actual merge plan.

I'm also cc'ing the entire pile to a lot more people on request.

Thanks, Daniel

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
 drivers/video/fbdev/core/fbcon.c              | 313 ++++++--------
 drivers/video/fbdev/core/fbcon.h              |   6 +-
 drivers/video/fbdev/core/fbmem.c              | 399 +++++++-----------
 drivers/video/fbdev/core/fbsysfs.c            |  20 +-
 drivers/video/fbdev/cyber2000fb.c             |   1 -
 drivers/video/fbdev/neofb.c                   |   9 +-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
 drivers/video/fbdev/sa1100fb.c                |  25 --
 drivers/video/fbdev/savage/savagefb_driver.c  |   9 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c        | 132 +-----
 drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
 include/linux/console_struct.h                |   5 +-
 include/linux/fb.h                            |  45 +-
 include/linux/fbcon.h                         |  30 ++
 27 files changed, 396 insertions(+), 782 deletions(-)

-- 
2.20.1

