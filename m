Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C72C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3269E206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfD1TkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfD1TkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:40:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDC493086200;
        Sun, 28 Apr 2019 19:40:04 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46AEA171FC;
        Sun, 28 Apr 2019 19:40:02 +0000 (UTC)
Subject: Re: [PATCH-tip v6 01/20] locking/rwsem: Prevent decrement of reader
 count before increment
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        stable <stable@vger.kernel.org>
References: <20190428155755.14267-1-longman@redhat.com>
 <20190428155755.14267-2-longman@redhat.com>
 <CAHk-=wgCrtM7fPd=qmmg6UUDRcw9iq7a7_ypOHH3740xgv6wkQ@mail.gmail.com>
 <CAHk-=wgGN9KKCW8dii=nXwKQdu2N5AOMrVdS5qJvZAPOTvwHjA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d251f785-407e-d63f-0591-de6251f6b14f@redhat.com>
Date:   Sun, 28 Apr 2019 15:40:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgGN9KKCW8dii=nXwKQdu2N5AOMrVdS5qJvZAPOTvwHjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 28 Apr 2019 19:40:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/19 1:59 PM, Linus Torvalds wrote:
> On Sun, Apr 28, 2019 at 10:41 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> It's the *first* loop that you could play games with, because you hold
>> the lock, and the list is stable during that loop. So the *first* loop
>> could just walk the list, and then do one list splitting operation
>> instead of doing that "list_move_tail()" thing for each entry.
> .. having looked at that, I would suggest against it.
>
> I _think_ this short and sweet code snippet might just work fine for
> the first loop:
>
>         list_for_each_entry(waiter, &sem->wait_list, list) {
>                 if (waiter->type == RWSEM_WAITING_FOR_WRITE)
>                         break;
>                 woken++;
>         }
>         list_cut_before(&wlist, &sem->wait_list, waiter);
>
> and if it *does* work it would be both smaller and more efficient. But
> it looks a bit too subtle to my taste. Somebody would need to go
> through that with a fine comb, and double-check that it gets the
> "whole list" case right, for example.
>
> So the "phase 1" loop could be perhaps simplified to the above cute things.
>
> But the "phase 2" loop absolutely has to be changed to use
> list_for_each_entry_safe().
>
>                Linus

You are right. Thanks for checking my code. I will make the necessary
change.

Cheers,
Longman

