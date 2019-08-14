Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C97C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F3C2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfHNPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:10:15 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44135 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfHNPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:10:14 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 66400FF806;
        Wed, 14 Aug 2019 15:10:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 6/9] rtc: pcf2123: don't use weekday alarm
Date:   Wed, 14 Aug 2019 17:09:59 +0200
Message-Id: <20190814151002.7324-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
References: <20190814151002.7324-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The week day may not be set properly by userspace. This would result is
missed alarms. Disable alarm matching on weekday.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index ba37060f299e..175aa8779623 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -82,7 +82,7 @@
 #define OSC_HAS_STOPPED		BIT(7)	/* Clock has been stopped */
 
 /* PCF2123_REG_ALRM_XX BITS */
-#define ALRM_ENABLE		BIT(7)	/* MN, HR, DM, or DW alarm enable */
+#define ALRM_DISABLE		BIT(7)	/* MN, HR, DM, or DW alarm matching */
 
 /* PCF2123_REG_TMR_CLKOUT BITS */
 #define CD_TMR_4096KHZ		(0)	/* 4096 KHz countdown timer */
@@ -286,7 +286,7 @@ static int pcf2123_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	txbuf[0] = bin2bcd(alm->time.tm_min & 0x7F);
 	txbuf[1] = bin2bcd(alm->time.tm_hour & 0x3F);
 	txbuf[2] = bin2bcd(alm->time.tm_mday & 0x3F);
-	txbuf[3] = bin2bcd(alm->time.tm_wday & 0x07);
+	txbuf[3] = ALRM_DISABLE;
 
 	ret = regmap_bulk_write(pcf2123->map, PCF2123_REG_ALRM_MN, txbuf,
 				sizeof(txbuf));
-- 
2.21.0

