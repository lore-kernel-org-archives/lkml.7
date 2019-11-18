Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5319C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A689121934
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKRRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:30:16 -0500
Received: from foss.arm.com ([217.140.110.172]:37536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfKRRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:30:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56321FB;
        Mon, 18 Nov 2019 09:30:14 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A35263F703;
        Mon, 18 Nov 2019 09:30:13 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: devfreq: Round frequencies to OPPs
Date:   Mon, 18 Nov 2019 17:30:02 +0000
Message-Id: <20191118173002.32015-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when setting a frequency in panfrost_devfreq_target the
returned frequency is the actual frequency that the clock driver reports
(the return of clk_get_rate()). However, where the provided OPPs don't
precisely match the frequencies that the clock actually achieves devfreq
will then complain (repeatedly):

  devfreq devfreq0: Couldn't update frequency transition information.

To avoid this change panfrost_devfreq_target() to fetch the opp using
devfreq_recommened_opp() and not actually query the clock for the
frequency.

A similar problem exists with panfrost_devfreq_get_cur_freq(), but in
this case because the function is optional we can just remove it and
devfreq will fall back to using the previously set frequency.

Fixes: 221bc77914cb ("drm/panfrost: Use generic code for devfreq")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 4c4e8a30a1ac..536ba93b0f46 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -18,15 +18,18 @@ static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev);
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
 {
-	struct panfrost_device *pfdev = dev_get_drvdata(dev);
+	struct dev_pm_opp *opp;
 	int err;
 
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	dev_pm_opp_put(opp);
+
 	err = dev_pm_opp_set_rate(dev, *freq);
 	if (err)
 		return err;
 
-	*freq = clk_get_rate(pfdev->clock);
-
 	return 0;
 }
 
@@ -60,20 +63,10 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 	return 0;
 }
 
-static int panfrost_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
-{
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
-
-	*freq = clk_get_rate(pfdev->clock);
-
-	return 0;
-}
-
 static struct devfreq_dev_profile panfrost_devfreq_profile = {
 	.polling_ms = 50, /* ~3 frames */
 	.target = panfrost_devfreq_target,
 	.get_dev_status = panfrost_devfreq_get_dev_status,
-	.get_cur_freq = panfrost_devfreq_get_cur_freq,
 };
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev)
-- 
2.20.1

