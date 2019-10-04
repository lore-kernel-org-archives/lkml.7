Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9841207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfJDOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:44:21 -0400
Received: from foss.arm.com ([217.140.110.172]:47154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388724AbfJDOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C1E1597;
        Fri,  4 Oct 2019 07:44:20 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B823F68E;
        Fri,  4 Oct 2019 07:44:19 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Remove NULL check for regulator
Date:   Fri,  4 Oct 2019 15:44:13 +0100
Message-Id: <20191004144413.42586-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_get() is used to populate pfdev->regulator which ensures
that this cannot be NULL (a dummy regulator will be returned if
necessary). So remove the check in panfrost_devfreq_target().

Signed-off-by: Steven Price <steven.price@arm.com>
---
This looks like it was accidentally reintroduced by the merge from
drm-next into drm-misc-next due to the duplication of "drm/panfrost: Add
missing check for pfdev-regulator" (commits c90f30812a79 and
52282163dfa6).
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index c1eb8cfe6aeb..12ff77dacc95 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -53,10 +53,8 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	if (err) {
 		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
 			err);
-		if (pfdev->regulator)
-			regulator_set_voltage(pfdev->regulator,
-					      pfdev->devfreq.cur_volt,
-					      pfdev->devfreq.cur_volt);
+		regulator_set_voltage(pfdev->regulator, pfdev->devfreq.cur_volt,
+				      pfdev->devfreq.cur_volt);
 		return err;
 	}
 
-- 
2.20.1

