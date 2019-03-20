Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7DDC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8E0213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCTMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:44:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34099 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfCTMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:44:35 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AA6ED40003;
        Wed, 20 Mar 2019 12:44:32 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: ps3: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 20 Mar 2019 13:44:25 +0100
Message-Id: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion as the PS3 handles 64bit
values.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ps3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ps3.c b/drivers/rtc/rtc-ps3.c
index 347288bff438..bffc5713e16f 100644
--- a/drivers/rtc/rtc-ps3.c
+++ b/drivers/rtc/rtc-ps3.c
@@ -40,16 +40,13 @@ static u64 read_rtc(void)
 
 static int ps3_get_time(struct device *dev, struct rtc_time *tm)
 {
-	rtc_time_to_tm(read_rtc() + ps3_os_area_get_rtc_diff(), tm);
+	rtc_time64_to_tm(read_rtc() + ps3_os_area_get_rtc_diff(), tm);
 	return 0;
 }
 
 static int ps3_set_time(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long now;
-
-	rtc_tm_to_time(tm, &now);
-	ps3_os_area_set_rtc_diff(now - read_rtc());
+	ps3_os_area_set_rtc_diff(rtc_tm_to_time64(tm) - read_rtc());
 	return 0;
 }
 
-- 
2.20.1

