Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5259C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1E2073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLNWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:03:27 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:44755 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfLNWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:03:10 -0500
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B22F1100005;
        Sat, 14 Dec 2019 22:03:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 13/17] rtc: rv3028: return meaningful value for RTC_VL_READ
Date:   Sat, 14 Dec 2019 23:02:55 +0100
Message-Id: <20191214220259.621996-14-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
References: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RV3028_STATUS_PORF means the voltage dropped too low and data has been
lost.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv3028.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d1a2c22861f2..a0ddc86c975a 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -428,15 +428,8 @@ static int rv3028_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		if (ret < 0)
 			return ret;
 
-		if (status & RV3028_STATUS_PORF)
-			dev_warn(&rv3028->rtc->dev, "Voltage low, data loss detected.\n");
-
-		status &= RV3028_STATUS_PORF;
-
-		if (copy_to_user((void __user *)arg, &status, sizeof(int)))
-			return -EFAULT;
-
-		return 0;
+		status = status & RV3028_STATUS_PORF ? RTC_VL_DATA_INVALID : 0;
+		return put_user(status, (unsigned int __user *)arg);
 
 	default:
 		return -ENOIOCTLCMD;
-- 
2.23.0

