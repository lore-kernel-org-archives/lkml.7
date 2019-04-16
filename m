Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5974C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42BF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfDPIa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:30:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43023 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfDPIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:30:54 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 5421CFF821;
        Tue, 16 Apr 2019 08:30:51 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: mxc: set range
Date:   Tue, 16 Apr 2019 10:30:44 +0200
Message-Id: <20190416083045.13924-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416083045.13924-1-alexandre.belloni@bootlin.com>
References: <20190416083045.13924-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the core handle the range, and in particular the imx1 offsetting. This
has the benefit of extending the range of the RTC further than 365 days and
making .read_time useful again on imx1.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mxc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index d9a038afedf0..31d3f375bc0f 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -256,19 +256,6 @@ static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
  */
 static int mxc_rtc_set_mmss(struct device *dev, time64_t time)
 {
-	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
-
-	/*
-	 * TTC_DAYR register is 9-bit in MX1 SoC, save time and day of year only
-	 */
-	if (is_imx1_rtc(pdata)) {
-		struct rtc_time tm;
-
-		rtc_time64_to_tm(time, &tm);
-		tm.tm_year = 70;
-		time = rtc_tm_to_time64(&tm);
-	}
-
 	/* Avoid roll-over from reading the different registers */
 	do {
 		set_alarm_or_time(dev, MXC_RTC_TIME, time);
@@ -346,6 +333,23 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc = rtc;
 	rtc->ops = &mxc_rtc_ops;
+	if (is_imx1_rtc(pdata)) {
+		struct rtc_time tm;
+
+		/* 9bit days + hours minutes seconds */
+		rtc->range_max = (1 << 9) * 86400 - 1;
+
+		/*
+		 * Set the start date as beginning of the current year. This can
+		 * be overridden using device tree.
+		 */
+		rtc_time64_to_tm(ktime_get_real_seconds(), &tm);
+		rtc->start_secs =  mktime64(tm.tm_year, 1, 1, 0, 0, 0);
+		rtc->set_start_time = true;
+	} else {
+		/* 16bit days + hours minutes seconds */
+		rtc->range_max = (1 << 16) * 86400ULL - 1;
+	}
 
 	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(pdata->clk_ipg)) {
-- 
2.20.1

