Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0E42184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WFVQ26EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbfEXIyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390179AbfEXIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id j12so13320305eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCf5Rgx3D70Kd2HtBB6qbJz/DSCv1md2CdZdgEtyLXg=;
        b=WFVQ26EU4e9g0t3Pm481bYAhTDj6tXbB5c5J+KUiu0aJlzh1dBe7L6KahUEgUKiyA8
         vHeWnvZRbe+/XU2JckZJQrEVWt8QgZmQ8wJpVfxgeI435T0ImU3QUKZjGDkUjC3Wjfii
         6gH5XIGzOsA0Do2IE3GYfzQxjB4Se7rpIwfsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCf5Rgx3D70Kd2HtBB6qbJz/DSCv1md2CdZdgEtyLXg=;
        b=csTJw8bvrAsUDXjW84hAFNPAB13qqdx708RXY2bQ+T39jGEz2ACXA792hHeoV7GrfD
         TjAwfE7iiVIJmKln+siWH3DxP/hdBmEA9R3XOy4bmG8L2anRqdopLUvdAhRtEg8kjOox
         qnwgtJi3pQqMY7QTRngkSFLfaYyzopOhFTkV7gA3cUt7EJTemoLvUYGoStaULwp249cE
         W6C5zOZhb1OSi2LPsDIeMj6TLad8gFILD1/TmmmoDnVUp5vTwJbXeTSigoP3nz4KKI/b
         bcxGH3M3ncXS8PsrwFOe5E92DPalPyXgtFd1U2epMvPyOS4ikuF3BQADtMWneAu2p6eR
         BraA==
X-Gm-Message-State: APjAAAWyQ98KZjkELMz9FCDBqVNr5Ac5r8Xi5+6SOizK0yOwBTgvMw50
        +BIPuGs1CLB5M0ue/FYMZsBY9Mi0jHY=
X-Google-Smtp-Source: APXvYqzyPNuIzdNMoEW4sq1/8xjOYEmjw8xi22YZoTjllIH3zi//9suSNZONQSkg5qYF7IHu4ZEvXg==
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr73467369edo.205.1558688077326;
        Fri, 24 May 2019 01:54:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:36 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 27/33] fb: Flatten control flow in fb_set_var
Date:   Fri, 24 May 2019 10:53:48 +0200
Message-Id: <20190524085354.27411-28-daniel.vetter@ffwll.ch>
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

Instead of wiring almost everything down to the very last line using
goto soup (but not consistently, where would the fun be otherwise)
drop out early when checks fail. This allows us to flatten the huge
indent levels to just 1.

Aside: If a driver doesn't set ->fb_check_var, then FB_ACTIVATE_NOW
does nothing. This bug exists ever since this code was extracted as a
common helper in 2002, hence I decided against fixing it. Everyone
just better have a fb_check_var to make sure things work correctly.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 126 +++++++++++++++----------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 25ae466ba593..96805fe85332 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -954,6 +954,9 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	int flags = info->flags;
 	int ret = 0;
+	u32 activate;
+	struct fb_var_screeninfo old_var;
+	struct fb_videomode mode;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
@@ -970,87 +973,84 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 			fb_delete_videomode(&mode1, &info->modelist);
 
 
-		ret = (ret) ? -EINVAL : 0;
-		goto done;
+		return ret ? -EINVAL : 0;
 	}
 
