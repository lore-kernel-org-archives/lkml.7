Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D8EC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84EE20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="akTeaLvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfETIWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35595 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfETIWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so22580659edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0tIhN6YywxcaWi2QH0yYGfpMycfWUEO/RS9r5SAA9E=;
        b=akTeaLvBQ6wsq1iSx7uVMLfY4jeOwDxuxje6jNqnJq8nwKvXx2+BxVJnG7NALR5v9x
         xSRyR8+rVvptXBeUuUt41AoQ8UQveKZ6PNqC8P3dEvq5vRqOIIriOpQfAG9s7cEpouM+
         G+j8lUIMNOMJMcLAw4VzWDGlVZcroZFqxJB40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0tIhN6YywxcaWi2QH0yYGfpMycfWUEO/RS9r5SAA9E=;
        b=uif4JWLVLTTuXA6+6qSqjbWmEthjY1XEoVKDy9ZMl5s2ysaZX6iyQZ/rQd81MMHKvB
         7LWFbQt/HjwPP8wD5niauTX/fsO1Fi62D7SN+NX9bEXhWSs4u19/sG44OMTMS5VH9EH8
         R7Q478ghJ6geV7UoIiZOfoW7ogLZ9kwaORLhhVdFxka7Wbq1zF3lwcaNRH2V5nPMxYHX
         VI7Of9YhmdUwn37Rs2su6KcVwFJaenmH/qlwpCRNR4aRCgv9WfWhNY8G/SbU2qUTiNcC
         7tDg9wyJ/e/+Ufc4R1/3f93QtdmOqnYn+Ue6K2fYVFd/iTah4d5jsGqbWkE000ljcq78
         2YsQ==
X-Gm-Message-State: APjAAAVCT3QXz8C4lDNaEtSnjJD709wiugOlePFXWdv8UZxfnHdhjR9F
        OoNDLcag2wEbMVxT/XxX4CVouQ==
X-Google-Smtp-Source: APXvYqyjBA7PktU+J9tWW8mtYlNlPAkzMVk0guYtE003G2qGc0oE2kDGJAaVWmK69a2pyHuXZSNPvA==
X-Received: by 2002:a17:906:d053:: with SMTP id bo19mr32339032ejb.86.1558340554401;
        Mon, 20 May 2019 01:22:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:33 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Date:   Mon, 20 May 2019 10:21:53 +0200
Message-Id: <20190520082216.26273-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

we have a static dependency between fbcon and fbdev, and we can
replace the indirection through the notifier chain with a function
call.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 14 +++-----------
 drivers/video/fbdev/core/fbmem.c |  9 ++-------
 include/linux/fb.h               |  4 ----
 include/linux/fbcon.h            |  4 ++++
 4 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a1be589b692f..95af6bd783e8 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3115,14 +3115,14 @@ static int fbcon_fb_unbind(int idx)
 }
 
 /* called with console_lock held */
-static int fbcon_fb_unregistered(struct fb_info *info)
+void fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	if (deferred_takeover)
-		return 0;
+		return;
 
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -3151,8 +3151,6 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 
 	if (!num_registered_fb)
 		do_unregister_con_driver(&fb_con);
-
-	return 0;
 }
 
 /* called with console_lock held */
@@ -3211,7 +3209,7 @@ static inline void fbcon_select_primary(struct fb_info *info)
 #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
 /* called with console_lock held */
-static int fbcon_fb_registered(struct fb_info *info)
+int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
@@ -3355,12 +3353,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		idx = info->node;
 		ret = fbcon_fb_unbind(idx);
 		break;
-	case FB_EVENT_FB_REGISTERED:
-		ret = fbcon_fb_registered(info);
-		break;
-	case FB_EVENT_FB_UNREGISTERED:
-		ret = fbcon_fb_unregistered(info);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index fc3d34a8ea5b..ae2db31eeba7 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1660,7 +1660,6 @@ MODULE_PARM_DESC(lockless_register_fb,
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
 	int i, ret;
-	struct fb_event event;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -1723,7 +1722,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;
 
-	event.info = fb_info;
 	if (!lockless_register_fb)
 		console_lock();
 	else
@@ -1732,9 +1730,8 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		ret = -ENODEV;
 		goto unlock_console;
 	}
-	ret = 0;
 
-	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
+	ret = fbcon_fb_registered(fb_info);
 	unlock_fb_info(fb_info);
 unlock_console:
 	if (!lockless_register_fb)
@@ -1771,7 +1768,6 @@ static int __unlink_framebuffer(struct fb_info *fb_info);
 
 static int do_unregister_framebuffer(struct fb_info *fb_info)
 {
-	struct fb_event event;
 	int ret;
 
 	ret = unbind_console(fb_info);
@@ -1789,9 +1785,8 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
-	event.info = fb_info;
 	console_lock();
-	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	fbcon_fb_unregistered(fb_info);
 	console_unlock();
 
 	/* this may free fb info */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f52ef0ad6781..701abaf79c87 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -136,10 +136,6 @@ struct fb_cursor_user {
 #define FB_EVENT_RESUME			0x03
 /*      An entry from the modelist was removed */
 #define FB_EVENT_MODE_DELETE            0x04
-/*      A driver registered itself */
-#define FB_EVENT_FB_REGISTERED          0x05
-/*      A driver unregistered itself */
-#define FB_EVENT_FB_UNREGISTERED        0x06
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index f68a7db14165..94a71e9e1257 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -4,9 +4,13 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 void __init fb_console_init(void);
 void __exit fb_console_exit(void);
+int fbcon_fb_registered(struct fb_info *info);
+void fbcon_fb_unregistered(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
+static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
+static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

