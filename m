Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B2C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCD52073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLNWDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:03:06 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60987 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfLNWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:03:04 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E0CDF60003;
        Sat, 14 Dec 2019 22:03:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 03/17] rtc: abx80x: return meaningful value for RTC_VL_READ
Date:   Sat, 14 Dec 2019 23:02:45 +0100
Message-Id: <20191214220259.621996-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
References: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABX8XX_STATUS_BLF indicates the battery is low and needs to be replaced
soon.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-abx80x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 73830670a41f..3521d8e8dc38 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -523,12 +523,9 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 		if (status < 0)
 			return status;
 
-		tmp = !!(status & ABX8XX_STATUS_BLF);
+		tmp = status & ABX8XX_STATUS_BLF ? RTC_VL_BACKUP_LOW : 0;
 
-		if (copy_to_user((void __user *)arg, &tmp, sizeof(int)))
-			return -EFAULT;
-
-		return 0;
+		return put_user(tmp, (unsigned int __user *)arg);
 
 	case RTC_VL_CLR:
 		status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
-- 
2.23.0

