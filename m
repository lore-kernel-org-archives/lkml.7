Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A9C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0212087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfHUFsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:48:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHUFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:48:16 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0JTP-0003j5-CO; Wed, 21 Aug 2019 07:47:55 +0200
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 8/9] printk-rb: new functionality to support printk
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-9-john.ogness@linutronix.de>
        <20190820095918.GB14137@jagdpanzerIV>
Date:   Wed, 21 Aug 2019 07:47:51 +0200
Message-ID: <8736hvf4s8.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> [..]
>> +void prb_init(struct printk_ringbuffer *rb, char *data, int data_size_bits,
>> +	      struct prb_desc *descs, int desc_count_bits,
>> +	      struct wait_queue_head *waitq)
>> +{
>> +	struct dataring *dr = &rb->dr;
>> +	struct numlist *nl = &rb->nl;
>> +
>> +	rb->desc_count_bits = desc_count_bits;
>> +	rb->descs = descs;
>> +	atomic_long_set(&descs[0].id, 0);
>> +	descs[0].desc.begin_lpos = 1;
>> +	descs[0].desc.next_lpos = 1;
>
> dataring_desc_init(), perhaps?

Agreed.
