Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328FA2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BxSg29KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfEINFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:05:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEINFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0BxG/P6nTaRHuqfrtLoIVS1BNNS5MjTMtFgzd0GUMd4=; b=BxSg29KQW/uKNfhjMWs5rtImU
        8kmU1YHUsnPgLAdVsq7IajVexZeJhCQmXXFr4xSyw93bYdvLNKDtXaNRluD5dvJw6cLW8Bwcp0dgT
        LxU2aHHRDS349X+b3z724lYmmmDfu8MQnJYG2Icn3+8YzFITQhpgbF+zVebP/wHIajnu6kaqY4qwG
        5QChwJRn2PqG4xZlcjH1gpU8QXTCWBHwubaGzgMLDX4EiIV5TSe6sUrhdNCDBi/n/nDD+g0T2cfSC
        Sij+nfh51Y9j9s/s4oS3COZ4ee/dxE2UNxG/Ixygrc7c8HkWIjOfomFA3j+X5IGFped/HqPYyET2X
        EwxMimN9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOijS-0003Ib-KB; Thu, 09 May 2019 13:05:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28E9222158202; Thu,  9 May 2019 15:05:04 +0200 (CEST)
Date:   Thu, 9 May 2019 15:05:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [Intel-gfx] [PATCH] RFC: console: hack up console_lock more v2
Message-ID: <20190509130504.GW2623@hirez.programming.kicks-ass.net>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190506074553.21464-1-daniel.vetter@ffwll.ch>
 <155739797736.28545.2942646931608459049@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155739797736.28545.2942646931608459049@skylake-alporthouse-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:32:57AM +0100, Chris Wilson wrote:
> Quoting Daniel Vetter (2019-05-06 08:45:53)
> > +/**
> > + * printk_safe_up - release the semaphore in console_unlock
> > + * @sem: the semaphore to release
> > + *
> > + * Release the semaphore.  Unlike mutexes, up() may be called from any
> > + * context and even by tasks which have never called down().
> > + *
> > + * NOTE: This is a special version of up() for console_unlock only. It is only
> > + * safe if there are no killable, interruptible or timing out down() calls.
> > + */
> > +void printk_safe_up(struct semaphore *sem)
> > +{
> > +       unsigned long flags;
> > +       struct semaphore_waiter *waiter = NULL;
> > +
> > +       raw_spin_lock_irqsave(&sem->lock, flags);
> > +       if (likely(list_empty(&sem->wait_list))) {
> > +               sem->count++;
> > +       } else {
> > +               waiter = list_first_entry(&sem->wait_list,
> > +                                         struct semaphore_waiter, list);
> > +               list_del(&waiter->list);
> > +               waiter->up = true;
> > +       }
> > +       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > +
> > +       if (waiter)
> > +               wake_up_process(waiter->task);
> 
> From comparing against __down_common() there's a risk here that as soon
> as waiter->up == true, the waiter may complete and make the onstack
> struct semaphore_waiter invalid. If you store waiter->task locally under
> the spinlock that problem is resolved.
> 
> Then there is the issue of an unprotected dereference of the task in
> wake_up_process() -- I think you can wrap this function with
> rcu_read_lock() to keep that safe, and wake_up_process() should be a
> no-op if it races against process termination.

task_struct is not RCU protected, see task_rcu_dereference() for magic.
