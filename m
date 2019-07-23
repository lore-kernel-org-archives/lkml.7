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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47012C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194BA21901
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9grusXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbfGWLKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:10:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37041 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389218AbfGWLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:10:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so18977847pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdC2f6TJF86FgwDX6KIDWxr/KpmV360i5Yrw3iyE1iw=;
        b=q9grusXg7FRhKMtX21/0dcOkdQVBD1QHBhVPY5S/qj/KaUYNuBibLBKhoW+IIIiL1U
         OSMGVNtBBUIc9Er+gmv9bpB3jOhTSOgpJLdOuVEto1b3OqnjBOXbmrkpsLgPTn3K7Bq6
         94ct5pEJZ3o5xlHoXkv2dj838nPe1HBXkI73wObalKvZg8IBkatpdC2blOk8M0Guldw5
         cXUrBQBgcq3BjSv46S3m6FFcWcUCzH7ClDC9YaVTYw7i/YlzIaRCp+HWZC2GYEc85pX4
         Y5XgjMpDuNKPUX/eGnWcf3sDiUCC1AF7CXfD4oMmUeapfvrDrvUEF5r1pValTcdBfn47
         NnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdC2f6TJF86FgwDX6KIDWxr/KpmV360i5Yrw3iyE1iw=;
        b=E9aRIaPDLTI9+ZDewHSZhsH+mj6Rmvq3MUnGmTMwUWnHlsqXJ3jckO74qqQkFw579t
         f/zTK3ZRHijXl/OmRaebIgfMZvVNC9cIcw4V1eBF2C5OVm8COcdzTee9m6czIPKstNhA
         yvs0GvjdFbP4Nb9nJyFubImi6QB/Fx3Uw2pzocLFyQBXCrjAUfJDBfIaPcxNwPAPUyQ9
         cpsGAh6vUBf9lA1F//oKe7mgRhXUA4tcfq57fB2JmPd43VrFM55yxEhxdK848l1w00Lw
         IwgppCUPfNsacIipWDSPNWr37OwuPwCy48siRdQholzWEF5ny4D1pwyB+WML0/YX16G4
         r4/Q==
X-Gm-Message-State: APjAAAXIU87tO5n0Vli5mSxVgk4WVhaejdJGn3AeqVERdtJe0wQCcee/
        K343DN6CRaiAxOCkargqkiLfRek0C1Y=
X-Google-Smtp-Source: APXvYqzFg8sL7ip6zspQWhRnUUbOYrrvGUS2Kinjim/SlCx29Bxi6970md1j/cfuqehMPa3Bnay/8A==
X-Received: by 2002:a17:90a:8591:: with SMTP id m17mr83143286pjn.100.1563880237482;
        Tue, 23 Jul 2019 04:10:37 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id g4sm54517887pfo.93.2019.07.23.04.10.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 04:10:36 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/vmwgfx: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 19:10:31 +0800
Message-Id: <20190723111031.11012-1-hslester96@gmail.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 9506190a0300..8f5f5980c9d8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1448,8 +1448,7 @@ static int vmw_pm_resume(struct device *kdev)
 
 static int vmw_pm_freeze(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 	struct vmw_private *dev_priv = vmw_priv(dev);
 	int ret;
 
@@ -1497,8 +1496,7 @@ static int vmw_pm_freeze(struct device *kdev)
 
 static int vmw_pm_restore(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 	struct vmw_private *dev_priv = vmw_priv(dev);
 	int ret;
 
-- 
2.20.1

