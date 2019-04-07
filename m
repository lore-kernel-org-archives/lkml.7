Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36FC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9983720880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDGVQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:16:55 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59199 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDGVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:16:51 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6292B20003;
        Sun,  7 Apr 2019 21:16:49 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: tegra: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Sun,  7 Apr 2019 23:16:45 +0200
Message-Id: <20190407211646.14962-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 3f93a1f7abb5..e93092aa6f7d 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -123,7 +123,7 @@ static int tegra_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	spin_unlock_irqrestore(&info->tegra_rtc_lock, sl_irq_flags);
 
-	rtc_time_to_tm(sec, tm);
+	rtc_time64_to_tm(sec, tm);
 
 	dev_vdbg(dev, "time read as %lu. %ptR\n", sec, tm);
 
@@ -137,7 +137,7 @@ static int tegra_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 
 	/* convert tm to seconds. */
-	rtc_tm_to_time(tm, &sec);
+	sec = rtc_tm_to_time64(tm);
 
 	dev_vdbg(dev, "time set to %lu. %ptR\n", sec, tm);
 
@@ -166,7 +166,7 @@ static int tegra_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	} else {
 		/* alarm is enabled. */
 		alarm->enabled = 1;
-		rtc_time_to_tm(sec, &alarm->time);
+		rtc_time64_to_tm(sec, &alarm->time);
 	}
 
 	tmp = readl(info->rtc_base + TEGRA_RTC_REG_INTR_STATUS);
@@ -204,7 +204,7 @@ static int tegra_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	unsigned long sec;
 
 	if (alarm->enabled)
-		rtc_tm_to_time(&alarm->time, &sec);
+		sec = rtc_tm_to_time64(&alarm->time);
 	else
 		sec = 0;
 
-- 
2.20.1

