Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9496C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC1221873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbfGSTpg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:45:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387668AbfGSTpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E00FACBC;
        Fri, 19 Jul 2019 19:45:33 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>,
        "huang ying" <huang.ying.caritas@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an atomic_long_t
References: <20190520205918.22251-1-longman@redhat.com>
        <20190520205918.22251-14-longman@redhat.com>
        <20190719184538.GA20324@hermes.olymp>
        <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
Date:   Fri, 19 Jul 2019 20:45:32 +0100
In-Reply-To: <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com> (Waiman Long's
        message of "Fri, 19 Jul 2019 15:32:10 -0400")
Message-ID: <87lfwtlsf7.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 7/19/19 2:45 PM, Luis Henriques wrote:
>> On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
>>> The rwsem->owner contains not just the task structure pointer, it also
>>> holds some flags for storing the current state of the rwsem. Some of
>>> the flags may have to be atomically updated. To reflect the new reality,
>>> the owner is now changed to an atomic_long_t type.
>>>
>>> New helper functions are added to properly separate out the task
>>> structure pointer and the embedded flags.
>> I started seeing KASAN use-after-free with current master, and a bisect
>> showed me that this commit 94a9717b3c40 ("locking/rwsem: Make
>> rwsem->owner an atomic_long_t") was the problem.  Does it ring any
>> bells?  I can easily reproduce it with xfstests (generic/464).
>>
>> Cheers,
>> --
>> Luís
>
> This patch shouldn't change the behavior of the rwsem code. The code
> only access data within the rw_semaphore structures. I don't know why it
> will cause a KASAN error. I will have to reproduce it and figure out
> exactly which statement is doing the invalid access.

Yeah, screwing the bisection is something I've done in the past so I may
have got the wrong commit.  Another detail is that I was running
xfstests against CephFS, I didn't tried with any other filesystem.  I
can try to reproduce with btrfs or xfs next week.

Cheers,
-- 
Luis
