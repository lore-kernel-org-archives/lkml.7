Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE43C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D794217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HUdmHgmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbfEXIyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34393 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390206AbfEXIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so13377711eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvJfpAYuex1ZzOWAPU6Riy4B+TLlFKSikZdtVIlcEvw=;
        b=HUdmHgmj6xKTF/IjmxdZCCQ8CBeV1rzmE0mINDeSFn9Qneug/fJWEvLp96IRv6kfvC
         945nj1FkujWD3gaC8/RWS8thQOvrVBUhwZvbngFiPZohDzX0b7uHbmyyJhdhJ29mwuwx
         FLVEnq5iGLC4vngpjPDvEq9wcH4Tf/lzfBzOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvJfpAYuex1ZzOWAPU6Riy4B+TLlFKSikZdtVIlcEvw=;
        b=mtAMHzGpVf3bHA8AjwP0jQtIbPpfGRW2Vv2AwGPx+C0xyYj4Bo3MiPj1dXX4SAFGXP
         KcFg77fACrEp4bUzTwfAlOTPHskRlHY4f7fYgga7+2POOPRNMRcuTdk8o2f/auYQV/ia
         u7DtvKJQq5ANSM2G90vz2Y/mNthOsyqsj+i1T8C9yK0yqwM89dFsrxvub1a7IjzHPo8g
         LuByACkQWGheHc4GbwJjjkemgTDaviSDOIvnUaQBvijuUmvsYcrmyZLsukvzMCbiTvx6
         IGR64RD7oYTtetECeugqyFi3lA+aDoGueIcWUaqmLUbiqMw4J6g9gcQaxNx+IMbJX9T5
         xxMw==
X-Gm-Message-State: APjAAAXs5KWi4M/eqigvGtIVesmPiROl5cA10yh+4Wwkz21RI7WsRX6r
        oqNHDeErcx4f0x7EdkTZrauz+ejX/lM=
X-Google-Smtp-Source: APXvYqyxJ3OtlgIvW239dvLOeioh8c4KEAqEFm7ic6IPrLWep6WRTnj3exef/quNNUVmDRuYnFB2hA==
X-Received: by 2002:a17:906:25c5:: with SMTP id n5mr49943586ejb.110.1558688079930;
        Fri, 24 May 2019 01:54:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:39 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org
Subject: [PATCH 29/33] vgaswitcheroo: call fbcon_remap_all directly
Date:   Fri, 24 May 2019 10:53:50 +0200
Message-Id: <20190524085354.27411-30-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, clean up the interface a bit and push the console locking
into fbcon.c.

v2: Remove now outdated comment (Lukas).

v3: Forgot to add static inline to the dummy function.

Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/vga/vga_switcheroo.c | 11 +++--------
 drivers/video/fbdev/core/fbcon.c | 14 +++++---------
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index a132c37d7334..65d7541c413a 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/fb.h>
 #include <linux/fs.h>
+#include <linux/fbcon.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_domain.h>
@@ -736,14 +737,8 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (!active->driver_power_control)
 		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
 
-	if (new_client->fb_info) {
-		struct fb_event event;
-
-		console_lock();
-		event.info = new_client->fb_info;
-		fb_notifier_call_chain(FB_EVENT_REMAP_ALL_CONSOLE, &event);
-		console_unlock();
-	}
+	if (new_client->fb_info)
+		fbcon_remap_all(new_client->fb_info);
 
 	mutex_lock(&vgasr_priv.mux_hw_lock);
 	ret = vgasr_priv.handler->switchto(new_client->id);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a07c261da53a..e08e984e2511 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3149,17 +3149,16 @@ void fbcon_fb_unregistered(struct fb_info *info)
 		do_unregister_con_driver(&fb_con);
 }
 
-/* called with console_lock held */
-static void fbcon_remap_all(int idx)
+void fbcon_remap_all(struct fb_info *info)
 {
-	int i;
-
-	WARN_CONSOLE_UNLOCKED();
+	int i, idx = info->node;
 
+	console_lock();
 	if (deferred_takeover) {
 		for (i = first_fb_vc; i <= last_fb_vc; i++)
 			con2fb_map_boot[i] = idx;
 		fbcon_map_override();
+		console_unlock();
 		return;
 	}
 
@@ -3172,6 +3171,7 @@ static void fbcon_remap_all(int idx)
 		       first_fb_vc + 1, last_fb_vc + 1);
 		info_idx = idx;
 	}
+	console_unlock();
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
@@ -3337,10 +3337,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
-	case FB_EVENT_REMAP_ALL_CONSOLE:
-		idx = info->node;
-		fbcon_remap_all(idx);
-		break;
 	}
 	return ret;
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f9c212f9b661..25e4b885f5b3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -139,8 +139,6 @@ struct fb_cursor_user {
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
-/*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
-#define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
 #define FB_EARLY_EVENT_BLANK		0x10
 /*      A hardware display blank revert early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index de31eeb22c97..69f900d289b2 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -16,6 +16,7 @@ void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
 void fbcon_fb_blanked(struct fb_info *info, int blank);
 void fbcon_update_vcs(struct fb_info *info, bool all);
+void fbcon_remap_all(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -31,6 +32,7 @@ static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
 static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
+static inline void fbcon_remap_all(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

