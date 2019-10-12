Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824D32087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfJLK0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 06:26:00 -0400
Received: from mx140-tc.baidu.com ([61.135.168.140]:51115 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727527AbfJLKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:23:59 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id BCB3111C004B;
        Sat, 12 Oct 2019 18:23:46 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH] watchdog/hardlockup: reassign last_timestamp when enable nmi event
Date:   Sat, 12 Oct 2019 18:23:46 +0800
Message-Id: <1570875826-30491-1-git-send-email-lirongqing@baidu.com>
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
---
 kernel/watchdog_hld.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..fc3a5c7ccd82 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -189,6 +189,8 @@ static int hardlockup_detector_event_create(void)
  */
 void hardlockup_detector_perf_enable(void)
 {
+	ktime_t now = ktime_get_mono_fast_ns();
+
 	if (hardlockup_detector_event_create())
 		return;
 
@@ -196,6 +198,7 @@ void hardlockup_detector_perf_enable(void)
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	this_cpu_write(last_timestamp, now);
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 
@@ -274,8 +277,12 @@ void __init hardlockup_detector_perf_restart(void)
 	for_each_online_cpu(cpu) {
 		struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
-		if (event)
+		if (event) {
+			ktime_t now = ktime_get_mono_fast_ns();
+
+			per_cpu(last_timestamp, cpu) = now;
 			perf_event_enable(event);
+		}
 	}
 }
 
-- 
2.16.2

