Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44313C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF0I2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfF0I2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:28:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A314AF51;
        Thu, 27 Jun 2019 08:28:04 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:28:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190627082803.7aduwbwxwejyhgan@pathway.suse.cz>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
 <87d0j31iyc.fsf@linutronix.de>
 <20190626211610.GY7905@worktop.programming.kicks-ass.net>
 <87k1d8koo3.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1d8koo3.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-06-26 23:43:56, John Ogness wrote:
> Here is where I have massive problems communicating. I don't understand
> why you say the barrier is _between_ newest and next. I would say the
> barrier is _on_ newest to _synchronize_ with next (or something). I am
> struggling with terminology. (To be honest, I'd much rather just post
> litmus tests.)
> 
> For example, if we have:
> 
> WRITE_ONCE(&a, 1);
> WRITE_ONCE(&b, 1);
> WRITE_ONCE(&c, 1);
> smp_store_release(&d, 1);
> 
> and:
> 
> local_d = smp_load_acquire(&d);
> local_a = READ_ONCE(&a);
> local_b = READ_ONCE(&b);
> local_c = READ_ONCE(&c);
> 
> How do you describe that? Do you say the memory barrier is between a and
> d? Or between a, b, c, d? (a, b, c aren't ordered, but they are one-way
> synchronized with d).
> 
> I would say there is a barrier on d to synchronize a, b, c.

Barriers are always paired. We need to know what variables are
synchonized against each other, what is the reason and where
is the counter part.

I think that it might be done many ways. I am familiar with
bariers in kernel/livepatch/ code. They use rather long description.
But I find it pretty useful especially when the problem is
complicated and more bariers are involved in a single
transition.

Best Regards,
Petr
