Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A251220684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCGJy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:54:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:54:26 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h1pio-0004Y5-DQ; Thu, 07 Mar 2019 10:53:50 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213025520.GA5803@jagdpanzerIV> <874l9721hf.fsf@linutronix.de>
        <20190304052335.GA6648@jagdpanzerIV>
Date:   Thu, 07 Mar 2019 10:53:48 +0100
In-Reply-To: <20190304052335.GA6648@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Mon, 4 Mar 2019 14:23:35 +0900")
Message-ID: <87lg1rggcz.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-04, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> - A dedicated kernel thread is created for printing to all consoles
>>>>   in a fully preemptible context.
>>>
>>> How do you handle sysrq-<foo> printouts on systems which can't
>>> schedule printk-kthread?
>> 
>> If those sysrq printouts are at the emergency loglevel (which most
>> are), then they are printed immediately to the emergency
>> consoles. This has already proved useful for our own kernel debugging
>> work. For example, currently sysrq-z for very large traces result in
>> messages being dropped because of printk buffer overflows. But with
>> the emergency console we always see the full trace buffer.
>
> Are we sure that all systems will always have ->atomic console(-s)
> enabled? Is it possible to convert all console drivers to ->atomic?
> fbcon, for instance (with scrolling and font scaling, etc)?

No, I am not sure if we can convert all console drivers to atomic
consoles. But I think if we don't have to fear disturbing the system,
the possibilities for such an implementation are greater.

> If there are setups which can be fully !atomic (in terms of console
> output) then we, essentially, have a fully preemptible kthread printk
> implementation.

Correct. I've mentioned in another response[0] some ideas about what
could be done to aid this.

I understand that fully preemptible kthread printing is unacceptable for
you. Since all current console drivers are already irq safe, I'm
wondering if using irq_work to handle the emergency printing for console
drivers without write_atomic() would help. (If the printk caller is in a
context that write() supports, then write() could be called directly.)
This would also demand that the irq-safe requirements for write() are
not relaxed. The printk-kthread might still be faster than irq_work, but
it might increase reliability if an irq_work is triggered as an extra
precaution.

John Ogness

[0] https://lkml.kernel.org/r/87o96p9gtx.fsf@linutronix.de
