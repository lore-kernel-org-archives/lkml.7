Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D405C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5FF217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391146AbfEXRAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390210AbfEXRAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 649873179179;
        Fri, 24 May 2019 17:00:17 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36CFF6092D;
        Fri, 24 May 2019 17:00:15 +0000 (UTC)
Subject: Re: [PATCH] locking/lock_events: Use this_cpu_add() when necessary
To:     Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
References: <20190522153953.30341-1-longman@redhat.com>
 <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
 <20190523145839.GB31896@fuggles.cambridge.arm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e6f9465a-2d26-23c4-96b6-4c5945993e6d@redhat.com>
Date:   Fri, 24 May 2019 13:00:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523145839.GB31896@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 24 May 2019 17:00:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 10:58 AM, Will Deacon wrote:
> On Wed, May 22, 2019 at 12:54:13PM -0700, Linus Torvalds wrote:
>> On Wed, May 22, 2019 at 8:40 AM Waiman Long <longman@redhat.com> wrote:
>>> +#if defined(CONFIG_PREEMPT) && \
>>> +   (defined(CONFIG_DEBUG_PREEMPT) || !defined(CONFIG_X86))
>>> +#define lockevent_percpu_inc(x)                this_cpu_inc(x)
>>> +#define lockevent_percpu_add(x, v)     this_cpu_add(x, v)
>> Why that CONFIG_X86 special case?
>>
>> On x86, the regular non-underscore versionm is perfectly fine, and the
>> underscore is no faster or simpler.
>>
>> So just make it be
>>
>>    #if defined(CONFIG_PREEMPT)
>>      .. non-underscore versions..
>>    #else
>>      .. underscore versions ..
>>    #endif
>>
>> and realize that x86 simply doesn't _care_. On x86, it will be one
>> single instruction regardless.
>>
>> Non-x86 may prefer the underscore versions for the non-preempt case.
> To be honest, given this depends on LOCK_EVENT_COUNTS, I'd be inclined to
> keep things simple and drop the underscore versions entirely. Saves having
> to worry about things like "could I take an interrupt during the add?".
>
I have sent out the v2 patch that simplifies the condition. Now the
underscore versions will be used for !preempt kernel and non-underscore
version used in preempt kernel. The non-underscore versions may generate
a lot more unnecessary code when CONFIG_PREEMPT_COUNT is defined.

Cheers,
Longman

