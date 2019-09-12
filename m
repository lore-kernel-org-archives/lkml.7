Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97454C4CECB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DED82067D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfILL2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:28:14 -0400
Received: from foss.arm.com ([217.140.110.172]:32786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbfILL2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:28:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D31F1597;
        Thu, 12 Sep 2019 04:28:13 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140643F67D;
        Thu, 12 Sep 2019 04:28:11 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/panfrost: Use generic code for devfreq
Date:   Thu, 12 Sep 2019 12:28:03 +0100
Message-Id: <20190912112804.10104-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912112804.10104-1-steven.price@arm.com>
References: <20190912112804.10104-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_pm_opp_set_rate() instead of open coding the devfreq
integration, simplifying the code.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 62 ++++-----------------
 drivers/gpu/drm/panfrost/panfrost_device.h  |  2 -
 2 files changed, 10 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index a1f5fa6a742a..7ded282a5ca8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -18,57 +18,14 @@ static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev, i
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
 {
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
-	struct dev_pm_opp *opp;
-	unsigned long old_clk_rate = pfdev->devfreq.cur_freq;
-	unsigned long target_volt, target_rate;
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	int err;
 
-	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
-
-	target_rate = dev_pm_opp_get_freq(opp);
-	target_volt = dev_pm_opp_get_voltage(opp);
-	dev_pm_opp_put(opp);
-
-	if (old_clk_rate == target_rate)
-		return 0;
-
-	/*
-	 * If frequency scaling from low to high, adjust voltage first.
-	 * If frequency scaling from high to low, adjust frequency first.
-	 */
-	if (old_clk_rate < target_rate && pfdev->regulator) {
-		err = regulator_set_voltage(pfdev->regulator, target_volt,
-					    target_volt);
-		if (err) {
-			dev_err(dev, "Cannot set voltage %lu uV\n",
-				target_volt);
-			return err;
-		}
-	}
-
-	err = clk_set_rate(pfdev->clock, target_rate);
-	if (err) {
-		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
-			err);
-		if (pfdev->regulator)
-			regulator_set_voltage(pfdev->regulator,
-					      pfdev->devfreq.cur_volt,
-					      pfdev->devfreq.cur_volt);
+	err = dev_pm_opp_set_rate(dev, *freq);
+	if (err)
 		return err;
-	}
 
-	if (old_clk_rate > target_rate && pfdev->regulator) {
-		err = regulator_set_voltage(pfdev->regulator, target_volt,
-					    target_volt);
-		if (err)
-			dev_err(dev, "Cannot set voltage %lu uV\n", target_volt);
-	}
-
-	pfdev->devfreq.cur_freq = target_rate;
-	pfdev->devfreq.cur_volt = target_volt;
+	*freq = clk_get_rate(pfdev->clock);
 
 	return 0;
 }
@@ -88,7 +45,7 @@ static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
 static int panfrost_devfreq_get_dev_status(struct device *dev,
 					   struct devfreq_dev_status *status)
 {
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
@@ -121,7 +78,7 @@ static int panfrost_devfreq_get_cur_freq(struct device *dev, unsigned long *freq
 {
 	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
 
-	*freq = pfdev->devfreq.cur_freq;
+	*freq = clk_get_rate(pfdev->clock);
 
 	return 0;
 }
@@ -137,6 +94,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 {
 	int ret;
 	struct dev_pm_opp *opp;
+	unsigned long cur_freq;
 
 	ret = dev_pm_opp_of_add_table(&pfdev->pdev->dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
@@ -146,13 +104,13 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 
 	panfrost_devfreq_reset(pfdev);
 
-	pfdev->devfreq.cur_freq = clk_get_rate(pfdev->clock);
+	cur_freq = clk_get_rate(pfdev->clock);
 
-	opp = devfreq_recommended_opp(&pfdev->pdev->dev, &pfdev->devfreq.cur_freq, 0);
+	opp = devfreq_recommended_opp(&pfdev->pdev->dev, &cur_freq, 0);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 
-	panfrost_devfreq_profile.initial_freq = pfdev->devfreq.cur_freq;
+	panfrost_devfreq_profile.initial_freq = cur_freq;
 	dev_pm_opp_put(opp);
 
 	pfdev->devfreq.devfreq = devm_devfreq_add_device(&pfdev->pdev->dev,
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index f503c566e99f..4c2b3c84baac 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -95,8 +95,6 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
-		unsigned long cur_freq;
-		unsigned long cur_volt;
 		struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
 	} devfreq;
 };
-- 
2.20.1

