Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF310C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C9320708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVKXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:23:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55825 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:23:04 -0500
X-Originating-IP: 92.184.97.94
Received: from localhost (unknown [92.184.97.94])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DD27D40004;
        Fri, 22 Nov 2019 10:22:54 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH 3/8] rtc: ds1685: remove set but unused variables
Date:   Fri, 22 Nov 2019 11:22:07 +0100
Message-Id: <20191122102212.400158-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
References: <20191122102212.400158-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings:
drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_read_time’:
drivers/rtc/rtc-ds1685.c:264:5: warning: variable ‘ctrlb’ set but not used [-Wunused-but-set-variable]
  264 |  u8 ctrlb, century;
      |     ^~~~~
drivers/rtc/rtc-ds1685.c: In function ‘ds1685_rtc_proc’:
drivers/rtc/rtc-ds1685.c:758:19: warning: variable ‘ctrlc’ set but not used [-Wunused-but-set-variable]
  758 |  u8 ctrla, ctrlb, ctrlc, ctrld, ctrl4a, ctrl4b, ssn[8];
      |                   ^~~~~
Cc: Joshua Kinard <kumba@gentoo.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 98d06b3ee913..8419595e7da7 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -261,7 +261,7 @@ static int
 ds1685_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	u8 ctrlb, century;
+	u8 century;
 	u8 seconds, minutes, hours, wday, mday, month, years;
 
 	/* Fetch the time info from the RTC registers. */
@@ -274,7 +274,6 @@ ds1685_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	month   = rtc->read(rtc, RTC_MONTH);
 	years   = rtc->read(rtc, RTC_YEAR);
 	century = rtc->read(rtc, RTC_CENTURY);
-	ctrlb   = rtc->read(rtc, RTC_CTRL_B);
 	ds1685_rtc_end_data_access(rtc);
 
 	/* bcd2bin if needed, perform fixups, and store to rtc_time. */
@@ -755,7 +754,7 @@ static int
 ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	u8 ctrla, ctrlb, ctrlc, ctrld, ctrl4a, ctrl4b, ssn[8];
+	u8 ctrla, ctrlb, ctrld, ctrl4a, ctrl4b, ssn[8];
 	char *model;
 
 	/* Read all the relevant data from the control registers. */
@@ -763,7 +762,6 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	ds1685_rtc_get_ssn(rtc, ssn);
 	ctrla = rtc->read(rtc, RTC_CTRL_A);
 	ctrlb = rtc->read(rtc, RTC_CTRL_B);
-	ctrlc = rtc->read(rtc, RTC_CTRL_C);
 	ctrld = rtc->read(rtc, RTC_CTRL_D);
 	ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
 	ctrl4b = rtc->read(rtc, RTC_EXT_CTRL_4B);
-- 
2.23.0

