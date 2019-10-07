Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C93ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1221D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfJGNrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:47:37 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54525 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfJGNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:47:33 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CA635FF80A;
        Mon,  7 Oct 2019 13:47:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/10] rtc: ds1347: mask ALM OUT when reading time
Date:   Mon,  7 Oct 2019 15:47:19 +0200
Message-Id: <20191007134724.15505-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
References: <20191007134724.15505-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 7 of the minutes registers is ALM OUT. It indicates an alarm fired.
Mask it out when reading the time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1347.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index 06abf0b47e16..763eb60e5e8f 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -52,7 +52,7 @@ static int ds1347_read_time(struct device *dev, struct rtc_time *dt)
 		return err;
 
 	dt->tm_sec = bcd2bin(buf[0]);
-	dt->tm_min = bcd2bin(buf[1]);
+	dt->tm_min = bcd2bin(buf[1] & 0x7f);
 	dt->tm_hour = bcd2bin(buf[2] & 0x3F);
 	dt->tm_mday = bcd2bin(buf[3]);
 	dt->tm_mon = bcd2bin(buf[4]) - 1;
-- 
2.21.0

