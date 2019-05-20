Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412ACC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Vh1HQx0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfETIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37730 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfETIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id w37so22552627edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAPnhxqw8kme2eR+AuVFsaR4pvfjpQV+5x2Qx7ASEQ8=;
        b=Vh1HQx0v1toKnOC/o4+NxIRAS4qdnL7xFxVmzs7PzaHJK00/mA1zLjPnQywnF9FaNS
         g2x4y7tGHyJ74sK8N9rCyeIwdUNSDAKgMreZ1nU6PCXGu0t2LLf0qy9PThDq7PyJshfS
         IkgW0obXAHORtuKJpLYNO1qhGGk1+JvHYHD2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAPnhxqw8kme2eR+AuVFsaR4pvfjpQV+5x2Qx7ASEQ8=;
        b=M21dxuRWFV9CJRZ2tdE/PaCH2P9ggK/UEXCnFLLYFPRH6xFZFMLFYPTM1Q3zkrSUTB
         3Xd/IUNV3KYvPqvKnJTpqZVz6EQU534twQ595HbT6sIkI8n48WGAKaY4J7pKyrivFaV4
         KoD0V0OuakH+J53iECEOmsn90IfhWrz1gA5BGULa8nu3HR78VB9WAVV9Xbe8y/RhtSQd
         hmqiK7sO7uFfjww9tfBzNM8wKr8XHRvJUvwJnIE2st76oRo5zH5EAhy5niqw5o4kjv9y
         KTlunkEIXzKa7tVfjoUHx0ffoqg9FobC3L7nI/VOYm9hthhsSBhRHBgkhiId1TCHlDmf
         9fkw==
X-Gm-Message-State: APjAAAXwAnmpdYvaBDjIZgGM9ip7Gf7OhUvUHCd0LbydvU+xibQ3Xdux
        ZgaV3FG/iOT92tXqe+FShVYTZ4MZ9T0=
X-Google-Smtp-Source: APXvYqy2pt8n+x8BPHCCQ5cJnXhvOlYkpsAiqSlVjIHsEB/DVOI4Hf/8671bBp3VO5BjCkiPfLabNQ==
X-Received: by 2002:a50:8bbb:: with SMTP id m56mr74709421edm.230.1558340556427;
        Mon, 20 May 2019 01:22:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:35 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 12/33] fbdev/omap: sysfs files can't disappear before the device is gone
Date:   Mon, 20 May 2019 10:21:55 +0200
Message-Id: <20190520082216.26273-13-daniel.vetter@ffwll.ch>
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
---
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 8087a009c54f..bd0d20283372 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -60,8 +60,7 @@ static ssize_t store_rotate_type(struct device *dev,
 	if (rot_type != OMAP_DSS_ROT_DMA && rot_type != OMAP_DSS_ROT_VRFB)
 		return -EINVAL;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	r = 0;
 	if (rot_type == ofbi->rotation_type)
@@ -112,8 +111,7 @@ static ssize_t store_mirror(struct device *dev,
 	if (r)
 		return r;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	ofbi->mirror = mirror;
 
@@ -149,8 +147,7 @@ static ssize_t show_overlays(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 	omapfb_lock(fbdev);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
@@ -208,8 +205,7 @@ static ssize_t store_overlays(struct device *dev, struct device_attribute *attr,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 	omapfb_lock(fbdev);
 
 	if (len > 0) {
@@ -340,8 +336,7 @@ static ssize_t show_overlays_rotate(struct device *dev,
 	ssize_t l = 0;
 	int t;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
 		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
@@ -369,8 +364,7 @@ static ssize_t store_overlays_rotate(struct device *dev,
 	if (buf[len - 1] == '\n')
 		len = len - 1;
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	if (len > 0) {
 		char *p = (char *)buf;
@@ -453,8 +447,7 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 
 	size = PAGE_ALIGN(size);
 
-	if (!lock_fb_info(fbi))
-		return -ENODEV;
+	lock_fb_info(fbi);
 
 	if (display && display->driver->sync)
 		display->driver->sync(display);
-- 
2.20.1

