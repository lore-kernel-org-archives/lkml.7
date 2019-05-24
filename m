Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F34C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72D32184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404150AbfEXRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404131AbfEXRfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 533573084295;
        Fri, 24 May 2019 17:35:43 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE52A5F7D7;
        Fri, 24 May 2019 17:35:39 +0000 (UTC)
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190524165346.26373-1-longman@redhat.com>
 <20190524171939.GA9120@fuggles.cambridge.arm.com>
 <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8ceebb1c-e8f1-8bc5-e032-48f1a653a979@redhat.com>
Date:   Fri, 24 May 2019 13:35:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 24 May 2019 17:35:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 1:27 PM, Linus Torvalds wrote:
> On Fri, May 24, 2019 at 10:19 AM Will Deacon <will.deacon@arm.com> wrote:
>> Are you sure this works wrt IRQs? For example, if I take an interrupt when
>> trying to update the counter, and then the irq handler takes a qspinlock
>> which in turn tries to update the counter. Would I lose an update in that
>> scenario?
> Sounds about right.
>
> We might decide that the lock event counters are not necessarily
> precise, but just rough guide-line statistics ("close enough in
> practice")
>
> But that would imply that it shouldn't be dependent on CONFIG_PREEMPT
> at all, and we should always use the double-underscore version, except
> without the debug checking.
>
> Maybe the #ifdef should just be CONFIG_PREEMPT_DEBUG, with a comment
> saying "we're not exact, but debugging complains, so if you enable
> debugging it will be slower and precise". Because I don't think we
> have a "do this unsafely and without any debugging" option.

I am not too worry about losing count here and there once in a while
because of interrupts, but the possibility of having the count from one
CPU to be put into another CPU in a preempt kernel may distort the total
count significantly. This is what I want to avoid.


>
> And the whole "not precise" thing should be documented, of course.

Yes, I will update the patch to document that fact that the count may
not be precise. Anyway even if we have a 1-2% error, it is not a big
deal in term of presenting a global picture of what operations are being
done.

Cheers,
Longman

