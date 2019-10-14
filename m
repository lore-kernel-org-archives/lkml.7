Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79162ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B63420650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfJNIa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNIaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4517210DCC82;
        Mon, 14 Oct 2019 08:30:55 +0000 (UTC)
Received: from [10.36.117.10] (ovpn-117-10.ams2.redhat.com [10.36.117.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDB8560920;
        Mon, 14 Oct 2019 08:30:53 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20191010141200.8985-1-david@redhat.com>
 <20191011151634.0b566c9e32e8d0e11181d025@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9fd1f157-d812-3a3b-813a-d34e0cc53f96@redhat.com>
Date:   Mon, 14 Oct 2019 10:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011151634.0b566c9e32e8d0e11181d025@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Mon, 14 Oct 2019 08:30:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.19 00:16, Andrew Morton wrote:
> On Thu, 10 Oct 2019 16:12:00 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Uninitialized memmaps contain garbage and in the worst case trigger kernel
>> BUGs, especially with CONFIG_PAGE_POISONING. They should not get
>> touched.
>>
>> Right now, when trying to soft-offline a PFN that resides on a memory
>> block that was never onlined, one gets a misleading error with
>> CONFIG_PAGE_POISONING:
>>    :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
>>    [   23.097167] soft offline: 0x150000 page already poisoned
>>
>> But the actual result depends on the garbage in the memmap.
>>
>> soft_offline_page() can only work with online pages, it returns -EIO in
>> case of ZONE_DEVICE. Make sure to only forward pages that are online
>> (iow, managed by the buddy) and, therefore, have an initialized memmap.
>>
>> Add a check against pfn_to_online_page() and similarly return -EIO.
>>
>> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> 
> Should this be cc:stable?

I think yes, more on that below.

> 
> What is the relationship between this and some similar fixes in the
> series "mm/memory_hotplug: Shrink zones before removing memory", v6?

In general, they all have the same root cause. With f1dd2cd13c4b, we 
started to initialize the memmap when onlining memory, however, we at 
least zeroed it out when adding the memory. With d0dc12e86b319 we 
removed the zeroing, and added conditional poisoning instead.

All these BUGs can be reproduced by adding memory and keeping some 
memory blocks offline. Most distributions either online memory directly 
in the kernel when added or userspace onlines it via udev rules. s390x 
is special, because there we don't online memory blocks as default in 
user space. So on !s390x systems, these BUGs are quite hard to reproduce.

With "mm/memory_hotplug: Shrink zones before removing memory" these BUGs 
get easier to reproduce, because it is now sufficient to offline a 
memory block that was already onlined.

Also, devmem with "driver reserved memory" (for which part we don't 
initialize the memmap) is able to trigger these BUGs, but that feature 
is more recent AFAIK.

So, cc:stable, I am not sure if it applies to all patches. Some really 
only trigger when page poisoning is active, but don't result in any 
damage (as so far observed). We really produce damage in case we 
de-reference the NID/zone via the garbage memmap (and probably when 
doing a page_to_pfn(pfn_to_page(gargabe_page))).

But here, it is quite hard to tell what could happen, so I guess, if in 
doubt, better add cc:stable?

> 
> Should any of the patches in "mm/memory_hotplug: Shrink zones before
> removing memory", v6 be cc:stable?
> 

I'll go over all patches and reply to the relevant ones.



So for this patch, please add:

Cc: stable@vger.kernel.org # v4.13+

-- 

Thanks,

David / dhildenb
