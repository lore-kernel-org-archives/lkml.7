Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D3DC282E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4674B208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kEX1dBYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfE1JD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38172 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfE1JDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id g13so838094edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIvSBS1B4MGUlvtXGtjMOQmcHlrlcr23oBPyjEdIMqw=;
        b=kEX1dBYsfLZqMz1zXWP5urOCL4wj3GR50ijZkMz53o+IqxGumJznNh5bWHFqzz/57F
         g2GIL+FYqK5zeRJoDlXmOwePs6wvEYLvE/nkB5jnXi45FLkvBnGQbiXCyV5IfNvHSdoU
         Rfo20w4pFvtVPLYS9Hx6btvQPMdK9n+DhCJB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIvSBS1B4MGUlvtXGtjMOQmcHlrlcr23oBPyjEdIMqw=;
        b=VOLb5pqXZzclXd1p4NiXsjJPNr51kAijn1xcr9078YFjCrkuTnvqrLhD93a0scjtUK
         5oSBsmztY+PBn6y8+TXD+PCJfMpXfA3bYclP77wLfLUEuAhu3C51CeQ5QsfTZAyPieBr
         U1Wi0QbJ7JCvHdvvOJvzDULkT2GOmLmhx6MsMacY0NzJXShlqKVSoCe7UozkyGGM9ta9
         vxtLdmHPSrX2aRbdic3VL80EsliZy5Prjvv2HvJ2VCKVt/fYb2p+38cWikq3dpm0tC7I
         l7CNL/dF9ZSSvJWbNeFcwG2EmuI1tD3XINB5A6MgC5Kvcs5SQJ+QwDPBRRZY8iaRcTBw
         1ZmA==
X-Gm-Message-State: APjAAAVSWZrXEitFPdsoWofm1TIMXKObLW/dpinlr5Z2AxBv7RU0UDTp
        FE7cpacJDZddqf9q3BvxPSnngSTVAsI=
X-Google-Smtp-Source: APXvYqzrT5yIPISvSHUclVX4EyZRCO+vxYwOVOnyeJaJPQCsiQ0H7rBwVIiiDjjc89dl8HybwqjL5A==
X-Received: by 2002:a17:906:f14a:: with SMTP id gw10mr94060688ejb.158.1559034233120;
        Tue, 28 May 2019 02:03:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:52 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH 29/33] vgaswitcheroo: call fbcon_remap_all directly
Date:   Tue, 28 May 2019 11:03:00 +0200
Message-Id: <20190528090304.9388-30-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index e98551f96138..158b9d5233e1 100644
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

