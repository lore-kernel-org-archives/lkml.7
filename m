Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34725C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2C92133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVbeQ6xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDKNEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:04:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aD933i4Wj9PjridmEAUhVomweZfmpjsmm/0HQqxO1Y8=; b=bVbeQ6xrMruQYyuLRfvKrsppY
        cXKFfQPN8NRMELmecJvA8Q5/+lQJ/f3d6aLTgjnTRdqALrJiRl6cmVaCBX27/xSlyBOMzJn0nrQBp
        ZIZn6wyI7MdTi+yBPdPLM6fVZAJbBEy+OoA+7aMqjM8gbAoJOUWGKV4zxIs7QEA5icn15m+hQJDtJ
        3fKd9Aq1CfOQtmPEjKkRW4P51i7IH8Qq1AlEzVazGAhMdKr6TnDO+TWMtwC+TWrV1ozTYvOlhl99B
        qQgkZ2LJimzzvRoFzkaXudyOn7Q40kDUXA7aPBqtEsywZBH9KcYIdxiWDnAnh+HKlYRF2PPLH0Mri
        I2TeTaBdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEZNc-0002ZD-HK; Thu, 11 Apr 2019 13:04:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49E8229AABF40; Thu, 11 Apr 2019 15:04:34 +0200 (CEST)
Date:   Thu, 11 Apr 2019 15:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mark.rutland@arm.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, brueckner@linux.ibm.com,
        torvalds@linux-foundation.org, alexander.shishkin@linux.intel.com,
        heiko.carstens@de.ibm.com, tmricht@linux.ibm.com,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, jolsa@redhat.com, hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/core: Fix perf_event_disable_inatomic()
 race
Message-ID: <20190411130434.GD11158@hirez.programming.kicks-ass.net>
References: <tip-86071b11317550d994b55ce5e31aa06bcad783b5@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-86071b11317550d994b55ce5e31aa06bcad783b5@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 05:13:54AM -0700, tip-bot for Peter Zijlstra wrote:
> Commit-ID:  86071b11317550d994b55ce5e31aa06bcad783b5
> Gitweb:     https://git.kernel.org/tip/86071b11317550d994b55ce5e31aa06bcad783b5
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Thu, 4 Apr 2019 15:03:00 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 10 Apr 2019 13:47:09 +0200
> 
> perf/core: Fix perf_event_disable_inatomic() race
> 
> Thomas-Mich Richter reported he triggered a WARN()ing from event_function_local()
> on his s390. The problem boils down to:
> 
> 	CPU-A				CPU-B
> 
> 	perf_event_overflow()
> 	  perf_event_disable_inatomic()
> 	    @pending_disable = 1
> 	    irq_work_queue();
> 
> 	sched-out
> 	  event_sched_out()
> 	    @pending_disable = 0
> 
> 					sched-in
> 					perf_event_overflow()
> 					  perf_event_disable_inatomic()
> 					    @pending_disable = 1;
> 					    irq_work_queue(); // FAILS
> 
> 	irq_work_run()
> 	  perf_pending_event()
> 	    if (@pending_disable)
> 	      perf_event_disable_local(); // WHOOPS
> 
> The problem exists in generic, but s390 is particularly sensitive
> because it doesn't implement arch_irq_work_raise(), nor does it call
> irq_work_run() from it's PMU interrupt handler (nor would that be
> sufficient in this case, because s390 also generates
> perf_event_overflow() from pmu::stop). Add to that the fact that s390
> is a virtual architecture and (virtual) CPU-A can stall long enough
> for the above race to happen, even if it would self-IPI.
> 
> Adding a irq_work_sync() to event_sched_in() would work for all hardare
> PMUs that properly use irq_work_run() but fails for software PMUs.
> 
> Instead encode the CPU number in @pending_disable, such that we can
> tell which CPU requested the disable. This then allows us to detect
> the above scenario and even redirect the IPI to make up for the failed
> queue.

Ingo, could you please fold in the below delta? It turns out I
overlooked two insteances :-(

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -392,7 +392,7 @@ void *perf_aux_output_begin(struct perf_
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = 1;
+			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
 			local_set(&rb->aux_nest, 0);
 			goto err_put;
@@ -480,7 +480,7 @@ void perf_aux_output_end(struct perf_out
 
 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = 1;
+			handle->event->pending_disable = smp_processor_id();
 		perf_output_wakeup(handle);
 	}
 
