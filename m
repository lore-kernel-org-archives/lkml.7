Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA1213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfCTMnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:43:49 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40927 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:43:47 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3128B1BF20A;
        Wed, 20 Mar 2019 12:43:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/4] rtc: dm355evm: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Wed, 20 Mar 2019 13:43:34 +0100
Message-Id: <20190320124335.14330-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320124335.14330-1-alexandre.belloni@bootlin.com>
References: <20190320124335.14330-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion as the range is enforced
by the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-dm355evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index cd80c89d9002..3fee96c19a5d 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -78,7 +78,7 @@ static int dm355evm_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	dev_dbg(dev, "read timestamp %08x\n", time.value);
 
-	rtc_time_to_tm(le32_to_cpu(time.value), tm);
+	rtc_time64_to_tm(le32_to_cpu(time.value), tm);
 	return 0;
 }
 
@@ -88,7 +88,7 @@ static int dm355evm_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	unsigned long	value;
 	int		status;
 
-	rtc_tm_to_time(tm, &value);
+	value = rtc_tm_to_time64(tm);
 	time.value = cpu_to_le32(value);
 
 	dev_dbg(dev, "write timestamp %08x\n", time.value);
-- 
2.20.1

