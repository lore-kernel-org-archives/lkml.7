Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A79020708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKVKX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:23:56 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:48275 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:23:56 -0500
X-Originating-IP: 92.184.97.94
Received: from localhost (unknown [92.184.97.94])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 63B1AFF811;
        Fri, 22 Nov 2019 10:23:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH 4/8] rtc: ds1685: fix build error with make W=1
Date:   Fri, 22 Nov 2019 11:22:08 +0100
Message-Id: <20191122102212.400158-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
References: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following parsing errors when building with W=1:
drivers/rtc/rtc-ds1685.c:1053: error: Cannot parse struct or union!
drivers/rtc/rtc-ds1685.c:1062: error: Cannot parse struct or union!
drivers/rtc/rtc-ds1685.c:1363: warning: cannot understand function prototype: 'struct platform_driver ds1685_rtc_driver = '

Cc: Joshua Kinard <kumba@gentoo.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 8419595e7da7..56c670af2e50 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1039,7 +1039,7 @@ ds1685_rtc_sysfs_serial_show(struct device *dev,
 }
 static DEVICE_ATTR(serial, S_IRUGO, ds1685_rtc_sysfs_serial_show, NULL);
 
-/**
+/*
  * struct ds1685_rtc_sysfs_misc_attrs - list for misc RTC features.
  */
 static struct attribute*
@@ -1050,7 +1050,7 @@ ds1685_rtc_sysfs_misc_attrs[] = {
 	NULL,
 };
 
-/**
+/*
  * struct ds1685_rtc_sysfs_misc_grp - attr group for misc RTC features.
  */
 static const struct attribute_group
@@ -1355,7 +1355,7 @@ ds1685_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/**
+/*
  * ds1685_rtc_driver - rtc driver properties.
  */
 static struct platform_driver ds1685_rtc_driver = {
-- 
2.23.0

