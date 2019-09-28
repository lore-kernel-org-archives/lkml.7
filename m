Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A62C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F134B20872
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oi+Ph7Va";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h6pZjOQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfI1B3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:29:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1B3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:29:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 982EE616FE; Sat, 28 Sep 2019 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634160;
        bh=m/+SNT1ylRadZlQdB8fVjW39Gd/vKBoLUGrjef6eP84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oi+Ph7Vappbne3npRkZ6MeD+lNwg7p5YgfNDSDcbgL+9aPewzYZdGBmHEYFEXcLv8
         +O7awEY5dbMi1NIdlijWU88Vk9sGvVzL01eiGBzJi5yDad6PZwfLBiaKvBhFBsh4ut
         /8QwdCjDavmuEgM/22YbkX/FFxhW1eyL42Y4Wz8k=
Received: from jeykumar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jsanka@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE709611D1;
        Sat, 28 Sep 2019 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634159;
        bh=m/+SNT1ylRadZlQdB8fVjW39Gd/vKBoLUGrjef6eP84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6pZjOQgOd2DEBcM8QQGQMWPVGaH4T/lHuZNiJrNEC83GtpsvXDS2yt1asqWGg2B1
         Yt2WCZYZEpHqjxBfjpgQWKStzp5NANfuL+KkOzi+AdaGD36k0V91cmBnssOHdwsyQ9
         NXWLwfsApOixzdz2aw0fSqfWU24MLfnLv1jrgkGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE709611D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jsanka@codeaurora.org
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>, narmstrong@baylibre.com,
        seanpaul@chromium.org, robdclark@gmail.com, jcrouse@codeaurora.org
Subject: [PATCH] drm: add fb max width/height fields to drm_mode_config
Date:   Fri, 27 Sep 2019 18:28:51 -0700
Message-Id: <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_config max width/height values determine the maximum
resolution the pixel reader can handle. But the same values are
used to restrict the size of the framebuffer creation. Hardware's
with scaling blocks can operate on framebuffers larger/smaller than
that of the pixel reader resolutions by scaling them down/up before
rendering.

This changes adds a separate framebuffer max width/height fields
in drm_mode_config to allow vendors to set if they are different
than that of the default max resolution values.

Vendors setting these fields should fix their mode_set paths too
by filtering and validating the modes against the appropriate max
fields in their mode_valid() implementations.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
---
 drivers/gpu/drm/drm_framebuffer.c | 15 +++++++++++----
 include/drm/drm_mode_config.h     |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 5756431..2083168 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -300,14 +300,21 @@ struct drm_framebuffer *
 		return ERR_PTR(-EINVAL);
 	}
 
-	if ((config->min_width > r->width) || (r->width > config->max_width)) {
+	if ((config->min_width > r->width) ||
+	    (!config->max_fb_width && r->width > config->max_width) ||
+	    (config->max_fb_width && r->width > config->max_fb_width)) {
 		DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d && <= %d\n",
-			  r->width, config->min_width, config->max_width);
+			r->width, config->min_width, config->max_fb_width ?
+			config->max_fb_width : config->max_width);
 		return ERR_PTR(-EINVAL);
 	}
-	if ((config->min_height > r->height) || (r->height > config->max_height)) {
+
+	if ((config->min_height > r->height) ||
+	    (!config->max_fb_height && r->height > config->max_height) ||
+	    (config->max_fb_height && r->height > config->max_fb_height)) {
 		DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d && <= %d\n",
-			  r->height, config->min_height, config->max_height);
+			r->height, config->min_height, config->max_fb_width ?
+			config->max_fb_height : config->max_height);
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 3bcbe30..c6394ed 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -339,6 +339,8 @@ struct drm_mode_config_funcs {
  * @min_height: minimum fb pixel height on this device
  * @max_width: maximum fb pixel width on this device
  * @max_height: maximum fb pixel height on this device
+ * @max_fb_width: maximum fb buffer width if differs from max_width
+ * @max_fb_height: maximum fb buffer height if differs from  max_height
  * @funcs: core driver provided mode setting functions
  * @fb_base: base address of the framebuffer
  * @poll_enabled: track polling support for this device
@@ -523,6 +525,7 @@ struct drm_mode_config {
 
 	int min_width, min_height;
 	int max_width, max_height;
+	int max_fb_width, max_fb_height;
 	const struct drm_mode_config_funcs *funcs;
 	resource_size_t fb_base;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

