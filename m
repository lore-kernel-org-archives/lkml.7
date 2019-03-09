Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C792C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D79207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NtlSNdWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCIEdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:33:39 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49658 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCIEdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:33:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D8D79D7E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IMKqEXLs7yP6 for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:33:37 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id AE46AD79
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:33:37 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id n15so697986ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wluJat1PksApvfWP7fcLVGHB4CEce/r4mb44xD+uFwA=;
        b=NtlSNdWGNpa1fk01M//0Z728WBas1o9a9pTaYGcjKjtts1eLz5G7g9UFQlu62OQgc0
         w5lItOENRnyTWkbheFY/m9EuSi3KHZrGDDeehiSaV/CoS1HkdvbuT7wNQvaBgviB1tIi
         IGLTzmvWuteLavy3czdWIvAItnTZdmbj7hV4syXTSyHZanzUQwKfeMhuqQQptwnmBLHi
         jxhUeWseanLolVuF7glLWckrb7+B3CdiE9tHt0VL/KqLWkQ0Uel/IyO3HP6o67tiuEAX
         Y3jdsY4N9UXm8n9HYJsqCMRsewpATXgshb+RpNigiM4ZyICAWiVztkFTDQcZr3edzNCf
         Drww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wluJat1PksApvfWP7fcLVGHB4CEce/r4mb44xD+uFwA=;
        b=cLXgYIPNLdbcDTtbaix2gt58xDgtcC7AAFNGWdLUfBxJ9sPp0YeI8ODpv8oJyJ5zV8
         3CEg0lNtplj+OFACbLGnubPnRZCcYkhWAP2vLJ/xQGMvHtbohROUDNfTY39nuMoTpXYH
         3/8xZtq5hGOtwFT+KfYOzDl6moGA9u55letKdOgFqefQKvwlif3NVIVi3nqlwUpzC77N
         NEsVRKpVGuPoJfN1cem+IrOvxIBqTYZulvyPqqQVizL52D+Dz5NvRNGUDCDxZ5epftJX
         q3qERq/Jmj2qsH1a3630hnLmNxNVXyjMQ0mWWiaEG6OThhKDkqLQ5wowF2oXzs09Dkev
         EaaQ==
X-Gm-Message-State: APjAAAU3qRZEHWGb536PpQUtiVDW/rIumWIuwaMIlpIDh6FFnq4uTc35
        +65e0ptnVPEqyeEDY/MXxyuaW7FlsgSsaQwx4SLJXSzw96HrXrRmOBOrM2L3u7d2uQWgr1rIXn4
        nYObrKhyjmG4yEKdyA4Pytw7FvFmC
X-Received: by 2002:a05:660c:6c3:: with SMTP id z3mr10333097itk.83.1552106017327;
        Fri, 08 Mar 2019 20:33:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEtZ0DXnOD4/CgXAKq8XZ9u/p3Tb9wm96LQw5r9KK9ItjnQCjbDdWDXobWF9oqqOFjWIIZWA==
X-Received: by 2002:a05:660c:6c3:: with SMTP id z3mr10333093itk.83.1552106017082;
        Fri, 08 Mar 2019 20:33:37 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e5sm5088529ite.33.2019.03.08.20.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:33:36 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: check if alloc_workqueue fails
Date:   Fri,  8 Mar 2019 22:33:31 -0600
Message-Id: <20190309043331.5210-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_workqueue may fail. The fix checks its status. We probably
need to add a return value for radeon_crtc_init, so that we can
pass an error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aa898c699101..16f95bde8c2e 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -678,6 +678,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue)
+		DRM_ERROR("failed to allocate the flip queue\n");
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
2.17.1

