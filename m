Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB597C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE4A21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbfDRKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:01:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37425 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbfDRKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:01:08 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8720C240015;
        Thu, 18 Apr 2019 10:01:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6/7] rtc: jz4740: rework invalid time detection
Date:   Thu, 18 Apr 2019 12:00:44 +0200
Message-Id: <20190418100045.29288-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scratchpad register is used to detect an invalid time when power to the
RTC has been lost. Instead of deleting that precious information and set
the time to the UNIX epoch, forward it to userspace.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-jz4740.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index fa15ad9fbe13..c9e16d857fa8 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -157,6 +157,9 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
 	uint32_t secs, secs2;
 	int timeout = 5;
 
+	if (jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD) != 0x12345678)
+		return -EINVAL;
+
 	/* If the seconds register is read while it is updated, it can contain a
 	 * bogus value. This can be avoided by making sure that two consecutive
 	 * reads have the same value.
@@ -180,8 +183,13 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
 static int jz4740_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, rtc_tm_to_time64(time));
+	if (ret)
+		return ret;
 
-	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, rtc_tm_to_time64(time));
+	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
 }
 
 static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -308,7 +316,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_rtc *rtc;
-	uint32_t scratchpad;
 	struct resource *mem;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	const struct of_device_id *of_id = of_match_device(
@@ -376,16 +383,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	scratchpad = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
-	if (scratchpad != 0x12345678) {
-		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
-		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, 0);
-		if (ret) {
-			dev_err(&pdev->dev, "Could not write to RTC registers\n");
-			return ret;
-		}
-	}
-
 	if (np && of_device_is_system_power_controller(np)) {
 		if (!pm_power_off) {
 			/* Default: 60ms */
-- 
2.20.1

