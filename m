Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B75C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0B2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH2L3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:29:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfH2L3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:29:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28598ABE9;
        Thu, 29 Aug 2019 11:29:00 +0000 (UTC)
Date:   Thu, 29 Aug 2019 13:28:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20190829112859.oqhsoudamd3nld7w@pathway.suse.cz>
References: <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <87sgpnmqdo.fsf@linutronix.de>
 <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
 <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
 <87o909lq3g.fsf@linutronix.de>
 <20190828085845.5k7ewfshbfed7txh@pathway.suse.cz>
 <20190828085845.5k7ewfshbfed7txh@pathway.suse.cz>
 <87k1axjsjp.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1axjsjp.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-28 16:03:38, John Ogness wrote:
> On 2019-08-28, Petr Mladek <pmladek@suse.com> wrote:
> > I only think that, especially, numlist API is too generic in v4.
> > It is not selfcontained. The consistency depends on external barriers.
> >
> > I believe that it might become fully self-contained and consistent
> > if we reduce possibilities of the generic usage. In particular,
> > the numlist should allow only linking of reusable structures
> > stored in an array.
> 
> OK. I will make the numlist the master of the ID-to-node mapping. To
> implement the getdesc() callback of the dataring, the printk_ringbuffer
> can call a numlist mapping function. Also, numlist will need to provide
> a function to bump the descriptor version (as your previous idea already
> showed).

Sounds good.

> I plan to change the array to be numlist nodes. The ID would move into
> the numlist node structure and a void-pointer private would be added so
> that the numlist user can add private data (for printk_ringbuffer that
> would just be a pointer to the dataring structure). When the
> printk_ringbuffer gets a never-used numlist node, it can set the private
> field.

I am not sure that I get the full picture. It would help to see some
snippet of the code (struct declaration).

Anyway, adding void-pointer into struct numlist looks like classic
(userspace?) implementation of dynamically linked structures.

I do not have strong opinion. But I would prefer to stay with
the kernel-style. I mean that the numlist structure is part
of the linked structures. And container_of() is eventually
used to get pointer to the upper structure. Also passing values
via a pointer with generic name (data) slightly complicates the code.

I know that numlist is special because id is used to get the pointer
of the numlist and also the upper structure. Anyway, the kernel
style looks more familiar to me in the kernel context.
But I'll leave it up to you.


> This has the added benefit of making it easy to detect accidental
> never-used descriptor usage when reading dataring garbage. This was
> non-trivial and I'm still not sure I solved it correctly. (I've already
> spent a week working on a definitive answer to your email[0] asking
> about this.)

Would a check for NULL data pointer help here? Well, it might be
motivation for using the pointer.

I wonder if begin_lpos == end_lpos check might be used to detect
never used descriptors. It is already used in another situation
in dataring_desc_init(). IMHO, the values even do not need to be
unaligned. But I might miss something.

Best Regards,
Petr
