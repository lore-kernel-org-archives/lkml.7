Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B869C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B84020663
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFRAoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFRAoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6764308421A;
        Tue, 18 Jun 2019 00:44:03 +0000 (UTC)
Received: from xz-x1.redhat.com (unknown [10.66.60.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54DF41001DE7;
        Tue, 18 Jun 2019 00:43:57 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>, peterx@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] timer: document TIMER_PINNED
Date:   Tue, 18 Jun 2019 08:43:56 +0800
Message-Id: <20190618004356.10357-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 18 Jun 2019 00:44:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag is very easy to understand but the interface is not,
especially the assumption that add_timer_on() must be used to
guarantee a correct behavior.

For example, currently if we setup a pinned timer but later on we call
mod_timer() upon the pinned timer, the mod_timer() will still try to
run the timer on the current processor and migrate the timer if
necessary.  In other words, the suggested way to arm a pinned timer
should be add_timer_on() always.  mod_timer() can be used in this case
only if current processor is the one that we want to pin the timer on.

Document it a bit with the definition of TIMER_PINNED so that all
future users will use it correctly.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/timer.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..4a3408a05f86 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,19 +36,26 @@ struct timer_list {
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/*
- * A deferrable timer will work normally when the system is busy, but
- * will not cause a CPU to come out of idle just to service it; instead,
- * the timer will be serviced when the CPU eventually wakes up with a
- * subsequent non-deferrable timer.
+/**
+ * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
+ * system is busy, but will not cause a CPU to come out of idle just
+ * to service it; instead, the timer will be serviced when the CPU
+ * eventually wakes up with a subsequent non-deferrable timer.
  *
- * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
- * the completion of the running instance from IRQ handlers, for example,
- * by calling del_timer_sync().
+ * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
+ * it's safe to wait for the completion of the running instance from
+ * IRQ handlers, for example, by calling del_timer_sync().
  *
  * Note: The irq disabled callback execution is a special case for
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
+ *
+ * @TIMER_PINNED: A pinned timer will not be affected by timer
+ * migration so it will always be run on a static cpu that was
+ * specified.  Note: neither timer_setup() nor mod_timer() will
+ * guarantee correct pinning of timers.  One should always use
+ * add_timer_on() when arm the timer to guarantee that the timer will
+ * be pinned to the target CPU correctly.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
-- 
2.17.1

