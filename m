Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801AEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0F32053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfHZOLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:11:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbfHZOLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:11:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18760AC32;
        Mon, 26 Aug 2019 14:10:59 +0000 (UTC)
Date:   Mon, 26 Aug 2019 16:10:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190826141058.y6idkqpjqkpbv5s7@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <20190826083436.GA3047@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826083436.GA3047@andrea>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-08-26 10:34:36, Andrea Parri wrote:
> > > +	/*
> > > +	 * bA:
> > > +	 *
> > > +	 * Setup the node to be a list terminator: next_id == id.
> > > +	 */
> > > +	WRITE_ONCE(n->next_id, id);
> > 
> > Do we need WRITE_ONCE() here?
> > Both "n" and "id" are given as parameters and do not change.
> > The assigment must be done before "id" is set as nl->head_id.
> > The ordering is enforced by cmpxchg_release().
> 
> (Disclaimer: this is still a very much debated issue...)
> 
> According to the LKMM, this question boils down to the question:
> 
>   Is there "ordering"/synchronization between the above access and
>   the "matching accesses" bF and aA' to the same location?
> 
> Again according to the LKMM's analysis, such synchronization is provided
> by the RELEASE -> "reads-from" -> ADDR relation.  (Encoding address dep.
> in litmus tests is kind of tricky but possible, e.g., for the pattern in
> question, we could write/model as follows:
> 
> C S+ponarelease+addroncena
> 
> {
> 	int *y = &a;
> }
> 
> P0(int *x, int **y, int *a)
> {
> 	int *r0;
> 
> 	*x = 2;
> 	r0 = cmpxchg_release(y, a, x);
> }
> 
> P1(int *x, int **y)
> {
> 	int *r0;
>
> 	r0 = READ_ONCE(*y);
> 	*r0 = 1;
> }
> 
> exists (1:r0=x /\ x=2)

Which r0 the above exists rule refers to, please?
Do both P0 and P1 define r0 by purpose?

> Then
> 
>   $ herd7 -conf linux-kernel.cfg S+ponarelease+addroncena
>   Test S+ponarelease+addroncena Allowed
>   States 2
>   1:r0=a; x=2;
>   1:r0=x; x=1;
>   No
>   Witnesses
>   Positive: 0 Negative: 2
>   Condition exists (1:r0=x /\ x=2)
>   Observation S+ponarelease+addroncena Never 0 2
>   Time S+ponarelease+addroncena 0.01
>   Hash=7eaf7b5e95419a3c352d7fd50b9cd0d5
> 
> that is, the test is not racy and the "exists" clause is not satisfiable
> in the LKMM.  Notice that _if the READ_ONCE(*y) in P1 were replaced by a
> plain read, then we would obtain:
> 
>   Test S+ponarelease+addrnana Allowed
>   States 2
>   1:r0=x; x=1;
>   1:r0=x; x=2;

Do you have any explanation how r0=x; x=2; could happen, please?

Does the ommited READ_ONCE allows to do r0 = (*y) twice
before and after *r0 = 1?
Or the two operations P1 can be called in any order?

I am sorry if it obvious. Feel free to ask me to re-read Paul's
articles on LWN more times or point me to another resources.



>   Ok
>   Witnesses
>   Positive: 1 Negative: 1
>   Flag data-race		[ <-- the LKMM warns about a data-race ]
>   Condition exists (1:r0=x /\ x=2)
>   Observation S+ponarelease+addrnana Sometimes 1 1
>   Time S+ponarelease+addrnana 0.00
>   Hash=a61acf2e8e51c2129d33ddf5e4c76a49
> 
> N.B. This analysis generally depends on the assumption that every marked
> access (e.g., the cmpxchg_release() called out above and the READ_ONCE()
> heading the address dependencies) are _single-copy atomic, an assumption
> which has been recently shown to _not be valid in such generality:
> 
>   https://lkml.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck

So, it might be even worse. Do I get it correctly?

Best Regards,
Petr

