Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9EAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFBF208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KjLil2b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfE1JGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35982 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfE1JD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so30638942edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WPeIDAqtSnPbDcxMeR1LaTs5pcjbLLnzUOYFaYwyy4=;
        b=KjLil2b0YP+O0+LLoKZvoQsb+o+ksT4MFgBy/gHuXSCAAGP6P6cA5C0cJ0Q064y4qh
         MGbSN9Y6fh5TrgSLKOYg3g3hchsqbQ/zTnXkZdsWXQ2yOLHhKkE88weQaBaJDRahFgfh
         kXldbmLz0TAZjV2rhJuHrpHFHPulmv4hUL1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WPeIDAqtSnPbDcxMeR1LaTs5pcjbLLnzUOYFaYwyy4=;
        b=MbReNSdMeHfMOAV3j9a9C4UkYeH8tHDqMFc1fXUrZhfVxkIPthuPTzhlJEibFwuZ6I
         nayudIiFSkxygZe9mRPEGINjbob1VHdCiGCPWW8Uwd2rM6Gl/gtUYUP+M+K4l1khpfXz
         lfaxoBYGrSPpcTfOZYATiAWOaBC1iLzHaYJ68y44mbQOJkxG3EX7fkDn02yExMOPRXLB
         LReOwfROcpnfjljrGia+arWxMnIABl55BW+X9wxTzEcr9LOevJ33sKYTjpZUjPZDVBTI
         /pzsTNSKS86BOW62tYmeKaPhD9gl8H5s8pkuoxndgeoBdH2Ft0TcYh2Qbf74yccrORZF
         c3lw==
X-Gm-Message-State: APjAAAUXeUbOzyZQCaF2ZciTRdUwG+EwMxtPaXwZ9HKqa23wj6aw5U1C
        b7fUzzbo3JK8CeIqj04nHkIwYYw2a+c=
X-Google-Smtp-Source: APXvYqwMsg+ox2j7/vocxj31v97alIwDq1JoAS4rf3ZZsaq9cI9N6Nbl/phYJ9vu/CPVcy0X+VXgjw==
X-Received: by 2002:a05:6402:12ce:: with SMTP id k14mr1550281edx.169.1559034208108;
        Tue, 28 May 2019 02:03:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:27 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 11/33] fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
Date:   Tue, 28 May 2019 11:02:42 +0200
Message-Id: <20190528090304.9388-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dead code, and removing it avoids me having to understand
what it's doing with lock_fb_info.

v2: Also remove sh_mobile_lcdc_must_reconfigure, now unused (Sam).

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> (v1)
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 82 --------------------------
 drivers/video/fbdev/sh_mobile_lcdcfb.h |  5 --
 2 files changed, 87 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index dc46be38c970..1437695415c9 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -534,89 +534,9 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
 		ch->tx_dev->ops->display_off(ch->tx_dev);
 }
 
-static bool
-sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
-				const struct fb_videomode *new_mode)
-{
-	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
-		ch->display.mode.xres, ch->display.mode.yres,
-		new_mode->xres, new_mode->yres);
-
-	/* It can be a different monitor with an equal video-mode */
-	if (fb_mode_is_equal(&ch->display.mode, new_mode))
-		return false;
-
-	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
-		ch->display.mode.yres, new_mode->yres);
-	ch->display.mode = *new_mode;
-
-	return true;
-}
-
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
@@ -2540,8 +2460,6 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_chan *ch)
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

