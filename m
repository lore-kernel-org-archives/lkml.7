Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E99C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fk3DTqyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfETJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45083 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so6886070pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axjwgmFLRM1+L1ustb875bbTzYApAFo/Jx5LqGuNXAY=;
        b=Fk3DTqyrXSG8DMVkQ5jpdd51WKOTXKnsgFqEzAEtHchQc+G9zhS3xB1IG7609RXfVX
         q75/4k3vKdMrJbBa8X4VuV/51N1jOEQsaWSoW90Qjyt4YPbticQxegvVVGoPchYpQXoc
         5I8nhBuj8pJEGKNFi7ISyYNWx8OZwjG9ZIjFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axjwgmFLRM1+L1ustb875bbTzYApAFo/Jx5LqGuNXAY=;
        b=S9JJRHBzsK901Zm5rKNedcDwxMRXNryexBj0rN8Ea0jnnmsdiCUnBRBxaaTJrs5xif
         7/HQsLu2iLwMwwf9EXwNFdrMDejieTCueC8FOTkJLw/nylOPwUje7Egxz4udzfrh14lK
         NckXW5dAy7CNgsrQv2J2KeUz0BlV8L42MzmEVWMNJHHZE0Noki9IAWueGighyqLDJUig
         SWx8PBToAAs46jZ96hj3KJV7eQcdQ2AxLNHXdh+HEQisx25BJ9Sqwq0O3C9yoNkO5+gT
         /LsN4sHbcwVtIQgt1j9/xuBh32wiwQjA1D6hASKnZoCXxhjwNaDln0EMIz8Iy6loGULe
         vgfw==
X-Gm-Message-State: APjAAAU5l8RsoDsQvazQX3OCZjkrCNhKlOPhfXbidi+AHcvD4BLSEBiI
        SR0AVjWAx4bi3cWAKrjCpnT6vA==
X-Google-Smtp-Source: APXvYqwGbaQMkKz2uPiQZnp7HtOpLgYa6O0yTNOI9ya7HqDNUc3JIKXW23gSNYmCnGZT1fCWbNiB+w==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr57798189pfa.49.1558343243972;
        Mon, 20 May 2019 02:07:23 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:23 -0700 (PDT)
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
Subject: [PATCH v10 02/11] drm/sun4i: dsi: Update start value in video start delay
Date:   Mon, 20 May 2019 14:33:09 +0530
Message-Id: <20190520090318.27570-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

start value in video start delay computation done in below commit
is as per the legacy bsp drivers/video/sunxi/legacy..
"drm/sun4i: dsi: Change the start delay calculation"
(sha1: da676c6aa6413d59ab0a80c97bbc273025e640b2)

