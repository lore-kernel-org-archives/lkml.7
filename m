Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4279C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C0F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="cvxHPDxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfEWLz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:55:27 -0400
Received: from mail2.skidata.com ([91.230.2.91]:48019 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfEWLz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1558612549; x=1590148549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O96KBXfBS7uBizMwp2s/jwpgKuAl+d+1cTWdfbrTGg4=;
  b=cvxHPDxpp3ddy3Pk3uq/dcmLidGdn+dY06lMhfWqtBp5BEmP5DkKm/Ay
   j2Hf/wk7M5QPBcueLU0C3xVZRsjDnGZMC7sMK+dhlwJauzWgue2nXPY7E
   4PxJFxWgcTG/cYBFplZ/74yKXpBmEhzVOCaRzFl/8XaKpeGykt+8PkArh
   E/DzvMogZA4B1b+bu9yh9OEyhx8/rmenexNuRhwYiUNoq29b1EvRPyl6X
   PanQDI9IhEBJ+ORh/dstax85ojNBaN6VwojYfrf9kfcrYuU2biG4jFOAt
   +Ca09c7r27zLHJBqV+QVh0X5DhVBkSvKoy0xCqRJOSCQyXCAZYzwoQgTA
   w==;
IronPort-SDR: WvICdEuj5J2cL3KxrYu9ZlE8SY3L/WWvvTLYgdI+7Y36C2QLCkKsBn7GBB9pKFH04z8CS3qMPO
 +qZS+TcI3O7DvC4HsNZPwMKq1qyO7+GGxFilJ4pH92HwXFNJZ+j4uqsYh8dgtP4vNUfw67y1gm
 Ytpb2kKxQv9ZjjkeNZFtIBnJxsWJxiFzRc4i5TQXr+yFw8BbEigIVzV3h7L6GLoWM4KQQ3UzFU
 jA8JeBypvXEys5UMAoD2TgtnKEUK9H5dsGCxM/RUbvLIOzNQDybVb4VqgwZiOXQRmcBoMiqx88
 7Rw=
X-IronPort-AV: E=Sophos;i="5.60,502,1549926000"; 
   d="scan'208";a="2154450"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 1/4] rtc: s35390a: clarify INT2 pin output modes
Date:   Thu, 23 May 2019 13:54:48 +0200
Message-ID: <20190523115451.20007-2-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523115451.20007-1-richard.leitner@skidata.com>
References: <20190523115451.20007-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the INT2 mode mask to not include the "TEST" flag. Furthermore
remove the not needed reversion of bits when parsing the INT2 modes.
Instead reverse the INT2_MODE defines to match the bit order from the
datasheet.

Additionally mention the flag names from the datasheet for the different
modes in the comments.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/rtc/rtc-s35390a.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 3c64dbb08109..fb795c454077 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -45,12 +45,13 @@
 /* flag for STATUS2 */
 #define S35390A_FLAG_TEST	0x01
 
-#define S35390A_INT2_MODE_MASK		0xF0
-
+/* INT2 pin output mode */
+#define S35390A_INT2_MODE_MASK		0x0E
 #define S35390A_INT2_MODE_NOINTR	0x00
-#define S35390A_INT2_MODE_FREQ		0x10
-#define S35390A_INT2_MODE_ALARM		0x40
-#define S35390A_INT2_MODE_PMIN_EDG	0x20
+#define S35390A_INT2_MODE_ALARM		BIT(1) /* INT2AE */
+#define S35390A_INT2_MODE_PMIN_EDG	BIT(2) /* INT2ME */
+#define S35390A_INT2_MODE_FREQ		BIT(3) /* INT2FE */
+#define S35390A_INT2_MODE_PMIN		(BIT(3) | BIT(2)) /* INT2FE | INT2ME */
 
 static const struct i2c_device_id s35390a_id[] = {
 	{ "s35390a", 0 },
@@ -303,9 +304,6 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	else
 		sts = S35390A_INT2_MODE_NOINTR;
 
-	/* This chip expects the bits of each byte to be in reverse order */
-	sts = bitrev8(sts);
-
 	/* set interupt mode*/
 	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
 	if (err < 0)
@@ -343,7 +341,7 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (err < 0)
 		return err;
 
-	if ((bitrev8(sts) & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
+	if ((sts & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
 		/*
 		 * When the alarm isn't enabled, the register to configure
 		 * the alarm time isn't accessible.
-- 
2.20.1

