Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C35C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2CD218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cFFpFNGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfCWCaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:30:04 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34596 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfCWCaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 22:30:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id E3D32E05
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 02:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HAwBx7KKNBrK for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 21:30:02 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id B4609DFA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 21:30:02 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id y6so3935744itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 19:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=viZxWs7tMQIpDA87de2/Gm2rpk/enxXRu6DSz3xzooE=;
        b=cFFpFNGoXBYFs5E8apeeUMfZ6HeYh/F+vHmDKYVUCvOSNIP04cdDKqSe3bOjNYxci1
         ILLOEMo1F/HWYmkJXC04l37370NSGlL6Jo2vBTJU4IGIVvYfA1T2pB7mBpBHv1LIYsxk
         Tf+AfNB4A9KcrY9rQTkYllJLjhO6fOILd5y8AiRn4ioK1L7wDe3BIJD2wgWSYiKP+/sH
         UqPi3uw7zFsSfdIPKffAawZpb6VShIaZiokHVsb+1mEXKHNhgO2IC6GTw6v+pblmUWJb
         cDsw6HnZOmf9f/41CrmHGl/3qw2yz/LWIs1Cu/M66k3LUCsqH+9Z9FBenzmC+R0cDx//
         /srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=viZxWs7tMQIpDA87de2/Gm2rpk/enxXRu6DSz3xzooE=;
        b=pGXOedinP3opVmRn9/S0MLXxkV8WroQeRCmg1+YzlBLBfYLZ1KGVzTgr6AoMMOUFCT
         cWbGHWIlerTk2pEiVumoeFCvOze0MqMoB0R+9BSszsIb3FSBy5r4TsXOZaqGmlSjUlCH
         pmwWZRK95y2yjvHOxvZHHlMz0wwhvaM6NfD+aggFrhaw+uXzB2QkpdvKgsHU9W3Oitq/
         to7/6WuyxzuFF/eIHXfax4etZEJ455XwVu9pofY/93prVNMhkSCZJFiZBKoXCEdE+71h
         5q1gbdoKCQ4sffCfdLGQ3ptTmUTPG2CAy/105RVHq7J93LaJKuGHzCk8MY6XAS0g0b9t
         5CQw==
X-Gm-Message-State: APjAAAXgqJ7Cb8/mr/BFCW+OsTkapcer206HBzSjy6mzDXr99NC+uJo6
        rYoiS2QfeO7zc0AZJL5EQpOSV7+NCBQvjU3EMjlzeoFKrzbawWR8NhPn2PSyw5eDy/mKx/CBomi
        ntzMcay0ndbUluM2StGgv+7YxH3il
X-Received: by 2002:a24:c301:: with SMTP id s1mr646335itg.112.1553308202144;
        Fri, 22 Mar 2019 19:30:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMdsiKaLLUn99M6ZSA/PqHDcXEeDYUG6R7eKiqdMSfTYlAJlDBkXQP+n9NcLqop6jFLlU+1w==
X-Received: by 2002:a24:c301:: with SMTP id s1mr646321itg.112.1553308201927;
        Fri, 22 Mar 2019 19:30:01 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k4sm4144913itc.32.2019.03.22.19.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 19:30:00 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: radeon: fix a potential NULL-pointer dereference
Date:   Fri, 22 Mar 2019 21:29:55 -0500
Message-Id: <20190323022955.14326-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue fails, the fix frees memory and
returns to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aa898c699101..a31305755a77 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -678,6 +678,11 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		DRM_ERROR("failed to allocate the flip queue\n");
+		kfree(radeon_crtc);
+		return;
+	}
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
2.17.1

