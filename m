Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAEBC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDDF20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfD2A15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 20:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfD2A14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 20:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 524F081F0F;
        Mon, 29 Apr 2019 00:27:56 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91764A3;
        Mon, 29 Apr 2019 00:27:54 +0000 (UTC)
Subject: Re: [PATCH-tip v7 00/20] locking/rwsem: Rwsem rearchitecture part 2
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
        huang ying <huang.ying.caritas@gmail.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
 <3f8fd44d-1962-e309-49b5-bb16fd662312@redhat.com>
 <CAHk-=wg_facR6y3gnmtGwBSJYZdHm5rWSPpPhJG6XswW4+mO1Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <604c8751-5269-de29-0b7f-b3e93b6df4ca@redhat.com>
Date:   Sun, 28 Apr 2019 20:27:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg_facR6y3gnmtGwBSJYZdHm5rWSPpPhJG6XswW4+mO1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 Apr 2019 00:27:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/19 8:10 PM, Linus Torvalds wrote:
> On Sun, Apr 28, 2019 at 4:12 PM Waiman Long <longman@redhat.com> wrote:
>> I implemented your suggestion in patch 1 as it will produce simpler and
>> faster code. However, one of the changes in my patchset is to wake up
>> all the readers in the wait list. This means I have to jump over the
>> writers and wake up the readers behind them as well. See patch 11 for
>> details. As a result, I have to revert back to use list_add_tail() and
>> list_for_each_entry_safe() for the first pass. That is why the diff for
>> the whole patchset is just the below change. It is done on purpose, not
>> an omission.
> Ahh, ok. In that case I suspect the clever code isn't even worth it,
> since it very much depends on just splitting the list in a fixed
> place.
>
>                    Linus

Not really, this is a serious problem that have to be backported to
earlier stable releases and downstream. The clever code is helpful in
those cases.

Cheers,
Longman

