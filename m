Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C12820645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfDSS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:56:04 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60458 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfDSS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:56:03 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 14:56:02 EDT
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 265433A7D10;
        Fri, 19 Apr 2019 08:25:08 +0000 (UTC)
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 61AE4FF804;
        Fri, 19 Apr 2019 08:25:07 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/6] rtc: ds2404: switch to rtc_time64_to_tm
Date:   Fri, 19 Apr 2019 10:24:57 +0200
Message-Id: <20190419082501.17549-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
References: <20190419082501.17549-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit version of rtc_time_to_tm now that the range is enforced by
the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds2404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 7b36c09bed10..17606e0fd28a 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -206,7 +206,7 @@ static int ds2404_read_time(struct device *dev, struct rtc_time *dt)
 	ds2404_read_memory(dev, 0x203, 4, (u8 *)&time);
 	time = le32_to_cpu(time);
 
-	rtc_time_to_tm(time, dt);
+	rtc_time64_to_tm(time, dt);
 	return 0;
 }
 
-- 
2.20.1

