Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9846FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7166C21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfD3J2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:28:30 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41561 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3J22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:28:28 -0400
X-Originating-IP: 109.213.14.175
Received: from localhost (alyon-652-1-31-175.w109-213.abo.wanadoo.fr [109.213.14.175])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 560231BF210;
        Tue, 30 Apr 2019 09:28:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/7] rtc: jz4740: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Tue, 30 Apr 2019 11:28:16 +0200
Message-Id: <20190430092821.27963-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430092821.27963-1-alexandre.belloni@bootlin.com>
References: <20190430092821.27963-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion now that the range is
enforced by the core.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-jz4740.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 079469627bd7..428376639870 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -171,7 +171,7 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
 	if (timeout == 0)
 		return -EIO;
 
-	rtc_time_to_tm(secs, time);
+	rtc_time64_to_tm(secs, time);
 
 	return 0;
 }
@@ -196,7 +196,7 @@ static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
 	alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
 
-	rtc_time_to_tm(secs, &alrm->time);
+	rtc_time64_to_tm(secs, &alrm->time);
 
 	return rtc_valid_tm(&alrm->time);
 }
@@ -205,9 +205,7 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	int ret;
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long secs;
-
-	rtc_tm_to_time(&alrm->time, &secs);
+	uint32_t secs = lower_32_bits(rtc_tm_to_time64(&alrm->time));
 
 	ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC_ALARM, secs);
 	if (!ret)
-- 
2.20.1

