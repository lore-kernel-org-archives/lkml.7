Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A475C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A692173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfHHW4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:56:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54337 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390022AbfHHW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:56:31 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvrK5-0000po-J4; Fri, 09 Aug 2019 00:55:53 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-10-john.ogness@linutronix.de>
        <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
Date:   Fri, 09 Aug 2019 00:55:51 +0200
In-Reply-To: <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 8 Aug 2019 12:07:28 -0700")
Message-ID: <874l2rclmw.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> 2. For the CONFIG_PPC_POWERNV powerpc platform, kernel log buffer
>>    registration is no longer available because there is no longer
>>    a single contigous block of memory to represent all of the
>>    ringbuffer.
>
> So this is tangential, but I've actually been wishing for a special
> "raw dump" format that has absolutely *no* structure to it at all, and
> is as a result not necessarily strictly reliable, but is a lot more
> robust.
>
> The background for that is that we have a class of bugs that are
> really hard to debug "in the wild", because people don't have access
> to serial consoles or any kind of special hardware at all (ie forget
> things like nvram etc), and when the machine locks up you're happy to
> just have a reset button (but more likely you have to turn power off
> and on).
>
> End result: a DRAM buffer can work, but is not "reliable".
> Particularly if you turn power on and off, data retention of DRAM is
> iffy. But it's possible, at least in theory.
>
> So I have a patch that implements a "stupid ring buffer" for thisa
> case, with absolutely zero data structures (because in the presense of
> DRAM corruption, all you can get is "hopefully only slightly garbled
> ASCII".

You can read the current printk ringbuffer this way also because the
ASCII strings are sorted and separated by struct binary data. The binary
parts of the structs can even prove useful in this case to act as record
separators.

        dump_area(log_buf, log_buf_len);

Note: To test this, I modified your dump_area() to call trace_printk()
instead of printk().

The _raw_ contents of the ringbuffer I am proposing (dataring.data) is
nearly identical to that of the current ringbuffer. Its raw data is also
sorted and separated by non-ascii data. So using:

        dump_area(prb->dr.data, 1 << prb->dr.size_bits);

produces essentially the same results. Both ringbuffers are structuring
the data similar to yours, but they have the advantage of writer
synchronization.

What is missing is a way for the raw data buffers to be fixed to a
specified address so that they can be recovered after a reset. I will
look into such a feature for my next version.

On a side note, I'm not sure sure if we want kernel code to do the ASCII
dump of the raw buffer. A userspace application grabbing from /dev/mem
might be more desirable. I can imagine that all kinds of "intelligence"
could be added to such an application to try to recover/sanitize as much
meta-data as possible (such as timestamps, CPU ID, task ID, etc). Maybe
we should add CRC or ECC to struct prink_log. :-)

John Ogness
