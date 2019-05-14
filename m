Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC90C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5B220675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfENJMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:12:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:58800 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:12:30 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQTTt-0001sf-Bj; Tue, 14 May 2019 12:12:17 +0300
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
 <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
 <a3870e32-3a27-e6df-fcb2-79080cdd167a@virtuozzo.com>
 <20190514063043.ojhsb6d3ohxx4wur@butterfly.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8f146863-5963-81b2-ed20-6428d1da353c@virtuozzo.com>
Date:   Tue, 14 May 2019 12:12:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514063043.ojhsb6d3ohxx4wur@butterfly.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.05.2019 09:30, Oleksandr Natalenko wrote:
> Hi.
> 
> On Mon, May 13, 2019 at 03:37:56PM +0300, Kirill Tkhai wrote:
>>> Yes, I get your point. But the intention is to avoid another hacky trick
>>> (LD_PRELOAD), thus *something* should *preferably* be done on the
>>> kernel level instead.
>>
>> I don't think so. Does userspace hack introduce some overhead? It does not
>> look so. Why should we think about mergeable VMAs in page fault handler?!
>> This is the last thing we want to think in page fault handler.
>>
>> Also, there is difficult synchronization in page fault handlers, and it's
>> easy to make a mistake. So, there is a mistake in [3/4], and you call
>> ksm_enter() with mmap_sem read locked, while normal way is to call it
>> with write lock (see madvise_need_mmap_write()).
>>
>> So, let's don't touch this path. Small optimization for unlikely case will
>> introduce problems in optimization for likely case in the future.
> 
> Yup, you're right, I've missed the fact that write lock is needed there.
> Re-vamping locking there is not my intention, so lets find another
> solution.
> 
>>> Also, just for the sake of another piece of stats here:
>>>
>>> $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
>>> 526
>>
>> This all requires attentive analysis. The number looks pretty big for me.
>> What are the pages you get merged there? This may be just zero pages,
>> you have identical.
>>
>> E.g., your browser want to work fast. It introduces smart schemes,
>> and preallocates many pages in background (mmap + write 1 byte to a page),
>> so in further it save some time (no page fault + alloc), when page is
>> really needed. But your change merges these pages and kills this
>> optimization. Sounds not good, does this?
>>
>> I think, we should not think we know and predict better than application
>> writers, what they want from kernel. Let's people decide themselves
>> in dependence of their workload. The only exception is some buggy
>> or old applications, which impossible to change, so force madvise
>> workaround may help. But only in case there are really such applications...
>>
>> I'd researched what pages you have duplicated in these 526 MB. Maybe
>> you find, no action is required or a report to userspace application
>> to use madvise is needed.
> 
> OK, I agree, this is a good argument to move decision to userspace.
> 
>>> 2) what kinds of opt-out we should maintain? Like, what if force_madvise
>>> is called, but the task doesn't want some VMAs to be merged? This will
>>> required new flag anyway, it seems. And should there be another
>>> write-only file to unmerge everything forcibly for specific task?
>>
>> For example,
>>
>> Merge:
>> #echo $task > /sys/kernel/mm/ksm/force_madvise
> 
> Immediate question: what should be actually done on this? I see 2
> options:
> 
> 1) mark all VMAs as mergeable + set some flag for mmap() to mark all
> further allocations as mergeable as well;
> 2) just mark all the VMAs as mergeable; userspace can call this
> periodically to mark new VMAs.
> 
> My prediction is that 2) is less destructive, and the decision is
> preserved predominantly to userspace, thus it would be a desired option.

Let's see, how we use KSM now. It's good for virtual machines: people
install the same distribution in several VMs, and they have the same
packages and the same files. When you read a file inside VM, its pages
are file cache for the VM, but they are anonymous pages for host kernel.

Hypervisor marks VM memory as mergeable, and host KSM merges the same
anonymous pages together. Many of file cache inside VM is constant
content, so we have good KSM compression on such the file pages.
The result we have is explainable and expected.

But we don't know anything about pages, you have merged on your laptop.
We can't make any assumptions before analysis of applications, which
produce such the pages. Let's check what happens before we try to implement
some specific design (if we really need something to implement).

The rest is just technical details. We may implement everything we need
on top of this (even implement a polling of /proc/[pid]/maps and write
a task and address of vma to force_madvise or similar file).

Kirill
