Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E362AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfLJRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:05:53 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39603 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfLJRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:05:53 -0500
X-Originating-IP: 90.182.112.136
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 628381BF213;
        Tue, 10 Dec 2019 17:05:51 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] PM / sleep: switch to rtc_time64_to_tm/rtc_tm_to_time64
Date:   Tue, 10 Dec 2019 18:05:40 +0100
Message-Id: <20191210170540.3006422-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the 64bit versions of rtc_tm time conversion to avoid the y2038 issue.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 kernel/power/suspend_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index 60564b58de07..e1ed58adb69e 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -70,7 +70,7 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 	static char info_test[] __initdata =
 		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
 
-	unsigned long		now;
+	time64_t		now;
 	struct rtc_wkalrm	alm;
 	int			status;
 
@@ -81,10 +81,10 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 		printk(err_readtime, dev_name(&rtc->dev), status);
 		return;
 	}
-	rtc_tm_to_time(&alm.time, &now);
+	now = rtc_tm_to_time64(&alm.time);
 
 	memset(&alm, 0, sizeof alm);
-	rtc_time_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
+	rtc_time64_to_tm(now + TEST_SUSPEND_SECONDS, &alm.time);
 	alm.enabled = true;
 
 	status = rtc_set_alarm(rtc, &alm);
-- 
2.23.0

