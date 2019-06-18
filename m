Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE9C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2592082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfFRWND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:13:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48940 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfFRWND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:13:03 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hdMLQ-0005xi-8L; Wed, 19 Jun 2019 00:12:48 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618045117.GA7419@jagdpanzerIV>
Date:   Wed, 19 Jun 2019 00:12:43 +0200
Message-ID: <87imt2bl0k.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> +	struct prb_reserved_entry e;
>> +	char *s;
>> +
>> +	s = prb_reserve(&e, &rb, 32);
>> +	if (s) {
>> +		sprintf(s, "Hello, world!");
>> +		prb_commit(&e);
>> +	}
>
> A nit: snprintf().
>
> sprintf() is tricky, it may write "slightly more than was
> anticipated" bytes - all those string_nocheck(" disabled"),
> error_string("pK-error"), etc.

Agreed. Documentation should show good examples.

>> +Sample reader code::
>> +
>> +	DECLARE_PRINTKRB_ENTRY(entry, 128);
>> +	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
>> +	u64 last_seq = 0;
>> +	int len;
>> +	char *s;
>> +
>> +	prb_for_each_entry(&iter, len) {
>> +		if (entry.seq - last_seq != 1) {
>> +			printf("LOST %llu ENTRIES\n",
>> +				entry.seq - (last_seq + 1));
>> +		}
>> +		last_seq = entry.seq;
>> +
>> +		s = (char *)&entry.buffer[0];
>> +		if (len >= 128)
>> +			s[128 - 1] = 0;
>> +		printf("data: %s\n", s);
>> +	}
>
> How are we going to handle pr_cont() loops?
>
> print_modules()
>  preempt_disable();
>  list_for_each_entry_rcu(mod, &modules, list) {
>   pr_cont(" %s%s", mod->name, module_flags(mod, buf));
>  }
>  preempt_enable();

pr_cont() (in its current form) is not related to the printk buffer
because cont messages use their own separate struct cont buffer. And for
the initial integration of the new ringbuffer I would leave that as it
is. Which means initially, pr_cont() would still sit behind a raw
spinlock and pr_cont() from NMI context would be stored as individual
messages.

However, to remove the spinlock of the cont buffer and allow pr_cont()
to work from NMI context, I would like to introduce a separate lockless
ringbuffer instance for cont that contains all the cont pieces
(including the caller_id). As soon as the caller_id changes from the
oldest record in the cont ringbuffer, that caller would assemble the
full cont message, popping all the pieces from the ringbuffer (with a
single cmpxchg) and insert the message to the printk ringbuffer.

John Ogness
