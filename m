Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE6CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfDPIeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:34:50 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43071 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:34:50 -0400
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C0E6D240008;
        Tue, 16 Apr 2019 08:34:45 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] rtc: imxdi: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Tue, 16 Apr 2019 10:34:29 +0200
Message-Id: <20190416083432.14483-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416083432.14483-1-alexandre.belloni@bootlin.com>
References: <20190416083432.14483-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-imxdi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 43d9cad69241..8a7ad1502e4f 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -552,7 +552,7 @@ static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned long now;
 
 	now = readl(imxdi->ioaddr + DTCMR);
-	rtc_time_to_tm(now, tm);
+	rtc_time64_to_tm(now, tm);
 
 	return 0;
 }
@@ -618,7 +618,7 @@ static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	u32 dcamr;
 
 	dcamr = readl(imxdi->ioaddr + DCAMR);
-	rtc_time_to_tm(dcamr, &alarm->time);
+	rtc_time64_to_tm(dcamr, &alarm->time);
 
 	/* alarm is enabled if the interrupt is enabled */
 	alarm->enabled = (readl(imxdi->ioaddr + DIER) & DIER_CAIE) != 0;
@@ -644,9 +644,7 @@ static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	unsigned long alarm_time;
 	int rc;
 
-	rc = rtc_tm_to_time(&alarm->time, &alarm_time);
-	if (rc)
-		return rc;
+	alarm_time = rtc_tm_to_time64(&alarm->time);
 
 	/* don't allow setting alarm in the past */
 	now = readl(imxdi->ioaddr + DTCMR);
-- 
2.20.1

