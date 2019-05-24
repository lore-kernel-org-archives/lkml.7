Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0152C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6662C217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A84J3j6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfEXIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39270 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389963AbfEXIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so13342348edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5iZhjuR5FCK/3TxL7IjS7BEtXamfSAXEK7faRMJIyY=;
        b=A84J3j6yA9uBLJ4ynLq1hkbX6gaeWiJBlrLbMqTJZ8UL/PCTKWUctpHKWgggmpBGPf
         I8KeLGCgt5cQA9HVi3LQAUwxnb1KiMFfk+3rbZjqd6yF4kX0nRL+Crqvs1W6zyDbd5LA
         yXVpa3vQNEoL/t8Djh76UgtdUToi4TPriNRZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5iZhjuR5FCK/3TxL7IjS7BEtXamfSAXEK7faRMJIyY=;
        b=RIBkWa5k5/xbPD26hK54L06Jx40sxbD1mdUqqDubJAXKB7BUgcx8u0o1ZR06dVvMgk
         PfURuYwy2yjgzSnY+tDIAdGz3xLqObYkv2JTWspgCk77jKcB5muuea3Qlr0fOsmIJsxb
         eL9KotkaYPCGwZU3GZrWkhFiBPwhq+M3Zqb9YvhUmG8wMkIFjc6XKJuUqC+bMXlJrNHi
         TleUmih8bUOwW336TGnlwSiLKz6Ub0/93AxOypVCUwxgHzQLrEZu14VX85j0Tn4kP3CB
         SaqOsS5S5EeFd301vu/VDVz4942/Zj6k6ABVlh53oMyi5QfsR3jd9Msicg3VOKZWnTxz
         Vi5w==
X-Gm-Message-State: APjAAAXyXaoKUf2duT1JzJEJ7F3M39ap2e1UVzbAMaLrCfRKP/IOSwkT
        3aNxBMKRPMTWlQUxIxhYQ0HyeBelmuo=
X-Google-Smtp-Source: APXvYqw+C7uEvcSOzAqBpZKzIjQB+kCYivog+9nN4dN0rkn4Uvf91qd6a0Cft/NG3LdotqRz3PN/jA==
X-Received: by 2002:a17:906:1c4a:: with SMTP id l10mr14985452ejg.124.1558688056848;
        Fri, 24 May 2019 01:54:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:16 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 11/33] fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
Date:   Fri, 24 May 2019 10:53:32 +0200
Message-Id: <20190524085354.27411-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dead code, and removing it avoids me having to understand
what it's doing with lock_fb_info.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
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

