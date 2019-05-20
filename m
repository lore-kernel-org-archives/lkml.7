Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6787C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7220863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NoAk5Ybf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfETIW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41938 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfETIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so22531724edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZL7dK3QHcNbZLKWjImh8nse/rAEY9uop0vjWdMdQzA=;
        b=NoAk5YbfgOrrNimMCYl/NP8C5JEoJkCWTI2pjUKdZmoYP0rjrm+mnHejEkHJawdEKF
         nuRBvHhZQbrtrxfKuEnAoSyV2BjjA6n2qfhn5YAdpw9yDjZL4fk1ZOVkAQ1g+ho2bJYi
         QrGJ1Pxj4z1zxnXE8b2klkEFzo/InU0gaGEVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZL7dK3QHcNbZLKWjImh8nse/rAEY9uop0vjWdMdQzA=;
        b=OgQBURs+T8I+7PGkECdJPFAaddx5m4cIagBW47WmWNN6CdZgd0muV0foojZKTrObAm
         XcmUqybkXFImJIMgHHyLvEj5pIq0ZFJ1lk7r5S6S2S40IFzvUi0TRcZG6hLCOKQiNx3t
         p44uKejghennFYCJq2WP41ihVlNHRRD4cx6+Jqp/7CzltnK02s82WP7BnV7Hv9F+hVr2
         gQ2v3KrAeBaaSqRla1BG8awWkuXQHCW9HLrZMPtXRCnCTld6gyr4YDIHyr1JmiY21CpD
         XucZl/tVkz/Z76fc/p2z30uUAu3nqQXQOcxSeWxE5oUn7SDaDdW0Rb+hlCntF0EYfakA
         j/jg==
X-Gm-Message-State: APjAAAW7R8TfSaiU5g1uw4xN0je3u6n2XeNGZ9J+O6GhRAuYYY0mgHL6
        mRHuKg4aRHmFMme31dyyPe5K2g==
X-Google-Smtp-Source: APXvYqxRm2Ckj9q3hFReAnFGuCBRLSDRkWc0S6Nan4YCQS01wu484++cIwoI5wP8Fcp4ASbyyRkA6A==
X-Received: by 2002:a50:87ab:: with SMTP id a40mr71795115eda.188.1558340571784;
        Mon, 20 May 2019 01:22:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 25/33] fbcon: directly call fbcon_fb_blanked
Date:   Mon, 20 May 2019 10:22:08 +0200
Message-Id: <20190520082216.26273-26-daniel.vetter@ffwll.ch>
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

We cant remove FB_EVENT_BLANK because that's still used by the
backlight and lcd code, but that's kinda fine: No recursion between
fbdev core code and fbcon code possible for that case.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 5 +----
 drivers/video/fbdev/core/fbmem.c | 1 +
 include/linux/fbcon.h            | 2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1549056a848e..f85d794a3bee 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3227,7 +3227,7 @@ int fbcon_fb_registered(struct fb_info *info)
 	return ret;
 }
 
-static void fbcon_fb_blanked(struct fb_info *info, int blank)
+void fbcon_fb_blanked(struct fb_info *info, int blank)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct vc_data *vc;
@@ -3331,9 +3331,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
-	case FB_EVENT_BLANK:
-		fbcon_fb_blanked(info, *(int *)event->data);
-		break;
 	case FB_EVENT_REMAP_ALL_CONSOLE:
 		idx = info->node;
 		fbcon_remap_all(idx);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d428d08c358a..9932130bf728 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1068,6 +1068,7 @@ fb_blank(struct fb_info *info, int blank)
 	event.data = &blank;
 
 	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
+	fbcon_fb_blanked(info, blank);
 
 	if (info->fbops->fb_blank)
  		ret = info->fbops->fb_blank(blank, info);
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 7f0a530a913c..90e196c835dd 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -14,6 +14,7 @@ int fbcon_mode_deleted(struct fb_info *info,
 void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
+void fbcon_fb_blanked(struct fb_info *info, int blank);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -27,6 +28,7 @@ int fbcon_mode_deleted(struct fb_info *info,
 void fbcon_new_modelist(struct fb_info *info) {}
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps) {}
+void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

