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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9FEC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020C621655
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utRCn1tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfGWKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:39:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389114AbfGWKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:39:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so20474298plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+Ko2s07XpmKeoiSRAWiG1TIYHRUPENDvoZZ633m3Sw=;
        b=utRCn1tS3UkpzPd6ElI+IxOO/JZMbnJfYeCK9miA3G0mug0yafGrLhngkkfuNJnwBN
         cG82d0dUWn9PwFB8Zz+JU6Wqposfon/0ryk9NqPAwTsoOWtsO/OpZamFF/yVchxO/4PE
         7yDDMjS4L4WuZxwK77FwviTlxoEcE0jerxHSG16KbNQXTSGXgbNjFlkZa5Ssb+4KSIJ4
         pV+rl4XyZek/SVBlZIPRFCnItCnESUnT9miR3EjwCZwso+XkOUwybjb39GJns0Il2663
         ULUINrw1ZWKOru3wY95F3HeNC+KFuj5T9Dp41abaV/uJe1VV09e9v4xCwjH1Umf0v7a3
         y7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+Ko2s07XpmKeoiSRAWiG1TIYHRUPENDvoZZ633m3Sw=;
        b=Y0om/OkLM8t/uVbvqv4pQK94u7UddRWS+sEivglL39orjNWC1Aik02w6MfpUdEQyJ4
         /akrQfPSPrsbFcH98EKjkVCZUt/6WElUMR4f6sGjORc05NR8p5bUY7TsbdZ+mvzxn8Ld
         IMb4LdYHeTjBWVtcfIudornEbXo/Aq7+uDeieV67kqYRyxKtTPFuQ1uM36pAkzoYH3E/
         BsET5d+ByWXwdYAuH7Na0xIp/qQRbqL2+nN5VAtAryxMyGDpz+o0dKulR8NnkOc4BBdb
         ukRZJAWGnw8ZmBeI1RTyBQz8enEBngK3jNToEA+dPAlFEC8PeromYinuIDhMirmCrkL5
         J0ig==
X-Gm-Message-State: APjAAAWUIErHNpr9xJJ0LuFQb9IQ6TUSj3rBWo+6DJGMdtFgZvm0PEUJ
        Ef4ZCQ5PwsSxVp1w8r4PLg0=
X-Google-Smtp-Source: APXvYqwUPzOHi7ydENLevjuyXdJ3XUAFL+jiA4oEHjJZ3l1IEn48+DSYYYC/Wenru2lLCRwqCnGYmw==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr79338215pla.89.1563878353880;
        Tue, 23 Jul 2019 03:39:13 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q8sm82654778pjq.20.2019.07.23.03.39.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:39:13 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/hisilicon: Use dev_get_drvdata
Date:   Tue, 23 Jul 2019 18:38:53 +0800
Message-Id: <20190723103852.3907-1-hslester96@gmail.com>
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
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index ce89e56937b0..f0be263feff5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -60,16 +60,14 @@ static struct drm_driver hibmc_driver = {
 
 static int __maybe_unused hibmc_pm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int  __maybe_unused hibmc_pm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	return drm_mode_config_helper_resume(drm_dev);
 }
-- 
2.20.1

