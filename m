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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21820C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E503820828
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRw86/e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfGWKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:11:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37293 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGWKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:11:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so18900627pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP8X9sV2oWmdtbrAX4y948F6oht2Sk62ebuibfrRCgI=;
        b=NRw86/e8mh77kdnNK9C7YaJaJcWd5Z8fJqD0ZErTbDzo8Azj7VtOvWFmg09hNrq1eM
         +f5bgAJWSLvg1MCX4zuKstidZiQFTzH2wn40SHV1iOtq6PsaibCw3225TRdqgmTVMgjs
         L7KLcu1jTSy54KpZMRjVMB3c9ViBrGIbj6nHd1c4CF7/YyFbqkvT4lnQsgL8SyQpmJWQ
         uuH/qICG+LlFawqvKfC13qSMcYuhmt9K64hlGCs6T75WVvtDdhGFgBx4nynKFTcUc9N9
         nUPCvtuSR0Io6JXte0qmeiIQz0g3tDwzSSoeALJT8xaPgW1ekjGlILFmU9ubhjM6oOFR
         iWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP8X9sV2oWmdtbrAX4y948F6oht2Sk62ebuibfrRCgI=;
        b=kAfJ6kkrdNNbQWJxKmMCOcOlLk1p2gvSF9b9UPNBh53ggv5GUAO8VHt6dFkEHfiJY9
         0f/a0LM9ZnoK2hQROWeOe42+4M0gDEwmj1Ei21XFat2c+YB/rNbyM4JMethwr3N35qVH
         8+ufW2pY6QFKlHhvcEm13wierM8j0HAdToqdKSb7bv3boWscPvpEaVWdFUbqzKK4XD4f
         /ozt3SdmcM2qy2cpmZdft2ibxCVGSORajDzxQEK6xqtTe3KPevXo79PcpD2B3Baap9re
         e6osP6TtVBUbT5VWB08bLos7rFgNs9ilHtpy/rl1Lo90hfjt5H1TlaigTeeMZex6VNB/
         MU/A==
X-Gm-Message-State: APjAAAW0Z+W4feHcf5CDCR6chL8hK8Q/nLfHW5Gk8ZUpyijp6udxY3x/
        5H9Q+zXcJMKVkh3B494vud4=
X-Google-Smtp-Source: APXvYqx6k9JPXdFGuvau+1Ruk+7CIKvE4sTfG9rgLFZmTSES9xLwIUxjnPTfV8K+SmpMvDM49GtUZQ==
X-Received: by 2002:a63:181:: with SMTP id 123mr77678792pgb.63.1563876662443;
        Tue, 23 Jul 2019 03:11:02 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id j15sm46736491pfe.3.2019.07.23.03.10.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:11:01 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/ast: Use dev_get_drvdata where possible
Date:   Tue, 23 Jul 2019 18:10:38 +0800
Message-Id: <20190723101037.30192-1-hslester96@gmail.com>
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
 drivers/gpu/drm/ast/ast_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 3811997e78c4..cc239c0fc59b 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -155,15 +155,13 @@ static int ast_pm_suspend(struct device *dev)
 }
 static int ast_pm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct drm_device *ddev = dev_get_drvdata(dev);
 	return ast_drm_resume(ddev);
 }
 
 static int ast_pm_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	if (!ddev || !ddev->dev_private)
 		return -ENODEV;
@@ -173,15 +171,13 @@ static int ast_pm_freeze(struct device *dev)
 
 static int ast_pm_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct drm_device *ddev = dev_get_drvdata(dev);
 	return ast_drm_thaw(ddev);
 }
 
 static int ast_pm_poweroff(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	return ast_drm_freeze(ddev);
 }
-- 
2.20.1