-	if ((var->activate & FB_ACTIVATE_FORCE) ||
-	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
-		u32 activate = var->activate;
+	if (!(var->activate & FB_ACTIVATE_FORCE) &&
+	    !memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
-		/* When using FOURCC mode, make sure the red, green, blue and
-		 * transp fields are set to 0.
-		 */
-		if ((info->fix.capabilities & FB_CAP_FOURCC) &&
-		    var->grayscale > 1) {
-			if (var->red.offset     || var->green.offset    ||
-			    var->blue.offset    || var->transp.offset   ||
-			    var->red.length     || var->green.length    ||
-			    var->blue.length    || var->transp.length   ||
-			    var->red.msb_right  || var->green.msb_right ||
-			    var->blue.msb_right || var->transp.msb_right)
-				return -EINVAL;
-		}
+	activate = var->activate;
 
-		if (!info->fbops->fb_check_var) {
-			*var = info->var;
-			goto done;
-		}
+	/* When using FOURCC mode, make sure the red, green, blue and
+	 * transp fields are set to 0.
+	 */
+	if ((info->fix.capabilities & FB_CAP_FOURCC) &&
+	    var->grayscale > 1) {
+		if (var->red.offset     || var->green.offset    ||
+		    var->blue.offset    || var->transp.offset   ||
+		    var->red.length     || var->green.length    ||
+		    var->blue.length    || var->transp.length   ||
+		    var->red.msb_right  || var->green.msb_right ||
+		    var->blue.msb_right || var->transp.msb_right)
+			return -EINVAL;
+	}
 
-		ret = info->fbops->fb_check_var(var, info);
+	if (!info->fbops->fb_check_var) {
+		*var = info->var;
+		return 0;
+	}
 
-		if (ret)
-			goto done;
+	ret = info->fbops->fb_check_var(var, info);
 
-		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-			struct fb_var_screeninfo old_var;
-			struct fb_videomode mode;
+	if (ret)
+		return ret;
 
-			if (info->fbops->fb_get_caps) {
-				ret = fb_check_caps(info, var, activate);
+	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+		return 0;
 
-				if (ret)
-					goto done;
-			}
+	if (info->fbops->fb_get_caps) {
+		ret = fb_check_caps(info, var, activate);
 
-			old_var = info->var;
-			info->var = *var;
+		if (ret)
+			return ret;
+	}
 
-			if (info->fbops->fb_set_par) {
-				ret = info->fbops->fb_set_par(info);
+	old_var = info->var;
+	info->var = *var;
 
-				if (ret) {
-					info->var = old_var;
-					printk(KERN_WARNING "detected "
-						"fb_set_par error, "
-						"error code: %d\n", ret);
-					goto done;
-				}
-			}
+	if (info->fbops->fb_set_par) {
+		ret = info->fbops->fb_set_par(info);
+
+		if (ret) {
+			info->var = old_var;
+			printk(KERN_WARNING "detected "
+				"fb_set_par error, "
+				"error code: %d\n", ret);
+			return ret;
+		}
+	}
 
-			fb_pan_display(info, &info->var);
-			fb_set_cmap(&info->cmap, info);
-			fb_var_to_videomode(&mode, &info->var);
+	fb_pan_display(info, &info->var);
+	fb_set_cmap(&info->cmap, info);
+	fb_var_to_videomode(&mode, &info->var);
 
-			if (info->modelist.prev && info->modelist.next &&
-			    !list_empty(&info->modelist))
-				ret = fb_add_videomode(&mode, &info->modelist);
+	if (info->modelist.prev && info->modelist.next &&
+	    !list_empty(&info->modelist))
+		ret = fb_add_videomode(&mode, &info->modelist);
 
-			if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
-				struct fb_event event;
-				int evnt = (activate & FB_ACTIVATE_ALL) ?
-					FB_EVENT_MODE_CHANGE_ALL :
-					FB_EVENT_MODE_CHANGE;
+	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
+		struct fb_event event;
+		int evnt = (activate & FB_ACTIVATE_ALL) ?
+			FB_EVENT_MODE_CHANGE_ALL :
+			FB_EVENT_MODE_CHANGE;
 
-				info->flags &= ~FBINFO_MISC_USEREVENT;
-				event.info = info;
-				event.data = &mode;
-				fb_notifier_call_chain(evnt, &event);
-			}
-		}
+		info->flags &= ~FBINFO_MISC_USEREVENT;
+		event.info = info;
+		event.data = &mode;
+		fb_notifier_call_chain(evnt, &event);
 	}
 
- done:
 	return ret;
 }
 EXPORT_SYMBOL(fb_set_var);
-- 
2.20.1

