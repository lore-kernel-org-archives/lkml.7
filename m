Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ECFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC226218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCUKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:16:12 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37697 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:16:11 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 68AEB1BF206;
        Thu, 21 Mar 2019 10:16:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: da9063: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Thu, 21 Mar 2019 11:15:57 +0100
Message-Id: <20190321101557.26857-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion now that the range is
enforced by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-da9063.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index b7052156e851..1b792bcea3c7 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -239,8 +239,8 @@ static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	da9063_data_to_tm(data, tm, rtc);
 
-	rtc_tm_to_time(tm, &tm_secs);
-	rtc_tm_to_time(&rtc->alarm_time, &al_secs);
+	tm_secs = rtc_tm_to_time64(tm);
+	al_secs = rtc_tm_to_time64(&rtc->alarm_time);
 
 	/* handle the rtc synchronisation delay */
 	if (rtc->rtc_sync == true && al_secs - tm_secs == 1)
-- 
2.20.1

