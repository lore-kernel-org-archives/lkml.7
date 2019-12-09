Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DEBC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0720692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLIJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:01:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:01:17 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ieEuZ-0005Bv-75; Mon, 09 Dec 2019 10:00:59 +0100
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
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191209074249.GC88619@google.com>
Date:   Mon, 09 Dec 2019 10:00:57 +0100
In-Reply-To: <20191209074249.GC88619@google.com> (Sergey Senozhatsky's message
        of "Mon, 9 Dec 2019 16:42:50 +0900")
Message-ID: <87v9qpzxdi.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-09, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> +#define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
>> +#define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
>> +#define DESC_SV_BITS			(sizeof(int) * 8)
>> +#define DESC_COMMITTED_MASK		(1U << (DESC_SV_BITS - 1))
>
> What does SV state for? State Value?

Yes. Originally this thing was just called the state. But it was a bit
confusing in the code because there is also an enum desc_state (used for
state queries), which is _not_ the value that is stored in the state
variable. That's why the code is using state_var/state_val (SV) for the
actual data values, keeping it separate from desc_state/d_state for the
the state queries.

John Ogness
