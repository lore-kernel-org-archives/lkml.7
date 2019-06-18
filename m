Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B453C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664132082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfFRWSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:18:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48950 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:18:48 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hdMQk-00067m-3p; Wed, 19 Jun 2019 00:18:18 +0200
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
        <20190618111215.GO3436@hirez.programming.kicks-ass.net>
Date:   Wed, 19 Jun 2019 00:18:16 +0200
In-Reply-To: <20190618111215.GO3436@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 18 Jun 2019 13:12:15 +0200")
Message-ID: <87ef3qbkrb.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
>> +/**
>> + * struct prb_descr - A descriptor representing an entry in the ringbuffer.
>> + * @seq: The sequence number of the entry.
>> + * @id: The descriptor id.
>> + *      The location of the descriptor within the descriptor array can be 
>> + *      determined from this value.
>> + * @data: The logical position of the data for this entry.
>> + *        The location of the beginning of the data within the data array
>> + *        can be determined from this value.
>> + * @data_next: The logical position of the data next to this entry.
>> + *             This is used to determine the length of the data as well as
>> + *             identify where the next data begins.
>> + * @next: The id of the next (newer) descriptor in the linked list.
>> + *        A value of EOL means it is the last descriptor in the list.
>> + *
>
> For the entire patch; can you please vertically align those
> descriptions? This is unreadable. Also, add some whitespace, to aid with
> reading, something like do:
>
>  * struct prb_descr - A descriptor representing an entry in the ringbuffer.
>  *
>  * @seq:       The sequence number of the entry.
>  *
>  * @id:        The descriptor id.
>  *             The location of the descriptor within the descriptor
>  *             array can be determined from this value.
>  *
>  * @data:      The logical position of the data for this entry.  The
>  *             location of the beginning of the data within the data
>  *             array can be determined from this value.
>  *
>  * @data_next: The logical position of the data next to this entry.
>  *             This is used to determine the length of the data as well as
>  *             identify where the next data begins.
>  *
>  * @next:      The id of the next (newer) descriptor in the linked list.
>  *             A value of EOL means it is the last descriptor in the
>  *             list.

OK. Thanks for taking the time to format an example.

John Ogness
