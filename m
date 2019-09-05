Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C366C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1842922CF7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfIEMMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:12:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42703 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbfIEMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcM-0007tB-No; Thu, 05 Sep 2019 14:12:02 +0200
Message-Id: <20190905120539.707986830@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot+55acd54b57bb4b3840a4@syzkaller.appspotmail.com
Subject: [patch 1/6] posix-cpu-timers: Always clear head pointer on dequeue
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The head pointer in struct cpu_timer is checked to be NULL in
posix_cpu_timer_del() when the delete raced with the exit cleanup. The
works correctly as long as the timer is actually dequeued via
posix_cpu_timers_exit*().

But if the timer was dequeued due to expiry the head pointer is still set
and triggers the warning.

In fact keeping the head pointer around after any dequeue is pointless as
is has no meaning at all after that.

Clear the head pointer always on dequeue and remove the unused requeue
function while at it.

Fixes: 60bda037f1dd ("posix-cpu-timers: Utilize timerqueue for storage")
Reported-by: syzbot+55acd54b57bb4b3840a4@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -74,11 +74,6 @@ struct cpu_timer {
 	int			firing;
 };
 
-static inline bool cpu_timer_requeue(struct cpu_timer *ctmr)
-{
-	return timerqueue_add(ctmr->head, &ctmr->node);
-}
-
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
 				     struct cpu_timer *ctmr)
 {
@@ -88,8 +83,10 @@ static inline bool cpu_timer_enqueue(str
 
 static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
 {
-	if (!RB_EMPTY_NODE(&ctmr->node.node))
+	if (ctmr->head) {
 		timerqueue_del(ctmr->head, &ctmr->node);
+		ctmr->head = NULL;
+	}
 }
 
 static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)


