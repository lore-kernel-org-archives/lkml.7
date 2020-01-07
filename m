Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5944CC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2092087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="a3skjP/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgAGT0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:26:08 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39913 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGT0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:26:07 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so218407ywc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=maOi+ccdSCJ33tytaZ2VQyWTlm9roQsB2CYyKUcC3tE=;
        b=a3skjP/AmaWwBHZeZWluAghlXwxiT7Cj7kdIwSY35YoouSaTAle6gkkF+gWSQ43i5K
         B0GbiFcbbFVZraT3GERgOABL8Uc68kYFZIreZ/RiZRxaBPKz51UcdeY8c9TkW4rBxplO
         +ma4KhzsrQj/BcgUSva7gsUmK8tJO0k2NfeH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=maOi+ccdSCJ33tytaZ2VQyWTlm9roQsB2CYyKUcC3tE=;
        b=HERSSypl1Eab4oquFln55x7lzrkInxz8r4H39+7TW/DkUPVNMnu+feHjfs2AvH4JJb
         HhUfuRvfC7DFLbYJdnyNJU9uoHDEuM1lXlatEDiBQkVhDuXP6ZvJdtKQd/CJsukCSSaw
         3SO8IJ/xpwplwJASG051g7Ov96/uRFc6iPIiucoGEDGDrmLA2iKAzX/5PXQV9OS3qNj9
         Wyvm5S+6N9vPDseOe2+2rYt21iPcqtVY723Cfyt44wTWDvzAS2Y+7sA3zz5QUwQHYKH+
         ft0GuBpLoz8k7kUiax1FPyYeK7+w9efkMwY86ZtBDv7vPSdd2UJPK/M2sUGEVqt9F2YV
         KYYg==
X-Gm-Message-State: APjAAAV/gLHR+6xv93jFqdsPhZ2i9iE1bmzEA2YXqMJoD37JPIJPLqqe
        Y7h1+bn1CrZn38BTV6pxuJ09
X-Google-Smtp-Source: APXvYqwCwkS16hDGTInMHpIbsWfaGLyz0bdtQUZqjjL2wAm7ADS3K2eO1OR9tckNRyznHTSO/nu0Yg==
X-Received: by 2002:a81:ec01:: with SMTP id j1mr738569ywm.274.1578425166700;
        Tue, 07 Jan 2020 11:26:06 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
        by smtp.gmail.com with ESMTPSA id q124sm228047ywb.93.2020.01.07.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:26:06 -0800 (PST)
From:   Tianlin Li <tli@digitalocean.com>
To:     kernel-hardening@lists.openwall.com, keescook@chromium.org
Cc:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tianlin Li <tli@digitalocean.com>
Subject: [PATCH 2/2] drm/radeon: change call sites to handle return value properly.
Date:   Tue,  7 Jan 2020 13:25:55 -0600
Message-Id: <20200107192555.20606-3-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107192555.20606-1-tli@digitalocean.com>
References: <20200107192555.20606-1-tli@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally, the failure of set_memory_*() should be passed up the call stack,
and callers should examine the failure and deal with it. Fix those call 
sites in drm/radeon to handle retval properly. 
Since fini functions are always void, print errors for the failures.

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
 drivers/gpu/drm/radeon/r100.c  | 3 ++-
 drivers/gpu/drm/radeon/rs400.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 110fb38004b1..7eafe15ba124 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -706,7 +706,8 @@ void r100_pci_gart_fini(struct radeon_device *rdev)
 {
 	radeon_gart_fini(rdev);
 	r100_pci_gart_disable(rdev);
-	radeon_gart_table_ram_free(rdev);
+	if (radeon_gart_table_ram_free(rdev))
+		DRM_ERROR("radeon: failed free system ram for GART page table.\n");
 }
 
 int r100_irq_set(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index 117f60af1ee4..de3674f5fe23 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -210,7 +210,8 @@ void rs400_gart_fini(struct radeon_device *rdev)
 {
 	radeon_gart_fini(rdev);
 	rs400_gart_disable(rdev);
-	radeon_gart_table_ram_free(rdev);
+	if (radeon_gart_table_ram_free(rdev))
+		DRM_ERROR("radeon: failed free system ram for GART page table.\n");
 }
 
 #define RS400_PTE_UNSNOOPED (1 << 0)
-- 
2.17.1

