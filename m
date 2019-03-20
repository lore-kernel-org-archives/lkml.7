Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FF2213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfCTMlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:41:04 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35705 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfCTMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:41:03 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 09F9F20000A;
        Wed, 20 Mar 2019 12:41:00 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/6] rtc: at91sam9: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 20 Mar 2019 13:40:40 +0100
Message-Id: <20190320124042.14141-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
References: <20190320124042.14141-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion as the range is enforced
by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-at91sam9.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 5ab13fe56164..62695596b00c 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -122,7 +122,7 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 	if (secs != secs2)
 		secs = rtt_readl(rtc, VR);
 
-	rtc_time_to_tm(offset + secs, tm);
+	rtc_time64_to_tm(offset + secs, tm);
 
 	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
@@ -135,15 +135,12 @@ static int at91_rtc_readtime(struct device *dev, struct rtc_time *tm)
 static int at91_rtc_settime(struct device *dev, struct rtc_time *tm)
 {
 	struct sam9_rtc *rtc = dev_get_drvdata(dev);
-	int err;
 	u32 offset, alarm, mr;
 	unsigned long secs;
 
 	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
-	err = rtc_tm_to_time(tm, &secs);
-	if (err != 0)
-		return err;
+	secs = rtc_tm_to_time64(tm);
 
 	mr = rtt_readl(rtc, MR);
 
@@ -193,7 +190,7 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	memset(alrm, 0, sizeof(*alrm));
 	if (alarm != ALARM_DISABLED && offset != 0) {
-		rtc_time_to_tm(offset + alarm, tm);
+		rtc_time64_to_tm(offset + alarm, tm);
 
 		dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
@@ -211,11 +208,8 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned long secs;
 	u32 offset;
 	u32 mr;
-	int err;
 
-	err = rtc_tm_to_time(tm, &secs);
-	if (err != 0)
-		return err;
+	secs = rtc_tm_to_time64(tm);
 
 	offset = gpbr_readl(rtc);
 	if (offset == 0) {
-- 
2.20.1

