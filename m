Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFBC04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77720989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GlkHs7h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfE1JDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37303 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfE1JDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so30610445edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cWHgfcnxD5I2BYjyMESTRE5UT0aIyijX/8odiiRxgw=;
        b=GlkHs7h288I4VAt2Wsjm8nLyS+B7h+Dtgxf6FxBZNbe8tu/qGhaA16KftXEf1mJ5ug
         bL1vUnjwuAB0uvbqE/PZsMxIhuIFbBFYtLhXdSNB/xBXBJ+cHgXwtmYHiVw3Ja48hVMb
         3vDsldEi2HaPKptlVv1u+oBma3NTApwQZqe80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cWHgfcnxD5I2BYjyMESTRE5UT0aIyijX/8odiiRxgw=;
        b=YLcRn7uTEwuCUoxmI46tuNZnfgdTN9LL4k8sLrldRkyz0zTazqwG481gUp7ATYkiiP
         hmuTNcwVzhArDc5+mky4NRSPq9rJl8E4enrRGmfpHiIy7odGW5aMOhiH2ZLyJKJExDQ3
         stgcCei7YGisZA4tOx95t80+3uhV4DGhhoLeQO33K78vyTC/Bbob3z4YGDh6Zp4w2R2U
         R0gKynYrqYyizT4jjzYaIRLcvNPXwglwR7oowO3iK24yH3OgOCixtT1xwI6biKhgnL9s
         DB0zNY/EHFLGcRmETekKkVgwKkxkyKMU8wxD2M35A2/bqiKQ6k8kLwbVt39PfCBhb28G
         jeDA==
X-Gm-Message-State: APjAAAVVq1Icfd41IwyopN2XiQNPG85GWipgpVXHGard6TBGtLIMWBXs
        fOZhFT0ieIKgiF/DiEQjdXzkjeg0XCM=
X-Google-Smtp-Source: APXvYqyX9S6oHBIHBIGW/9NIZtlG5/2Myp+Wl1BI9XPUva2TrxMFDV17OVdC7KUz960S5dQ16cG0Dw==
X-Received: by 2002:a50:ba1a:: with SMTP id g26mr127396218edc.90.1559034224558;
        Tue, 28 May 2019 02:03:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:43 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 23/33] fbdev: Call fbcon_get_requirement directly
Date:   Tue, 28 May 2019 11:02:54 +0200
Message-Id: <20190528090304.9388-24-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index 515366308537..ef69bd4ad343 100644
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

