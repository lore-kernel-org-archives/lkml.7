Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51317C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409771AbfIXPBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390565AbfIXPBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2D8BC057F88;
        Tue, 24 Sep 2019 15:01:38 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1545060BFB;
        Tue, 24 Sep 2019 15:01:36 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190924143615.19628-1-david@redhat.com>
 <20190924144846.GA23050@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <fe50c38c-df15-26c1-e8f5-04c17937a534@redhat.com>
Date:   Tue, 24 Sep 2019 17:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924144846.GA23050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 24 Sep 2019 15:01:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.19 16:48, Michal Hocko wrote:
> On Tue 24-09-19 16:36:15, David Hildenbrand wrote:
>> Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
>> rwsem") we do a cpus_read_lock() in mem_hotplug_begin(). This was
>> introduced to fix a potential deadlock between get_online_mems() and
>> get_online_cpus() - the memory and cpu hotplug lock. The root issue was
>> that build_all_zonelists() -> stop_machine() required the cpu hotplug lock:
>>     The reason is that memory hotplug takes the memory hotplug lock and
>>     then calls stop_machine() which calls get_online_cpus().  That's the
>>     reverse lock order to get_online_cpus(); get_online_mems(); in
>>     mm/slub_common.c
>>
>> So memory hotplug never really required any cpu lock itself, only
>> stop_machine() and lru_add_drain_all() required it. Back then,
>> stop_machine_cpuslocked() and lru_add_drain_all_cpuslocked() were used
>> as the cpu hotplug lock was now obtained in the caller.
>>
>> Since commit 11cd8638c37f ("mm, page_alloc: remove stop_machine from build
>> all_zonelists"), the stop_machine_cpuslocked() call is gone.
>> build_all_zonelists() does no longer require the cpu lock and does no
>> longer make use of stop_machine().
>>
>> Since commit 9852a7212324 ("mm: drop hotplug lock from
>> lru_add_drain_all()"), lru_add_drain_all() "Doesn't need any cpu hotplug
>> locking because we do rely on per-cpu kworkers being shut down before our
>> page_alloc_cpu_dead callback is executed on the offlined cpu.". The
>> lru_add_drain_all_cpuslocked() variant was removed.
>>
>> So there is nothing left that requires the cpu hotplug lock. The memory
>> hotplug lock and the device hotplug lock are sufficient.
> 
> I would love to see this happen. The biggest offenders should be gone. 
> I really hated how those two locks have been conflated which likely
> resulted in some undocumented/unintended dependencies. So for now, I
> cannot really tell you whether the patch is correct. It would really
> require a lot of testing. I am not sure this is reasonably reviewable.

At least judging from the obvious history, this should be fine. But the
bad parts are undocumented side effects that sneaked in in the meantime.
I agree that reviewing this is hard - too much hidden and undocumented
complexity.

> 
> So please add some testing results (ideally cpu hotplug racing a lot
> with the memory hotplug). Then I would be willing to give this a try
> and see. First by keeping it in linux-next for a release or two and then
> eyes closed, fingers crossed and go to the wild. Do we have a tag for
> that Dared-by maybe?

I'll do some more testing to try to find the obvious issues. But I
suspect if there are still some leftovers, they will be hard to trigger.
So I agree that keeping this in linux-next for a longer period sounds
like a good idea.

Tentatively-Acked-by ? :D

> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> RFC -> v1:
>> - Reword and add more details why the cpu hotplug lock was needed here
>>   in the first place, and why we no longer require it.
>>
>> ---
>>  mm/memory_hotplug.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index c3e9aed6023f..5fa30f3010e1 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -88,14 +88,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
>>  
>>  void mem_hotplug_begin(void)
>>  {
>> -	cpus_read_lock();
>>  	percpu_down_write(&mem_hotplug_lock);
>>  }
>>  
>>  void mem_hotplug_done(void)
>>  {
>>  	percpu_up_write(&mem_hotplug_lock);
>> -	cpus_read_unlock();
>>  }
>>  
>>  u64 max_mem_size = U64_MAX;
>> -- 
>> 2.21.0
> 


-- 

Thanks,

David / dhildenb
