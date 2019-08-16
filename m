Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848C206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHPJbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:31:14 -0400
Received: from foss.arm.com ([217.140.110.172]:54056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfHPJbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE1028;
        Fri, 16 Aug 2019 02:31:13 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0183F706;
        Fri, 16 Aug 2019 02:31:12 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] drm/panfrost: Enable devfreq to work without regulator
Date:   Fri, 16 Aug 2019 10:31:05 +0100
Message-Id: <20190816093107.30518-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no regulator defined for the GPU then still control the
frequency using the supplied clock.

Some boards have clock control but no (direct) control of the regulator.
For example the HiKey960 uses a mailbox protocol to a MCU to control
frequencies and doesn't directly control the voltage. This patch allows
frequency control of the GPU on this system.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index a7c18bceb7fd..77e1ad24de53 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -39,7 +39,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	 * If frequency scaling from low to high, adjust voltage first.
 	 * If frequency scaling from high to low, adjust frequency first.
 	 */
-	if (old_clk_rate < target_rate) {
+	if (old_clk_rate < target_rate && pfdev->regulator) {
 		err = regulator_set_voltage(pfdev->regulator, target_volt,
 					    target_volt);
 		if (err) {
@@ -58,7 +58,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 		return err;
 	}
 
-	if (old_clk_rate > target_rate) {
+	if (old_clk_rate > target_rate && pfdev->regulator) {
 		err = regulator_set_voltage(pfdev->regulator, target_volt,
 					    target_volt);
 		if (err)
@@ -136,9 +136,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	int ret;
 	struct dev_pm_opp *opp;
 
-	if (!pfdev->regulator)
-		return 0;
-
 	ret = dev_pm_opp_of_add_table(&pfdev->pdev->dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
 		return 0;
-- 
2.20.1

