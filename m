Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53987C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3F4206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfH0PH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfH0PH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:07:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA3C6ACC3;
        Tue, 27 Aug 2019 15:07:26 +0000 (UTC)
Date:   Tue, 27 Aug 2019 17:07:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190827150725.scfaegg74mzqiqxw@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <878srfo8pp.fsf@linutronix.de>
 <20190827074057.2qybpmvfueub3ztl@pathway.suse.cz>
 <87mufuvg0o.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mufuvg0o.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-08-27 16:28:55, John Ogness wrote:
> On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
> >> On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
> >>>> --- /dev/null
> >>>> +++ b/kernel/printk/numlist.c
> >>>> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
> >>>> +{
> > [...]
> >>>> +
> >>>> +	/* bB: #1 */
> >>>> +	head_id = atomic_long_read(&nl->head_id);
> >>>> +
> >>>> +	for (;;) {
> >>>> +		/* bC: */
> >>>> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
> >>>> +			/*
> >>>> +			 * @head_id is invalid. Try again with an
> >>>> +			 * updated value.
> >>>> +			 */
> >>>> +
> >>>> +			cpu_relax();
> >>>
> >>> I have got very confused by this. cpu_relax() suggests that this
> >>> cycle is busy waiting until a particular node becomes valid.
> >>> My first though was that it must cause deadlock in NMI when
> >>> the interrupted code is supposed to make the node valid.
> >>>
> >>> But it is the other way. The head is always valid when it is
> >>> added to the list. It might become invalid when another CPU
> >>> moves the head and the old one gets reused.
> >>>
> >>> Anyway, I do not see any reason for cpu_relax() here.
> >> 
> >> You are correct. The cpu_relax() should not be there. But there is
> >> still an issue that this could spin hard if the head was recycled and
> >> this CPU does not yet see the new head value.
> >
> > I do not understand this. The head could get reused only after
> > head_id was replaced with the following valid node.
> > The next cycle is done with a new id that should be valid.
> >
> > Of course, the new ID might get reused as well. But then we just
> > repeat the cycle. We have to be able to find a valid head after
> > few cycles. The last valid ID could not get reused because nodes
> > can be removed only if was not the last valid node.
> 
> Sorry, I was not very precise with my language. I will try again...
> 
> nl->head_id is read using a relaxed read.

I wonder if the "relaxed read" causes the confusion. Could it read
the old id even when numlist_read() for this id failed?

If this is true then it should not be relaxed read.


> A second CPU may have added new nodes and removed/recycled
> the node with the ID that the first CPU read as the head.

This sounds like ABA problem. My understanding is that we
use ID to prevent these problems and could ignore them.


> As a result, the first CPU's numlist_read() will (correctly) fail. If
> numlist_read() failed in the first node() callback within numlist_read()
> (i.e. it sees that the node already has a new ID), there is no guarantee
> that rereading the head ID will provide a new ID. At some point the
> memory system would make the new head ID visible, but there could be
> some heavy spinning until that happens.
>
> Here is a litmus test showing the problem (using comments and verbose
> variable names):
> 
> C numlist_push_loop
> 
> {
> 	int node1 = 1;
> 	int node2 = 2;
> 	int *numlist_head = &node1;
> }
> 
> P0(int **numlist_head)
> {
> 	int *head;
> 	int id;
> 
> 	// read head ID
> 	head = READ_ONCE(*numlist_head);
> 
> 	// read head node ID
> 	id = READ_ONCE(*head);
> 
> 	// re-read head ID when node ID is unexpected
> 	head = READ_ONCE(*numlist_head);
> }
> 
> P1(int **numlist_head, int *node1, int *node2)
> {
> 	int *r0;
> 
> 	// push node2
> 	r0 = cmpxchg_release(numlist_head, node1, node2);
> 
> 	// pop node1, reassigning a new ID
> 	smp_store_release(node1, 3);
> }

I think that the Litmus test does not describe the code.
If it does then we need to fix the algorithm or barriers.

> The results show that P0 sees the head is node1 but also sees that
> node1's ID has changed. (And if node1's ID changed, it means P1 had
> previously replaced the head.) If P0 ran in a while-loop, at some point
> it _would_ see that node2 is now the head. But that is wasteful spinning
> and may possibly have negative influence on the memory system.

My undestanding is that only valid nodes are added to the list.

If a node read via head_id is not valid then head_id already
points to another valid node. Am I wrong, please?

Best Regards,
Petr
