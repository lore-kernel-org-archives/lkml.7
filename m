Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87154206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfH0NDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:03:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbfH0NDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:03:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B883EB016;
        Tue, 27 Aug 2019 13:03:51 +0000 (UTC)
Date:   Tue, 27 Aug 2019 15:03:49 +0200
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
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <87sgpnmqdo.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgpnmqdo.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-08-27 01:57:39, John Ogness wrote:
> On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
> >> --- /dev/null
> >> +++ b/kernel/printk/numlist.c
> >> @@ -0,0 +1,375 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/sched.h>
> >> +#include "numlist.h"
> >
> > struct numlist is really special variant of a list. Let me to
> > do a short summary:
> >
> >    + FIFO queue interface
> >
> >    + nodes sequentially numbered
> >
> >    + nodes referenced by ID instead pointers to avoid ABA problems
> >      + requires custom node() callback to get pointer for given ID
> >
> >    + lockless access:
> >      + pushed nodes must not longer get modified by push() caller
> >      + pop() caller gets exclusive write access, except that they
> >        must modify ID first and do smp_wmb() later
> 
> Only if the "numlist user" decides to recycle descriptors (which the
> printk_ringbuffer does) is ID modification of descriptors necessary. How
> that is synchronized with readers is up to the user (for example,
> whether a RELEASE or an smp_wmb() is used).

IMHO, the most tricky part of numlist API is handling of IDs.
The IDs are there to avoid ABA races when reusing the nodes.

I want to say that this API is useful only when the nodes are reused.
All other users would want anything easier.

> >    + pop() does not work:
> >      + tail node is "busy"
> > 	+ needs a custom callback that defines when a node is busy
> 
> Note that busy() could always return false if the user has no concept of
> nodes that should not be popped.

This would be append only list. Again the is no need for IDs
and other complexities.


> >      + tail is the last node
> > 	+ needed for lockless sequential numbering
> >
> > I will start with one inevitable question ;-) Is it realistic to find
> > another user for this API, please?
> 
> If someone needs a FIFO queue that supports:
> 
> 1. multiple concurrent writers and multiple concurrent non-consuming
>    readers
> 
> 2. where readers are allowed to miss nodes but are able to detect how
>    many were missed
> 
> 3. from any context (including NMI)
>
> then I know of no other data structure available. (Otherwise I would
> have used it!)

It might be also because nobody else needed structure with
our numlist semantic. I guess that lockless read/write
structures are usually implemented using RCU.


> > I am not sure that all the indirections, caused by the generic API,
> > are worth the gain.
>
> IMHO the API is sane. The only bizarre rule is that the numlist must
> always have at least 1 node. But since the readers are non-consuming,
> there is no real tragedy here.
>
> My goal is not to create some fabulous abstract data structure that
> everyone should use. But I did try to minimize numlist (and dataring) to
> only be concerned with clearly defined and minimal responsibilities
> without imposing unnecessary restrictions on the user.

The API is complicated because of the callbacks. It depends on a logic
that is implemented externally. It makes it abstract to some extent.

My view is that the API would be much cleaner and easier to review
when the ID handling is "hardcoded" (helper functions). It could be
made abstract anytime later when there is another user.

There should always be a reason why to make a code more complicated
than necessary. It seems that the only reason is some theoretical
future user and its theoretical requirements.


> > Well, the separate API makes sense anyway. I have some ideas that
> > might make it cleaner.
> 
> [snipped the nice refactoring of the ID into the nl_node]
> 
> Your idea (along with previous discussions) convinced me of the
> importance of moving the ID-related barriers into the same
> file. However, rather than pushing the ID parts into the numlist, I will
> be moving them all into the "numlist user"
> (i.e. printk_ringbuffer). Your use of the ACQUIRE to load the ID made me
> realize that I need to be doing that as well! (but in the node()
> callback)
> 
> The reasons why I do not want the ID in nl_node is:
> 
> - The numlist would need to implement the ID-to-node mapping. For the
>   printk_ringbuffer that mapping is simply masking to an index within an
>   array. But why should a numlist user be forced to do it that way? I
>   see no advantage to restricting numlists to being arrays of nodes.

It might be done a generic way when there is a user with another need.

Honestly, I have big troubles to imagine another reasonable mapping
between id and pointer than masking. We are talking about lockless
code. Anything more complicated might become a nightmare.


> - The dataring structure also uses IDs and requires an ID-to-node
>   mapping. I do not want to bind the dataring and numlist data
>   structures together at this level because they really have nothing to
>   do with each other. Having the dataring and numlist ID-to-node
>   mappings (and their barriers) in the same place (in the
>   numlist/dataring _user_) simplifies the big picture.

The ID is used in all three APIs. Then it might be only a matter of
taste where it is stored.

I still feel that struct nl_node is better place because:

    + already includes next_id
    + includes seq that identifies the structure another way
    + id describes the node

I still need to think more about the other APIs. Well, id
substitutes a pointer here. It is like struct list_head
pointer. It is normal that it is passed as parameter
by a list API user.


> I believe your main concern was having easily visible symmetric
> barriers. We can achieve that if the read-barriers are in the callbacks
> (for both numlist and dataring). I think it makes more sense to put them
> there. dataring and numlist should not care about the ID-to-node
> mapping.

Symmetry is really important. It is often sign of a good design.

Simple and straightforward code is another important thing at
this stage. The code is complicated and we need to make sure
that it works. Any optimizations and generalization might
be done later when needed.

Best Regards,
Petr
