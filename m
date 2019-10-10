Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB751C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B18D21920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfJJIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:41:59 -0400
Received: from mx133-tc.baidu.com ([61.135.168.133]:26301 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733108AbfJJIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:41:52 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm03.tc.baidu.com (Postfix) with ESMTP id 76F3F4500033;
        Thu, 10 Oct 2019 16:41:39 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] perf/x86: avoid false-positives hard lockup
Date:   Thu, 10 Oct 2019 16:41:38 +0800
Message-Id: <1570696898-13169-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if perf counter is used as nmi watchdog, and twice nmi in soft
watchdog sample period will trigger hard lockup

make sure left time is not less than soft watchdog period by
compared with 3/5 period to skip forward, since soft watchdog
sample period is 2/5 of watchdog_thresh, nmi watchdog sample
period, computed by set_sample_period

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..1f5309456d4c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1196,7 +1196,11 @@ int x86_perf_event_set_period(struct perf_event *event)
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+	if (unlikely(left <= -(period * 3 / 5))) {
+#else
 	if (unlikely(left <= -period)) {
+#endif
 		left = period;
 		local64_set(&hwc->period_left, left);
 		hwc->last_period = period;
-- 
2.16.2

