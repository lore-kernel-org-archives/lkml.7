Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB0C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1B0217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfF0Buj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfF0Bui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 124E33082B6B;
        Thu, 27 Jun 2019 01:50:33 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBA55D9C6;
        Thu, 27 Jun 2019 01:50:23 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterx@redhat.com
Subject: [PATCH v2] timer: document TIMER_PINNED
Date:   Thu, 27 Jun 2019 09:50:19 +0800
Message-Id: <20190627015019.21964-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 01:50:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag hints the user that the pinned timers will always be run on a
static CPU (because that should be what "pinned" means...) but that's
not the truth, at least with current implementation.

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
 include/linux/timer.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..1b96cc623a12 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,19 +36,31 @@ struct timer_list {
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
+ * @TIMER_PINNED: A pinned timer will not be affected by any timer
+ * placement heuristics (like, NOHZ) and will always be run on the CPU
+ * when the timer was enqueued.
+ *
+ * Note: Because enqueuing of timers can actually migrate the timer
+ * from one CPU to another, pinned timers are not guaranteed to stay
+ * on the initialy selected CPU.  They move to the CPU on which the
+ * enqueue function is invoked via mod_timer() or add_timer().  If the
+ * timer should be placed on a particular CPU, then add_timer_on() has
+ * to be used.  It is also suggested that the user should always use
+ * add_timer_on() explicitly for pinned timers.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
-- 
2.21.0

