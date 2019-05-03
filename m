Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50ABC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54BA2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJtc9x1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfECQvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:51:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfECQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JSfZSnhfLCwq3EF/rm18mhgrZ/mBAr/9qLKvmGZ7e5k=; b=CJtc9x1sJgOtGIK9SdEtVPDuI
        F2V22cSUt6ciyaMob3D8mwSPgcQ91uhQMCrpA2bOrk66deDHvhEV5GIzSa9kVeslpUvkxGKHjOPd4
        5Mm4u/onI46AhS5Vg4bmqVTBYrvAOYB+1OlVfq+7OUJW6fupcUbgGsKbfsiGfYpK5hT547t5Ke1ht
        DEXfZBjnSPKCTBMTw2vyQBqrtUxZpBYRfe2gtGQrOQHTe9+rp2GI+HwYYL+uBGZ4bAuz5uvXDhBgb
        ns3BNPF33DgtCBY/KRNOk9m09OF/BT77lRrjkcHIH+EViQeOHeMOZHnx8Rq49FbaA27LRlQA8OZ1p
        6UiEx2b6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMbPS-0007fd-Ox; Fri, 03 May 2019 16:51:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43CCB286B6533; Fri,  3 May 2019 18:51:41 +0200 (CEST)
Date:   Fri, 3 May 2019 18:51:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v7 11/20] locking/rwsem: Wake up almost all readers
 in wait queue
Message-ID: <20190503165141.GI2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-12-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428212557.13482-12-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 05:25:48PM -0400, Waiman Long wrote:
> When the front of the wait queue is a reader, other readers
> immediately following the first reader will also be woken up at the
> same time. However, if there is a writer in between. Those readers
> behind the writer will not be woken up.

> @@ -345,13 +359,20 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>  	 * 2) For each waiters in the new list, clear waiter->task and
>  	 *    put them into wake_q to be woken up later.
>  	 */
> -	list_for_each_entry(waiter, &sem->wait_list, list) {
> +	INIT_LIST_HEAD(&wlist);
> +	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
>  		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
> -			break;
> +			continue;
>  
>  		woken++;
> +		list_move_tail(&waiter->list, &wlist);
> +
> +		/*
> +		 * Limit # of readers that can be woken up per wakeup call.
> +		 */
> +		if (woken >= MAX_READERS_WAKEUP)
> +			break;
>  	}
> -	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
>  
>  	adjustment = woken * RWSEM_READER_BIAS - adjustment;
>  	lockevent_cond_inc(rwsem_wake_reader, woken);

An idea for later; maybe we can simplify this by playing silly games
with the queueing.

Writers: always list_add_tail()
Readers: keep a pointer to first_reader in the queue;
	 when NULL; list_add_tail() and set
	 otherwise: list_add_tail(, first_reader);

Possily also keep a count of first_reader list size, and if 'big' reset
first_reader.

That way we never have to skip over writers.

