Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF190C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB57206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLNWLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:11:08 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41871 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfLNWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:10:31 -0500
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 420E3100008;
        Sat, 14 Dec 2019 22:10:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 10/16] rtc: rv3029: add RTC_VL_READ and RTC_VL_CLEAR support
Date:   Sat, 14 Dec 2019 23:10:16 +0100
Message-Id: <20191214221022.622482-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
References: <20191214221022.622482-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RV3029 can report three different conditions: power on, voltage dropped
and data is lost and voltage is low and temperature compensation has
stopped. The first two conditions amount to the same status, the RTC data
is invalid.

VLOW1 has to be cleared manually to resume temperature compensation, this
is achieved using RTC_VL_CLEAR.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3029c2.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index f327a7713e04..6ae96baa111a 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -459,6 +459,35 @@ static int rv3029_set_time(struct device *dev, struct rtc_time *tm)
 				  RV3029_STATUS_PON, 0);
 }
 
+static int rv3029_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rv3029_data *rv3029 = dev_get_drvdata(dev);
+	unsigned long vl = 0;
+	int sr, ret = 0;
+
+	switch (cmd) {
+	case RTC_VL_READ:
+		ret = regmap_read(rv3029->regmap, RV3029_STATUS, &sr);
+		if (ret < 0)
+			return ret;
+
+		if (sr & RV3029_STATUS_VLOW1)
+			vl = RTC_VL_ACCURACY_LOW;
+
+		if (sr & (RV3029_STATUS_VLOW2 | RV3029_STATUS_PON))
+			vl |= RTC_VL_DATA_INVALID;
+
+		return put_user(vl, (unsigned int __user *)arg);
+
+	case RTC_VL_CLR:
+		return regmap_update_bits(rv3029->regmap, RV3029_STATUS,
+					  RV3029_STATUS_VLOW1, 0);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
 static const struct rv3029_trickle_tab_elem {
 	u32 r;		/* resistance in ohms */
 	u8 conf;	/* trickle config bits */
@@ -672,6 +701,7 @@ static void rv3029_hwmon_register(struct device *dev, const char *name)
 static struct rtc_class_ops rv3029_rtc_ops = {
 	.read_time	= rv3029_read_time,
 	.set_time	= rv3029_set_time,
+	.ioctl		= rv3029_ioctl,
 };
 
 static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.23.0

