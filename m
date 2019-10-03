Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61AEC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3084218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Si2+eXmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfJCGqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:46:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfJCGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:46:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so1142869pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0yjLoFJnnDpb4/0vl3aNO6o/4TykC3cym0JUZE/NWI=;
        b=Si2+eXmQ4tcfJciRfx3CwhRpPXA1JiV+W1GJTimvxDMNK3lHB5GB1DKRqKqkq2v5To
         ViXdDa6X3dmqW6zM60QUIAIwGhahe5s7TDDut4p/5QQyC+VgWjVmL2LPOiQF2M02U5tX
         xiaXCQ6Ok7/yKjuji2H8ZRYGDKqwCilkgEtiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0yjLoFJnnDpb4/0vl3aNO6o/4TykC3cym0JUZE/NWI=;
        b=RgWot2E9sW/ZcR4uk5X8ZKs6DKag90fNND/lqzXJ6TQEnziOPwElYGMfrxxka7pMfh
         xwfXMV7MxfeF/BwvTik9JqBZO5lHcy5TwACydjkQUEOYAhgA011yeMoICKTvoOw1Vrln
         CpbcyNmzwWWHJRkjsxu35jittDC9fc2/iWyYhN7CTUxcgJV2ONR8ygEWwLeA2FDx1tn3
         la/E8AwenlD62AXKTUYNyY2q70xsPkdd+X+vCo2FnHoyO+EImWAj3dmZMIkravJTtzta
         rT4jjLVAR2qZ4OXxvUwWcYbuhJAMqf5TV0RN08xjghjiiKL6bnszlWvQJyhQSHk12+Hp
         kkLQ==
X-Gm-Message-State: APjAAAV5groXsOKkCm28fDf6wv2E8cuSgJIEi69iBv5HTNHduYNwDyoj
        2zkrnlOiteNuim3tZcYjM+kjUw==
X-Google-Smtp-Source: APXvYqyyOaCYtLD4fAd0lPGKoG6yL6GHPaCr7dwsq7YBZDAnyPzGVLp/zBgtASm5hUnqoozLCx2olQ==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr9413941pfk.39.1570085167861;
        Wed, 02 Oct 2019 23:46:07 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.121])
        by smtp.gmail.com with ESMTPSA id b18sm1423294pfi.157.2019.10.02.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 23:46:07 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 2/7] drm/sun4i: dsi: Update start value in video start delay
Date:   Thu,  3 Oct 2019 12:15:22 +0530
Message-Id: <20191003064527.15128-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191003064527.15128-1-jagan@amarulasolutions.com>
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

start value in video start delay was changed in
commit da676c6aa641 ("drm/sun4i: dsi: Change the start delay calculation")
to match the legacy BSP driver [1].

So, using this existing start delay computation gives the wrong
start delay value for the "bananapi,s070wv20-ct16" panel. Due to
this the panel trigger below flip_done timed out as during kernel bootup:

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

To fix this, adjust the start delay computation according to the
new BSP code [2].

Unfortunately we don't have any evidence or documentation for this
reassignment to 1 in new bsp, but it is working with below mainline
supported panels in A33, A64.
- bananapi,s070wv20-ct16
- feiyang,fy07024di26a30d
- techstar,ts8550b

So, use the start as per new bsp code since it is working in all
the supported panels.

[1] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L682
[2] https://github.com/BPI-SINOVOIP/BPI-M2M-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp/de/lowlevel_sun8iw5/de_dsi.c#L807

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index f83522717488..c9c99c52bf1e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -365,7 +365,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
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
+	 * working in DSI panels available in mainline.
+	 */
+	u8 start = 1;
 	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
 
 	if (delay > mode->vtotal)
-- 
2.18.0.321.gffc6fa0e3

