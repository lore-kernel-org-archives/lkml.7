Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F7C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1298F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfFRPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:39:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54249 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfFRPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:39:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdGCj-000724-6L; Tue, 18 Jun 2019 15:39:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/chrome: wilco_ec: fix null pointer dereference on failed kzalloc
Date:   Tue, 18 Jun 2019 16:39:24 +0100
Message-Id: <20190618153924.19491-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

If the kzalloc of the entries queue q fails a null pointer dereference
occurs when accessing q->capacity and q->lock.  Add a kzalloc failure
check and handle the null return case in the calling function
event_device_add.

Addresses-Coverity: ("Dereference null return")
Fixes: 75589e37d1dc ("platform/chrome: wilco_ec: Add circular buffer as event queue")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/chrome/wilco_ec/event.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index c975b76e6255..e251a989b152 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -112,8 +112,11 @@ module_param(queue_size, int, 0644);
 static struct ec_event_queue *event_queue_new(int capacity)
 {
 	size_t entries_size = sizeof(struct ec_event *) * capacity;
-	struct ec_event_queue *q = kzalloc(sizeof(*q) + entries_size,
-					   GFP_KERNEL);
+	struct ec_event_queue *q;
+
+	q = kzalloc(sizeof(*q) + entries_size, GFP_KERNEL);
+	if (!q)
+		return NULL;
 
 	q->capacity = capacity;
 	spin_lock_init(&q->lock);
@@ -474,6 +477,11 @@ static int event_device_add(struct acpi_device *adev)
 	/* Initialize the device data. */
 	adev->driver_data = dev_data;
 	dev_data->events = event_queue_new(queue_size);
+	if (!dev_data->events) {
+		kfree(dev_data);
+		error = -ENOMEM;
+		goto free_minor;
+	}
 	init_waitqueue_head(&dev_data->wq);
 	dev_data->exist = true;
 	atomic_set(&dev_data->available, 1);
-- 
2.20.1

