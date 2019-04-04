Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E505C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAAF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azs8j6C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfDDNDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:03:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDNDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2eORCRvSDvO6jizBu164MngG79aEY2YEpD4oMitGjlI=; b=azs8j6C0cGYyjAZ975gn6LX+a
        8eVfDHTXDF+/HtaOgITge8VApY0S+ZtIpxnHuUmR6NkCqDVSLA+Emu3TM+a6CQaCCbJmcbu4kd6mp
        tIhlXLtiETs+Hq7Ci4RVME6Rqd0zGJHYwZmHBb0+kfWmQC5QzE7Ykl5XQYMtzIR9Sb1WXvuKvjUTl
        C3VrNktyyLvMdxbxl3NMBNUqf/gKq+AoLiydnDtLnbDxAib+BlUfaMCBhkgJpgwiclZ3ZGkk02Q3Y
        slSO9snK+MWgmfjNI7wcd7pj/cW/FqaJI3cdXAlRShfIlZAONCHWIoQ+8yGRoyQALr9AK2yEW3+b3
        1NApQd36w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC21H-00055Y-As; Thu, 04 Apr 2019 13:03:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 928CD2038C24B; Thu,  4 Apr 2019 15:03:00 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:03:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190404130300.GF14281@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404110909.GY4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:09:09PM +0200, Peter Zijlstra wrote:

> That is not entirely the scenario I talked about, but *groan*.
> 
> So what I meant was:
> 
> 	CPU-0							CPU-n
> 
> 	__schedule()
> 	  local_irq_disable()
> 
> 	  ...
> 	    deactivate_task(prev);
> 
> 								try_to_wake_up(@p)
> 								  ...
> 								  smp_cond_load_acquire(&p->on_cpu, !VAL);
> 
> 	  <PMI>
> 	    ..
> 	    perf_event_disable_inatomic()
> 	      event->pending_disable = 1;
> 	      irq_work_queue() /* self-IPI */
> 	  </PMI>
> 
> 	  context_switch()
> 	    prepare_task_switch()
> 	      perf_event_task_sched_out()
> 	        // the above chain that clears pending_disable
> 
> 	    finish_task_switch()
> 	      finish_task()
> 	        smp_store_release(prev->on_cpu, 0);
> 								  /* finally.... */
> 								// take woken
> 								// context_switch to @p
> 	      finish_lock_switch()
> 	        raw_spin_unlock_irq()
> 		/* w00t, IRQs enabled, self-IPI time */
> 	        <self-IPI>
> 		  perf_pending_event()
> 		    // event->pending_disable == 0
> 		</self-IPI>
> 
> 
> What you're suggesting, is that the time between:
> 
>   smp_store_release(prev->on_cpu, 0);
> 
> and
> 
>   <self-IPI>
> 
> on CPU-0 is sufficient for CPU-n to context switch to the task, enable
> the event there, trigger a PMI that calls perf_event_disable_inatomic()
> _again_ (this would mean irq_work_queue() failing, which we don't check)
> (and schedule out again, although that's not required).
> 
> This being virt that might actually be possible if (v)CPU-0 takes a nap
> I suppose.
> 
> Let me think about this a little more...

Does the below cure things? It's not exactly pretty, but it could just
do the trick.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dfc4bab0b02b..d496e6911442 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2009,8 +2009,8 @@ event_sched_out(struct perf_event *event,
 	event->pmu->del(event, 0);
 	event->oncpu = -1;
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
+	if (event->pending_disable == smp_processor_id()) {
+		event->pending_disable = -1;
 		state = PERF_EVENT_STATE_OFF;
 	}
 	perf_event_set_state(event, state);
@@ -2198,7 +2198,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 
 void perf_event_disable_inatomic(struct perf_event *event)
 {
-	event->pending_disable = 1;
+	event->pending_disable = smp_processor_id();
 	irq_work_queue(&event->pending);
 }
 
@@ -5822,8 +5822,8 @@ static void perf_pending_event(struct irq_work *entry)
 	 * and we won't recurse 'further'.
 	 */
 
-	if (event->pending_disable) {
-		event->pending_disable = 0;
+	if (event->pending_disable == smp_processor_id()) {
+		event->pending_disable = -1;
 		perf_event_disable_local(event);
 	}
 
@@ -10236,6 +10236,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 
 	init_waitqueue_head(&event->waitq);
+	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
 
 	mutex_init(&event->mmap_mutex);
