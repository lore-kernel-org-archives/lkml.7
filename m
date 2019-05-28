Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A640620989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S8RfuEcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfE1JDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33601 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfE1JDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so30689008edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ooi4hbNCFWLvdn7gPI0VJoLcd+qEK7EqaAEtyPgNrvM=;
        b=S8RfuEcjpgpmoyZCzNoHK8dLIiuaW5CIB+VxCtfy6GnMIvrlpna7ceB7yiYxlqeHrx
         jBndnR2Hh/seM8PvHDCU54zhrIhNO//uE0eeo4boFXOzPL0By8avIVPg8TTg4Wj8XJK1
         ro2g9jS6/je89BQPID7iNTY1Jt2ifOIDPf2Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ooi4hbNCFWLvdn7gPI0VJoLcd+qEK7EqaAEtyPgNrvM=;
        b=BpaX6KdXDA7VC+beuDxH5X/TYDJsyKOC9nbQ5H8FcEKiaij6+IbehTlqXMzaodGzR7
         p1Mx62xBfeWy0MKrCpwu2GlRRUyr+5hEkS76G7sTqmQtK5izl8O19VLF9HSZSCvJt4ET
         9qLJmPtFekr1WV6ZrihHjCYwOLaypOnWgbdieqe3m9uyEQASpfHLIbNrXkheEujmo8TS
         5jbNYrZ1vwMscHh+t9qbZm7Z4bOG91+izHHZM0NOa4N6fs+STsI1WIGeOGg08h0CtWg9
         ianMTWq3pB6MpsdVzCUYnUWyARfI58BM72TNxqVzlAG2/q5g0ks6NSJcKKv/roQ1O3Xf
         696w==
X-Gm-Message-State: APjAAAW2xL9FDwWO2rsCloYj2Qxr6HySvSlJoXfgSSSofU8LUDGvWdYi
        NKPRXudmsN/ixjcFWWzoTBYGStIogYE=
X-Google-Smtp-Source: APXvYqx2/pj/om14dAedFkMIr9nON3I1vQ8gKLDTPmWBJKmhJYG5UizCgUZgKeSWqd6Rhcjw75tXeg==
X-Received: by 2002:a17:906:9145:: with SMTP id y5mr57481511ejw.206.1559034221591;
        Tue, 28 May 2019 02:03:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:40 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 21/33] fbdev: directly call fbcon_suspended/resumed
Date:   Tue, 28 May 2019 11:02:52 +0200
Message-Id: <20190528090304.9388-22-daniel.vetter@ffwll.ch>
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

With the sh_mobile notifier removed we can just directly call the
fbcon code here.

v2: Remove now unused local variable.

v3: fixup !CONFIG_FRAMEBUFFER_CONSOLE, noticed by kbuild

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index 142686953b71..e3267d71395c 100644
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

