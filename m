Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC24B217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbfEXSvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391376AbfEXSvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 133B9307D911;
        Fri, 24 May 2019 18:50:57 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB0B41001E6C;
        Fri, 24 May 2019 18:50:53 +0000 (UTC)
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <8ceebb1c-e8f1-8bc5-e032-48f1a653a979@redhat.com>
 <20190524173915.GB9120@fuggles.cambridge.arm.com>
 <ed19cb78-3c00-4788-5369-73bcd8199e15@redhat.com>
 <20190524183258.GD9697@fuggles.cambridge.arm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3adcd994-7e9e-2f1b-fea3-9084cb641eda@redhat.com>
Date:   Fri, 24 May 2019 14:50:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524183258.GD9697@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 24 May 2019 18:51:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 2:32 PM, Will Deacon wrote:
> On Fri, May 24, 2019 at 02:11:23PM -0400, Waiman Long wrote:
>> On 5/24/19 1:39 PM, Will Deacon wrote:
>>
>>             And the whole "not precise" thing should be documented, of course.
>>
>>         Yes, I will update the patch to document that fact that the count may
>>         not be precise. Anyway even if we have a 1-2% error, it is not a big
>>         deal in term of presenting a global picture of what operations are being
>>         done.
>>
>>     I suppose one alternative would be to have a per-cpu local_t variable,
>>     and do the increments on that. However, that's probably worse than the
>>     current approach for x86.
>>
>> I don't quite understand what you mean by per-cpu local_t variable. A per-cpu
>> variable is either statically allocated or dynamically allocated. Even with
>> dynamical allocation, the same problem exists, I think unless you differentiate
>> between irq context and process context. That will make it a lot more messier,
>> I think.
> So I haven't actually tried this to see if it works, but all I meant was
> that you could replace the current:
>
> DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);
>
> with:
>
> DECLARE_PER_CPU(local_t, lockevents[lockevent_num]);
>
> and then rework the inc/add macros to use a combination of raw_cpu_ptr
> and local_inc().
>
> I think that would allow you to get rid of the #ifdeffery, but it may
> introduce a small overhead for x86.

OK, I was not aware of the local_t type. Anyway, the x86 local_t type
perform similar single-instruction update. On other architectures that
can't do that, it will be a real atomic operation which will be more costly.

-Longman

