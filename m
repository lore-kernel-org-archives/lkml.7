Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95855C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfDPIbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:31:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34915 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfDPIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:30:55 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D65121C0007;
        Tue, 16 Apr 2019 08:30:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: mxc: use .set_time
Date:   Tue, 16 Apr 2019 10:30:45 +0200
Message-Id: <20190416083045.13924-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416083045.13924-1-alexandre.belloni@bootlin.com>
References: <20190416083045.13924-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use .set_time instead of the deprecated .set_mmss64.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mxc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 31d3f375bc0f..e697e96612bb 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -254,8 +254,10 @@ static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 /*
  * This function sets the internal RTC time based on tm in Gregorian date.
  */
-static int mxc_rtc_set_mmss(struct device *dev, time64_t time)
+static int mxc_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	time64_t time = rtc_tm_to_time64(tm);
+
 	/* Avoid roll-over from reading the different registers */
 	do {
 		set_alarm_or_time(dev, MXC_RTC_TIME, time);
@@ -298,7 +300,7 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 /* RTC layer */
 static const struct rtc_class_ops mxc_rtc_ops = {
 	.read_time		= mxc_rtc_read_time,
-	.set_mmss64		= mxc_rtc_set_mmss,
+	.set_time		= mxc_rtc_set_time,
 	.read_alarm		= mxc_rtc_read_alarm,
 	.set_alarm		= mxc_rtc_set_alarm,
 	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
-- 
2.20.1

