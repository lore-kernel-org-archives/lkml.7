Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B1C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9420873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfGTJc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:32:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727373AbfGTJc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:32:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1159EAE2D;
        Sat, 20 Jul 2019 09:32:55 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Waiman Long" <longman@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Will Deacon" <will.deacon@arm.com>,
        "huang ying" <huang.ying.caritas@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
References: <20190520205918.22251-1-longman@redhat.com>
        <20190520205918.22251-14-longman@redhat.com>
        <20190719184538.GA20324@hermes.olymp>
        <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
        <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
        <87h87hksim.fsf@suse.com>
Date:   Sat, 20 Jul 2019 10:32:53 +0100
In-Reply-To: <87h87hksim.fsf@suse.com> (Luis Henriques's message of "Sat, 20
        Jul 2019 09:41:05 +0100")
Message-ID: <87a7d9kq4a.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Henriques <lhenriques@suse.com> writes:

> "Linus Torvalds" <torvalds@linux-foundation.org> writes:
>
>> On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>>>
>>> This patch shouldn't change the behavior of the rwsem code. The code
>>> only access data within the rw_semaphore structures. I don't know why it
>>> will cause a KASAN error. I will have to reproduce it and figure out
>>> exactly which statement is doing the invalid access.
>>
>> The stack traces should show line numbers if you run them through
>> scripts/decode_stacktrace.sh.
>>
>> You need to have debug info enabled for that, though.
>>
>> Luis?
>>
>>              Linus
>
> Yep, sure.  And I should have done this in the initial report.  It's a
> different trace, I had to recompile the kernel.
>
> (I'm also adding Jeff to the CC list.)
>

Ah, and I also managed to reproduce this on btrfs so I guess this rules
out a bug in the filesystem code.

Cheers,
-- 
Luis
