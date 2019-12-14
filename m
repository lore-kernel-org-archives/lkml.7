Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD33C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96BC2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLNWDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:03:11 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44293 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLNWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:03:06 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 814591BF206;
        Sat, 14 Dec 2019 22:03:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/17] rtc: pcf8563: remove conditional compilation
Date:   Sat, 14 Dec 2019 23:02:49 +0100
Message-Id: <20191214220259.621996-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
References: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always compile pcf8563_rtc_ioctl as we are sure that CONFIG_RTC_INTF_DEV is
selected on actual kernel configurations.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8563.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index c701eef82349..026192fc0c2a 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -276,11 +276,9 @@ static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
 				9 - PCF8563_REG_SC, buf + PCF8563_REG_SC);
 }
 
-#ifdef CONFIG_RTC_INTF_DEV
 static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct pcf8563 *pcf8563 = i2c_get_clientdata(to_i2c_client(dev));
-	struct rtc_time tm;
 
 	switch (cmd) {
 	case RTC_VL_READ:
@@ -295,9 +293,6 @@ static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 		return -ENOIOCTLCMD;
 	}
 }
-#else
-#define pcf8563_rtc_ioctl NULL
-#endif
 
 static int pcf8563_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *tm)
 {
-- 
2.23.0

