Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8690C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F63218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfCVHXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:23:04 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52047 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCVHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:23:03 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EAA0E40008;
        Fri, 22 Mar 2019 07:23:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: sun4v: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Fri, 22 Mar 2019 08:22:54 +0100
Message-Id: <20190322072256.17108-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion as the hypervisor handles
64bit values.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-sun4v.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-sun4v.c b/drivers/rtc/rtc-sun4v.c
index 11bc562eba5d..378081fffa91 100644
--- a/drivers/rtc/rtc-sun4v.c
+++ b/drivers/rtc/rtc-sun4v.c
@@ -39,7 +39,7 @@ static unsigned long hypervisor_get_time(void)
 
 static int sun4v_read_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(hypervisor_get_time(), tm);
+	rtc_time64_to_tm(hypervisor_get_time(), tm);
 	return 0;
 }
 
@@ -66,14 +66,7 @@ static int hypervisor_set_time(unsigned long secs)
 
 static int sun4v_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long secs;
-	int err;
-
-	err = rtc_tm_to_time(tm, &secs);
-	if (err)
-		return err;
-
-	return hypervisor_set_time(secs);
+	return hypervisor_set_time(rtc_tm_to_time64(tm));
 }
 
 static const struct rtc_class_ops sun4v_rtc_ops = {
-- 
2.20.1

