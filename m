Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B8C282E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7A920989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XG2Xk6Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfE1JDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfE1JDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so30610835edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdSAzTv9tDPr6PTxvMhXZVM/Er2L9zs7q0S7NNjW/ok=;
        b=XG2Xk6QdQnFvZNtT1FJSbJRUie40rMANdM0srLaNSg5DjS2kagtuP2RFgL4VendVOT
         BabNgErILkSIbHiZbTBTMTYqlOuoHuDBbXOVrWrUlgwpokq6/Wf0htlfVQ/vZhH8sFl9
         dkgrYC8vItg/cnP9Ums7sqMpu0F3/0mku30MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdSAzTv9tDPr6PTxvMhXZVM/Er2L9zs7q0S7NNjW/ok=;
        b=P+9qdHwr8gbc4gHw+3MpiYpujRCbath22BD0GUa06l7wql0oUtd2IduLP77B09+CbR
         sEBMjnTeDfoy9ukDXXuQKmGak/uv7WZOMOlPWUyhXSV2hWj+4F4Gl/844KWtYKQ0qLqc
         X5Onj1GRfLNoSEobWHxTuEDv+UPxHfY1K67caCV7W3LCL6lvfDPMEKKbt6kdnnkTBN0x
         pGe9WYigTAG/+w55b4EqnLZCppzUUZEKwzvBy+o4z4MPIjKd76tChMDZNjv3xRr7bDfr
         ALH1Rr/dm7oLmiSDT6Wfff1y+kNE0KO/FkiMBYQGgPZKIUgKSZhWYgYvK0ZOqBKfO/aG
         Y9zw==
X-Gm-Message-State: APjAAAXCubrz1vPm2quCK/7wx3e8LlPyOVd+1M7Qf+g93kXdly+87vjj
        bCpAgK54RoN+/L5f+IfhpfUHnKKHcmU=
X-Google-Smtp-Source: APXvYqz7N+WGbx3CGIzAcTP4j/O/T91KOj5m1m+2vfXlGhtH0z7XZhnZ1uDp1ATj69H/KzvnZS3Kaw==
X-Received: by 2002:a50:f4fb:: with SMTP id v56mr128756589edm.13.1559034228987;
        Tue, 28 May 2019 02:03:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 26/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Date:   Tue, 28 May 2019 11:02:57 +0200
Message-Id: <20190528090304.9388-27-daniel.vetter@ffwll.ch>
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

With the recursion broken in the previous patch we can drop the
FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
prevention was it's only job.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c   | 5 ++---
 drivers/video/fbdev/core/fbmem.c   | 3 ---
 drivers/video/fbdev/core/fbsysfs.c | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a4617067ff24..b5ee89f16d6c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2386,9 +2386,8 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (!(info->flags & FBINFO_MISC_USEREVENT))
-				if (fb_blank(info, blank))
-					fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, blank))
+				fbcon_generic_blank(vc, info, blank);
 		}
 
 		if (!blank)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d6713dce9e31..25ae466ba593 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1194,10 +1194,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
-		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
-		info->flags &= ~FBINFO_MISC_USEREVENT;
-
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
 		unlock_fb_info(info);
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 252d4f52d2a5..882b471d619e 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -310,9 +310,7 @@ static ssize_t store_blank(struct device *device,
 
 	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
-	fb_info->flags |= FBINFO_MISC_USEREVENT;
 	err = fb_blank(fb_info, arg);
-	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
 	/* might again call into fb_blank */
 	fbcon_fb_blanked(fb_info, arg);
 	console_unlock();
-- 
2.20.1

