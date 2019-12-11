Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7163DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323DB2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvJifS9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfLKQ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:29:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729377AbfLKQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576081768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjHPK8JEPFBs1EYFKmzchbOHjalPkcJFICCdbspA0Is=;
        b=OvJifS9/O9/ytKV6/C/iN8v7hl1SzkyYjF8J2haaMI3bWs5VwcKYwhNJTLqU9ZrgA5FBHu
        E2AXi6jEpdt9tmosngUw0+rjU+EkhbdQaXnxSr1Fi2InRUZT9/BDAuMY9OG1+1H6U91Mzp
        gZgmGl/aY0mxXRTptJJvrkLQkvlCHVs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-NdTD4yFiPJGdpSBVnCKB7g-1; Wed, 11 Dec 2019 11:29:27 -0500
X-MC-Unique: NdTD4yFiPJGdpSBVnCKB7g-1
Received: by mail-qk1-f199.google.com with SMTP id a6so14910040qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjHPK8JEPFBs1EYFKmzchbOHjalPkcJFICCdbspA0Is=;
        b=j4V5i/QJAUrOP4ihI0AZyn53BfaeXnVye3lcf/sLYlEOdfg8SEdyWqDpe8ZdxHpKF/
         a0i4yGkvn7K5InoqoyFpRzzc5JTE5HFF60QJkOOm/PMoz+wCREZFobPPsK0WPPAZGaAH
         zgqiWDZ0Zhdts1OKrhjJdijfyoxo7lQdZK8BAwdUFhcs7QKKkGZrd2xoavCRNTS0srH3
         c0TVZfPoU1k+A1luW2kpyvzb/fPeHJUBxbY/ZTCr1Evh2w3Kj8r1qrbRve/4tyJI66dv
         9i94EL7xBWlQrI40Wp6WY/tbaZl1wox6VTMohVUBF4un/GMOAdzZtQNire12EmI55udi
         Q04g==
X-Gm-Message-State: APjAAAWAwO7lHUf/YpKWA4yiq5JPKVsJSIiPPz/bKGqHrIZGu8UI53Uo
        SA594FrOBKGFproOnC0czcGz2LCT06kk59kChNjXKHKt6Dr6KKa1k25V+CGXIy5qHU0/N6KxVp9
        nragP71N3q/Rnu111w2RUWxO7
X-Received: by 2002:ad4:4dc3:: with SMTP id cw3mr3859715qvb.130.1576081767237;
        Wed, 11 Dec 2019 08:29:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzs/nC3KBBr4GvPRFt/0NZq4RcwrMSGEDrh3F6FSZyuV/K585i/pJUZUtc8AfTbNXAbMhO3tw==
X-Received: by 2002:ad4:4dc3:: with SMTP id cw3mr3859680qvb.130.1576081766883;
        Wed, 11 Dec 2019 08:29:26 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q34sm1072239qtc.33.2019.12.11.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:29:26 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:29:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: Allow smp_call_function_single_async() to insert
 locked csd
Message-ID: <20191211162925.GD48697@xz-x1>
References: <20191204204823.1503-1-peterx@redhat.com>
 <20191211154058.GO2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211154058.GO2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:40:58PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 04, 2019 at 03:48:23PM -0500, Peter Xu wrote:
> > Previously we will raise an warning if we want to insert a csd object
> > which is with the LOCK flag set, and if it happens we'll also wait for
> > the lock to be released.  However, this operation does not match
> > perfectly with how the function is named - the name with "_async"
> > suffix hints that this function should not block, while we will.
> > 
> > This patch changed this behavior by simply return -EBUSY instead of
> > waiting, at the meantime we allow this operation to happen without
> > warning the user to change this into a feature when the caller wants
> > to "insert a csd object, if it's there, just wait for that one".
> > 
> > This is pretty safe because in flush_smp_call_function_queue() for
> > async csd objects (where csd->flags&SYNC is zero) we'll first do the
> > unlock then we call the csd->func().  So if we see the csd->flags&LOCK
> > is true in smp_call_function_single_async(), then it's guaranteed that
> > csd->func() will be called after this smp_call_function_single_async()
> > returns -EBUSY.
> > 
> > Update the comment of the function too to refect this.
> > 
> > CC: Marcelo Tosatti <mtosatti@redhat.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Nadav Amit <namit@vmware.com>
> > CC: Josh Poimboeuf <jpoimboe@redhat.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > The story starts from a test where we've encountered the WARN_ON() on
> > a customized kernel and the csd_wait() took merely forever to
> > complete (so we've got a WARN_ON plusing a hang host).  The current
> > solution (which is downstream-only for now) is that from the caller's
> > side we use a boolean to store whether the csd is executed, we do:
> > 
> >   if (atomic_cmpxchg(&in_progress, 0, 1))
> >     smp_call_function_single_async(..);
> > 
> > While at the end of csd->func() we clear the bit.  However imho that's
> > mostly what csd->flags&LOCK is doing.  So I'm thinking maybe it would
> > worth it to raise this patch for upstream too so that it might help
> > other users of smp_call_function_single_async() when they need the
> > same semantic (and, I do think we shouldn't wait in _async()s...)
> 
> hrtick_start() seems to employ something similar.

True.  More "statistics" below.

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> duplicate tag :-)

Oops, I'll remove that when I repost (of course, if at least any of
you would still like me to repost :).

