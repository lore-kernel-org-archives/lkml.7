Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479A120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="U42euZjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfGOIMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:12:39 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60452 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729257AbfGOIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:12:39 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 6B4E02E0E47;
        Mon, 15 Jul 2019 11:12:35 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bY44Bou3DU-CY4qvewE;
        Mon, 15 Jul 2019 11:12:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563178355; bh=5cuUVGpOKjEZE2zEyOt2pCBdqAx98lYW54gZVsRcm3M=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=U42euZjcfMleJ11bS6fI0HsLyRDy+E4n7PUvELcF8Z4i01C6Uvz6z/cKhGX43dAr4
         1bxWZ/z0s3g/OJRIWfqPTDog6Jenk0Z7I5ShKB2xpFrs5axy1uzicmVWyR9D+MMhz/
         dFcfROpk5PX9kBqt2krQKIKjBIvfUbhMNYh953TQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38c5:1c4f:8e20:cf1b])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id zz1WwJWmSJ-CYQCqQb5;
        Mon, 15 Jul 2019 11:12:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump from
 NMI context
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
 <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
 <20190715023338.GB3653@jagdpanzerIV>
 <20190715075444.fzxnf3iduqj6dkgp@pathway.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <45b818b7-045d-2d65-327f-217b752accee@yandex-team.ru>
Date:   Mon, 15 Jul 2019 11:12:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715075444.fzxnf3iduqj6dkgp@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2019 10:54, Petr Mladek wrote:
> On Mon 2019-07-15 11:33:38, Sergey Senozhatsky wrote:
>> On (07/13/19 17:03), Konstantin Khlebnikov wrote:
>>>> We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop()
>>>
>>> Indeed, panic is especially handled and looks fine.
> 
> Just to get a picture. What other situations are we talking about,
> please?
> 
> oops_exit() is one candidate. The other callers seem to be working
> in normal context.

Oops in NMI mostly. Also I've screwed up several times with NMI watchdog
and dumping log at setting taint.

> 
> 
>>> Sanity check in my patch could be relaxed:
>>>
>>>         if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
>>>                 return;
>>
>> How critical kmsg_dump() is? We deadlock only if NMI->kmsg_dump()
>> happens on the CPU which already holds the logbuf_lock; in any
>> other case logbuf_lock is owned by another CPU which is expected
>> to unlock it eventually. So it doesn't look like disabling all
>> NMI->kmsg_dump() is the only way to fix it.
>>
>> When we lock logbuf_lock we increment per-CPU printk_context
>> (PRINTK_SAFE_CONTEXT_MASK bits); when we unlock logbuf_lock
>> we decrement printk_context. Thus we always can tell if the
>> logbuf_lock was locked on the very same CPU - this_cpu printk_context
>> has PRINTK_SAFE_CONTEXT_MASK bits sets - and we are about to deadlock
>> in a nested context (NMI), or the lock was locked on another CPU and
>> it's "safe" to spin on logbuf_lock and wait for logbuf_lock to become
>> available.
> 
> This sounds familiar. I think that we did not consider it safe in the
> end, see the commit 03fc7f9c99c1e7ae29 ("printk/nmi: Prevent deadlock
> when accessing the main log buffer in NMI").
> 
> If the problem is only with Oops then the 2nd propose might be
> acceptable. The system will either try to continue or it will end
> up in panic() anyway.
> 
> Well, WARN() looks like an overkill, especially if there is only
> one possible caller that prints the stack anyway. I would personally
> do not print any message and do just:
> 
> 	/*
> 	 * Prevent deadlock on logbuf_lock. It is safe only
> 	 * in panic() after smp_send_stop() and resetting
> 	 * the lock.
> 	 */
> 	if (in_nmi() && reason != KMSG_DUMP_PANIC)
> 		return;
> 

WARN_ON_ONCE is useful timesaver in debugging.
It's better to know when happens something that shouldn't.

> Best Regards,
> Petr
> 
