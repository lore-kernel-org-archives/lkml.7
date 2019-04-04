Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60948C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D2206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yhZ/F32D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfDDMNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:13:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDMNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HUwFP7TkC1YnjyowwteQRvNxlrkSBhJ8vJzEY4NX+W0=; b=yhZ/F32DVphy0uwCNAh5i/vH2
        Z9bZSOBK+RM9U1axD+QUv8/xlQbV4XOv9p4LEzyRdZNhMSLZB4TGDBgbeTQjO7fcFlcAk0eRVTN63
        byv+NPLoRNhlWRhYSFRCXtNr/SM8DBUCMobZiLvwZd3WXY+eOIsy3nX0n/ya8FjY1dB/r9yrsvBno
        9moWnRl/Umusc97FUVwzctUrgpOh+19yXzycYcAlRU+kgNqixHX9KTwMg0a33jkmP3nunXBzwxiwO
        FYfTIc0wrmYv5iNoTL0xi0ko3MsSqIgwLaFsGYS9Bc0Iz1kMG2pFqr0i8KsmJJy2WwBfRup1RNjMf
        7eSsmXD2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC1FS-0003I8-GF; Thu, 04 Apr 2019 12:13:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E143F2038C247; Thu,  4 Apr 2019 14:13:36 +0200 (CEST)
Date:   Thu, 4 Apr 2019 14:13:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190404121336.GE14281@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404120214.GD14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404120214.GD14281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:02:14PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 04, 2019 at 01:09:09PM +0200, Peter Zijlstra wrote:
> > That is not entirely the scenario I talked about, but *groan*.
> > 
> > So what I meant was:
> > 
> > 	CPU-0							CPU-n
> > 
> > 	__schedule()
> > 	  local_irq_disable()
> > 
> > 	  ...
> > 	    deactivate_task(prev);
> > 
> > 								try_to_wake_up(@p)
> > 								  ...
> > 								  smp_cond_load_acquire(&p->on_cpu, !VAL);
> > 
> > 	  <PMI>
> > 	    ..
> > 	    perf_event_disable_inatomic()
> > 	      event->pending_disable = 1;
> > 	      irq_work_queue() /* self-IPI */
> > 	  </PMI>
> > 
> > 	  context_switch()
> > 	    prepare_task_switch()
> > 	      perf_event_task_sched_out()
> > 	        // the above chain that clears pending_disable
> > 
> > 	    finish_task_switch()
> > 	      finish_task()
> > 	        smp_store_release(prev->on_cpu, 0);
> > 								  /* finally.... */
> > 								// take woken
> > 								// context_switch to @p
> > 	      finish_lock_switch()
> > 	        raw_spin_unlock_irq()
> > 		/* w00t, IRQs enabled, self-IPI time */
> > 	        <self-IPI>
> > 		  perf_pending_event()
> > 		    // event->pending_disable == 0
> > 		</self-IPI>
> > 
> > 
> > What you're suggesting, is that the time between:
> > 
> >   smp_store_release(prev->on_cpu, 0);
> > 
> > and
> > 
> >   <self-IPI>
> > 
> > on CPU-0 is sufficient for CPU-n to context switch to the task, enable
> > the event there, trigger a PMI that calls perf_event_disable_inatomic()
> > _again_ (this would mean irq_work_queue() failing, which we don't check)
> > (and schedule out again, although that's not required).
> > 
> > This being virt that might actually be possible if (v)CPU-0 takes a nap
> > I suppose.
> > 
> > Let me think about this a little more...
> 
> Arghh... s390 doesn't implement arch_irq_work_raise(), which makes it
> far far worse.
> 
> I have a hack that might've cured it, were it not for that. Let me think
> more still..

Could you educate me on the s390 PMU, afaict only the SF one has a
sampling interrupt (cpumf_measurement_alert), is that NMI-like or a
regular IRQ ?
