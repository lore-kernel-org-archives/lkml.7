Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64896C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F022512
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJEGgQaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfGWKkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:40:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34798 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGWKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:40:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so13006787pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PK0IBZUbQHnyOZDtUqj2prrcS6SHRWpLkmBXJgDEKWo=;
        b=JJEGgQaULMIyBtsF9Zmew5QKL6iwU5DJsa+yzl56UpjBCSjzgnjbTm1D8sUg4zA1fo
         Rqvm5clXYIpVWuG3UvJ9Guhup1h3dWDqi38rpeBx/FQY9fMC+0kHJ/8HCq7soKQOzCxx
         nwgn3YjizCPCQ+Qi1XLpVkmwNITnKWINbFnzbGrSoayK4iQeWX6AjULlyQGLwmHCQtVV
         amlHgx7MOvg5GCeXx3OWz4VxnjAET5qyqL22PCCiUT9Jg/TO7ESxfPptPJhKRwX6ycIF
         GmOZ/RysLc2ZGHYfZv3DeeT+V/3DXyPwVvAGE2FKJKioGkfe9H/X7N7azeOk2u9XISBs
         q4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PK0IBZUbQHnyOZDtUqj2prrcS6SHRWpLkmBXJgDEKWo=;
        b=ZapIzNnsPz5hp+GYwcM4AYwCJ6wehrpANu3ClVIp9lDxydOC5IKHBGUmEOYIerc+QM
         d2XvEVhJWh1RdynS8Nu8uBrC06S07VAenmuwqc9OPDKNZuOTaBbgMvaTQNN7Nb0UCLgU
         mtGPb6TA6X3wvKtwVHvvkpgHfpaZ5Zu+3pulZ759pxLX/io0b2zSL6pJXqbRsNqcp6J4
         r0DcVXcvzSjqXOuWCXflka5DLNkygT9gMiS1bgGLJhDbikfi8+Bv8IU2zXiEBQ4sbqpu
         W2uGBicRWobYc+EwqBraNxKtvFjQcjVOel8MZR96LWb0V3x7cd5YFigIvoDNlWTs92Lf
         6Mtg==
X-Gm-Message-State: APjAAAWVCLR6PmX4G+dycdrQyAa4XvCT71+duzhXtxlzQTSZyLoVd6rf
        5XgRGJEOQBbKTnMCy1DDn18=
X-Google-Smtp-Source: APXvYqxNi+SizBMl+BpgOlGEa4wEMzr8MJSUWRsgRL/2x6RHFUOsxCW0h9hrMpeXnwK8haoe2AWQXQ==
X-Received: by 2002:a17:90a:1a45:: with SMTP id 5mr83413685pjl.43.1563878422662;
        Tue, 23 Jul 2019 03:40:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id c8sm47990214pjq.2.2019.07.23.03.40.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:40:22 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/qxl: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 18:40:00 +0800
Message-Id: <20190723103959.4078-1-hslester96@gmail.com>
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
 drivers/gpu/drm/qxl/qxl_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index f33e349c4ec5..af1e2b377945 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -206,16 +206,14 @@ static int qxl_pm_resume(struct device *dev)
 
 static int qxl_pm_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return qxl_drm_resume(drm_dev, true);
 }
 
 static int qxl_pm_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return qxl_drm_freeze(drm_dev);
 }
-- 
2.20.1

