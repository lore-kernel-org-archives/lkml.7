Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20562C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82E3214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I9CWIabO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGINKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:10:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52210 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGINKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:10:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190709131030euoutp01545eb1aab733fb7f168a0cef27196a50~vvzURgusT0711307113euoutp01H
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2019 13:10:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190709131030euoutp01545eb1aab733fb7f168a0cef27196a50~vvzURgusT0711307113euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562677830;
        bh=abLS5N9fHBpa56FPUBNXdhu87US4z83MsdPIfDinYtM=;
        h=From:Subject:To:Cc:Date:References:From;
        b=I9CWIabOcP739lVVl59ImncrUttfAXx4L9jyv75FRqY6I6ka/RZMTApR0uSv3wuDE
         RE8NZR6ULEHzMuHW/7RsOUysaXR+OP3yYVhWu7V38ySTRG3an/j+69MCO9+Vzc2o9t
         dUW+b+Yp0YkM/vYKeHjxoD3nd8AewyLx1Jy5/Oow=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190709131029eucas1p281d6a218cc09ec9ed8a9f0ab1db9815c~vvzTniNYI1770417704eucas1p2b;
        Tue,  9 Jul 2019 13:10:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8C.58.04377.542942D5; Tue,  9
        Jul 2019 14:10:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5~vvzS4DkbI2496224962eucas1p13;
        Tue,  9 Jul 2019 13:10:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190709131028eusmtrp2bff6204633fc3ed8c9aab92aea4d0deb~vvzSp9B6Y1209012090eusmtrp28;
        Tue,  9 Jul 2019 13:10:28 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-cc-5d2492451b93
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.26.04140.442942D5; Tue,  9
        Jul 2019 14:10:28 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190709131028eusmtip1a693e095114b0df30c58e49b2af5da71~vvzSOp4Kr1279012790eusmtip1C;
        Tue,  9 Jul 2019 13:10:28 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev changes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <a6d44af3-cf51-a072-7c52-f505c8990630@samsung.com>
Date:   Tue, 9 Jul 2019 15:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87quk1RiDZZ8ErG48vU9m8WJvg+s
        Fpd3zWGzeP+pk8li696r7BaP+t6yO7B5NN64weaxaVUnm8eJGb9ZPO53H2fy+LxJLoA1issm
        JTUnsyy1SN8ugStjV3dywbaEirUXjRsYz7l2MXJySAiYSMz+fYCxi5GLQ0hgBaPEh1+L2SCc
        L4wSKxfcZoFwPjNKbP/YztzFyAHW0vI/EiK+nFFi6YdTrBDOW0aJBRsWsoPMZROwkpjYvooR
        xBYW0JJ433YUzBYRMJL4/OIKK4jNLLCfUWL13jCQobwCdhLXv/mBhFkEVCS6r/UygdiiAhES
        949tACvnFRCUODnzCQtEq7jErSfzmSBseYntb+cwg9wgIdDPLnG38zIzxG8uEud3PmCHsIUl
        Xh3fAmXLSPzfCdIM0rCOUeJvxwuo7u2MEssn/2ODqLKWOHz8IivIdcwCmhLrd+lDhB0l1l1+
        zAYJCT6JG28FIY7gk5i0bTo0gHglOtqEIKrVJDYs28AGs7Zr50qo0zwkzi6dyjiBUXEWktdm
        IXltFpLXZiHcsICRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg0jn97/iXHYy7/iQd
        YhTgYFTi4ZVoUYkVYk0sK67MPcQowcGsJMK7z105Vog3JbGyKrUoP76oNCe1+BCjNAeLkjhv
        NcODaCGB9MSS1OzU1ILUIpgsEwenVAOjzxOZjrqlnqc9j75t0r32d6PxrW9n1D62Mfy6PUmZ
        PT9BOqUiQpprlcnztLPrrLf/sWPaoCH+prRf8IAfK2fYzNgzFSVfDqXeP+c3M2PB191yYSuk
        N3+exvR2bUT+Lx/lpCsb76x78HqJ/X1mNe/dPl/WRbjPtzA95bRW7dv8ihUHVTs+W6suVGIp
        zkg01GIuKk4EAIpf6Qw2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7ouk1RiDc7tULK48vU9m8WJvg+s
        Fpd3zWGzeP+pk8li696r7BaP+t6yO7B5NN64weaxaVUnm8eJGb9ZPO53H2fy+LxJLoA1Ss+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jV3dywbaE
        irUXjRsYz7l2MXJwSAiYSLT8j+xi5OIQEljKKNFyZhkTRFxG4vj6si5GTiBTWOLPtS42iJrX
        jBKPN29kBUmwCVhJTGxfxQhiCwtoSbxvOwpmiwgYSXx+cQWshlngIKPEtv0SIDN5Bewkrn/z
        AwmzCKhIdF/rZQKxRQUiJM68X8ECYvMKCEqcnPmEBaJVXeLPvEvMELa4xK0n85kgbHmJ7W/n
        ME9gFJiFpGUWkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBith37uWUH
        Y9e74EOMAhyMSjy8Ei0qsUKsiWXFlbmHGCU4mJVEePe5K8cK8aYkVlalFuXHF5XmpBYfYjQF
        emgis5Rocj4wmvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBu
        9uPdwPnpbUr3ocxA5mupq1488/qeabhrhaXSMbcAea5vgbOFltieqv4nznTk58RNx/OFT6p7
        ndnmKh4WsIlxpanOAg6ln1yHzbUElcPjk0z+dH1Zt/XmbW+l134HjAorVncuu+uQ+U1AJH/5
        q/rk/hNfVx++Wrzc7FPow9AO96NlpwyWVvMosRRnJBpqMRcVJwIAWlLWm64CAAA=
