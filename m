Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7347CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9E3216E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VbSQAghJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfETIW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33601 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfETIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so22609143edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwgnmEYo2AsN2seVNWQ6w+9PIizDlMfg8yS3XiJMdOk=;
        b=VbSQAghJf9HGDlQKsfxLWsNnfzStGXkNX/j4p10S+ADRCmX5ava6aXstIoGq/kMwT/
         V5DmK2pw7hfLF1iQGa6rk4HMAXO51zxcMtqHAwNPms7BgcinLOR2sprrHMax1xl5KP03
         /LXXKYtpR4kPUJWk2v7opeAYU3tzrFk3DosG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwgnmEYo2AsN2seVNWQ6w+9PIizDlMfg8yS3XiJMdOk=;
        b=hChGhQubCUiMdvB1F3dV0/SuMF3vn7bDGdi7f0oApcLOIwujnfzDjiGaJHGukagSRD
         DpgenrgY7sVliNXhqRDfntsziLhzZVIew9n+zfPAAZtbuO4DT2PHExFT8Y/zZRdxwua3
         9gLjbA+FjTZML5VlvQ261qJR+S/hGBW9mpurmV8DyVRGdCbOmi9CS6kAZdP1ATn8eUZr
         qAPzGNj6blq7FiCXdOWMy05PNu9mas9tTsyBcJ92KAiBQPLuGVBBma/IswFf6PPZ3vpa
         yNv+npMSGgrHLUP+VwAZw3nEQvpfqAOVAfwr91Y0CBg6vRtSWfXWPBW1W7n4A28t4YEu
         NvkA==
X-Gm-Message-State: APjAAAVBMHIOQq5CGiKX8+5EtBhBWxp/MOMRUWbmuZphv1oqITqkaKkw
        luqkL3Xur5yUkWVPegPFKajFHw==
X-Google-Smtp-Source: APXvYqwceNL/LrOuvhdD1jUDdGInDeKdG5i9IVGNSecmbPjM9xRsI2Rc0RFnW2wU5dzx+HqfwLDVKw==
X-Received: by 2002:a50:970a:: with SMTP id c10mr74054624edb.2.1558340570749;
        Mon, 20 May 2019 01:22:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:50 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Richard Purdie <rpurdie@rpsys.net>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org
Subject: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Date:   Mon, 20 May 2019 10:22:07 +0200
Message-Id: <20190520082216.26273-25-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.

The justification is that if hw blanking fails (i.e. fbops->fb_blank)
fails, then we still want to shut down the backlight. Which is exactly
_not_ what fb_blank() does and so rather inconsistent if we end up
with different behaviour between fbcon and direct fbdev usage. Given
that the entire notifier maze is getting in the way anyway I figured
it's simplest to revert this not well justified commit.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/backlight.c | 2 +-
 drivers/video/fbdev/core/fbcon.c    | 9 ---------
 include/linux/fb.h                  | 4 +---
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index deb824bef6e2..c55590ec0057 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -46,7 +46,7 @@ static int fb_notifier_callback(struct notifier_block *self,
 	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
+	if (event != FB_EVENT_BLANK)
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 58b876718d81..1549056a848e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2346,8 +2346,6 @@ static int fbcon_switch(struct vc_data *vc)
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
-	struct fb_event event;
-
 	if (blank) {
 		unsigned short charmask = vc->vc_hi_font_mask ?
 			0x1ff : 0xff;
@@ -2358,13 +2356,6 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
-
-
-	lock_fb_info(info);
-	event.info = info;
-	event.data = &blank;
-	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
-	unlock_fb_info(info);
 }
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index e76185244593..4b9b882f8f52 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -130,12 +130,10 @@ struct fb_cursor_user {
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
-/*      A hardware display blank change occurred */
+/*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
-/*	A software display blank change occurred */
-#define FB_EVENT_CONBLANK               0x0C
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
-- 
2.20.1

