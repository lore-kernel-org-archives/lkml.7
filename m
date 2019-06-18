Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A89C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFF220873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfFRWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:31:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbfFRWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:31:00 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hdMcW-0006VX-LW; Wed, 19 Jun 2019 00:30:28 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618112237.GP3436@hirez.programming.kicks-ass.net>
Date:   Wed, 19 Jun 2019 00:30:26 +0200
In-Reply-To: <20190618112237.GP3436@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 18 Jun 2019 13:22:37 +0200")
Message-ID: <87a7eebk71.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
>> +/**
>> + * DOC: memory barriers
>
> What's up with that 'DOC' crap?

The separate documentation in
Documentation/core-api/printk-ringbuffer.rst references this so it
automatically shows up in the kernel docs. An external reference
requires the DOC keyword.

Maybe the memory barrier descriptions do not belong in the kernel docs?

>> + *
>> + * Writers
>> + * -------
>> + * The main issue with writers is expiring/invalidating old data blocks in
>> + * order to create new data blocks. This is performed in 6 steps that must
>> + * be observed in order by all writers to allow cooperation. Here is a list
>> + * of the 6 steps and the named acquire/release memory barrier pairs that
>> + * are used to synchronized them:
>> + *
>> + * * old data invalidation (MB1): Pushing rb.data_list.oldest forward.
>> + *   Necessary for identifying if data has been expired.
>> + *
>> + * * new data reservation (MB2): Pushing rb.data_list.newest forward.
>> + *   Necessary for validating data.
>> + *
>> + * * assign the data block to a descriptor (MB3): Setting data block id to
>> + *   descriptor id. Necessary for finding the descriptor associated with th
>> + *   data block.
>> + *
>> + * * commit data (MB4): Setting data block data_next. (Now data block is
>> + *   valid). Necessary for validating data.
>> + *
>> + * * make descriptor newest (MB5): Setting rb.descr_list.newest to descriptor.
>> + *   (Now following new descriptors will be linked to this one.) Necessary for
>> + *   ensuring the descriptor's next is set to EOL before adding to the list.
>> + *
>> + * * link descriprtor to previous newest (MB6): Setting the next of the
>> + *   previous descriptor to this one. Necessary for correctly identifying if
>> + *   a descriptor is the only descriptor on the list.
>> + *
>> + * Readers
>> + * -------
>> + * Readers only make of smb_rmb() to ensure that certain critical load
>> + * operations are performed in an order that allows readers to evaluate if
>> + * the data they read is really valid.
>> + */
>
> This isn't really helping much I feel. It doesn't begin to describe the
> ordering. But maybe the code makes more sense.

Sorry. I really have no feel about what (or how) exactly I should
document the memory barriers. I think the above comments make sense when
someone understands the details of the implementation. But perhaps it
should describe things such that someone without knowledge of the
implementation would understand what the memory barriers are for? That
would significantly increase the amount of text as I would have to
basically explain the implementation.

I would appreciate it if you could point out a source file that
documents its memory barriers the way you would like to see these memory
barriers documented.

John Ogness
