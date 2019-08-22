Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E380C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E2233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfHVJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:32:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfHVJcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:32:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 468881596;
        Thu, 22 Aug 2019 02:32:41 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27C703F246;
        Thu, 22 Aug 2019 02:32:40 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Steven Price <steven.price@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/panfrost: Add missing check for pfdev->regulator
Date:   Thu, 22 Aug 2019 10:32:18 +0100
Message-Id: <20190822093218.26014-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822091512.GA32661@mwanda>
References: <20190822091512.GA32661@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When modifying panfrost_devfreq_target() to support a device without a
regulator defined I missed the check on the error path. Let's add it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: e21dd290881b ("drm/panfrost: Enable devfreq to work without regulator")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 710d903f8e0d..a1f5fa6a742a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -53,8 +53,10 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 	if (err) {
 		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
 			err);
-		regulator_set_voltage(pfdev->regulator, pfdev->devfreq.cur_volt,
-				      pfdev->devfreq.cur_volt);
+		if (pfdev->regulator)
+			regulator_set_voltage(pfdev->regulator,
+					      pfdev->devfreq.cur_volt,
+					      pfdev->devfreq.cur_volt);
 		return err;
 	}
 
-- 
2.20.1

