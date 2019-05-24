Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B572175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ON31KhiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbfEXIz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42308 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390042AbfEXIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so13313932eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lXeRZ7+1o5U5dHGG0ORDMhpYP5fAtgOAp6zT8nSIo0=;
        b=ON31KhiHpUIXMSNACz0tRxkdkxCJwHwzNye1J+X9u8zAq/jjxKs1BB0H6/oSCg5o3W
         bT35kEnHIkU1PDhDAQkVtrPlWfJ2L1Z4TRhgLPv5GV/ln48CdHRJomScq81q5NUSPZOk
         MNyyzxlEvhR4eGhdGgFUYa8IBqqB0ShsjkF1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lXeRZ7+1o5U5dHGG0ORDMhpYP5fAtgOAp6zT8nSIo0=;
        b=IaBLvoevPQ1htL6QbP2wzrA8ceGqeuDaLEWsYTKEGfhYu0/ByiPhFt9BzLVh57xukv
         N2LFtZhqPlxsGu7jGrNVMOOrNGOn7TH9hc1h73gSaRVdacnSQMkfWIDiGL+Yfzy1ic5T
         tcd29ABTGt8cDM2TF4J8r1tkXHbq8DRA7ou4GSWRXqfIgmZgQIZvL6WbBRQ41FNDz0dM
         16fYCKOg/9zc2P1zMWBYlBs1dAVcDepVhGS6QQresvUq9bgxGKBqqZrDvG7E4qPWNtW4
         bFBLPAzhd/rjkNCA9hcZyQXvl4A4Fp7tF1zz9Gm8E4LX7sD8S4loho6QCkbQzswwqlBN
         WjnA==
X-Gm-Message-State: APjAAAWX5sNoRtFN7eBpO2/5iZNjH9mmB04aQVcN9n7tKB6CO0v+DDxP
        O7RVeg7K8zDtLVwYiZreNS1XOGJ6VfI=
X-Google-Smtp-Source: APXvYqzT76LbMv3vIJJ44G9iWC4Z1/Jal2sPgYQ3xGhJtgHlEZtQ7TOQJJCB2VSk1YBd3d8xt0QEDA==
X-Received: by 2002:a50:a5b4:: with SMTP id a49mr104761629edc.30.1558688072260;
        Fri, 24 May 2019 01:54:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:31 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 23/33] fbdev: Call fbcon_get_requirement directly
Date:   Fri, 24 May 2019 10:53:44 +0200
Message-Id: <20190524085354.27411-24-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty simple case really.

v2: Forgot to remove a break;

v3: Add static inline to the dummy versions.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 9 ++-------
 drivers/video/fbdev/core/fbmem.c | 5 +----
 include/linux/fb.h               | 2 --
 include/linux/fbcon.h            | 4 ++++
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 35ecd25b385c..259cdd118475 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3283,8 +3283,8 @@ void fbcon_new_modelist(struct fb_info *info)
 	}
 }
 
-static void fbcon_get_requirement(struct fb_info *info,
-				  struct fb_blit_caps *caps)
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps)
 {
 	struct vc_data *vc;
 	struct fbcon_display *p;
@@ -3325,7 +3325,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
 	struct fb_con2fbmap *con2fb;
-	struct fb_blit_caps *caps;
 	int idx, ret = 0;
 
 	switch(action) {
@@ -3348,10 +3347,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_BLANK:
 		fbcon_fb_blanked(info, *(int *)event->data);
 		break;
-	case FB_EVENT_GET_REQ:
-		caps = event->data;
-		fbcon_get_requirement(info, caps);
-		break;
 	case FB_EVENT_REMAP_ALL_CONSOLE:
 		idx = info->node;
 		fbcon_remap_all(idx);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cbdd141e7695..ddc0c16b8bbf 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -932,16 +932,13 @@ EXPORT_SYMBOL(fb_pan_display);
 static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 			 u32 activate)
 {
-	struct fb_event event;
 	struct fb_blit_caps caps, fbcaps;
 	int err = 0;
 
 	memset(&caps, 0, sizeof(caps));
 	memset(&fbcaps, 0, sizeof(fbcaps));
 	caps.flags = (activate & FB_ACTIVATE_ALL) ? 1 : 0;
-	event.info = info;
-	event.data = &caps;
-	fb_notifier_call_chain(FB_EVENT_GET_REQ, &event);
+	fbcon_get_requirement(info, &caps);
 	info->fbops->fb_get_caps(info, &fbcaps, var);
 
 	if (((fbcaps.x ^ caps.x) & caps.x) ||
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 7a788ed8c7b5..0d86aa31bf8d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -143,8 +143,6 @@ struct fb_cursor_user {
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occurred */
 #define FB_EVENT_CONBLANK               0x0C
-/*      Get drawing requirements        */
-#define FB_EVENT_GET_REQ                0x0D
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index c139834342f5..305e4f2eddac 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -12,6 +12,8 @@ void fbcon_resumed(struct fb_info *info);
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode);
 void fbcon_new_modelist(struct fb_info *info);
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -23,6 +25,8 @@ static inline void fbcon_resumed(struct fb_info *info) {}
 static inline int fbcon_mode_deleted(struct fb_info *info,
 				     struct fb_videomode *mode) { return 0; }
 static inline void fbcon_new_modelist(struct fb_info *info) {}
+static inline void fbcon_get_requirement(struct fb_info *info,
+					 struct fb_blit_caps *caps) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

