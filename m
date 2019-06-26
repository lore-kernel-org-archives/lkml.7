Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A745C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C77F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yka6dmsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFZWsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:48:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49396 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfFZWsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cSOYeJb33t5DLExxhAnhlCHJrYRdxM+QS30ifzE4/kw=; b=Yka6dmsWLTG8z6U+LsrlGtKwK
        5CXuIC6g42C8cu14FDBm4T2FozEHZPDR0A2GeObyaCB86sZxW4UsqhtKvcvn+XwIvJsZp4hZ0mZqT
        PvT5oaV8CGsU19XHPYWZ19grhmB1cgcD55b663KSHfQAccP/qrjKaNBXYXiVtuxVIVU28pwCwWdva
        dNaMcukltXVzYLm+2qe6HczbUkRGtAl4PmgWyPFJ4FNo1OOVDNKjePrJuYOsdEDoS3TVqfoRHtdm7
        qjARXbRgaao/iQYdLtKy84oLQYe8mhJn5jPoqzlzA9pudgFiw97vHPZFjjBDJzgUwNmNtaLCpfDue
        ugPlGTxag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgGhU-0002yx-3d; Wed, 26 Jun 2019 22:47:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6A4A98198F; Thu, 27 Jun 2019 00:47:03 +0200 (CEST)
Date:   Thu, 27 Jun 2019 00:47:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626224703.GL2490@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1df28x4.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:23:19AM +0200, John Ogness wrote:
> On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
> >> +
> >> +	if (unlikely(newest_id == EOL)) {
> >> +		/* no previous newest means we *are* the list, set oldest */
> >> +
> >> +		/*
> >> +		 * MB UNPAIRED
> >
> > That's a bug, MB must always be paired.
> 
> Well, it "pairs" with the smp_rmb() of the readers, but I didn't think
> that counts as a pair. That's why I wrote unpaired. The litmus test is:
> 
> P0(int *x, int *y)
> {
>         WRITE_ONCE(*x, 1);
>         smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y)
> {
>         int rx;
>         int ry;
> 
>         ry = READ_ONCE(*y);
>         smp_rmb();
>         rx = READ_ONCE(*x);
> }
> 
> exists (1:rx=0 /\ 1:ry=1)
> 
> The readers rely on the store_releases "pairing" with the smp_rmb() so
> that the readers see things in a sane order.

That is certainly a valid pairing, see also the 'SMP BARRIER PAIRING'
section in memory-barriers.txt (I thought we had a table in there, but
apparently that never quite made it in).
