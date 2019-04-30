Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C74420835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfD3JdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:33:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41999 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfD3JdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:33:08 -0400
Received: from localhost (alyon-652-1-31-175.w109-213.abo.wanadoo.fr [109.213.14.175])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4B2EF10001A;
        Tue, 30 Apr 2019 09:33:06 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] rtc: pcap: set range
Date:   Tue, 30 Apr 2019 11:32:59 +0200
Message-Id: <20190430093302.28648-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While PCAP_RTC_DAY_MASK is set to 0x3ffff, it is very unlikely to be
correct as this ends in june 1992, before the product even existed. It is
more likely to be a 14-bit day counter. The next product in the family (the
mc13xxx) has a 15-bit day counter.

The same issue is seen with PCAP_RTC_TOD_MASK which only has 65535 seconds
and falls short of the necessary 86400 seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index f176cb9d0dbc..976240853260 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -149,11 +149,13 @@ static int __init pcap_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcap_rtc);
 
-	pcap_rtc->rtc = devm_rtc_device_register(&pdev->dev, "pcap",
-					&pcap_rtc_ops, THIS_MODULE);
+	pcap_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(pcap_rtc->rtc))
 		return PTR_ERR(pcap_rtc->rtc);
 
+	pcap_rtc->rtc->ops = &pcap_rtc_ops;
+	pcap_rtc->rtc->range_max = (1 << 14) * 86400ULL - 1;
+
 	timer_irq = pcap_to_irq(pcap_rtc->pcap, PCAP_IRQ_1HZ);
 	alarm_irq = pcap_to_irq(pcap_rtc->pcap, PCAP_IRQ_TODA);
 
@@ -167,7 +169,7 @@ static int __init pcap_rtc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	return 0;
+	return rtc_register_device(pcap_rtc->rtc);
 }
 
 static int __exit pcap_rtc_remove(struct platform_device *pdev)
-- 
2.20.1

