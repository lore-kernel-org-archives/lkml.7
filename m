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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFDEC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369922839
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2j4H0Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfGWKLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:11:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46926 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732954AbfGWKLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:11:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so151425pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbUuvVU1khp7VKFUFggKwVLkVb4q2fUGBg+CHMkUJd0=;
        b=l2j4H0CdEmZdpJCZvrzmmDahBvKCJ8fXgy9HbAdqesEQ8sZ1khYFM0LnORwhE0hYZ0
         3Ze25ytmIxhjnmXe3bQwRjJ54RsCOGLmVfy40uxaV/DUaqP0KDeJlf9RZD41izLJrZiP
         gqsxN0rhaGjKtFeWhCWAaiu7Qp4tfMieiTwmdDSW4eP7uzpVH0Fvu7FquuWyi0AqR6ek
         YHV3VCX2oqZlsxUPmlxxHdyGpoK5fnI+6t/Je1c5LbRl6cw83448Ey1iIOjizX1xb2u9
         1UIinCNFpTGduwYlPA3TYct8ABOKHz3JOc2A+IW+tqVEFULDqAXXgDGdoWRSrXKDwJDf
         QwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hbUuvVU1khp7VKFUFggKwVLkVb4q2fUGBg+CHMkUJd0=;
        b=Jugl8rsRiOddaeH7vAsWkXSFIj0EIETKH3BjMNoyjy7tgsNDq4V8wY7f7c0H1CiBkC
         og6MQL5xkt4caqiWfb+73v9RsMkED0ksDVPHHfVE+Sa8IY0so58hJSi26NxgVTCKNCx7
         RF0i5mC3cuEAF38Ed1qt1H65ZnQLAibbhp/oyg99Jke7EhaPm3Ney2cC86SSWU4YRvDn
         acwbj47tF7Wsqhwf4bfhiSG4cX3lg61jDkShDeIDwOJDHG846shE8oGtFJMNZ1xEIuIw
         ZIo0GCjKieG3rA0Oxi4uQiQwScx/6eOIc6EV7KDyIxrtx0d7CIPRFJjW9ILqxMWmOld7
         m0fA==
X-Gm-Message-State: APjAAAVMo3C0RkN0i562FqTgfTAMoEgsOWbrXKOoSvbZtZT/SH617+VO
        yumlVhakSm+RQOQkGthrt5E=
X-Google-Smtp-Source: APXvYqwy0r8ZusvFqfsldnwyEu98w+HFWmNsxG7OqhmiSQqukGtgNtu0HJn5kk33sRugAZkhG5uf6w==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr76616987pgk.363.1563876681873;
        Tue, 23 Jul 2019 03:11:21 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s12sm43414905pgr.79.2019.07.23.03.11.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:11:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/bochs: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 18:11:04 +0800
Message-Id: <20190723101103.30250-1-hslester96@gmail.com>
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
 drivers/gpu/drm/bochs/bochs_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 8f3a5bda9d03..d8a50200408c 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -83,16 +83,14 @@ static struct drm_driver bochs_driver = {
 #ifdef CONFIG_PM_SLEEP
 static int bochs_pm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int bochs_pm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_resume(drm_dev);
 }
-- 
2.20.1

