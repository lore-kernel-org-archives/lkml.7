Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7597C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980CE20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="m0RspacW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYVGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:06:20 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43174 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:06:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 55DAB744
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id szpUh4Pp7qqJ for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:06:18 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1F4C4837
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:06:18 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id q184so9646784itd.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iELtKhPzIshZDbvaluvxOSSlfieDKoYqR5/gISsqtL4=;
        b=m0RspacWboH26LXyLuz33+dSBEjUKG0ypxjT4LqXg+U4WL3PS9ejPqRXerKU7OGpYt
         P03Tk4b7N4qVE3FVwCISOwdiV3y46lWFbzZOJauQhzX1kMhz0PXltXs1yKUnrEaaPxkJ
         +nea06u7Q48zgb9V02xp+gXChOsQbRn2nn7DnH7Q8hVfepdDKfejiDNY56sa9C64jjxP
         TLuVQW03ujx5z2MFYEx0tslqYVOQs1gnW872LEayQsU08Ljw7S9BkFF6w8UoSGoWi7qI
         MI2cD5xPG0npV9KT8KRp/PR2jo3grxomjlFLjNw9l5Iw5tUEp1j7JoLpMPuPpgk8yXwI
         tyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iELtKhPzIshZDbvaluvxOSSlfieDKoYqR5/gISsqtL4=;
        b=mKMeb1kcpo/cYVMk0LZe+tHxVqd7gTn5sX01OcneZnzsF2BtqwRlD5L27Io7KfMoBj
         /GoOMrIfZ124qJcBSpATeKas3WEhEvx4e9U/CnAshlcY9koQKlhApZSSwywwZW7ufxOf
         Y60IhR9JmvhjWqI2Ew19Bpn0l8Gv/PN4hHA6vYKE/hTs455OmIyeM+smvsTfKsLDIDKu
         Xob7GNzrbyLYKsZ0OQunqi80CsXO/1Z6XqJRiqa1wF8lk3x6GJB5SozczypqAX0LBWmw
         TuXycdlaD2mBqHXYs0nEcG81iPS+3ec/VIUQG9Ptaw9HGHqg4tqOGxwNzql83Xn6/+Z0
         VsIA==
X-Gm-Message-State: APjAAAXzY9uT2Z+as4pjwMouT048Loigrg16j0Es4TocyO/k4xyLv2VL
        ayxlaJ+sxgwoOel0gKfF1vvBshOFmFVFaDVufHogCGp+EMDH4xlYlBpQpFbHztJ5ZbXvxwMweqP
        XLpU+3279KGVt/0sQ/j99v9zjiL4u
X-Received: by 2002:a6b:8f4f:: with SMTP id r76mr20156290iod.161.1553547977724;
        Mon, 25 Mar 2019 14:06:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxa51MJEwH2NRG/AJhC3SjhLoIINKCIt7AHZdr94gaiVEYmz7ty6GdPuXwiVdzvHjrNPc3HOQ==
X-Received: by 2002:a6b:8f4f:: with SMTP id r76mr20156268iod.161.1553547977484;
        Mon, 25 Mar 2019 14:06:17 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id a80sm6326396ita.0.2019.03.25.14.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:06:16 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: radeon: fix a potential NULL-pointer dereference
Date:   Mon, 25 Mar 2019 16:05:52 -0500
Message-Id: <20190325210552.12797-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0fc81efe-186b-3207-e0d0-b0bb95626069@daenzer.net>
References: <0fc81efe-186b-3207-e0d0-b0bb95626069@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails, the fix frees memory and
returns -ENOMEM to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
v2: use radeon_crtc_destroy to properly clean up resources as
suggested by Michel Dänzer <michel@daenzer.net>
---
 drivers/gpu/drm/radeon/radeon_display.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aa898c699101..3c6d3289316b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -663,7 +663,7 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.page_flip_target = radeon_crtc_page_flip_target,
 };
 
-static void radeon_crtc_init(struct drm_device *dev, int index)
+static int radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
@@ -671,13 +671,18 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 
 	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
 	if (radeon_crtc == NULL)
-		return;
+		return -ENOMEM;
 
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		DRM_ERROR("failed to allocate the flip queue\n");
+		radeon_crtc_destroy(&radeon_crtc->base);
+		return -ENOMEM;
+	}
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
@@ -706,6 +711,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+
+	return 0;
 }
 
 static const char *encoder_names[38] = {
@@ -1612,7 +1619,9 @@ int radeon_modeset_init(struct radeon_device *rdev)
 
 	/* allocate crtcs */
 	for (i = 0; i < rdev->num_crtc; i++) {
-		radeon_crtc_init(rdev->ddev, i);
+		ret = radeon_crtc_init(rdev->ddev, i);
+		if (ret)
+			return ret;
 	}
 
 	/* okay we should have all the bios connectors */
-- 
2.17.1

