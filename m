Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C9204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfDQONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:13:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38593 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:13:08 -0400
Received: from [123.118.215.169] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1hGlJC-0004gI-JJ; Wed, 17 Apr 2019 14:13:07 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com, aaron.ma@canonical.com
Subject: [PATCH] nvme: determine the number of IO queues
Date:   Wed, 17 Apr 2019 22:12:59 +0800
Message-Id: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers support limited IO queues, when over set
the number, it will return invalid field error.
Then NVME will be removed by driver.

Find the max number of IO queues that controller supports.
When it still got invalid result, set 1 IO queue at least to
bring NVME online.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/nvme/host/core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c43e12b70af..fb7f05c310c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1134,14 +1134,24 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
-	u32 q_count = (*count - 1) | ((*count - 1) << 16);
+	u32 q_count;
 	u32 result;
-	int status, nr_io_queues;
-
-	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
-			&result);
-	if (status < 0)
-		return status;
+	int status = -1;
+	int nr_io_queues;
+	int try_count;
+
+	for (try_count = *count; try_count > 0; try_count--) {
+		q_count = (try_count - 1) | ((try_count - 1) << 16);
+		status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES,
+				q_count, NULL, 0, &result);
+		if (status < 0)
+			return status;
+		else if (status == 0) {
+			nr_io_queues = min(result & 0xffff, result >> 16) + 1;
+			*count = min(try_count, nr_io_queues);
+			break;
+		}
+	}
 
 	/*
 	 * Degraded controllers might return an error when setting the queue
@@ -1150,10 +1160,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 	 */
 	if (status > 0) {
 		dev_err(ctrl->device, "Could not set queue count (%d)\n", status);
-		*count = 0;
-	} else {
-		nr_io_queues = min(result & 0xffff, result >> 16) + 1;
-		*count = min(*count, nr_io_queues);
+		*count = 1;
 	}
 
 	return 0;
-- 
2.20.1

