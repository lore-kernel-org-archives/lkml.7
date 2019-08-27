Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA4DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B872070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH0HlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfH0HlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:41:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25D36AFF2;
        Tue, 27 Aug 2019 07:41:00 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:40:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20190827074057.2qybpmvfueub3ztl@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <878srfo8pp.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878srfo8pp.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-08-27 00:36:18, John Ogness wrote:
> Hi Petr,
> 
> AndreaP responded with some explanation (and great links!) on the topic
> of READ_ONCE. But I feel like your comments about the WRITE_ONCE were
> not addressed. I address that (and your other comments) below...
> 
> On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
> >> --- /dev/null
> >> +++ b/kernel/printk/numlist.c
> >> +/**
> >> + * numlist_push() - Add a node to the list and assign it a sequence number.
> >> + *
> >> + * @nl: The numbered list to push to.
> >> + *
> >> + * @n:  A node to push to the numbered list.
> >> + *      The node must not already be part of a list.
> >> + *
> >> + * @id: The ID of the node.
> >> + *
> >> + * A node is added in two steps: The first step is to make this node the
> >> + * head, which causes a following push to add to this node. The second step is
> >> + * to update @next_id of the former head node to point to this one, which
> >> + * makes this node visible to any task that sees the former head node.
> >> + */
> >> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
> >> +{
[...]
> >> +
> >> +	/* bB: #1 */
> >> +	head_id = atomic_long_read(&nl->head_id);
> >> +
> >> +	for (;;) {
> >> +		/* bC: */
> >> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
> >> +			/*
> >> +			 * @head_id is invalid. Try again with an
> >> +			 * updated value.
> >> +			 */
> >> +
> >> +			cpu_relax();
> >
> > I have got very confused by this. cpu_relax() suggests that this
> > cycle is busy waiting until a particular node becomes valid.
> > My first though was that it must cause deadlock in NMI when
> > the interrupted code is supposed to make the node valid.
> >
> > But it is the other way. The head is always valid when it is
> > added to the list. It might become invalid when another CPU
> > moves the head and the old one gets reused.
> >
> > Anyway, I do not see any reason for cpu_relax() here.
> 
> You are correct. The cpu_relax() should not be there. But there is still
> an issue that this could spin hard if the head was recycled and this CPU
> does not yet see the new head value.

I do not understand this. The head could get reused only after
head_id was replaced with the following valid node.
The next cycle is done with a new id that should be valid.

Of course, the new ID might get reused as well. But then we just
repeat the cycle. We have to be able to find a valid head after
few cycles. The last valid ID could not get reused because nodes
can be removed only if was not the last valid node.


> To handle that, and in preparation for my next version, I'm now using a
> read_acquire() to load the ID in the node() callback (matching the
> set_release() in assign_desc()). This ensures that if numlist_read()
> fails, the new head will be visible.

I do not understand this either. The above paragraph seems to
describe a race. I do not see how it could cause an infinite loop.

Best Regards,
Petr
