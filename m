Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A18621842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfGWC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:57:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfGWC5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6AAE5D674;
        Tue, 23 Jul 2019 02:57:07 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65BAB60603;
        Tue, 23 Jul 2019 02:57:05 +0000 (UTC)
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp>
 <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
 <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
 <87h87hksim.fsf@suse.com> <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com>
 <87wogbjeoh.fsf@suse.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <82c9383c-487f-1e13-2bbd-4767ac634a79@redhat.com>
Date:   Mon, 22 Jul 2019 22:57:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87wogbjeoh.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 23 Jul 2019 02:57:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/19 4:49 PM, Luis Henriques wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> On 7/20/19 4:41 AM, Luis Henriques wrote:
>>> "Linus Torvalds" <torvalds@linux-foundation.org> writes:
>>>
>>>> On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>>>>> This patch shouldn't change the behavior of the rwsem code. The code
>>>>> only access data within the rw_semaphore structures. I don't know why it
>>>>> will cause a KASAN error. I will have to reproduce it and figure out
>>>>> exactly which statement is doing the invalid access.
>>>> The stack traces should show line numbers if you run them through
>>>> scripts/decode_stacktrace.sh.
>>>>
>>>> You need to have debug info enabled for that, though.
>>>>
>>>> Luis?
>>>>
>>>>              Linus
>>> Yep, sure.  And I should have done this in the initial report.  It's a
>>> different trace, I had to recompile the kernel.
>>>
>>> (I'm also adding Jeff to the CC list.)
>>>
>>> Cheers,
>> Thanks for the information. I think I know where the problem is. Would
>> you mind applying the attached patch to see if it can fix the KASAN error.
> Yep, that seems to work -- I can't reproduce the error anymore (and
> sorry for the delay).  Thanks!  And feel free to add my Tested-by.
>
> Cheers,

Thanks for the testing. I will post the official patch tomorrow.

Cheers,
Longman

