Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F1C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFABD20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfEPOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:25:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:55298 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfEPOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:25:11 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hRHJj-0007J4-HM; Thu, 16 May 2019 17:25:07 +0300
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
 <20190515193841.GA29728@angband.pl>
 <7136aa47-3ce5-243d-6c92-5893b7b1379d@virtuozzo.com>
 <20190516134220.GB24860@angband.pl>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <14efd2c5-ffd1-84ad-b1d1-42f8ef44d7e2@virtuozzo.com>
Date:   Thu, 16 May 2019 17:25:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516134220.GB24860@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.2019 16:42, Adam Borowski wrote:
> On Thu, May 16, 2019 at 04:10:07PM +0300, Kirill Tkhai wrote:
>> On 15.05.2019 22:38, Adam Borowski wrote:
>>> On Wed, May 15, 2019 at 06:11:15PM +0300, Kirill Tkhai wrote:
>>>> This patchset adds a new syscall, which makes possible
>>>> to clone a mapping from a process to another process.
>>>> The syscall supplements the functionality provided
>>>> by process_vm_writev() and process_vm_readv() syscalls,
>>>> and it may be useful in many situation.
>>>>
>>>> For example, it allows to make a zero copy of data,
>>>> when process_vm_writev() was previously used:
>>>
>>> I wonder, why not optimize the existing interfaces to do zero copy if
>>> properly aligned?  No need for a new syscall, and old code would immediately
>>> benefit.
>>
>> Because, this is just not possible. You can't zero copy anonymous pages
>> of a process to pages of a remote process, when they are different pages.
> 
> fork() manages that, and so does KSM.  Like KSM, you want to make a page
> shared -- you just skip the comparison step as you want to overwrite the old
> contents.
> 
> And there's no need to touch the page, as fork() manages that fine no matter
> if the page is resident, anonymous in swap, or file-backed, all without
> reading from swap.

Yes, and in case of you dive into the patchset, you will found the new syscall
manages page table entries in the same way fork() makes.
 
>>>> There are several problems with process_vm_writev() in this example:
>>>>
>>>> 1)it causes pagefault on remote process memory, and it forces
>>>>   allocation of a new page (if was not preallocated);
>>>>
>>>> 2)amount of memory for this example is doubled in a moment --
>>>>   n pages in current and n pages in remote tasks are occupied
>>>>   at the same time;
>>>>
>>>> 3)received data has no a chance to be properly swapped for
>>>>   a long time.
>>>
>>> That'll handle all of your above problems, except for making pages
>>> subject to CoW if written to.  But if making pages writeably shared is
>>> desired, the old functions have a "flags" argument that doesn't yet have a
>>> single bit defined.
> 
> 
> Meow!
> 

