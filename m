Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09BAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E0527681
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfFCPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:51:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbfFCPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352DC1A25;
        Mon,  3 Jun 2019 08:51:45 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6C423F246;
        Mon,  3 Jun 2019 08:51:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org
Subject: [RFC PATCH 30/57] drivers: leds: Use class_find_device_by_name() helper
Date:   Mon,  3 Jun 2019 16:49:56 +0100
Message-Id: <1559577023-558-31-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new class_find_device_by_name() helper.

Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/leds/led-class.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 85848c5..ee052aa 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -216,13 +216,6 @@ static int led_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
 
-static int match_name(struct device *dev, const void *data)
-{
-	if (!dev_name(dev))
-		return 0;
-	return !strcmp(dev_name(dev), (char *)data);
-}
-
 static int led_classdev_next_name(const char *init_name, char *name,
 				  size_t len)
 {
@@ -233,7 +226,7 @@ static int led_classdev_next_name(const char *init_name, char *name,
 	strlcpy(name, init_name, len);
 
 	while ((ret < len) &&
-	       (dev = class_find_device(leds_class, NULL, name, match_name))) {
+	       (dev = class_find_device_by_name(leds_class, NULL, name))) {
 		put_device(dev);
 		ret = snprintf(name, len, "%s_%u", init_name, ++i);
 	}
-- 
2.7.4

