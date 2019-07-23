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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B13C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7631D21655
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiHRqsP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfGWKjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:39:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37582 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfGWKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:39:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so18938269pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQdJg2/4lKgWcnf+TrMSalC//3yipNmoM7+B+S1bhVE=;
        b=GiHRqsP0MqsxXU0/DDu//IyiPLurIp7h8Qsc4piNtaGXN3jiK5EJBCA6lPrMoXCIYN
         zMOpq3/jdKVtnynmnqLVM/cLbx93BVIiWlRUUEqldUdORuuFbNLY5XLzMxZKmNoFz65+
         xwMqfWNpQ3+nxoJgz6yGiECPpGzTn4cras7w+UP1SBQLwJ41vEV4RBrxFBMGUxymiVVZ
         eFkw0vGPP3SKRg8h6Hpqog2kbfqgPj9fkVQt7lhglEsr6PpB6w/OMdPvv1YfVtdNcft9
         sJIg2PQqXKRt7ydQlBYg9qaeVrblO/60VYLz35Yl+bqXBDJ1dPBFs5DkU0eGTiGAfPnW
         xnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FQdJg2/4lKgWcnf+TrMSalC//3yipNmoM7+B+S1bhVE=;
        b=h+TiHgz3oFWi4EKY+QSPLeoYr4IZj/NqaOTr9XuNaLe3Uq77DAnc2X5tHktcQDXQbv
         zueWJ/Bt2Lm5Y+AjYDC87DfTrO+fhukaR7/u4o+nWAZ6a28luMAlfTzQ55uRqjlVuP6J
         Q16H8qA5LSzjcKYexv16PHhUHUJ29M6Fpsjobx0r1b8wGE0OEUgq865zIGJV7kZYl+6h
         e4Z7g7RQJF+N2VkZsDIqO/L18mErhA4wqWx8EFngHguf+VZzZBwwkNv7B947D7rzyFz3
         MeifGZOA+jTbaRTCyUdtmgkYt7u3jowFD6cd4X9WPIepo1+nNu5dqWxV1zdqe9yfYxTn
         7jhA==
X-Gm-Message-State: APjAAAWOmBGCw026Q8i0JwXFWXmDj/WX28/td4KOsfJ7AbTakrgmSkCa
        JhsUmKuCw68EbiFkhvPudLA=
X-Google-Smtp-Source: APXvYqxQ/ir9kTkIUyO/t324fyo6Rd7HEo6Ovpm8eULgEKQjKMdvhheMwSxnT5oTtU0Ms/rNJI+MCA==
X-Received: by 2002:a65:4786:: with SMTP id e6mr74113367pgs.448.1563878376347;
        Tue, 23 Jul 2019 03:39:36 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id g11sm39871799pgu.11.2019.07.23.03.39.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:39:35 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/i915: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 18:39:16 +0800
Message-Id: <20190723103915.3964-1-hslester96@gmail.com>
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
 drivers/gpu/drm/i915/i915_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index f62e3397d936..2a677c89641d 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -2384,8 +2384,7 @@ static int i915_resume_switcheroo(struct drm_device *dev)
 
 static int i915_pm_prepare(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 
 	if (!dev) {
 		dev_err(kdev, "DRM not initialized, aborting suspend.\n");
@@ -2400,8 +2399,7 @@ static int i915_pm_prepare(struct device *kdev)
 
 static int i915_pm_suspend(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 
 	if (!dev) {
 		dev_err(kdev, "DRM not initialized, aborting suspend.\n");
@@ -2895,8 +2893,7 @@ static int vlv_resume_prepare(struct drm_i915_private *dev_priv,
 
 static int intel_runtime_suspend(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
 	int ret;
@@ -2994,8 +2991,7 @@ static int intel_runtime_suspend(struct device *kdev)
 
 static int intel_runtime_resume(struct device *kdev)
 {
-	struct pci_dev *pdev = to_pci_dev(kdev);
-	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct drm_device *dev = dev_get_drvdata(kdev);
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
 	int ret = 0;
-- 
2.20.1

