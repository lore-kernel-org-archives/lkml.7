Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7270C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B722073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfDQIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfDQIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA715C04959F;
        Wed, 17 Apr 2019 08:48:36 +0000 (UTC)
Received: from holly.tpb.lab.eng.brq.redhat.com (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56FC41001DF3;
        Wed, 17 Apr 2019 08:48:35 +0000 (UTC)
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] ntp: Allow TAI-UTC offset to be set to zero
Date:   Wed, 17 Apr 2019 10:48:33 +0200
Message-Id: <20190417084833.7401-1-mlichvar@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 17 Apr 2019 08:48:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADJ_TAI adjtimex mode sets the TAI-UTC offset of the system clock.
It is typically set by NTP/PTP implementations and it is automatically
updated by the kernel on leap seconds. The initial value is zero (which
applications may interpret as unknown), but this value cannot be set by
adjtimex. This limitation seems to go back to the original "nanokernel"
implementation by David Mills.

Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
order to allow setting it back to the initial value.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 92a90014a925..f43d47c8c3b6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && txc->constant >= 0)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
-- 
2.17.2

