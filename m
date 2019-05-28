Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4834F208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="frw58n0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfE1JDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47052 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfE1JDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id f37so30562065edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqvjuHP1JlltKsAAI+cqqXVrkqUOcJ7eWhpcU6m4g1c=;
        b=frw58n0pRHAXNDbcXB+xAqYIkvLZxek+SzpkxuUVcIcCgtAz4ksuilklcx2AQ4saSF
         4whTeD2QhLuWUQBHUNchNxxkkb8QdQNnYaTwPxS9iD+InQMnlwn6A6Hx4kcb2+t8RIKl
         C4tVxDn3n3c+Eq+/pdndHPl8PbLYZ9uoeajEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqvjuHP1JlltKsAAI+cqqXVrkqUOcJ7eWhpcU6m4g1c=;
        b=dkHH+vfGhQJUOXxiDXE3gbU7q2XoO8PYrNyOr33XcD0DT4zrX4Wwzw8FN8HqHJWWib
         lQoehzyV9evwn6Hf8EHMRhgaEqdgcY71MNdOpKJEFNVZCvo21B1TLEY2TWP1Cc95U6SU
         ObcFkYvJJLnDhQhU7TQ+z/u5o7kK+LaUWL1IHVQq6abjyi72LqdX6BmeqaTe++ZPGXej
         ms/0UORce871BzSeE38EkI6t/FkVesiCSkevbkQRAllqHcVaMBJOWQdUiTIs3NW+CrWa
         ckmq0FW7I9vxlCabHdrJQAlTINP/ljv6bm2dblswJKUQ4ezXRlei/5bJT2h2MrnAH9Yc
         7a1A==
X-Gm-Message-State: APjAAAU/nMc2C3HLM+R96NdDylJ9PYymJgP0T9aXPYcF7AIQ1mttp6lC
        WDdNc+1LAnFn2z5If/nZ/6dRuKnSG1E=
X-Google-Smtp-Source: APXvYqxkR8uRPfRQx/cEMiLS4f+zqTikJ6iJyG5emvQCsp3aU+7WOuJdm2C2xsdHOcVuFOgNa2Uw0Q==
X-Received: by 2002:a50:a4f7:: with SMTP id x52mr128120101edb.86.1559034209379;
        Tue, 28 May 2019 02:03:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:28 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 12/33] fbdev/omap: sysfs files can't disappear before the device is gone
Date:   Tue, 28 May 2019 11:02:43 +0200
Message-Id: <20190528090304.9388-13-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which means lock_fb_info can never fail. Remove the error handling.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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

