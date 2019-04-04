Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F7F20700
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDDFFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:05:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfDDFFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:05:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBA84AD8A;
        Thu,  4 Apr 2019 05:05:27 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
Date:   Thu, 4 Apr 2019 07:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 18:01, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 11:39:09AM -0400, Alex Kogan wrote:
> 
>>>> The patch that I am looking for is to have a separate
>>>> numa_queued_spinlock_slowpath() that coexists with
>>>> native_queued_spinlock_slowpath() and
>>>> paravirt_queued_spinlock_slowpath(). At boot time, we select the most
>>>> appropriate one for the system at hand.
>> Is this how this selection works today for paravirt?
>> I see a PARAVIRT_SPINLOCKS config option, but IIUC you are talking about a different mechanism here.
>> Can you, please, elaborate or give me a link to a page that explains that?
> 
> Oh man, you ask us to explain how paravirt patching works... that's
> magic :-)
> 
> Basically, the compiler will emit a bunch of indirect calls to the
> various pv_ops.*.* functions.
> 
> Then, at alternative_instructions() <- apply_paravirt() it will rewrite
> all these indirect calls to direct calls to the function pointers that
> are in the pv_ops structure at that time (+- more magic).
> 
> So we initialize the pv_ops.lock.* methods to the normal
> native_queued_spin*() stuff, if KVM/Xen/whatever setup detectors pv
> spnlock support changes the methods to the paravirt_queued_*() stuff.
> 
> If you wnt more details, you'll just have to read
> arch/x86/include/asm/paravirt*.h and arch/x86/kernel/paravirt*.c, I
> don't think there's a coherent writeup of all that.
> 
>>> Agreed; and until we have static_call, I think we can abuse the paravirt
>>> stuff for this.
>>>
>>> By the time we patch the paravirt stuff:
>>>
>>>  check_bugs()
>>>    alternative_instructions()
>>>      apply_paravirt()
>>>
>>> we should already have enumerated the NODE topology and so nr_node_ids()
>>> should be set.
>>>
>>> So if we frob pv_ops.lock.queued_spin_lock_slowpath to
>>> numa_queued_spin_lock_slowpath before that, it should all get patched
>>> just right.
>>>
>>> That of course means the whole NUMA_AWARE_SPINLOCKS thing depends on
>>> PARAVIRT_SPINLOCK, which is a bit awkward…
> 
>> Just to mention here, the patch so far does not address paravirt, but
>> our goal is to add this support once we address all the concerns for
>> the native version.  So we will end up with four variants for the
>> queued_spinlock_slowpath() — one for each combination of
>> native/paravirt and NUMA/non-NUMA.  Or perhaps we do not need a
>> NUMA/paravirt variant?
> 
> I wouldn't bother with a pv version of the numa aware code at all. If
> you have overcommitted guests, topology is likely irrelevant anyway. If
> you have 1:1 pinned guests, they'll not use pv spinlocks anyway.
> 
> So keep it to tertiary choice:
> 
>  - native
>  - native/numa
>  - paravirt

Just for the records: the paravirt variant could easily choose whether
it wants to include a numa version just by using the existing hooks.
With PARAVIRT_SPINLOCK configured I guess even the native case would
need to use the paravirt hooks for selection of native or native/numa.

Without PARAVIRT_SPINLOCK this would be just an alternative() then?

Maybe the resulting code would be much more readable if we'd just
make PARAVIRT_SPINLOCK usable without the other PARAVIRT hooks? So
splitting up PARAVIRT into PARAVIRT_GUEST (timer hooks et al) and
the patching infrastructure, with PARAVIRT_GUEST and PARAVIRT_SPINLOCK
selecting PARAVIRT, and PARAVIRT_XXL selecting PARAVIRT_GUEST.


Juergen