This existing start delay computation gives start value of 35,
for "bananapi,s070wv20-ct16" panel timings which indeed trigger
panel flip_done timed out as:

 WARNING: CPU: 0 PID: 31 at drivers/gpu/drm/drm_atomic_helper.c:1429 drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0
 [CRTC:46:crtc-0] vblank wait timed out
 Modules linked in:
 CPU: 0 PID: 31 Comm: kworker/0:1 Tainted: G        W         5.1.0-next-20190514-00025-gf928bc7cc146 #15
 Hardware name: Allwinner sun8i Family
 Workqueue: events deferred_probe_work_func
 [<c010ed54>] (unwind_backtrace) from [<c010b76c>] (show_stack+0x10/0x14)
 [<c010b76c>] (show_stack) from [<c0688c90>] (dump_stack+0x84/0x98)
 [<c0688c90>] (dump_stack) from [<c011d9e4>] (__warn+0xfc/0x114)
 [<c011d9e4>] (__warn) from [<c011da40>] (warn_slowpath_fmt+0x44/0x68)
 [<c011da40>] (warn_slowpath_fmt) from [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1+0x298/0x2a0)
 [<c040cd50>] (drm_atomic_helper_wait_for_vblanks.part.1) from [<c040e694>] (drm_atomic_helper_commit_tail_rpm+0x5c/0x6c)
 [<c040e694>] (drm_atomic_helper_commit_tail_rpm) from [<c040e4dc>] (commit_tail+0x40/0x6c)
 [<c040e4dc>] (commit_tail) from [<c040e5cc>] (drm_atomic_helper_commit+0xbc/0x128)
 [<c040e5cc>] (drm_atomic_helper_commit) from [<c0411b64>] (restore_fbdev_mode_atomic+0x1cc/0x1dc)
 [<c0411b64>] (restore_fbdev_mode_atomic) from [<c0411cb0>] (drm_fb_helper_pan_display+0xac/0x1d0)
 [<c0411cb0>] (drm_fb_helper_pan_display) from [<c03a4e84>] (fb_pan_display+0xcc/0x134)
 [<c03a4e84>] (fb_pan_display) from [<c03b1214>] (bit_update_start+0x14/0x30)
 [<c03b1214>] (bit_update_start) from [<c03afe94>] (fbcon_switch+0x3d8/0x4e0)
 [<c03afe94>] (fbcon_switch) from [<c03ec930>] (redraw_screen+0x174/0x238)
 [<c03ec930>] (redraw_screen) from [<c03aceb4>] (fbcon_prepare_logo+0x3c4/0x400)
 [<c03aceb4>] (fbcon_prepare_logo) from [<c03ad2b8>] (fbcon_init+0x3c8/0x5ac)
 [<c03ad2b8>] (fbcon_init) from [<c03eb8a0>] (visual_init+0xbc/0x104)
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
 [<c043f060>] (sun4i_drv_bind) from [<c044b5b0>] (try_to_bring_up_master+0x164/0x1a0)
 [<c044b5b0>] (try_to_bring_up_master) from [<c044b680>] (__component_add+0x94/0x140)
 [<c044b680>] (__component_add) from [<c0445e1c>] (sun6i_dsi_probe+0x144/0x234)
 [<c0445e1c>] (sun6i_dsi_probe) from [<c0452f0c>] (platform_drv_probe+0x48/0x9c)
 [<c0452f0c>] (platform_drv_probe) from [<c04512e4>] (really_probe+0x1dc/0x2c8)
 [<c04512e4>] (really_probe) from [<c0451530>] (driver_probe_device+0x60/0x160)
 [<c0451530>] (driver_probe_device) from [<c044f7bc>] (bus_for_each_drv+0x74/0xb8)
 [<c044f7bc>] (bus_for_each_drv) from [<c0451094>] (__device_attach+0xd0/0x13c)
 [<c0451094>] (__device_attach) from [<c045048c>] (bus_probe_device+0x84/0x8c)
 [<c045048c>] (bus_probe_device) from [<c0450918>] (deferred_probe_work_func+0x64/0x90)
 [<c0450918>] (deferred_probe_work_func) from [<c0135970>] (process_one_work+0x204/0x420)
 [<c0135970>] (process_one_work) from [<c013690c>] (worker_thread+0x274/0x5a0)
 [<c013690c>] (worker_thread) from [<c013b3d8>] (kthread+0x11c/0x14c)
 [<c013b3d8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
 Exception stack(0xde539fb0 to 0xde539ff8)
 9fa0:                                     00000000 00000000 00000000 00000000
 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 ---[ end trace 755e10f62b83f396 ]---
 Console: switching to colour frame buffer device 100x30
 [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:46:crtc-0] flip_done timed out
 [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:48:DSI-1] flip_done timed out
 [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:30:plane-0] flip_done timed out

But the expected start delay value is 1 which is confirmed from
new bsp [2].

The important and unclear note on legacy and new bsp codes [1] [2]
is both use similar start computation initially but it later reassign
it to 1 in new bsp.

Unfortunately we don't have any evidence or documentation for this
reassignment to 1 in new bsp, but it is working with all supported
panels in A33, A64.

So, use the start as per new bsp code since it is working in all
the supported panels.

[2] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L807
[1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L682

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c5bec0096b7c..b3ca85410b2c 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -364,7 +364,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
+	/**
+	 * Allwinner legacy (drivers/video/sunxi/legacy),
+	 * new (drivers/video/sunxi/disp/de/lowlevel_sun8iw5) bsp drivers
+	 * are evaluating start as:
+	 *
+	 *	vtotal - vdisplay - 10
+	 *
+	 * but the new drivers are reassigning start to 1, which seems to be
+	 * working in all supported panels as of now.
+	 */
+	u8 start = 1;
 	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
 
 	if (delay > mode->vtotal)
-- 
2.18.0.321.gffc6fa0e3

