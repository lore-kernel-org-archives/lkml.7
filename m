Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2642C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9164B206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfHPJbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:54078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfHPJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:31:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F1311570;
        Fri, 16 Aug 2019 02:31:15 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F233F706;
        Fri, 16 Aug 2019 02:31:14 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Remove opp table when unloading
Date:   Fri, 16 Aug 2019 10:31:07 +0100
Message-Id: <20190816093107.30518-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq opp table needs to be removed when unloading the driver to
free the memory associated with it.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 77e1ad24de53..710d903f8e0d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -160,12 +160,18 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 		DRM_DEV_ERROR(&pfdev->pdev->dev, "Couldn't initialize GPU devfreq\n");
 		ret = PTR_ERR(pfdev->devfreq.devfreq);
 		pfdev->devfreq.devfreq = NULL;
+		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		return ret;
 	}
 
 	return 0;
 }
 
+void panfrost_devfreq_fini(struct panfrost_device *pfdev)
+{
+	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+}
+
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
 {
 	int i;
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index eb999531ed90..e3bc63e82843 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -5,6 +5,7 @@
 #define __PANFROST_DEVFREQ_H__
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev);
+void panfrost_devfreq_fini(struct panfrost_device *pfdev);
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev);
 void panfrost_devfreq_suspend(struct panfrost_device *pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index ae70200be44a..44a558c6e17e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -547,12 +547,14 @@ static int panfrost_probe(struct platform_device *pdev)
 	 */
 	err = drm_dev_register(ddev, 0);
 	if (err < 0)
-		goto err_out1;
+		goto err_out2;
 
 	panfrost_gem_shrinker_init(ddev);
 
 	return 0;
 
+err_out2:
+	panfrost_devfreq_fini(pfdev);
 err_out1:
 	panfrost_device_fini(pfdev);
 err_out0:
@@ -571,6 +573,7 @@ static int panfrost_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(pfdev->dev);
 	pm_runtime_put_sync_autosuspend(pfdev->dev);
 	pm_runtime_disable(pfdev->dev);
+	panfrost_devfreq_fini(pfdev);
 	panfrost_device_fini(pfdev);
 	drm_dev_put(ddev);
 	return 0;
-- 
2.20.1

