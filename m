Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA65C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F49121530
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfFRPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:47:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfFRPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:47:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70AC530860AD;
        Tue, 18 Jun 2019 15:47:16 +0000 (UTC)
Received: from holly.tpb.lab.eng.brq.redhat.com (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC98B176BC;
        Tue, 18 Jun 2019 15:47:14 +0000 (UTC)
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     swkhack@gmail.com, Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] ntp: Limit TAI-UTC offset
Date:   Tue, 18 Jun 2019 17:47:13 +0200
Message-Id: <20190618154713.20929-1-mlichvar@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 18 Jun 2019 15:47:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow the TAI-UTC offset of the system clock to be set by
adjtimex() to a value larger than 100000 seconds.

This prevents an overflow in the conversion to int, prevents the
CLOCK_TAI clock from getting too far ahead of the CLOCK_REALTIME clock,
and it is still large enough to allow leap seconds to be inserted at the
maximum rate currently supported by the kernel (once per day) for the
next ~270 years, however unlikely it is that someone can survive a
catastrophic event which slowed down the rotation of the Earth so much.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 kernel/time/ntp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8de4f789dc1b..65eb796610dc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -43,6 +43,7 @@ static u64			tick_length_base;
 #define MAX_TICKADJ		500LL		/* usecs */
 #define MAX_TICKADJ_SCALED \
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
+#define MAX_TAI_OFFSET		100000
 
 /*
  * phase-lock loop variables
@@ -691,7 +692,8 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant >= 0)
+	if (txc->modes & ADJ_TAI &&
+			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
-- 
2.17.2

