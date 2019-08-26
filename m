Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F90C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA22173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfHZX5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:57:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41609 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:57:50 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2Orm-0007L4-6A; Tue, 27 Aug 2019 01:57:42 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
Date:   Tue, 27 Aug 2019 01:57:39 +0200
In-Reply-To: <20190823171802.eo2chwyktibeub7a@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 23 Aug 2019 19:18:02 +0200")
Message-ID: <87sgpnmqdo.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/numlist.c
>> @@ -0,0 +1,375 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/sched.h>
>> +#include "numlist.h"
>
> struct numlist is really special variant of a list. Let me to
> do a short summary:
>
>    + FIFO queue interface
>
>    + nodes sequentially numbered
>
>    + nodes referenced by ID instead pointers to avoid ABA problems
>      + requires custom node() callback to get pointer for given ID
>
>    + lockless access:
>      + pushed nodes must not longer get modified by push() caller
>      + pop() caller gets exclusive write access, except that they
>        must modify ID first and do smp_wmb() later

Only if the "numlist user" decides to recycle descriptors (which the
printk_ringbuffer does) is ID modification of descriptors necessary. How
that is synchronized with readers is up to the user (for example,
whether a RELEASE or an smp_wmb() is used).

>    + pop() does not work:
>      + tail node is "busy"
> 	+ needs a custom callback that defines when a node is busy

Note that busy() could always return false if the user has no concept of
nodes that should not be popped.

>      + tail is the last node
> 	+ needed for lockless sequential numbering
>
> I will start with one inevitable question ;-) Is it realistic to find
> another user for this API, please?

If someone needs a FIFO queue that supports:

1. multiple concurrent writers and multiple concurrent non-consuming
   readers

2. where readers are allowed to miss nodes but are able to detect how
   many were missed

3. from any context (including NMI)

then I know of no other data structure available. (Otherwise I would
have used it!)

> I am not sure that all the indirections, caused by the generic API,
> are worth the gain.

IMHO the API is sane. The only bizarre rule is that the numlist must
always have at least 1 node. But since the readers are non-consuming,
there is no real tragedy here.

My goal is not to create some fabulous abstract data structure that
everyone should use. But I did try to minimize numlist (and dataring) to
only be concerned with clearly defined and minimal responsibilities
without imposing unnecessary restrictions on the user.

> Well, the separate API makes sense anyway. I have some ideas that
> might make it cleaner.

[snipped the nice refactoring of the ID into the nl_node]

Your idea (along with previous discussions) convinced me of the
importance of moving the ID-related barriers into the same
file. However, rather than pushing the ID parts into the numlist, I will
be moving them all into the "numlist user"
(i.e. printk_ringbuffer). Your use of the ACQUIRE to load the ID made me
realize that I need to be doing that as well! (but in the node()
callback)

The reasons why I do not want the ID in nl_node is:

- The numlist would need to implement the ID-to-node mapping. For the
  printk_ringbuffer that mapping is simply masking to an index within an
  array. But why should a numlist user be forced to do it that way? I
  see no advantage to restricting numlists to being arrays of nodes.

- The dataring structure also uses IDs and requires an ID-to-node
  mapping. I do not want to bind the dataring and numlist data
  structures together at this level because they really have nothing to
  do with each other. Having the dataring and numlist ID-to-node
  mappings (and their barriers) in the same place (in the
  numlist/dataring _user_) simplifies the big picture.

- ID-related barriers are only needed if node recycling is involved. The
  numlist user decides if recycling is used and if yes, then the numlist
  user is responsible for correctly implementing that.

- By moving all the ID-related barriers to the callbacks, the numlist
  code remains clean and (with the exception of the one smp_rmb()) does
  not expect anything from the numlist user.

I believe your main concern was having easily visible symmetric
barriers. We can achieve that if the read-barriers are in the callbacks
(for both numlist and dataring). I think it makes more sense to put them
there. dataring and numlist should not care about the ID-to-node
mapping.

John Ogness
