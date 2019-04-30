Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702C20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfD3UTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:19:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47659 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfD3UTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:19:05 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5A297E0008;
        Tue, 30 Apr 2019 20:19:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: st-lpc: remove unnecessary check
Date:   Tue, 30 Apr 2019 22:18:34 +0200
Message-Id: <20190430201834.12634-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core already ensures the alarm is set to a time in the future, it
is not necessary to check again in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index bee75ca7ff79..ce2dae6e2a24 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -166,10 +166,6 @@ static int st_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	now_secs = rtc_tm_to_time64(&now);
 	alarm_secs = rtc_tm_to_time64(&t->time);
 
-	/* Invalid alarm time */
-	if (now_secs > alarm_secs)
-		return -EINVAL;
-
 	memcpy(&rtc->alarm, t, sizeof(struct rtc_wkalrm));
 
 	/* Now many secs to fire */
-- 
2.20.1

