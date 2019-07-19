Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B3521849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfGSUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfGSUOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:14:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48E4530C1E2F;
        Fri, 19 Jul 2019 20:14:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79EB451DE6;
        Fri, 19 Jul 2019 20:14:34 +0000 (UTC)
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp>
 <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com> <87lfwtlsf7.fsf@suse.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <da3d3b39-ede2-1e0c-e7f6-ea918d20d0f9@redhat.com>
Date:   Fri, 19 Jul 2019 16:14:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87lfwtlsf7.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 19 Jul 2019 20:14:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/19 3:45 PM, Luis Henriques wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> On 7/19/19 2:45 PM, Luis Henriques wrote:
>>> On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
>>>> The rwsem->owner contains not just the task structure pointer, it also
>>>> holds some flags for storing the current state of the rwsem. Some of
>>>> the flags may have to be atomically updated. To reflect the new reality,
>>>> the owner is now changed to an atomic_long_t type.
>>>>
>>>> New helper functions are added to properly separate out the task
>>>> structure pointer and the embedded flags.
>>> I started seeing KASAN use-after-free with current master, and a bisect
>>> showed me that this commit 94a9717b3c40 ("locking/rwsem: Make
>>> rwsem->owner an atomic_long_t") was the problem.  Does it ring any
>>> bells?  I can easily reproduce it with xfstests (generic/464).
>>>
>>> Cheers,
>>> --
>>> Luís
>> This patch shouldn't change the behavior of the rwsem code. The code
>> only access data within the rw_semaphore structures. I don't know why it
>> will cause a KASAN error. I will have to reproduce it and figure out
>> exactly which statement is doing the invalid access.
> Yeah, screwing the bisection is something I've done in the past so I may
> have got the wrong commit.  Another detail is that I was running
> xfstests against CephFS, I didn't tried with any other filesystem.  I
> can try to reproduce with btrfs or xfs next week.
>
> Cheers,

Oh, I don't have a CephFS setup. Will you use the
scripts/decode_stacktrace.sh to find what line number is the offending
statement? That will help in figuring out what has gone wrong.

Anyway, it seems like a structure that include a rwsem is freed while
another cpu is still waiting to acquire the lock. It is probably a
hidden bug in the filesystem code somewhere that the recent changes in
rwsem behavior make it easier for  the problem to show up.

Cheers,
Longman

