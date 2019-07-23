Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E9BC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAFC21901
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG9fniY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbfGWLKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:10:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfGWLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:10:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so18968555pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxPuevqDrXKRl+QxbN2Y5oAWPx3TYkvtTDFzWJOHnjs=;
        b=YG9fniY0/+oHh3gEX8AcUgyWwxPgWQEPEhxjpZHpi94MqnZXwH+QdVyrVg+nmhEA8z
         SM/UqyK6EtA4Bc5sa2cLFgokwYU2cT+2CdpDqH76HU2xSy0bx+tFcd89YVxyXRuE2vLg
         MKlCtrYeWocOOwxzyIUrEwiYK2V+ct1EWD4rtV4vHOajVWE7zAA514xDwLU4s+36/CXp
         oWHrs4WW3S/NtRJrA+HaLlsocF2CgILAkg5SO1ue14LiWHwap7WudPDhryPG1+wpEr77
         RqA8g/5FuGum/BQHeLKg5v0+rVdCadygiLFXiEjpIN9sOreBsWuYIzbOT9LR7H+lf6Dh
         jBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxPuevqDrXKRl+QxbN2Y5oAWPx3TYkvtTDFzWJOHnjs=;
        b=kXJZV1RtRgzWiyDr1wABIHZFiCTAJA/3pE1SAtyEZ4ZiHXauawIFU2+sZubmd15e9P
         Kbomet9/dRCtQbQUOmRWEKJhdtsGhHbhWzyx8XjrPicnYxuycF0bTcZFrQ75P+Svz3hf
         N/xd9uLVCyMnk3HKLOOFWykJGCzcbry0JAJiCFEwlOZKmQ3f6EK/pHgGsvU1jfE6Yf5+
         UlvxEKYBHNvBtBvoiWeEZTWzggGhObPfneTjW5fuqQXsDfhslmhy6bb/FcEhd/63ZM+E
         Et011OdAXyDIDhv2efGuyYnzFFNcisbr2NgvqgTxEieVpyJYtpYPrnC4YFXG+8W8WuXe
         4e2A==
X-Gm-Message-State: APjAAAV7qLengKLwaMFReRfhPQmrZr1+x2YkL5oSxBOSOB1Y8mWbOvns
        vxmCYxHl++V5J/EkkO9iAFk=
X-Google-Smtp-Source: APXvYqwtnMRZGdchvBOx/iERHD9AcxxAfbmX8wbGsH4fMfJSma9v9udnTzlqmuaZglKQqjqCkiCFvA==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr82708219pjb.44.1563880217039;
        Tue, 23 Jul 2019 04:10:17 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id v126sm11374576pgb.23.2019.07.23.04.10.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:10:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/radeon: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 19:10:08 +0800
Message-Id: <20190723111008.10955-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index a6cbe11f79c6..b2bb74d5bffb 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -358,15 +358,13 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 
 static int radeon_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_suspend_kms(drm_dev, true, true, false);
 }
 
 static int radeon_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* GPU comes up enabled by the bios on resume */
 	if (radeon_is_px(drm_dev)) {
@@ -380,15 +378,13 @@ static int radeon_pmops_resume(struct device *dev)
 
 static int radeon_pmops_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_suspend_kms(drm_dev, false, true, true);
 }
 
 static int radeon_pmops_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_resume_kms(drm_dev, false, true);
 }
 
@@ -447,8 +443,7 @@ static int radeon_pmops_runtime_resume(struct device *dev)
 
 static int radeon_pmops_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
 
 	if (!radeon_is_px(drm_dev)) {
-- 
2.20.1

