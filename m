Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05856C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B1F20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8RpHyZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLQK2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:28:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UEBFjFglUYEwUag/Y8czbNk7NQSN0Ch4qTXNxLN/7Ss=; b=m8RpHyZr8fjTH9aK74TkyMBOs
        WAR/xNoyswNLSfuCNNHvhNbwaFxHaw34cS/zyF5p8h96utL95iAFRv/n579YTtauKFzG0isuAn2OZ
        4tNRnRXOh0K8ByhwGY4FZ3R4ShDYHgxZidGPIrrgIB4r5gABu8d5e66RUFpX8MLEvhE0oCcflEdGd
        VjZZyMB4yFYQjE2lvJBKG7vBcje48xrzm9yErcRnyZtPHcg6VTV1R7pjCg4ZvdU7EZ5NRX6kwqCuM
        uEv1ncZEg+f5EI0IHxo3pMEtEnWOF2qKiukkwyXhPviSStBv2GirhUnYhPSoqA4+1FTFlk0EuvLNe
        rzJiIA3zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihA5K-0004zz-Ou; Tue, 17 Dec 2019 10:28:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 017B93040CB;
        Tue, 17 Dec 2019 11:26:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E2B729E718CF; Tue, 17 Dec 2019 11:28:08 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:28:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191217102808.GO2871@hirez.programming.kicks-ass.net>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <ee75fc38-c3c8-3f9e-13ba-5c8312d61325@redhat.com>
 <20191119155826.GA4739@redhat.com>
 <20191217102654.GA2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217102654.GA2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:26:54AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 19, 2019 at 04:58:26PM +0100, Oleg Nesterov wrote:
> > On 11/19, Waiman Long wrote:
> > >
> > > On 11/13/19 5:21 AM, Peter Zijlstra wrote:
> > > > +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
> > > > +				      unsigned int mode, int wake_flags,
> > > > +				      void *key)
> > > > +{
> > > > +	struct task_struct *p = get_task_struct(wq_entry->private);
> > > > +	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
> > > > +	struct percpu_rw_semaphore *sem = key;
> > > > +
> > > > +	/* concurrent against percpu_down_write(), can get stolen */
> > > > +	if (!__percpu_rwsem_trylock(sem, reader))
> > > > +		return 1;
> > > > +
> > > > +	list_del_init(&wq_entry->entry);
> > > > +	smp_store_release(&wq_entry->private, NULL);
> > > > +
> > > > +	wake_up_process(p);
> > > > +	put_task_struct(p);
> > > > +
> > > > +	return !reader; /* wake 'all' readers and 1 writer */
> > > > +}
> > > > +
> > >
> > > If I read the function correctly, you are setting the WQ_FLAG_EXCLUSIVE
> > > for both readers and writers and __wake_up() is called with an exclusive
> > > count of one. So only one reader or writer is woken up each time.
> > 
> > This depends on what percpu_rwsem_wake_function() returns. If it returns 1,
> > __wake_up_common() stops, exactly because all waiters have WQ_FLAG_EXCLUSIVE.
> 
> Indeed, let me see if I can clarify that somehow.
> 
> > > However, the comment above said we wake 'all' readers and 1 writer. That
> > > doesn't match the actual code, IMO.
> > 
> > Well, "'all' readers" probably means "all readers before writer",
> 
> Correct.

Does this clarify?

--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -101,6 +101,19 @@ static bool __percpu_rwsem_trylock(struc
 	return __percpu_down_write_trylock(sem);
 }
 
+/*
+ * The return value of wait_queue_entry::func means:
+ *
+ *  <0 - error, wakeup is terminated and the error is returned
+ *   0 - no wakeup, a next waiter is tried
+ *  >0 - woken, if EXCLUSIVE, counted towards @nr_exclusive.
+ * 
+ * We use EXCLUSIVE for both readers and writers to preserve FIFO order,
+ * and play games with the return value to allow waking multiple readers.
+ *
+ * Specifically, we wake readers until we've woken a single writer, or until a
+ * trylock fails.
+ */
 static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
@@ -119,7 +132,7 @@ static int percpu_rwsem_wake_function(st
 	wake_up_process(p);
 	put_task_struct(p);
 
-	return !reader; /* wake 'all' readers and 1 writer */
+	return !reader; /* wake (readers until) 1 writer */
 }
 
 static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
