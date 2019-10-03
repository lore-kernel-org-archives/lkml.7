Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE090C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BCD20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Iki2atwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJCGqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45074 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCGqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so1099782pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBYzNQrrCI+/d9BDyqt6dmiGAFdmQJ5LcStNQH+f9vk=;
        b=Iki2atwP++jngWkgd/oyQfLKI6P2KdEDs3m/1JI4TZpay8OMRqq3po8gbUurBi6un1
         gIiOhqhG5TqrUwCbYqzyRf8ett7wVmwOkiZOka3NSjYBmjxzkIgbnBNHdfIyV77eSnUw
         260Gy+jyfS1F7qZTeL22jyCEQMDBUU4FQGk64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBYzNQrrCI+/d9BDyqt6dmiGAFdmQJ5LcStNQH+f9vk=;
        b=jS84uz/38nYN8rjs5FvIaW0rMd4LJ73flZ1Gvc5VGFgenlFHzU3yBPu6LHTEiCXQBD
         MptEr8MXoN4fZ+HPSahFRsIo5WVx7JPGnv0i82zG62CVkkMoaDDHL/Tfy5lB93afthDk
         7EaSkZssf27Jf2ROxTZ9eKhK/AANNK5A1rNQkKtCG8SR5umHhZrzW8bmLweA08aiRsRf
         oFymQRjdtfS/4VyyXXiL7bf5rWYUj1uDZNUdoEiEfDXAGA7nNMGvNCWtVHi3lCxSfhqt
         6mxOTpM7SH2mYNma3eABIolo33flKQrnuu7RMiPy5oCjlHaCZzsQHNGHP8yMsTpoviNn
         x97g==
X-Gm-Message-State: APjAAAW+PkhO4DsJMdvPy2ewPY7KXQTIW4i/WaMsJrgd813ocAxIIxCZ
        BIDigi8tFAD7B6ikAfeQN+Fq/g==
X-Google-Smtp-Source: APXvYqwKKy1Oiu6vAMil6tRs2Bd6zJY2DNrs4tO0aVc7kA2MQrUw+mpc155pUel3CS1Wa5t/szdQiA==
X-Received: by 2002:a17:90a:77c9:: with SMTP id e9mr8524950pjs.99.1570085171525;
        Wed, 02 Oct 2019 23:46:11 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:46:11 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 3/7] drm/sun4i: dsi: Fix video start delay computation
Date:   Thu,  3 Oct 2019 12:15:23 +0530
Message-Id: <20191003064527.15128-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191003064527.15128-1-jagan@amarulasolutions.com>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD timing definitions between Linux DRM vs Allwinner are different,
below diagram shows this clear differences.

           Active                 Front           Sync           Back
           Region                 Porch                          Porch
<-----------------------><----------------><--------------><-------------->
  //////////////////////|
 ////////////////////// |
//////////////////////  |..................                ................
                                           ________________
<----- [hv]display ----->
<------------- [hv]sync_start ------------>
<--------------------- [hv]sync_end ---------------------->
<-------------------------------- [hv]total ------------------------------>

<----- lcd_[xy] -------->		  <- lcd_[hv]spw ->
					  <---------- lcd_[hv]bp --------->
<-------------------------------- lcd_[hv]t ------------------------------>

The DSI driver misinterpreted the vbp term from the BSP code to refer
only to the backporch, when in fact it was backporch + sync. Thus the
driver incorrectly used the vertical front porch plus sync in its
calculation of the DRQ set bit value, when it should not have included
the sync timing.

Including additional sync timings leads to flip_done timed out as:

WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
[CRTC:46:crtc-0] vblank wait timed out
Modules linked in:
CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 5.1.0-next-20190514-00029-g09e5b0ed0a58 #18
Hardware name: Allwinner sun8i Family
Workqueue: events deferred_probe_work_func
[<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
[<c010b76c>] (show_stack) from [<c0688c70>] (dump_stack+0x84/0x98)
[<c0688c70>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
[<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
[<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
[<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
[<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
[<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
[<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
[<c0411b64>] (restore_fbdev_mode_atomic) from [<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
[<c04156f8>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c0415774>] (drm_fb_helper_set_par+0x30/0x54)
[<c0415774>] (drm_fb_helper_set_par) from [<c03ad450>] (fbcon_init+0x560/0x5ac)
[<c03ad450>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
[<c03eb8a0>] (visual_init) from [<c03ed1b8>] (do_bind_con_driver+0x1b0/0x390)
[<c03ed1b8>] (do_bind_con_driver) from [<c03ed780>] (do_take_over_console+0x13c/0x1c4)
[<c03ed780>] (do_take_over_console) from [<c03ad800>] (do_fbcon_takeover+0x74/0xcc)
[<c03ad800>] (do_fbcon_takeover) from [<c013c9c8>] (notifier_call_chain+0x44/0x84)
[<c013c9c8>] (notifier_call_chain) from [<c013cd20>] (__blocking_notifier_call_chain+0x48/0x60)
[<c013cd20>] (__blocking_notifier_call_chain) from [<c013cd50>] (blocking_notifier_call_chain+0x18/0x20)
[<c013cd50>] (blocking_notifier_call_chain) from [<c03a6e44>] (register_framebuffer+0x1e0/0x2f8)
[<c03a6e44>] (register_framebuffer) from [<c04153c0>] (__drm_fb_helper_initial_config_and_unlock+0x2fc/0x50c)
[<c04153c0>] (__drm_fb_helper_initial_config_and_unlock) from [<c04158c8>] (drm_fbdev_client_hotplug+0xe8/0x1b8)
[<c04158c8>] (drm_fbdev_client_hotplug) from [<c0415a20>] (drm_fbdev_generic_setup+0x88/0x118)
[<c0415a20>] (drm_fbdev_generic_setup) from [<c043f060>] (sun4i_drv_bind+0x128/0x160)
[<c043f060>] (sun4i_drv_bind) from [<c044b598>] (try_to_bring_up_master+0x164/0x1a0)
[<c044b598>] (try_to_bring_up_master) from [<c044b668>] (__component_add+0x94/0x140)
[<c044b668>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
[<c0445e1c>] (sun6i_dsi_probe) from [<c0452ef4>] (platform_drv_probe+0x48/0x9c)
[<c0452ef4>] (platform_drv_probe) from [<c04512cc>] (really_probe+0x1dc/0x2c8)
[<c04512cc>] (really_probe) from [<c0451518>] (driver_probe_device+0x60/0x160)
[<c0451518>] (driver_probe_device) from [<c044f7a4>] (bus_for_each_drv+0x74/0xb8)
[<c044f7a4>] (bus_for_each_drv) from [<c045107c>] (__device_attach+0xd0/0x13c)
[<c045107c>] (__device_attach) from [<c0450474>] (bus_probe_device+0x84/0x8c)
[<c0450474>] (bus_probe_device) from [<c0450900>] (deferred_probe_work_func+0x64/0x90)
[<c0450900>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
[<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
[<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
[<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xde539fb0 to 0xde539ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 495200a78b24980e ]---
random: fast init done
[drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
[drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
[drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out

With the terms(as described in above diagram) fixed, the panel
displays correctly without any timeouts.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c9c99c52bf1e..446dc56cc44b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -376,7 +376,7 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 	 * working in DSI panels available in mainline.
 	 */
 	u8 start = 1;
-	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
+	u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay) + start;
 
 	if (delay > mode->vtotal)
 		delay = delay % mode->vtotal;
-- 
2.18.0.321.gffc6fa0e3

