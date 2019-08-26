Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B867DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D7A2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1lPDFxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfHZO0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:26:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55014 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfHZO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WO444oEA1zgifP9XUqYjFbPXrYeuDflpL1353l6p8iw=; b=O1lPDFxmLrqaOFJtDi8wdtpAz
        FK/zQ5dznaZDbmVhKkr5WHSKcbIjfm1hWef4PMy3Gd2Av7cFqu+R/qFF+Cqj0NH72eASWtFStEuVt
        v1vX9HzbwEjIkqatpVApW653TugLBVEAC1foSSuIn9Ac2Qs/QUSIyB4DswsMGSt+qizD3xhFI6wYk
        q8CpyZbFV4xIcZkJdeDxsKMifp3Fw2cCrVKQ6NPSScERo6CL5bQkVvMh42Kj6gcSCUFfun7QgB35A
        A35kwsfhK/YaIo1ErQSJVxUSi59EXES3RMSMiz34M+O/pZMPU1e8m9wiJl1nnv5q9GQtHRKjarljd
        LEYxOD4Mw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2FwV-0000cW-Bh; Mon, 26 Aug 2019 14:25:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFC4A3075FE;
        Mon, 26 Aug 2019 16:25:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C8AC20A71EF1; Mon, 26 Aug 2019 16:25:57 +0200 (CEST)
Date:   Mon, 26 Aug 2019 16:25:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's
 down family of function
Message-ID: <20190826142557.GM2386@hirez.programming.kicks-ass.net>
References: <20190822155112.GU2369@hirez.programming.kicks-ass.net>
 <20190824035100.7969-1-sst2005@gmail.com>
 <20190826141436.GE2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826141436.GE2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:14:36PM +0200, Peter Zijlstra wrote:
> (XXX, we should probably move the schedule_timeout() thing into its own
> patch)

A better version here...

---
Subject: sched,time: Allow better constprop/DCE for schedule_timeout()

If timeout is constant and MAX_SCHEDULE_TIMEOUT, it would be nice to
allow to optimize away everything timeout.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h | 13 ++++++++++++-
 kernel/time/timer.c   | 52 ++++++++++++++++++++++++---------------------------
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0edee94834a..6003e96bce52 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -214,7 +214,18 @@ extern void scheduler_tick(void);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
-extern long schedule_timeout(long timeout);
+extern long __schedule_timeout(long timeout);
+
+static inline long schedule_timeout(long timeout)
+{
+	if (__builtin_constant_p(timeout) && timeout == MAX_SCHEDULE_TIMEOUT) {
+		schedule();
+		return timeout;
+	}
+
+	return __schedule_timeout(timeout);
+}
+
 extern long schedule_timeout_interruptible(long timeout);
 extern long schedule_timeout_killable(long timeout);
 extern long schedule_timeout_uninterruptible(long timeout);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0e315a2e77ae..912ae56b96b8 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1851,38 +1851,34 @@ static void process_timeout(struct timer_list *t)
  * jiffies will be returned.  In all cases the return value is guaranteed
  * to be non-negative.
  */
-signed long __sched schedule_timeout(signed long timeout)
+signed long __sched __schedule_timeout(signed long timeout)
 {
 	struct process_timer timer;
 	unsigned long expire;
 
-	switch (timeout)
-	{
-	case MAX_SCHEDULE_TIMEOUT:
-		/*
-		 * These two special cases are useful to be comfortable
-		 * in the caller. Nothing more. We could take
-		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
-		 * but I' d like to return a valid offset (>=0) to allow
-		 * the caller to do everything it want with the retval.
-		 */
+	/*
+	 * We could take MAX_SCHEDULE_TIMEOUT from one of the negative values,
+	 * but I'd like to return a valid offset (>= 0) to allow the caller to
+	 * do everything it wants with the retval.
+	 */
+	if (timeout == MAX_SCHEDULE_TIMEOUT) {
 		schedule();
-		goto out;
-	default:
-		/*
-		 * Another bit of PARANOID. Note that the retval will be
-		 * 0 since no piece of kernel is supposed to do a check
-		 * for a negative retval of schedule_timeout() (since it
-		 * should never happens anyway). You just have the printk()
-		 * that will tell you if something is gone wrong and where.
-		 */
-		if (timeout < 0) {
-			printk(KERN_ERR "schedule_timeout: wrong timeout "
+		return timeout;
+	}
+
+	/*
+	 * Another bit of PARANOID. Note that the retval will be 0 since no
+	 * piece of kernel is supposed to do a check for a negative retval of
+	 * schedule_timeout() (since it should never happens anyway). You just
+	 * have the printk() that will tell you if something is gone wrong and
+	 * where.
+	 */
+	if (timeout < 0) {
+		printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
-			dump_stack();
-			current->state = TASK_RUNNING;
-			goto out;
-		}
+		dump_stack();
+		current->state = TASK_RUNNING;
+		goto out;
 	}
 
 	expire = timeout + jiffies;
@@ -1898,10 +1894,10 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	timeout = expire - jiffies;
 
- out:
+out:
 	return timeout < 0 ? 0 : timeout;
 }
-EXPORT_SYMBOL(schedule_timeout);
+EXPORT_SYMBOL(__schedule_timeout);
 
 /*
  * We can use __set_current_state() here because schedule_timeout() calls
