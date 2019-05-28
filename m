Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A194C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531D0208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AxHczMPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfE1JGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42999 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfE1JD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so2698266eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWzvBOSi043NlPhBjWBcZ5gYsPOn0TslCCY3OR85nNc=;
        b=AxHczMPWvdB0duF+TZIkUR7zn9ttLdk/LQJ410Odk6YrE3Ov+Xj8w2xf8WBWz+h8zh
         hWr4b6fx9GdaTYN4B8ue+7obfo93vkEkYnyUUC5slS0fTzODA8qH0Dh4vIKG/yUsL9Dl
         k1KBtJQ7JTBTxRPR6NwEJyDK2bQCgXhLRM7hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWzvBOSi043NlPhBjWBcZ5gYsPOn0TslCCY3OR85nNc=;
        b=Rv62+gHE30iftcKEobrSDDJKhojvLzO1inXW7eAbbG/fEhRv8vezJ4QMcI6TdQc7tj
         5dEakOCSXKuXiVQzWsjSREeFm6GG7SSNw+AJIaKWWrpWY4tlNDou1JpZTSjwGprkxuPq
         TlT7TIKfksA1ooyJEmqP0gPtyw+N329GpIIqKk2gqPyf6VOO1fyjmZrjKI+E8CfI37d1
         wf4y6uTNbZWO6a3nMIlLeCiiuy61kZJA6JNT9cDvWagpZP2oCiQsL6Lri3BBhmiJA2Pv
         mQb8dheexhTyLhA3z8EalfOwc46PgZkNEgeOYpIm2fQfc2Ja3wg+Y5TL64pSWPv/3QE8
         /aHQ==
X-Gm-Message-State: APjAAAVfqBL7Pzh7Xk4MnFSjqTQ0GaO4b0SkL6I+mS6TGzGSI+tnJU70
        nIk/OjjE7pQdiBVEeJIyUyXYTq9dJtY=
X-Google-Smtp-Source: APXvYqxwYBWK+S/Sn+nc60pnOFDN3a1NVbrdhjndc/zKC3s0aq0anlm33HbTi0toBUJUK+1EhIP7hw==
X-Received: by 2002:a50:918b:: with SMTP id g11mr128303052eda.24.1559034205270;
        Tue, 28 May 2019 02:03:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:24 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 09/33] fbcon: Remove fbcon_has_exited
Date:   Tue, 28 May 2019 11:02:40 +0200
Message-Id: <20190528090304.9388-10-daniel.vetter@ffwll.ch>
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

v3: CI showed me that I still didn't fully understand what's going on
here. The leaked references in con2fb_map have been used upon
rebinding the fb console in fbcon_init. It worked because fbdev
unregistering still cleaned out con2fb_map, and reset it to info_idx.
If the last fbdev driver unregistered, then it also reset info_idx,
and unregistered the fbcon driver.

Imo that's all a bit fragile, so let's keep the con2fb_map reset to
-1, and in fbcon_init pick info_idx if we're starting fresh. That
means unbinding and rebinding will cleanse the mapping, but why are
you doing that if you want to retain the mapping, so should be fine.

Also, I think info_idx == -1 is impossible in fbcon_init - we
unregister the fbcon in that case. So catch&warn about that.

v4: Drop unecessary assignment - I forgot to delete the first
assignment of info in fbcon_init.

Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbcon.c | 41 ++++++--------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5424051c8e1a..e11bae2787e6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -112,7 +112,6 @@ static int softback_lines;
 static int first_fb_vc;
 static int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
-static int fbcon_has_exited;
 static int primary_device = -1;
 static int fbcon_has_console_bind;
 
@@ -1050,13 +1049,12 @@ static const char *fbcon_startup(void)
 		info->var.bits_per_pixel);
 
 	fbcon_add_cursor_timer(info);
-	fbcon_has_exited = 0;
 	return display_desc;
 }
 
 static void fbcon_init(struct vc_data *vc, int init)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info;
 	struct fbcon_ops *ops;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
@@ -1064,9 +1062,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
 	int cap, ret;
 
-	if (info_idx == -1 || info == NULL)
+	if (WARN_ON(info_idx == -1))
 	    return;
 
+	if (con2fb_map[vc->vc_num] == -1)
+		con2fb_map[vc->vc_num] = info_idx;
+
+	info = registered_fb[con2fb_map[vc->vc_num]];
 	cap = info->flags;
 
 	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
@@ -3336,14 +3338,6 @@ static int fbcon_event_notify(struct notifier_block *self,
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
@@ -3396,7 +3390,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		fbcon_remap_all(idx);
 		break;
 	}
-done:
 	return ret;
 }
 
@@ -3443,9 +3436,6 @@ static ssize_t store_rotate(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3468,9 +3458,6 @@ static ssize_t store_rotate_all(struct device *device,
 	int rotate, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3491,9 +3478,6 @@ static ssize_t show_rotate(struct device *device,
 	struct fb_info *info;
 	int rotate = 0, idx;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3514,9 +3498,6 @@ static ssize_t show_cursor_blink(struct device *device,
 	struct fbcon_ops *ops;
 	int idx, blink = -1;
 
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3543,9 +3524,6 @@ static ssize_t store_cursor_blink(struct device *device,
 	int blink, idx;
 	char **last = NULL;
 
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx = con2fb_map[fg_console];
 
@@ -3668,9 +3646,6 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
 
-	if (fbcon_has_exited)
-		return;
-
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	if (deferred_takeover) {
 		dummycon_unregister_output_notifier(&fbcon_output_nb);
@@ -3695,7 +3670,7 @@ static void fbcon_exit(void)
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i) {
 				mapped = 1;
-				break;
+				con2fb_map[j] = -1;
 			}
 		}
 
@@ -3718,8 +3693,6 @@ static void fbcon_exit(void)
 				info->queue.func = NULL;
 		}
 	}
-
-	fbcon_has_exited = 1;
 }
 
 void __init fb_console_init(void)
-- 
2.20.1

