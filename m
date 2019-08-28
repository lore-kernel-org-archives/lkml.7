Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD92C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24AB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfH1ODr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:03:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfH1ODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:44 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2yXz-0005Fc-Vf; Wed, 28 Aug 2019 16:03:40 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
        <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
        <87sgpnmqdo.fsf@linutronix.de>
        <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
        <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
        <87o909lq3g.fsf@linutronix.de>
        <20190828085845.5k7ewfshbfed7txh@pathway.suse.cz>
Date:   Wed, 28 Aug 2019 16:03:38 +0200
In-Reply-To: <20190828085845.5k7ewfshbfed7txh@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 28 Aug 2019 10:58:45 +0200")
Message-ID: <87k1axjsjp.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-28, Petr Mladek <pmladek@suse.com> wrote:
> I only think that, especially, numlist API is too generic in v4.
> It is not selfcontained. The consistency depends on external barriers.
>
> I believe that it might become fully self-contained and consistent
> if we reduce possibilities of the generic usage. In particular,
> the numlist should allow only linking of reusable structures
> stored in an array.

OK. I will make the numlist the master of the ID-to-node mapping. To
implement the getdesc() callback of the dataring, the printk_ringbuffer
can call a numlist mapping function. Also, numlist will need to provide
a function to bump the descriptor version (as your previous idea already
showed).

I plan to change the array to be numlist nodes. The ID would move into
the numlist node structure and a void-pointer private would be added so
that the numlist user can add private data (for printk_ringbuffer that
would just be a pointer to the dataring structure). When the
printk_ringbuffer gets a never-used numlist node, it can set the private
field.

This has the added benefit of making it easy to detect accidental
never-used descriptor usage when reading dataring garbage. This was
non-trivial and I'm still not sure I solved it correctly. (I've already
spent a week working on a definitive answer to your email[0] asking
about this.)

John Ogness

[0] https://lkml.kernel.org/r/20190820151239.yzdqz56yeldlknln@pathway.suse.cz
