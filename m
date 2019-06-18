Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537F0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C3420873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfFRQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 020187BF00;
        Tue, 18 Jun 2019 16:06:15 +0000 (UTC)
Received: from holly.tpb.lab.eng.brq.redhat.com (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA6027D576;
        Tue, 18 Jun 2019 16:06:12 +0000 (UTC)
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH repost] kselftests: timers: freq-step: Update maximum acceptable precision and errors
Date:   Tue, 18 Jun 2019 18:06:12 +0200
Message-Id: <20190618160612.21957-1-mlichvar@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Jun 2019 16:06:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTI has a significant impact on precision of the MONOTONIC_RAW clock,
which prevents a lot of computers from running the freq-step test.
Increase the maximum acceptable precision for the test to not be skipped
to 500 nanoseconds.

After commit 78b98e3c5a66 ("timekeeping/ntp: Determine the multiplier
directly from NTP tick length") the frequency and time errors should be
much smaller. Reduce the maximum acceptable values for the test to pass
to 0.02 ppm and 50 nanoseconds respectively.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 tools/testing/selftests/timers/freq-step.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 8cd10662ffba..4b76450d78d1 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -21,9 +21,9 @@
 #define SAMPLE_READINGS 10
 #define MEAN_SAMPLE_INTERVAL 0.1
 #define STEP_INTERVAL 1.0
-#define MAX_PRECISION 100e-9
-#define MAX_FREQ_ERROR 10e-6
-#define MAX_STDDEV 1000e-9
+#define MAX_PRECISION 500e-9
+#define MAX_FREQ_ERROR 0.02e-6
+#define MAX_STDDEV 50e-9
 
 #ifndef ADJ_SETOFFSET
   #define ADJ_SETOFFSET 0x0100
-- 
2.17.2

