Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B282184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UJ/oc6lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbfEXIyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41648 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390104AbfEXIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so13313430edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qewta4jE6NaBT1wgic7FFQ06WBBHYmA/qRjwYgxOqRs=;
        b=UJ/oc6lGweLhLGaGI+xbhdiMnf+Cl5bY1xWJJbxHvngccKX4OoywLCjeBh1g4pYDoJ
         qi1WhmNTybu+BYt2gziM+hFKub1eGlHbu1KVKoGMG+FCaKAPV4qEvHKNT3weADfNlJ0l
         fN49GpBW5Nme6wUCxJRLNAJpa3n4EJNc6UmaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qewta4jE6NaBT1wgic7FFQ06WBBHYmA/qRjwYgxOqRs=;
        b=qnltT2mzFwMX3MVImBHWqZ65cjDP3ORG+Rx29IDML18QoZ03Ln/Ys2c6oEHEcL/FM/
         lGnouXgwwddDnZV98gjR0HslUECNV8cJ5MeJsNnBxn7JbaBrchmCvZXcRmVuT1D6hRIM
         NmVw4JHWxQJJ4MRRmQhdGATYeRvYxCwJ8cY8AWJtl23Lb9A0Mt90WhggYdCLZN2yUdrA
         9sCRtL7yPIrqvYCfINFEhntgBmukDwkKhbepORfsYvjN7lw4Bx+O6fLuIiiW4Zjl8Ojp
         uhDChZrRY2cjKbp5IVIw9YhCTIekrYYb8GhJROQb5+fcDNIn/VqZ+I0ihNe68ckxBOxK
         TdQg==
X-Gm-Message-State: APjAAAXj5j559Q35tYiizgzwj16AW4LldJNHKIKliiBdUxMyrBIMd5LU
        LUXAYLQ2vSrbTJPdPWAMYywuV9CVIBw=
X-Google-Smtp-Source: APXvYqyr6Tw3IMkdvKEhRIRZY6yk1Ivs/PjOxT7WpIXudWAibRjX8vDW5XPFQ0Wc/pC5twi84XhpqA==
X-Received: by 2002:a50:8684:: with SMTP id r4mr103185155eda.98.1558688069727;
        Fri, 24 May 2019 01:54:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:29 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 21/33] fbdev: directly call fbcon_suspended/resumed
Date:   Fri, 24 May 2019 10:53:42 +0200
Message-Id: <20190524085354.27411-22-daniel.vetter@ffwll.ch>
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

With the sh_mobile notifier removed we can just directly call the
fbcon code here.

v2: Remove now unused local variable.

v3: fixup !CONFIG_FRAMEBUFFER_CONSOLE, noticed by kbuild

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 10 ++--------
 drivers/video/fbdev/core/fbmem.c |  7 ++-----
 include/linux/fb.h               |  8 --------
 include/linux/fbcon.h            |  4 ++++
 4 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f114b4c88796..24ea6e4fbee0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2919,7 +2919,7 @@ static int fbcon_set_origin(struct vc_data *vc)
 	return 0;
 }
 
-static void fbcon_suspended(struct fb_info *info)
+void fbcon_suspended(struct fb_info *info)
 {
 	struct vc_data *vc = NULL;
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2932,7 +2932,7 @@ static void fbcon_suspended(struct fb_info *info)
 	fbcon_cursor(vc, CM_ERASE);
 }
 
-static void fbcon_resumed(struct fb_info *info)
+void fbcon_resumed(struct fb_info *info)
 {
 	struct vc_data *vc;
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -3330,12 +3330,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	int idx, ret = 0;
 
 	switch(action) {
-	case FB_EVENT_SUSPEND:
-		fbcon_suspended(info);
-		break;
-	case FB_EVENT_RESUME:
-		fbcon_resumed(info);
-		break;
 	case FB_EVENT_MODE_CHANGE:
 		fbcon_modechanged(info);
 		break;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bee45e9405b8..73269dedcd45 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1917,17 +1917,14 @@ EXPORT_SYMBOL(unregister_framebuffer);
  */
 void fb_set_suspend(struct fb_info *info, int state)
 {
-	struct fb_event event;
-
 	WARN_CONSOLE_UNLOCKED();
 
-	event.info = info;
 	if (state) {
-		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
+		fbcon_suspended(info);
 		info->state = FBINFO_STATE_SUSPENDED;
 	} else {
 		info->state = FBINFO_STATE_RUNNING;
-		fb_notifier_call_chain(FB_EVENT_RESUME, &event);
+		fbcon_resumed(info);
 	}
 }
 EXPORT_SYMBOL(fb_set_suspend);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b90cf7d56bd8..794b386415b7 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,14 +126,6 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*	The display on this fb_info is being suspended, no access to the
- *	framebuffer is allowed any more after that call returns
- */
-#define FB_EVENT_SUSPEND		0x02
-/*	The display on this fb_info was resumed, you can restore the display
- *	if you own it
- */
-#define FB_EVENT_RESUME			0x03
 /*      An entry from the modelist was removed */
 #define FB_EVENT_MODE_DELETE            0x04
 
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 38d44fdb6d14..790c42ec7b5d 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -7,12 +7,16 @@ void __exit fb_console_exit(void);
 int fbcon_fb_registered(struct fb_info *info);
 void fbcon_fb_unregistered(struct fb_info *info);
 void fbcon_fb_unbind(struct fb_info *info);
+void fbcon_suspended(struct fb_info *info);
+void fbcon_resumed(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
 static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
 static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 static inline void fbcon_fb_unbind(struct fb_info *info) {}
+static inline void fbcon_suspended(struct fb_info *info) {}
+static inline void fbcon_resumed(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

