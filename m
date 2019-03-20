Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B458C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BB5213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfCTMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:44:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45631 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfCTMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:44:47 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D912E4000A;
        Wed, 20 Mar 2019 12:44:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/4] rtc: ps3: set range
Date:   Wed, 20 Mar 2019 13:44:28 +0100
Message-Id: <20190320124428.14445-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
References: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PS3 has a 64bit second counter from 2000. While this exceeds the 64bit
UNIX timestamp, there is not doubt that non of them will still be working
by then.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ps3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ps3.c b/drivers/rtc/rtc-ps3.c
index f8b56f3b2529..3ee80693f141 100644
--- a/drivers/rtc/rtc-ps3.c
+++ b/drivers/rtc/rtc-ps3.c
@@ -52,6 +52,7 @@ static int __init ps3_rtc_probe(struct platform_device *dev)
 		return PTR_ERR(rtc);
 
 	rtc->ops = &ps3_rtc_ops;
+	rtc->range_max = U64_MAX;
 
 	platform_set_drvdata(dev, rtc);
 
-- 
2.20.1

