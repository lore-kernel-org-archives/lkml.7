Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F7EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3EE2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IkmKMN4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFZVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:16:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gvmyRW50uYuz0LuvATyGPI0uW8SQvuUBVNqYusKK+Z8=; b=IkmKMN4B7L6D5gS8CGrtJk7BZ
        fxgCWW7+kGMiO8AO+KdV6K5MZALERUxDLgH7Rquq/DoacO59k4sClrSHn88mILg7iihclmh7KYCU4
        rKJfzSFTpVnjKVqXKgSsEtZT+xkxahDHYaKHjuSfQXuuO39KuFLNA2AVZ9/0FAXOIDRFPrxnrNDV+
        FU/OEqUxR+P0mKZJk7LtDVKGlvsNic4+8aZ4xRAcBm9A5bpsq/G46sP5LE0K7Hgd8/+MjE6+45f78
        5aIXfQKIj/FNJPCUf4Az1CbLgMQkGIzMkAhKem/pmHOt+lFzbGppJMjiWVX5sAP61Rs1R8FrqMDOX
        l/xRueJZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgFH8-00026c-3W; Wed, 26 Jun 2019 21:16:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE44498198F; Wed, 26 Jun 2019 23:16:10 +0200 (CEST)
Date:   Wed, 26 Jun 2019 23:16:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626211610.GY7905@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <87d0j31iyc.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0j31iyc.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:33:15AM +0200, John Ogness wrote:
> Here are the writer-relevant memory barriers and their associated
> variables:
> 
> MB1: data_list.oldest
> MB2: data_list.newest
> MB3: data_block.id
> MB4: descr.data_next
> MB5: descr_list.newest
> MB6: descr.next

I think this is the fundamental divergence in parlance.

You seem to associate a barrier with a (single) variable, where normally
a barrier is between two (or more) variables.

As you wrote in that other email (I'm stlil going through all that);
your MB5 isn't desc_list.newest, but rather between desc_list.newest and
descr.next.

Remember, the topic is called 'memory ordering', and you cannot order
singles.
