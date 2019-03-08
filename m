Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10A7205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCHRnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:43:39 -0500
Received: from anholt.net ([50.246.234.109]:53286 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfCHRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:43:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9E5A110A2E2C;
        Fri,  8 Mar 2019 09:43:38 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id TdrIHQK3-WOw; Fri,  8 Mar 2019 09:43:36 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CC26A10A2E2B;
        Fri,  8 Mar 2019 09:43:36 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 41EB22FE4653; Fri,  8 Mar 2019 09:43:36 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 1/2] drm/v3d: Handle errors from IRQ setup.
Date:   Fri,  8 Mar 2019 09:43:35 -0800
Message-Id: <20190308174336.7866-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noted in review by Dave Emett for V3D 4.2 support.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.c |  8 ++++++--
 drivers/gpu/drm/v3d/v3d_drv.h |  2 +-
 drivers/gpu/drm/v3d/v3d_irq.c | 13 +++++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 3680ebd229f2..f9906cac7a88 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -311,14 +311,18 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 	if (ret)
 		goto dev_destroy;
 
-	v3d_irq_init(v3d);
+	ret = v3d_irq_init(v3d);
+	if (ret)
+		goto gem_destroy;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto gem_destroy;
+		goto irq_disable;
 
 	return 0;
 
+irq_disable:
+	v3d_irq_disable(v3d);
 gem_destroy:
 	v3d_gem_destroy(drm);
 dev_destroy:
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index d856159bd007..bb58ecb9d9c5 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -304,7 +304,7 @@ void v3d_reset(struct v3d_dev *v3d);
 void v3d_invalidate_caches(struct v3d_dev *v3d);
 
 /* v3d_irq.c */
-void v3d_irq_init(struct v3d_dev *v3d);
+int v3d_irq_init(struct v3d_dev *v3d);
 void v3d_irq_enable(struct v3d_dev *v3d);
 void v3d_irq_disable(struct v3d_dev *v3d);
 void v3d_irq_reset(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 69338da70ddc..29d746cfce57 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -156,7 +156,7 @@ v3d_hub_irq(int irq, void *arg)
 	return status;
 }
 
-void
+int
 v3d_irq_init(struct v3d_dev *v3d)
 {
 	int ret, core;
@@ -173,13 +173,22 @@ v3d_irq_init(struct v3d_dev *v3d)
 	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
 			       v3d_hub_irq, IRQF_SHARED,
 			       "v3d_hub", v3d);
+	if (ret)
+		goto fail;
+
 	ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
 			       v3d_irq, IRQF_SHARED,
 			       "v3d_core0", v3d);
 	if (ret)
-		dev_err(v3d->dev, "IRQ setup failed: %d\n", ret);
+		goto fail;
 
 	v3d_irq_enable(v3d);
+	return 0;
+
+fail:
+	if (ret != -EPROBE_DEFER)
+		dev_err(v3d->dev, "IRQ setup failed: %d\n", ret);
+	return ret;
 }
 
 void
-- 
2.20.1

