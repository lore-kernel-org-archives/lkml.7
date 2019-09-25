Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA47C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1843C21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392463AbfIYTs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfIYTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD55B2D7E1;
        Wed, 25 Sep 2019 19:48:56 +0000 (UTC)
Received: from [10.36.116.51] (ovpn-116-51.ams2.redhat.com [10.36.116.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 902A01001B12;
        Wed, 25 Sep 2019 19:48:54 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
To:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190924143615.19628-1-david@redhat.com>
 <1569337401.5576.217.camel@lca.pw> <20190924151147.GB23050@dhcp22.suse.cz>
 <1569351244.5576.219.camel@lca.pw>
 <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
 <1569427262.5576.225.camel@lca.pw> <20190925174809.GM23050@dhcp22.suse.cz>
 <1569435659.5576.227.camel@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <92bce3d4-0a3e-e157-529d-35aafbc30f3b@redhat.com>
Date:   Wed, 25 Sep 2019 21:48:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569435659.5576.227.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 25 Sep 2019 19:48:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.19 20:20, Qian Cai wrote:
> On Wed, 2019-09-25 at 19:48 +0200, Michal Hocko wrote:
>> On Wed 25-09-19 12:01:02, Qian Cai wrote:
>>> On Wed, 2019-09-25 at 09:02 +0200, David Hildenbrand wrote:
>>>> On 24.09.19 20:54, Qian Cai wrote:
>>>>> On Tue, 2019-09-24 at 17:11 +0200, Michal Hocko wrote:
>>>>>> On Tue 24-09-19 11:03:21, Qian Cai wrote:
>>>>>> [...]
>>>>>>> While at it, it might be a good time to rethink the whole locking over there, as
>>>>>>> it right now read files under /sys/kernel/slab/ could trigger a possible
>>>>>>> deadlock anyway.
>>>>>>>
>>>>>>
>>>>>> [...]
>>>>>>> [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
>>>>>>> [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
>>>>>>> [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
>>>>>>> [  442.469930][ T5224]        lock_acquire+0x31c/0x360
>>>>>>> [  442.474803][ T5224]        get_online_mems+0x54/0x150
>>>>>>> [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
>>>>>>> [  442.485072][ T5224]        total_objects_show+0x28/0x34
>>>>>>> [  442.490292][ T5224]        slab_attr_show+0x38/0x54
>>>>>>> [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
>>>>>>> [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
>>>>>>> [  442.505433][ T5224]        seq_read+0x30c/0x8a8
>>>>>>> [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
>>>>>>> [  442.515007][ T5224]        __vfs_read+0x88/0x20c
>>>>>>> [  442.519620][ T5224]        vfs_read+0xd8/0x10c
>>>>>>> [  442.524060][ T5224]        ksys_read+0xb0/0x120
>>>>>>> [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
>>>>>>> [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
>>>>>>> [  442.538768][ T5224]        el0_svc+0x8/0xc
>>>>>>
>>>>>> I believe the lock is not really needed here. We do not deallocated
>>>>>> pgdat of a hotremoved node nor destroy the slab state because an
>>>>>> existing slabs would prevent hotremove to continue in the first place.
>>>>>>
>>>>>> There are likely details to be checked of course but the lock just seems
>>>>>> bogus.
>>>>>
>>>>> Check 03afc0e25f7f ("slab: get_online_mems for
>>>>> kmem_cache_{create,destroy,shrink}"). It actually talk about the races during
>>>>> memory as well cpu hotplug, so it might even that cpu_hotplug_lock removal is
>>>>> problematic?
>>>>>
>>>>
>>>> Which removal are you referring to? get_online_mems() does not mess with
>>>> the cpu hotplug lock (and therefore this patch).
>>>
>>> The one in your patch. I suspect there might be races among the whole NUMA node
>>> hotplug, kmem_cache_create, and show_slab_objects(). See bfc8c90139eb ("mem-
>>> hotplug: implement get/put_online_mems")
>>>
>>> "kmem_cache_{create,destroy,shrink} need to get a stable value of cpu/node
>>> online mask, because they init/destroy/access per-cpu/node kmem_cache parts,
>>> which can be allocated or destroyed on cpu/mem hotplug."
>>
>> I still have to grasp that code but if the slub allocator really needs
>> a stable cpu mask then it should be using the explicit cpu hotplug
>> locking rather than rely on side effect of memory hotplug locking.
>>
>>> Both online_pages() and show_slab_objects() need to get a stable value of
>>> cpu/node online mask.
>>
>> Could tou be more specific why online_pages need a stable cpu online
>> mask? I do not think that show_slab_objects is a real problem because a
>> potential race shouldn't be critical.
> 
> build_all_zonelists()
>   __build_all_zonelists()
>     for_each_online_cpu(cpu)
> 

Two things:

a) We currently always hold the device hotplug lock when onlining memory
and when onlining cpus (for CPUs at least via user space - we would have
to double check other call paths). So theoretically, that should guard
us from something like that already.

b)

commit 11cd8638c37f6c400cc472cc52b6eccb505aba6e
Author: Michal Hocko <mhocko@suse.com>
Date:   Wed Sep 6 16:20:34 2017 -0700

    mm, page_alloc: remove stop_machine from build_all_zonelists

Tells me:

"Updates of the zonelists happen very seldom, basically only when a zone
 becomes populated during memory online or when it loses all the memory
 during offline.  A racing iteration over zonelists could either miss a
 zone or try to work on one zone twice.  Both of these are something we
 can live with occasionally because there will always be at least one
 zone visible so we are not likely to fail allocation too easily for
 example."

Sounds like if there would be a race, we could live with it if I am not
getting that totally wrong.

-- 

Thanks,

David / dhildenb
