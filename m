Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11677C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23E120838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ywfVC4u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfGOHiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:38:12 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50370 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbfGOHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:38:12 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6E2EF2E0A47;
        Mon, 15 Jul 2019 10:38:08 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rukKDZ5J9h-c7iOAIU9;
        Mon, 15 Jul 2019 10:38:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563176288; bh=AEDnjZJg+/Lt0F8ELdUDTZdfEPafRPFQS0JYf0Lk/gI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=ywfVC4u+sG80eygPE3oARLE4GjPce7V1zPnCKI7b9Vali+ye9V4bA3MjttktRieQK
         LrUBN/ZMAaLr5Rg273ebFlZwRk/ECguKrquFFTOp3/7wljG1lROcqYrpvyCIy4pj/b
         Sh4P0Wye9oY3JrQ7WHBKAmWYfAW8HKzue7X5XTvw=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38c5:1c4f:8e20:cf1b])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id sK7rOwnrz9-c7wSIeNu;
        Mon, 15 Jul 2019 10:38:07 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump from
 NMI context
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
 <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
 <20190715023338.GB3653@jagdpanzerIV>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d3958637-a03d-f899-63ef-8d0d50e78a1e@yandex-team.ru>
Date:   Mon, 15 Jul 2019 10:38:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715023338.GB3653@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2019 5:33, Sergey Senozhatsky wrote:
> On (07/13/19 17:03), Konstantin Khlebnikov wrote:
>>> We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop() and after
>>> printk_safe_flush_on_panic(). printk_safe_flush_on_panic() resets
>>> the state of logbuf_lock, so logbuf_lock, in general case, should
>>> be unlocked by the time we call kmsg_dump(KMSG_DUMP_PANIC).
>>> Even for nested contexts.
>>>
>>>          CPU0
>>>          printk()
>>>           logbuf_lock_irqsave(flags)
>>>            -> NMI
>>>             panic()
>>>              smp_send_stop()
>>>               printk_safe_flush_on_panic()
>>>                raw_spin_lock_init(&logbuf_lock) << reinit >>
>>>              kmsg_dump(KMSG_DUMP_PANIC)
>>>               logbuf_lock_irqsave(flags)        << expected to be OK >>
>>>
>>> So do we have strong reasons to disable NMI->panic->kmsg_dump(DUMP_PANIC)?
>>>
>>> Other kmsg_dump(), maybe, can experience some troubles sometimes,
>>> need to check that.
>>
>> Indeed, panic is especially handled and looks fine.
>>
>> Sanity check in my patch could be relaxed:
>>
>>         if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
>>                 return;
> 
> How critical kmsg_dump() is? We deadlock only if NMI->kmsg_dump()
> happens on the CPU which already holds the logbuf_lock; in any
> other case logbuf_lock is owned by another CPU which is expected
> to unlock it eventually. So it doesn't look like disabling all
> NMI->kmsg_dump() is the only way to fix it.
> 
> When we lock logbuf_lock we increment per-CPU printk_context
> (PRINTK_SAFE_CONTEXT_MASK bits); when we unlock logbuf_lock
> we decrement printk_context. Thus we always can tell if the
> logbuf_lock was locked on the very same CPU - this_cpu printk_context
> has PRINTK_SAFE_CONTEXT_MASK bits sets - and we are about to deadlock
> in a nested context (NMI), or the lock was locked on another CPU and
> it's "safe" to spin on logbuf_lock and wait for logbuf_lock to become
> available.

I see no users who dumps dmesg from NMI context except panic.
This shouldn't happen. But might happen is something goes very wrong.

So, this trickery is not required.
Also spinning in NMI for handling non-fatal cases is a bad idea.
