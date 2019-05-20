Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43825C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1895C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LVMcjUHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfETIYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:24:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36209 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfETIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so22559349edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Yo/Zer+8+iZGO3QV40bLkqCAAdgnz/HLbmfJGGYr+Q=;
        b=LVMcjUHiu9elaHcvju6oijD096OkeD1rCO8uoQPNTGt0fOEVW6lb2YqOePOduwuC0R
         SnyyUwKDlhWGsP/P/rOme7Yyry2xo+zUigmnV26HCAqtqU23iZdbgd4nAQI2lcc6rkIS
         EhuEwvu9OKdJNj15SzU/r8nEGq/huZCyYiE5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Yo/Zer+8+iZGO3QV40bLkqCAAdgnz/HLbmfJGGYr+Q=;
        b=tSH/IR+oH21cDnu1w4d1GxSJLpJOqmx7kPZ6Awd9mJvnqTQ1kqgiMRvYksPhvfhess
         5VO0EfHhg5rIV96YCuoZ7AC4etF7kFx9VvwJGWLmH5veTI9cwS/uMyOmwB9lfW+g+e+V
         MqT5iHaW9RWZ0gXIkQfR7/UlC76XYWpPyYWIjWx3l6WelVsRFSD5I6Kekatg238DjMSc
         ffHLqUAiQFQ5NkBsi1vN1h6g4Uu7mDLfsNv+MGahu/X5VsxqZcyAIGKcE3zR5YJwUCce
         aBWmXbb8tDJsxQmBS/BQIbm1BRLtMfEer69suVfJbLiDM64TkSn3sqOe3OEN8Fft/kdK
         B2QQ==
X-Gm-Message-State: APjAAAX/8gBcQH93OghxL8vDjW1NH08LA914HABLxye/gZuxhAspVC3b
        sc/pd9OMnofrOJomEQ7E9iiTqA==
X-Google-Smtp-Source: APXvYqzSNedje/GrhvJfy+yDfT67EfzYCBA9dSKXp3EwKybc9/rxqIqDEBVyCwEsyZ9DjbZ6qFx3XQ==
X-Received: by 2002:a17:906:66c9:: with SMTP id k9mr9493808ejp.21.1558340557540;
        Mon, 20 May 2019 01:22:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:36 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 13/33] fbdev: sysfs files can't disappear before the device is gone
Date:   Mon, 20 May 2019 10:21:56 +0200
Message-Id: <20190520082216.26273-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which means lock_fb_info can never fail. Remove the error handling.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 44cca39f2b51..5f329278e55f 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -179,10 +179,7 @@ static ssize_t store_modes(struct device *device,
 		return -EINVAL;
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	list_splice(&fb_info->modelist, &old_list);
 	fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
@@ -409,10 +406,7 @@ static ssize_t store_fbstate(struct device *device,
 	state = simple_strtoul(buf, &last, 0);
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	fb_set_suspend(fb_info, (int)state);
 
-- 
2.20.1

