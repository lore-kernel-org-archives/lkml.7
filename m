Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A89C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E113206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfGUUt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:49:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfGUUt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:49:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B713AF33;
        Sun, 21 Jul 2019 20:49:54 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        "huang ying" <huang.ying.caritas@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
References: <20190520205918.22251-1-longman@redhat.com>
        <20190520205918.22251-14-longman@redhat.com>
        <20190719184538.GA20324@hermes.olymp>
        <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
        <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
        <87h87hksim.fsf@suse.com>
        <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com>
Date:   Sun, 21 Jul 2019 21:49:50 +0100
In-Reply-To: <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com> (Waiman Long's
        message of "Sat, 20 Jul 2019 11:04:10 -0400")
Message-ID: <87wogbjeoh.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 7/20/19 4:41 AM, Luis Henriques wrote:
>> "Linus Torvalds" <torvalds@linux-foundation.org> writes:
>>
>>> On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>>>> This patch shouldn't change the behavior of the rwsem code. The code
>>>> only access data within the rw_semaphore structures. I don't know why it
>>>> will cause a KASAN error. I will have to reproduce it and figure out
>>>> exactly which statement is doing the invalid access.
>>> The stack traces should show line numbers if you run them through
>>> scripts/decode_stacktrace.sh.
>>>
>>> You need to have debug info enabled for that, though.
>>>
>>> Luis?
>>>
>>>              Linus
>> Yep, sure.  And I should have done this in the initial report.  It's a
>> different trace, I had to recompile the kernel.
>>
>> (I'm also adding Jeff to the CC list.)
>>
>> Cheers,
>
> Thanks for the information. I think I know where the problem is. Would
> you mind applying the attached patch to see if it can fix the KASAN error.

Yep, that seems to work -- I can't reproduce the error anymore (and
sorry for the delay).  Thanks!  And feel free to add my Tested-by.

Cheers,
-- 
Luis
