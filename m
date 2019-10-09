Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4BBECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9775320679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KkUEF5Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfJIQDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:03:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42180 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731724AbfJIQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:03:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99G0t1m031465;
        Wed, 9 Oct 2019 18:03:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=P91uflCk9IxMFAolU92mGIgCGbWGGNLXBZ/pJBjwmlY=;
 b=KkUEF5MoMVIQonrjKXYx6+82BFHHpwxE8H86KYV/P8pE2e8nhujJ1TgWwdxtzXVLvszr
 MxEKBPE4S1ZOagrUDP0BPF1StC9IAZYC8H00DwpCQFmsaSxGaHLcZd9sqVDqjDS9k68K
 YmMhR99AEeyWizNgcHBb6PftOcmp8y//1Je0PF7vTA5r7M3ay1bJfNa+5ULecjCI7oyS
 LWpDYTHkDWDTjI/wukSJAbzrEwVxbflXKy53vAs7+px0FJtfki2WJbf71M6aLs4uYcJM
 NZvm/ZGj8FFyJTe7FFrVG/dsV7tjTfe8ZhzK5WLd5eKOxV1NDR6lUmwkQiif8N9/kfs1 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2pf6he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 18:03:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 267A7100034;
        Wed,  9 Oct 2019 18:02:58 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E95E52A9704;
        Wed,  9 Oct 2019 18:02:57 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 18:02:57 +0200
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 18:02:57
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <marc.zyngier@arm.com>, <daniel.lezcano@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] tick: check if broadcast device could really be stopped
Date:   Wed, 9 Oct 2019 18:02:46 +0200
Message-ID: <20191009160246.17898-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_07:2019-10-08,2019-10-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CPU isn't able to go in states where the clock event will
be stopped we can ignore CLOCK_EVT_FEAT_C3STOP flag.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 kernel/time/tick-broadcast.c |  6 +++---
 kernel/time/tick-common.c    |  4 ++--
 kernel/time/tick-internal.h  | 12 ++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index e51778c312f1..5393778d7703 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -78,7 +78,7 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
 {
 	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
 	    (newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
-	    (newdev->features & CLOCK_EVT_FEAT_C3STOP))
+	    tick_broadcast_could_stop(newdev))
 		return false;
 
 	if (tick_broadcast_device.mode == TICKDEV_MODE_ONESHOT &&
@@ -188,7 +188,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 		 * Clear the broadcast bit for this cpu if the
 		 * device is not power state affected.
 		 */
-		if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
+		if (!tick_broadcast_could_stop(dev))
 			cpumask_clear_cpu(cpu, tick_broadcast_mask);
 		else
 			tick_device_setup_broadcast_func(dev);
@@ -368,7 +368,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 	/*
 	 * Is the device not affected by the powerstate ?
 	 */
-	if (!dev || !(dev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!dev || !tick_broadcast_could_stop(dev))
 		goto out;
 
 	if (!tick_device_is_functional(dev))
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 59225b484e4e..a300ee941c56 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -72,7 +72,7 @@ int tick_is_oneshot_available(void)
 
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return 0;
-	if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!tick_broadcast_could_stop(dev))
 		return 1;
 	return tick_broadcast_oneshot_available();
 }
@@ -393,7 +393,7 @@ int tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 
-	if (!(td->evtdev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!tick_broadcast_could_stop(td->evtdev))
 		return 0;
 
 	return __tick_broadcast_oneshot_control(state);
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7b2496136729..99aa7b5a8dae 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -2,6 +2,7 @@
 /*
  * tick internal variable and functions used by low/high res code
  */
+#include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
 
@@ -48,6 +49,17 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 	dev->state_use_accessors = state;
 }
 
+/**
+ * Return true if the cpu could go in states where the device will be stopped
+ */
+static inline int tick_broadcast_could_stop(struct clock_event_device *dev)
+{
+	struct cpuidle_driver *drv = cpuidle_get_driver();
+
+	return !!((dev->features & CLOCK_EVT_FEAT_C3STOP)
+		  && drv && drv->bctimer);
+}
+
 extern void clockevents_shutdown(struct clock_event_device *dev);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
-- 
2.15.0

