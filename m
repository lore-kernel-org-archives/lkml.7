Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1FC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6037220815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KGiXud+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfETJHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39145 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id w22so6486360pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYczVIziVgtoXaMdiCSJdvyko6PsZTz3vls3yir8pOc=;
        b=KGiXud+0mWIzef+T+5928Tp2QLkZEwQdsube/Mgj1NsURWWBSmIr1e5eaY1DllcZ3t
         6qJ6btrYaRzmtfjBPOQI2vNNXZoFKi5TvA20kzKNDW+cxd3g8pjk7qvGgaynXuvr2LA4
         181A9OS01zODaG73aVNpLn7K8Pk5sHcKdrBRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYczVIziVgtoXaMdiCSJdvyko6PsZTz3vls3yir8pOc=;
        b=kNn+W8o9OtoAzDE1lWa0KKY6ZSHgWRCVOddu2rT8Q4ubOta0/2K9kG98aCvBPWMrWB
         flaR2VS22KZv/DllF0SRG4SY/IcNGqobDkw8XCwYINe4J+yR1VTwknjJa/D0tk5aUkoV
         Qjl/Ev7WVH4fpM4BR8V/Cw8/7Xfma2UvXNif1B9Sa6pAZq5KzTBu7YtikKN6JSGhFbOQ
         WuZwYE4EEzVDKv9Yu5NvndxFzKrc7gyNUxZ4uSdwiVGpMY4fQTP3RwFs5MXaMwUFP++h
         h76CvOhZgNll/Txg8PUGRuyauQsvmrnGU2D8jz1Aw/aU+3Aw2z4cCxf0wlFxHqA102Pt
         yNNw==
X-Gm-Message-State: APjAAAUPf7KSMtrVwm/4q1RtpRsmGY6e3bgMEFcPJeXbNPKImPZ+Lkh/
        KV+gZWnp9Saj0MuV8rWWBXWpDQ==
X-Google-Smtp-Source: APXvYqwM3CLUrDYKF/BBqBe7vJrcloDE2nkmCClqznvzdeHC5V98hdU+vn56RYsovMfxbvtGLzfsZg==
X-Received: by 2002:a65:6449:: with SMTP id s9mr72257102pgv.90.1558343249223;
        Mon, 20 May 2019 02:07:29 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 03/11] drm/sun4i: dsi: Fix video start delay computation
Date:   Mon, 20 May 2019 14:33:10 +0530
Message-Id: <20190520090318.27570-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code is computing vertical video start delay as

delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;

On which the second parameter

mode->vsync_end - mode->vdisplay = front porch + sync timings

according to "DRM kernel-internal display mode structure" in
include/drm/drm_modes.h

With adding additional sync timings, the desired video start delay
value as 510 for "bananapi,s070wv20-ct16" panel timings which indeed
trigger panel flip_done timed out as:

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

But the expected video start delay value is 513 which states that
the second parameter on the computation is "front porch" value
(no sync timings included).

This is clearly confirmed from the legacy [1] and new [2] bsp codes
that the second parameter on the video start delay is "front porch"

Here is the detailed evidence for calculating front porch as per
bsp code.

vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp
=> (panel->lcd_vt) - panel->lcd_y - panel->lcd_vbp
=> (tt->ver_front_porch + lcdp->panel_info.lcd_vbp
    + lcdp->panel_info.lcd_y) -  panel->lcd_y - panel->lcd_vbp
=> tt->ver_front_porch

Which is mode->vsync_start - mode->vdisplay according to
"DRM kernel-internal display mode structure" in include/drm/drm_modes.h

This patch fix this by updating the video start delay to use
front porch value.

[2] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/disp_lcd.c#L2051
[1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L803

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b3ca85410b2c..47d571d97600 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -375,7 +375,7 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 	 * working in all supported panels as of now.
 	 */
 	u8 start = 1;
-	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
+	u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay) + start;
 
 	if (delay > mode->vtotal)
 		delay = delay % mode->vtotal;
-- 
2.18.0.321.gffc6fa0e3

