Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7359C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D627984
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfFCPvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:55 -0400
Received: from foss.arm.com ([217.140.101.70]:53900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfFCPvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB521A25;
        Mon,  3 Jun 2019 08:51:52 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8F323F246;
        Mon,  3 Jun 2019 08:51:51 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [RFC PATCH 35/57] drivers: core: Reuse generic match by device type helper
Date:   Mon,  3 Jun 2019 16:50:01 +0100
Message-Id: <1559577023-558-36-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helper to match the device type of a given device.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 731baac..69cba57 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2839,13 +2839,6 @@ struct device *device_create_with_groups(struct class *class,
 }
 EXPORT_SYMBOL_GPL(device_create_with_groups);
 
-static int __match_devt(struct device *dev, const void *data)
-{
-	const dev_t *devt = data;
-
-	return dev->devt == *devt;
-}
-
 /**
  * device_destroy - removes a device that was created with device_create()
  * @class: pointer to the struct class that this device was registered with
@@ -2858,7 +2851,7 @@ void device_destroy(struct class *class, dev_t devt)
 {
 	struct device *dev;
 
-	dev = class_find_device(class, NULL, &devt, __match_devt);
+	dev = class_find_device_by_devt(class, NULL, devt);
 	if (dev) {
 		put_device(dev);
 		device_unregister(dev);
-- 
2.7.4

