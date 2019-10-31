Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B688BCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CEE20650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXqyOsFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJaGL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:11:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJaGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ekyP2u6hl4dU0Fr2OI4p0LhZwndQzmbkhUAM9FQpt6M=; b=PXqyOsFpyMZnvidiE7SgWVtw8
        TGABJjEmsr0FJaZO9i3CAgkERYuCZ2rPcmLXB+TYnGKBycqGUm96Ptkb40GOFo78CRG4bcWLppCDj
        up6QW46OxyR0oRi5Cdzy8ydYnHJk+B8RLVmGuUG2eMpRJoURwC9qYeznY3k1QcS/IxysxvhH2erUp
        svIAwgeXMmUmOmnHel7rCm3VOoA2QNkIfyLF9BFIb/3O2bsF1voqIfvpUwTE9HlEwaQEFknRi36HS
        p4/YFOf/Y1CmqiV65yCvmvcW5cS6bnniZ/wqVAQ2GSuXLc8yq9V8T+vEtNl+m8jqIcMENU/d3+XX4
        cFZDWuCbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQ3g2-0008CD-9k; Thu, 31 Oct 2019 06:11:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1411C30025A;
        Thu, 31 Oct 2019 07:10:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 866B12B40326C; Thu, 31 Oct 2019 07:11:18 +0100 (CET)
Date:   Thu, 31 Oct 2019 07:11:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20191031061118.GH5671@hirez.programming.kicks-ass.net>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
 <20190806161741.GC21454@redhat.com>
 <20190806171515.GR2349@hirez.programming.kicks-ass.net>
 <20190807095657.GA24112@redhat.com>
 <20191029184739.GA3079@worktop.programming.kicks-ass.net>
 <20191030175231.GF5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030175231.GF5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:52:31PM +0100, Peter Zijlstra wrote:
> +enum wake_state {
> +	unknown = -1,
> +	writer = 0,
> +	reader = 1,
> +};
> +
> +/*
> + * percpu_rwsem_wake_function -- provide FIFO fair reader/writer wakeups
> + *
> + * As per percpu_rwsem_wait() all waiters are queued exclusive (tail/FIFO)
> + * without autoremove to preserve FIFO order.
> + */
> +static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
> +				      unsigned int mode, int wake_flags,
> +				      void *key)
> +{
> +	enum wake_state state = (wq_entry->flags & WQ_FLAG_CUSTOM) ? reader : writer;
> +	enum wake_state *statep = key;
> +
> +	if (*statep != unknown && (*statep == writer || state == writer))
> +		return 1; /* stop; woken 1 writer or exhausted readers */
> +
> +	if (default_wake_function(wq_entry, mode, wake_flags, NULL))
> +		*statep = state;
> +
> +	return 0; /* continue waking */
> +}
> +
> +#define percpu_rwsem_wait(sem, reader, cond)				\
> +do {									\
> +	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);		\
> +									\
> +	if (reader)							\
> +		wq_entry.flags |= WQ_FLAG_CUSTOM;			\
> +									\
> +	add_wait_queue_exclusive(&(sem)->waiters, &wq_entry);		\
> +	for (;;) {							\
> +		set_current_state(TASK_UNINTERRUPTIBLE);		\
> +		if (cond)						\
> +			break;						\
> +		schedule();						\
> +	}								\
> +	__set_current_state(TASK_RUNNING);				\
> +	remove_wait_queue(&(sem)->waiters, &wq_entry);			\
> +} while (0)
> +
> +#define percpu_rwsem_wake(sem)						\
> +do {									\
> +	enum wake_state ____state = unknown;				\
> +	__wake_up(&(sem)->waiters, TASK_NORMAL, 1, &____state);		\
> +} while (0)

That isn't quite right, when it has readers and a pending writer, things
go sideways.

I'm going to have to poke a little more at this.
