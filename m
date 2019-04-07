Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC765213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDGVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:06:25 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33967 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDGVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:06:24 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DF9AD240007;
        Sun,  7 Apr 2019 21:06:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/8] rtc: ds1672: use .set_time
Date:   Sun,  7 Apr 2019 23:05:39 +0200
Message-Id: <20190407210541.13409-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
References: <20190407210541.13409-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1672.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 653abef2e5cd..4997b4f3d667 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -84,11 +84,12 @@ static int ds1672_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int ds1672_set_mmss(struct device *dev, unsigned long secs)
+static int ds1672_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int xfer;
 	unsigned char buf[6];
+	unsigned long secs = rtc_tm_to_time64(tm);
 
 	buf[0] = DS1672_REG_CNT_BASE;
 	buf[1] = secs & 0x000000FF;
@@ -108,7 +109,7 @@ static int ds1672_set_mmss(struct device *dev, unsigned long secs)
 
 static const struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time = ds1672_read_time,
-	.set_mmss = ds1672_set_mmss,
+	.set_time = ds1672_set_time,
 };
 
 static int ds1672_probe(struct i2c_client *client,
-- 
2.20.1

