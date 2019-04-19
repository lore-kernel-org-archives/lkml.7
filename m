Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72FEC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AB420645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfDSS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:56:04 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60460 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfDSS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:56:03 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2CC7C3A8E7F;
        Fri, 19 Apr 2019 08:25:09 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 77C80FF810;
        Fri, 19 Apr 2019 08:25:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/6] rtc: ds2404: use .set_time
Date:   Fri, 19 Apr 2019 10:24:58 +0200
Message-Id: <20190419082501.17549-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
References: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds2404.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 17606e0fd28a..3b12ec9e4c9d 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -210,16 +210,16 @@ static int ds2404_read_time(struct device *dev, struct rtc_time *dt)
 	return 0;
 }
 
-static int ds2404_set_mmss(struct device *dev, unsigned long secs)
+static int ds2404_set_time(struct device *dev, struct rtc_time *dt)
 {
-	u32 time = cpu_to_le32(secs);
+	u32 time = cpu_to_le32(rtc_tm_to_time64(dt));
 	ds2404_write_memory(dev, 0x203, 4, (u8 *)&time);
 	return 0;
 }
 
 static const struct rtc_class_ops ds2404_rtc_ops = {
 	.read_time	= ds2404_read_time,
-	.set_mmss	= ds2404_set_mmss,
+	.set_time	= ds2404_set_time,
 };
 
 static int rtc_probe(struct platform_device *pdev)
-- 
2.20.1