X-CMS-MailID: 20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5
References: <CGME20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v5.3. They are:
- removal of fbdev notifier usage for fbcon
- COMPILE_TEST support for more fb drivers
- removal of no longer needed fbdev mxsfb driver
- minor fixes/cleanups for other fb drivers

Please see the signed tag description for details.

Test merge revealed a small merge conflict with SPDX changes, the
resolution is trivial (drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
should be deleted).

Also there is a conflict with media tree (pull request for media
tree has been posted a bit earlier today by Mauro), a fix for it
has been carried in linux-next tree by Stephen:

diff --cc drivers/media/pci/ivtv/ivtvfb.c
index 800b3654cac5,299ff032f528..000000000000
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@@ -1251,16 -1246,7 +1251,12 @@@ static int ivtvfb_callback_cleanup(stru
  	struct osd_info *oi = itv->osd_info;
  
  	if (itv->v4l2_cap & V4L2_CAP_VIDEO_OUTPUT) {
 +		itv->streams[IVTV_DEC_STREAM_TYPE_YUV].vdev.device_caps &=
 +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
 +		itv->streams[IVTV_DEC_STREAM_TYPE_MPG].vdev.device_caps &=
 +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
 +		itv->v4l2_cap &= ~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
- 		if (unregister_framebuffer(&itv->osd_info->ivtvfb_info)) {
- 			IVTVFB_WARN("Framebuffer %d is in use, cannot unload\n",
- 				       itv->instance);
- 			return 0;
- 		}
+ 		unregister_framebuffer(&itv->osd_info->ivtvfb_info);
  		IVTVFB_INFO("Unregister framebuffer %d\n", itv->instance);
  		itv->ivtvfb_restore = NULL;
  		ivtvfb_blank(FB_BLANK_VSYNC_SUSPEND, &oi->ivtvfb_info);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.3

for you to fetch changes up to 732146a3f1dc78ebb0d3c4b1f4dc6ea33cc2c58f:

  video: fbdev: imxfb: fix a typo in imxfb_probe() (2019-07-05 17:42:13 +0200)

----------------------------------------------------------------
fbdev changes for v5.3:

- remove fbdev notifier usage for fbcon (as prep work to clean up the fbcon
  locking), add locking checks in vt/console code and make assorted cleanups
  in fbdev and backlight code (Daniel Vetter)

- add COMPILE_TEST support to atmel_lcdfb, da8xx-fb, gbefb, imxfb, pvr2fb and
  pxa168fb drivers (me)

- fix DMA API abuse in au1200fb and jz4740_fb drivers (Christoph Hellwig)

- add check for new BGRT status field rotation bits in efifb driver (Hans de
  Goede)

- mark expected switch fall-throughs in s3c-fb driver (Gustavo A. R. Silva)

- remove fbdev mxsfb driver in favour of the drm version (Fabio Estevam)

- remove broken rfbi code from omap2fb driver (me)

- misc fixes (Arnd Bergmann, Shobhit Kukreti, Wei Yongjun, me)

- misc cleanups (Gustavo A. R. Silva, Colin Ian King, me)

----------------------------------------------------------------
Arnd Bergmann (1):
      video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit

Bartlomiej Zolnierkiewicz (21):
      Merge tag 'v5.2-rc1' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      video: fbdev: atafb: remove superfluous function prototypes
      video: fbdev: atmel_lcdfb: add COMPILE_TEST support
      video: fbdev: imxfb: add COMPILE_TEST support
      video: fbdev: pxa168fb: add COMPILE_TEST support
      video: fbdev: gbefb: add COMPILE_TEST support
      video: fbdev: da8xx-fb: add COMPILE_TEST support
      video: fbdev: cyber2000fb: remove superfluous CONFIG_PCI ifdef
      video: fbdev: pvr2fb: remove function prototypes
      video: fbdev: pvr2fb: add COMPILE_TEST support
      Merge tag 'topic/remove-fbcon-notifiers-2019-06-14-1' of git://anongit.freedesktop.org/drm/drm-misc into fbdev-for-next
      Merge branch 'topic/remove-fbcon-notifiers' of git://anongit.freedesktop.org/drm/drm-misc into fbdev-for-next
      video: fbdev: pvr2fb: fix build warning when compiling as module
      video: fbdev: imxfb: fix sparse warnings about using incorrect types
      video: fbdev: s3c-fb: add COMPILE_TEST support
      video: fbdev: omap2: remove rfbi
      Merge tag 'topic/remove-fbcon-notifiers-2019-06-26' of git://anongit.freedesktop.org/drm/drm-misc into fbdev-for-next
      video: fbdev: s3c-fb: return -ENOMEM on framebuffer_alloc() failure
      video: fbdev: intelfb: return -ENOMEM on framebuffer_alloc() failure
      video: fbdev: don't print error message on framebuffer_alloc() failure
      video: fbdev: s3c-fb: fix sparse warnings about using incorrect types

Christoph Hellwig (2):
      au1200fb: fix DMA API abuse
      jz4740_fb: fix DMA API abuse

Colin Ian King (1):
      video: fbdev: atmel_lcdfb: remove redundant initialization to variable ret

Daniel Vetter (35):
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
      fbcon: Export fbcon_update_vcs
      vga_switcheroo: Depend upon fbcon being built-in, if enabled

Fabio Estevam (1):
      video: fbdev: mxsfb: Remove driver

Gustavo A. R. Silva (2):
      video: fbdev-MMP: Use struct_size() in devm_kzalloc()
      video: fbdev: s3c-fb: Mark expected switch fall-throughs

Hans de Goede (1):
      efifb: BGRT: Add check for new BGRT status field rotation bits

Shobhit Kukreti (1):
      video: fbdev: controlfb: fix warnings about comparing pointer to 0

Wei Yongjun (1):
      video: fbdev: imxfb: fix a typo in imxfb_probe()

 arch/arm/mach-pxa/am200epd.c                    |   13 +-
 drivers/gpu/vga/Kconfig                         |    1 +
 drivers/gpu/vga/vga_switcheroo.c                |   11 +-
 drivers/hid/hid-picolcd_fb.c                    |    4 +-
 drivers/media/pci/ivtv/ivtvfb.c                 |    6 +-
 drivers/staging/fbtft/fbtft-core.c              |    4 +-
 drivers/staging/olpc_dcon/TODO                  |    7 +
 drivers/staging/olpc_dcon/olpc_dcon.c           |    6 +-
 drivers/tty/vt/vt.c                             |   18 +
 drivers/video/backlight/backlight.c             |    2 +-
 drivers/video/backlight/lcd.c                   |   12 -
 drivers/video/console/dummycon.c                |    6 +
 drivers/video/fbdev/Kconfig                     |   34 +-
 drivers/video/fbdev/Makefile                    |    1 -
 drivers/video/fbdev/amifb.c                     |    4 +-
 drivers/video/fbdev/arkfb.c                     |    4 +-
 drivers/video/fbdev/atafb.c                     |   21 -
 drivers/video/fbdev/atmel_lcdfb.c               |   10 +-
 drivers/video/fbdev/aty/aty128fb.c              |   69 +-
 drivers/video/fbdev/aty/atyfb_base.c            |   13 +-
 drivers/video/fbdev/aty/radeon_base.c           |    2 -
 drivers/video/fbdev/au1200fb.c                  |   19 +-
 drivers/video/fbdev/chipsfb.c                   |    1 -
 drivers/video/fbdev/cirrusfb.c                  |    5 +-
 drivers/video/fbdev/controlfb.c                 |    8 +-
 drivers/video/fbdev/core/fbcmap.c               |    6 +-
 drivers/video/fbdev/core/fbcon.c                |  314 +++----
 drivers/video/fbdev/core/fbcon.h                |    6 +-
 drivers/video/fbdev/core/fbmem.c                |  399 +++------
 drivers/video/fbdev/core/fbsysfs.c              |   20 +-
 drivers/video/fbdev/cyber2000fb.c               |    6 -
 drivers/video/fbdev/da8xx-fb.c                  |    1 -
 drivers/video/fbdev/efifb.c                     |    6 +-
 drivers/video/fbdev/gbefb.c                     |   19 +-
 drivers/video/fbdev/grvga.c                     |    4 +-
 drivers/video/fbdev/gxt4500.c                   |    5 +-
 drivers/video/fbdev/hyperv_fb.c                 |    4 +-
 drivers/video/fbdev/i740fb.c                    |    4 +-
 drivers/video/fbdev/imsttfb.c                   |    5 +-
 drivers/video/fbdev/imxfb.c                     |   11 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c        |    7 +-
 drivers/video/fbdev/jz4740_fb.c                 |   11 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c      |    5 +-
 drivers/video/fbdev/mbx/mbxfb.c                 |    4 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c           |    8 +-
 drivers/video/fbdev/mxsfb.c                     | 1028 ---------------------
 drivers/video/fbdev/neofb.c                     |    9 +-
 drivers/video/fbdev/omap/omapfb_main.c          |    2 -
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig    |   12 -
 drivers/video/fbdev/omap2/omapfb/dss/Makefile   |    1 -
 drivers/video/fbdev/omap2/omapfb/dss/core.c     |    6 -
 drivers/video/fbdev/omap2/omapfb/dss/dss.h      |    4 -
 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c     | 1078 -----------------------
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c  |    6 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c |   21 +-
 drivers/video/fbdev/platinumfb.c                |    5 +-
 drivers/video/fbdev/pmag-aa-fb.c                |    4 +-
 drivers/video/fbdev/pmag-ba-fb.c                |    4 +-
 drivers/video/fbdev/pmagb-b-fb.c                |    4 +-
 drivers/video/fbdev/pvr2fb.c                    |  188 ++--
 drivers/video/fbdev/riva/fbdev.c                |    1 -
 drivers/video/fbdev/s3c-fb.c                    |   24 +-
 drivers/video/fbdev/s3fb.c                      |    4 +-
 drivers/video/fbdev/sa1100fb.c                  |   25 -
 drivers/video/fbdev/savage/savagefb_driver.c    |    9 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c          |  140 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.h          |    5 -
 drivers/video/fbdev/sm501fb.c                   |    4 +-
 drivers/video/fbdev/sm712fb.c                   |    1 -
 drivers/video/fbdev/smscufx.c                   |    4 +-
 drivers/video/fbdev/ssd1307fb.c                 |    4 +-
 drivers/video/fbdev/sunxvr1000.c                |    1 -
 drivers/video/fbdev/sunxvr2500.c                |    1 -
 drivers/video/fbdev/sunxvr500.c                 |    1 -
 drivers/video/fbdev/tgafb.c                     |    4 +-
 drivers/video/fbdev/udlfb.c                     |    4 +-
 drivers/video/fbdev/via/viafbdev.c              |    6 +-
 drivers/video/fbdev/vt8623fb.c                  |    4 +-
 include/linux/console_struct.h                  |    5 +-
 include/linux/fb.h                              |   45 +-
 include/linux/fbcon.h                           |   30 +
 include/video/omapfb_dss.h                      |   32 -
 82 files changed, 582 insertions(+), 3270 deletions(-)
 delete mode 100644 drivers/video/fbdev/mxsfb.c
 delete mode 100644 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
