Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8940C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9005D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QsXk17pA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfETIWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34346 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfETIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so22585340eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwFpKjbpcVfpxavAIzY2FLdOXjuwdFWEEdQZCv4IdjM=;
        b=QsXk17pAjlKycoPZTOSaN4LlLR4asGEE0iqfcFpeJDjgVLyUgtaqMucm8pPF4Hh7y3
         0P1ZDpsUiTukc91Jg9NYU0gTd9GISmiuhXHZUVXRAPCDq/c5hkdGY/fzuLrel8ZqClgJ
         DhGW8hIctQhq4oFsNDmF08WccwkWXo5yuibzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwFpKjbpcVfpxavAIzY2FLdOXjuwdFWEEdQZCv4IdjM=;
        b=hzsz514/uK3NolMvq3X72W4ZlkYwhCiB8T6GnV4mTaS3RM+kmuxCIpnnqcwFFz17iF
         tR8DycxdOQipycUq+3vGPzyU8+j6j9mBtsxf5thgpQeWlHl0c/Vmkzk4J0A7Y+6xdqJK
         O1dwV9exilX/1HOctHJ1t3XEE2cNii0NA/xqCMJapopBqVxDo53MpKhEru/bSicVsbPo
         9nLct0PHhwg8ccPxy1VBZCg1H91JQE56SQCnMqFaE7WOf9z1Ew36pGY3Vuff/L10YfOn
         dKvezCMeDBPgJrXPuCiHtUpy0Naabm/P55W+45Xcg/igzAcVj6ELjbX9nV68Z2IbXnbX
         rE+w==
X-Gm-Message-State: APjAAAU4+emd0SMCTpRVdgsQQJARtSzkahpDTJneXJyVgltkCyOh0arg
        F99k2c9drBX7dCGk+GRPu3fQJQ==
X-Google-Smtp-Source: APXvYqyaF3UDCmRImjTKmK2S0jUqa2Jdsisz4g5gCuh/2C8JABswvXs+xL3FfvnEiNUWEG4UegO6aw==
X-Received: by 2002:a50:e705:: with SMTP id a5mr73800863edn.270.1558340553273;
        Mon, 20 May 2019 01:22:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:32 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 09/33] fbcon: Remove fbcon_has_exited
Date:   Mon, 20 May 2019 10:21:52 +0200
Message-Id: <20190520082216.26273-10-daniel.vetter@ffwll.ch>
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

This is unused code since

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

when fbcon was made a compile-time static dependency of fbdev. We
can't exit fbcon anymore without exiting fbdev first, which only works
if all fbdev drivers have unloaded already. Hence this is all dead
code.

v2: I missed that fbcon_exit is also called from con_deinit stuff, and
there fbcon_has_exited prevents double-cleanup. But we can fix that
by properly resetting con2fb_map[] to all -1, which is used everywhere
else to indicate "no fb_info allocate to this console". With that
change the double-cleanup (which resulted in a module refcount underflow,
among other things) is prevented.

Aside: con2fb_map is a signed char, so don't register more than 128 fb_info
or hilarity will ensue.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbcon.c | 33 +-------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2b2082615ca1..a1be589b692f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -112,7 +112,6 @@ static int softback_lines;
 static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
-static int fbcon_has_exited;
 static int primary_device = -1;
 static int fbcon_has_console_bind;
 
@@ -1050,7 +1049,6 @@ static const char *fbcon_startup(void)
 		info->var.bits_per_pixel);
 
 	fbcon_add_cursor_timer(info);
-	fbcon_has_exited = 0;
 	return display_desc;
 }
 
@@ -3336,14 +3334,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	struct fb_blit_caps *caps;
 	int idx, ret = 0;
 
-	/*
-	 * ignore all events except driver registration and deregistration
-	 * if fbcon is not active
-	 */
-	if (fbcon_has_exited && !(action == FB_EVENT_FB_REGISTERED ||
-				  action == FB_EVENT_FB_UNREGISTERED))
-		goto done;
-
 	switch(action) {
 	case FB_EVENT_SUSPEND:
 		fbcon_suspended(info);
@@ -3396,7 +3386,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		fbcon_remap_all(idx);
 		break;
 	}
-done:
 	return ret;
 }
 
@@ -3443,9 +3432,6 @@ static ssize_t store_rotate(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3468,9 +3454,6 @@ static ssize_t store_rotate_all(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3491,9 +3474,6 @@ static ssize_t show_rotate(struct device *device,
 	struct fb_info *info;
 	int rotate = 0, idx;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3514,9 +3494,6 @@ static ssize_t show_cursor_blink(struct device *device,
 	struct fbcon_ops *ops;
 	int idx, blink = -1;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3543,9 +3520,6 @@ static ssize_t store_cursor_blink(struct device *device,
 	int blink, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3668,9 +3642,6 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
 
-	if (fbcon_has_exited)
-		return;
-
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	if (deferred_takeover) {
 		dummycon_unregister_output_notifier(&fbcon_output_nb);
@@ -3695,7 +3666,7 @@ static void fbcon_exit(void)
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i) {
 				mapped = 1;
-				break;
+				con2fb_map[j] = -1;
 			}
 		}
 
@@ -3718,8 +3689,6 @@ static void fbcon_exit(void)
 				info->queue.func = NULL;
 		}
 	}
-
-	fbcon_has_exited = 1;
 }
 
 void __init fb_console_init(void)
-- 
2.20.1

