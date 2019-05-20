Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260E921655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CJE6x2vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfETIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:24:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39855 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbfETIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so22524613edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxqcSYFwHsuvd2Lv/d2TG+VXwZfFZyMIWYgQCzFB2T8=;
        b=CJE6x2vwqV3LQYmFhtuIPutKZptFzaKYr7k4mX1elPEsoncWPJ/GrDVp2MNooxU1YN
         xEtL2BegbC/MvQovtXXLHG7jiZdSGkI14MrhieJPhjfjk9EjLkKP/TEOYw1C9UGcG5BG
         tRpJgocZKYyHG15LmfgCt/u9VTVIi6lSN8Qys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxqcSYFwHsuvd2Lv/d2TG+VXwZfFZyMIWYgQCzFB2T8=;
        b=rrDn0yrFC106gcDJZCLgw/4Jdoma0KHPQwpuc8Gfgn/IXxm6tPDi4coR97cdP6pYaj
         x/9WSKuK8xK1U8hE9oSjKZ09oqk+/zzKwuAMuMN10EvJdwuhvsBXwoCD5ezn/icHb9oP
         XV9bRlT8maJoJzlUkpw87EGTr9v6ruca6TY3T8QWLg4rB5dCgS1utGSw4AZgz9uWqn7K
         EbT5ABtowD9byVRFoH4f3iYqgBlemc1IP9Ej/j6OeocP++bL092mgRnkcjjBNyKK6HoW
         ZhOeaygM+jschFn6uj1t4MbcSsBY6xgoAOazSsgDr+ChpNQk2DpBq9yMobHkPeiVUnGI
         PJ1Q==
X-Gm-Message-State: APjAAAULtEZ3TdE/dT06INLPb8FTyOPjnzMu4v9O8zHIfBH2KuDWz62b
        F8qKoYCC3tZL8EwksBGJ8iQtVa9q4IE=
X-Google-Smtp-Source: APXvYqzH5vi4xjbpIabhzI98CxlrdX5ZWZAJwSpnPRN8dmpzTWzU7l5z6Z1WUkTqbCcTD46EZXl8Dg==
X-Received: by 2002:aa7:d381:: with SMTP id x1mr74213607edq.251.1558340555273;
        Mon, 20 May 2019 01:22:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:34 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 11/33] fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
Date:   Mon, 20 May 2019 10:21:54 +0200
Message-Id: <20190520082216.26273-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dead code, and removing it avoids me having to understand
what it's doing with lock_fb_info.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 63 --------------------------
 drivers/video/fbdev/sh_mobile_lcdcfb.h |  5 --
 2 files changed, 68 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index dc46be38c970..c5924f5e98c6 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -556,67 +556,6 @@ sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
 static int sh_mobile_lcdc_check_var(struct fb_var_screeninfo *var,
 				    struct fb_info *info);
 
-static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
-					 enum sh_mobile_lcdc_entity_event event,
-					 const struct fb_videomode *mode,
-					 const struct fb_monspecs *monspec)
-{
-	struct fb_info *info = ch->info;
-	struct fb_var_screeninfo var;
-	int ret = 0;
-
-	switch (event) {
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
-		/* HDMI plug in */
-		console_lock();
-		if (lock_fb_info(info)) {
-
-
-			ch->display.width = monspec->max_x * 10;
-			ch->display.height = monspec->max_y * 10;
-
-			if (!sh_mobile_lcdc_must_reconfigure(ch, mode) &&
-			    info->state == FBINFO_STATE_RUNNING) {
-				/* First activation with the default monitor.
-				 * Just turn on, if we run a resume here, the
-				 * logo disappears.
-				 */
-				info->var.width = ch->display.width;
-				info->var.height = ch->display.height;
-				sh_mobile_lcdc_display_on(ch);
-			} else {
-				/* New monitor or have to wake up */
-				fb_set_suspend(info, 0);
-			}
-
-
-			unlock_fb_info(info);
-		}
-		console_unlock();
-		break;
-
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
-		/* HDMI disconnect */
-		console_lock();
-		if (lock_fb_info(info)) {
-			fb_set_suspend(info, 1);
-			unlock_fb_info(info);
-		}
-		console_unlock();
-		break;
-
-	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
-		/* Validate a proposed new mode */
-		fb_videomode_to_var(&var, mode);
-		var.bits_per_pixel = info->var.bits_per_pixel;
-		var.grayscale = info->var.grayscale;
-		ret = sh_mobile_lcdc_check_var(&var, info);
-		break;
-	}
-
-	return ret;
-}
-
 /* -----------------------------------------------------------------------------
  * Format helpers
  */
@@ -2540,8 +2479,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
 	unsigned int max_size;
 	unsigned int i;
 
-	ch->notify = sh_mobile_lcdc_display_notify;
-
 	/* Validate the format. */
 	format = sh_mobile_format_info(cfg->fourcc);
 	if (format == NULL) {
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
index b8e47a8bd8ab..589400372098 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
@@ -87,11 +87,6 @@ struct sh_mobile_lcdc_chan {
 	unsigned long base_addr_c;
 	unsigned int line_size;
 
-	int (*notify)(struct sh_mobile_lcdc_chan *ch,
-		      enum sh_mobile_lcdc_entity_event event,
-		      const struct fb_videomode *mode,
-		      const struct fb_monspecs *monspec);
-
 	/* Backlight */
 	struct backlight_device *bl;
 	unsigned int bl_brightness;
-- 
2.20.1

