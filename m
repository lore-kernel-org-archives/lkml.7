Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314FECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433E820872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJOGeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:34:20 -0400
Received: from mx132-tc.baidu.com ([61.135.168.132]:31970 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbfJOGeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:34:20 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm03.tc.baidu.com (Postfix) with ESMTP id 1BFE34500035;
        Tue, 15 Oct 2019 14:34:07 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Kan.liang@intel.com
Subject: [PATCH][v2] watchdog/hardlockup: reassign last_timestamp when enable nmi event
Date:   Tue, 15 Oct 2019 14:34:07 +0800
Message-Id: <1571121247-19392-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

last_timestamp is not initialized and is zero after boot, or stop
to forward when nmi watchdog is disabled; and false positives still
is possible when restart NMI timer after stopping 120 seconds

so reassign last_timestamp always when enable nmi event

Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---

v1-->v2: make it be able to be compiled on no CONFIG_HARDLOCKUP_CHECK_TIMESTAMP platform 

kernel/watchdog_hld.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..f14d18280387 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -91,11 +91,24 @@ static bool watchdog_check_timestamp(void)
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
+
+static void watchdog_touch_timestamp(int cpu)
+{
+
+	ktime_t now = ktime_get_mono_fast_ns();
+
+	per_cpu(last_timestamp, cpu) = now;
+}
 #else
 static inline bool watchdog_check_timestamp(void)
 {
 	return true;
 }
+
+static void watchdog_touch_timestamp(int cpu)
+{
+
+}
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -196,6 +209,7 @@ void hardlockup_detector_perf_enable(void)
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_touch_timestamp(smp_processor_id());
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 
@@ -274,8 +288,10 @@ void __init hardlockup_detector_perf_restart(void)
 	for_each_online_cpu(cpu) {
 		struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
-		if (event)
+		if (event) {
+			watchdog_touch_timestamp(cpu);
 			perf_event_enable(event);
+		}
 	}
 }
 
-- 
2.16.2

