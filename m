Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67793C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA85206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfCFWXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:23:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52560 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCFWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:23:11 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h1ewI-0006kr-4y; Wed, 06 Mar 2019 23:23:02 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-9-john.ogness@linutronix.de>
        <20190304073856.GA552@jagdpanzerIV>
        <20190304100044.GC21004@jagdpanzerIV>
        <20190304110703.GA960@tigerII.localdomain>
        <87o96p9gtx.fsf@linutronix.de>
        <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
        <87r2bjbt47.fsf@linutronix.de>
Date:   Wed, 06 Mar 2019 23:22:57 +0100
In-Reply-To: <87r2bjbt47.fsf@linutronix.de> (John Ogness's message of "Wed, 06
        Mar 2019 22:17:12 +0100")
Message-ID: <87k1hbbq2m.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-06, Petr Mladek <pmladek@suse.com> wrote:
>> _Both_ categories are important for the user, but their requirements
>> are different:
>> 
>>    informational: non-disturbing
>>    emergency:     reliable
>
> Isn't this already handled by the console_level?
>
> The informational messages can be reliably read via syslog, /dev/kmsg.
> They are related to the normal works when the system works well.
>
> The emergency messages (errors, warnings) are printed in emergency
> situations. They are printed as reliably as possible to the console
> because the userspace might not be reliable enough.

I've never viewed console_level this way. _If_ console_level really is
supposed to define the emergency/informational boundary, all
informational messages are supposed to be handled by userspace, and
console printing's main objective is reliability... then I would change
my proposal such that:

- if a console supports write_atomic(), _all_ console printing for that
  console would use write_atomic()

- only consoles without write_atomic() will be printing via the
  printk-kthread(s)

IMO, for consoles with write_atomic(), this would increase reliability
over the current mainline implementation. It would also simplify
write_atomic() implementations because they would no longer need to
synchronize against write().

For those consoles that cannot implement write_atomic() (vt and
netconsole come to mind), or as a transition period until remaining
console drivers have implemented write_atomic(), these would use the
"fallback" of printing fully preemptively in their own kthread using
write().

Does this better align with the concept of the console_loglevel and the
purpose of console printing?

John Ogness
