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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64647C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A3227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM2uf2W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfGWJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:05:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40908 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfGWJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:05:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so19104761pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0Po2t8vMBWo5yX2pfDsLkHP1u5XK6Mx9PkT5fdjYG8=;
        b=GM2uf2W7Igd9e55i5i0eZpV6eTP1FWB9O+BRMOE0iuMwen2uXvQUaOHmQLSn8Sqa1f
         YZtRbIoKEIHQN0n8QZ1Q2gjDf2+82vkQkxZcYj7ZQJ3nW2llVA9dDQ/8U+5pS9tfhjq/
         nI24gEItIF+najDQu2Z5a1Jm/O7JcBA10Q+6XCcgVuCawTajiDg5d1Yr5POBhgqWa/4l
         5U7ngGWsjI2gaf5+czBFW8b+8Y0+kh8vRdJgNGWykRJNm42fbmx2tyxft1BG/xME6a1c
         jiDfFyC9YTsz4jP9frqZa9fSwrZH+m4iCyi6OmmCANTA3/S0bceQlWhX8ZtO4afBKVj3
         PGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0Po2t8vMBWo5yX2pfDsLkHP1u5XK6Mx9PkT5fdjYG8=;
        b=WK5yfUg/+BZzVguVC/w7/+KR98lGmvDZASTeSKCxVrUrmutAhkjlRzjRbU8TYAyw7R
         bd2sq2zjlCxn0SoWSDijHIPlWCODMQH5JZwVeJCitp3zcEndv0e3NnfgxRTwdNyryndm
         Pfa9tstt+MORPD+bo4UGCoob1N0rtm5tM/9IHFQ20Yao8aBlLGh6Iovnt9wUceIJhPGT
         /yMFS7scmNM768CjLpomWEC/lRw03YWM1rZPOegVGtNCbo0U7/s4rk2KlLL8uZB6V2bq
         4IVPpUwDl/QPxdUbIUAR2I1rlw3wN89V+aFU1Km8jv6NiOcviWg5VvGY11Qw4Jf0vDCZ
         hAIA==
X-Gm-Message-State: APjAAAU3KZzPvcQZ4NgPT4jb6S0spoZLF/9dYMyzlYlLqfjzeKyDzWCs
        dh90tYwt1wqFk6Yq2tpHH7U=
X-Google-Smtp-Source: APXvYqzi1VipkVfIiCMuWUb3kwhiy44hGn3bRykz918gKVbkMtrrfz4oVJGquFgJUXOaZXK2Re9/YA==
X-Received: by 2002:a17:90a:1b48:: with SMTP id q66mr77930931pjq.83.1563872711763;
        Tue, 23 Jul 2019 02:05:11 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id d23sm33574749pjv.18.2019.07.23.02.05.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:05:11 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/amdgpu: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 17:04:50 +0800
Message-Id: <20190723090449.27589-1-hslester96@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f2e8b4238efd..df82091a29d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1097,16 +1097,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 
 static int amdgpu_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	return amdgpu_device_suspend(drm_dev, true, true);
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* GPU comes up enabled by the bios on resume */
 	if (amdgpu_device_is_px(drm_dev)) {
@@ -1120,33 +1118,29 @@ static int amdgpu_pmops_resume(struct device *dev)
 
 static int amdgpu_pmops_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_suspend(drm_dev, false, true);
 }
 
 static int amdgpu_pmops_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_resume(drm_dev, false, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_suspend(drm_dev, true, true);
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	return amdgpu_device_resume(drm_dev, false, true);
 }
 
@@ -1205,8 +1199,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 
 static int amdgpu_pmops_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
 
 	if (!amdgpu_device_is_px(drm_dev)) {
-- 
2.20.1