> 
> > ---
> >  kernel/smp.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 7dbcb402c2fc..dd31e8228218 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -329,6 +329,11 @@ EXPORT_SYMBOL(smp_call_function_single);
> >   * (ie: embedded in an object) and is responsible for synchronizing it
> >   * such that the IPIs performed on the @csd are strictly serialized.
> >   *
> > + * If the function is called with one csd which has not yet been
> > + * processed by previous call to smp_call_function_single_async(), the
> > + * function will return immediately with -EBUSY showing that the csd
> > + * object is still in progress.
> > + *
> >   * NOTE: Be careful, there is unfortunately no current debugging facility to
> >   * validate the correctness of this serialization.
> >   */
> > @@ -338,14 +343,17 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
> >  
> >  	preempt_disable();
> >  
> > -	/* We could deadlock if we have to wait here with interrupts disabled! */
> > -	if (WARN_ON_ONCE(csd->flags & CSD_FLAG_LOCK))
> > -		csd_lock_wait(csd);
> > +	if (csd->flags & CSD_FLAG_LOCK) {
> > +		err = -EBUSY;
> > +		goto out;
> > +	}
> >  
> >  	csd->flags = CSD_FLAG_LOCK;
> >  	smp_wmb();
> >  
> >  	err = generic_exec_single(cpu, csd, csd->func, csd->info);
> > +
> > +out:
> >  	preempt_enable();
> >  
> >  	return err;
> 
> Yes.. I think this will work.
> 
> I worry though; usage such as in __blk_mq_complete_request() /
> raise_blk_irq(), which explicitly clears csd.flags before calling it
> seems more dangerous than usual.
> 
> liquidio_napi_drv_callback() does that same.

This is also true.

Here's the statistics I mentioned:

=================================================

(1) Implemented the same counter mechanism on the caller's:

*** arch/mips/kernel/smp.c:
tick_broadcast[713]            smp_call_function_single_async(cpu, csd);
*** drivers/cpuidle/coupled.c:
cpuidle_coupled_poke[336]      smp_call_function_single_async(cpu, csd);
*** kernel/sched/core.c:
hrtick_start[298]              smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);

(2) Cleared the csd flags before calls:

*** arch/s390/pci/pci_irq.c:
zpci_handle_fallback_irq[185]  smp_call_function_single_async(cpu, &cpu_data->csd);
*** block/blk-mq.c:
__blk_mq_complete_request[622] smp_call_function_single_async(ctx->cpu, &rq->csd);
*** block/blk-softirq.c:
raise_blk_irq[70]              smp_call_function_single_async(cpu, data);
*** drivers/net/ethernet/cavium/liquidio/lio_core.c:
liquidio_napi_drv_callback[735] smp_call_function_single_async(droq->cpu_id, csd);

(3) Others:

*** arch/mips/kernel/process.c:
raise_backtrace[713]           smp_call_function_single_async(cpu, csd);
*** arch/x86/kernel/cpuid.c:
cpuid_read[85]                 err = smp_call_function_single_async(cpu, &csd);
*** arch/x86/lib/msr-smp.c:
rdmsr_safe_on_cpu[182]         err = smp_call_function_single_async(cpu, &csd);
*** include/linux/smp.h:
bool[60]                       int smp_call_function_single_async(int cpu, call_single_data_t *csd);
*** kernel/debug/debug_core.c:
kgdb_roundup_cpus[272]         ret = smp_call_function_single_async(cpu, csd);
*** net/core/dev.c:
net_rps_send_ipi[5818]         smp_call_function_single_async(remsd->cpu, &remsd->csd);

=================================================

For (1): These probably justify more on that we might want a patch
         like this to avoid reimplementing it everywhere.

For (2): If I read it right, smp_call_function_single_async() is the
         only place where we take a call_single_data_t structure
         rather than the (smp_call_func_t, void *) tuple.  I could
         miss something important, but otherwise I think it would be
         good to use the tuple for smp_call_function_single_async() as
         well, then we move call_single_data_t out of global header
         but move into smp.c to avoid callers from toucing it (which
         could be error-prone).  In other words, IMHO it would be good
         to have all these callers fixed.

For (3): I didn't dig, but I think some of them (or future users)
         could still suffer from the same issue on retriggering the
         WARN_ON... 

Thoughts?

Thanks,

-- 
Peter Xu

