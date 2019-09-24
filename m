Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09573217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfIXPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfIXPXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE10520E9;
        Tue, 24 Sep 2019 15:23:38 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7C360C44;
        Tue, 24 Sep 2019 15:23:36 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
To:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190924143615.19628-1-david@redhat.com>
 <1569337401.5576.217.camel@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <69b3332f-c1b9-05f3-ab12-62b831c0cc6c@redhat.com>
Date:   Tue, 24 Sep 2019 17:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569337401.5576.217.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 24 Sep 2019 15:23:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.19 17:03, Qian Cai wrote:
> On Tue, 2019-09-24 at 16:36 +0200, David Hildenbrand wrote:
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
>>
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
> 
> While at it, it might be a good time to rethink the whole locking over there, as
> it right now read files under /sys/kernel/slab/ could trigger a possible
> deadlock anyway.

We still have another (I think incorrect) splat when onlining/offlining
memory and then removing it e.g., via ACPI. It's also a (problematic ?)
"kn->count" lock in these cases.

E.g., when offlining memory (via sysfs) we first take the kn->count and
then the memory hotplug lock. When removing memory devices we first take
the memory hotplug lock and then the kn->count (to remove the sysfs
files). But at least there we have the device hotplug lock involved to
effectively prohibit any deadlocks. But it's somewhat similar to what
you pasted below (but there, it could as well be that we can just drop
the lock as Michal said).

I wonder if one general solution could be to replace the
device_hotplug_lock by a per-subsystem (memory, cpu) lock. Especially,
in drivers/base/core.c:online_store and when creating/deleting devices
we would take that subsystem lock directly, and not fairly down in the
call paths.

There are only a handful of places (e.g., node onlining/offlining) where
cpu and memory hotplug can race. But we can handle these cases differently.

Eventually we could get rid of the device_hotplug_lock() and use locks
per subsystem instead. That would at least be better compared to what we
have just now (we always need the device hotplug lock and the memory
hotplug lock in memory hotplug paths).

> 
> [  442.258806][ T5224] WARNING: possible circular locking dependency detected
> [  442.265678][ T5224] 5.3.0-rc7-mm1+ #6 Tainted: G             L   
> [  442.271766][ T5224] ------------------------------------------------------
> [  442.278635][ T5224] cat/5224 is trying to acquire lock:
> [  442.283857][ T5224] ffff900012ac3120 (mem_hotplug_lock.rw_sem){++++}, at:
> show_slab_objects+0x94/0x3a8
> [  442.293189][ T5224] 
> [  442.293189][ T5224] but task is already holding lock:
> [  442.300404][ T5224] b8ff009693eee398 (kn->count#45){++++}, at:
> kernfs_seq_start+0x44/0xf0
> [  442.308587][ T5224] 
> [  442.308587][ T5224] which lock already depends on the new lock.
> [  442.308587][ T5224] 
> [  442.318841][ T5224] 
> [  442.318841][ T5224] the existing dependency chain (in reverse order) is:
> [  442.327705][ T5224] 
> [  442.327705][ T5224] -> #2 (kn->count#45){++++}:
> [  442.334413][ T5224]        lock_acquire+0x31c/0x360
> [  442.339286][ T5224]        __kernfs_remove+0x290/0x490
> [  442.344428][ T5224]        kernfs_remove+0x30/0x44
> [  442.349224][ T5224]        sysfs_remove_dir+0x70/0x88
> [  442.354276][ T5224]        kobject_del+0x50/0xb0
> [  442.358890][ T5224]        sysfs_slab_unlink+0x2c/0x38
> [  442.364025][ T5224]        shutdown_cache+0xa0/0xf0
> [  442.368898][ T5224]        kmemcg_cache_shutdown_fn+0x1c/0x34
> [  442.374640][ T5224]        kmemcg_workfn+0x44/0x64
> [  442.379428][ T5224]        process_one_work+0x4f4/0x950
> [  442.384649][ T5224]        worker_thread+0x390/0x4bc
> [  442.389610][ T5224]        kthread+0x1cc/0x1e8
> [  442.394052][ T5224]        ret_from_fork+0x10/0x18
> [  442.398835][ T5224] 
> [  442.398835][ T5224] -> #1 (slab_mutex){+.+.}:
> [  442.405365][ T5224]        lock_acquire+0x31c/0x360
> [  442.410240][ T5224]        __mutex_lock_common+0x16c/0xf78
> [  442.415722][ T5224]        mutex_lock_nested+0x40/0x50
> [  442.420855][ T5224]        memcg_create_kmem_cache+0x38/0x16c
> [  442.426598][ T5224]        memcg_kmem_cache_create_func+0x3c/0x70
> [  442.432687][ T5224]        process_one_work+0x4f4/0x950
> [  442.437908][ T5224]        worker_thread+0x390/0x4bc
> [  442.442868][ T5224]        kthread+0x1cc/0x1e8
> [  442.447307][ T5224]        ret_from_fork+0x10/0x18
> [  442.452090][ T5224] 
> [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> [  442.474803][ T5224]        get_online_mems+0x54/0x150
> [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> [  442.485072][ T5224]        total_objects_show+0x28/0x34
> [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> [  442.524060][ T5224]        ksys_read+0xb0/0x120
> [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> [  442.538768][ T5224]        el0_svc+0x8/0xc
> [  442.542858][ T5224] 
> [  442.542858][ T5224] other info that might help us debug this:
> [  442.542858][ T5224] 
> [  442.552936][ T5224] Chain exists of:
> [  442.552936][ T5224]   mem_hotplug_lock.rw_sem --> slab_mutex --> kn->count#45
> [  442.552936][ T5224] 
> [  442.565803][ T5224]  Possible unsafe locking scenario:
> [  442.565803][ T5224] 
> [  442.573105][ T5224]        CPU0                    CPU1
> [  442.578322][ T5224]        ----                    ----
> [  442.583539][ T5224]   lock(kn->count#45);
> [  442.587545][ T5224]                                lock(slab_mutex);
> [  442.593898][ T5224]                                lock(kn->count#45);
> [  442.600433][ T5224]   lock(mem_hotplug_lock.rw_sem);
> [  442.605393][ T5224] 
> [  442.605393][ T5224]  *** DEADLOCK ***
> [  442.605393][ T5224] 
> [  442.613390][ T5224] 3 locks held by cat/5224:
> [  442.617740][ T5224]  #0: 9eff00095b14b2a0 (&p->lock){+.+.}, at:
> seq_read+0x4c/0x8a8
> [  442.625399][ T5224]  #1: 0eff008997041480 (&of->mutex){+.+.}, at:
> kernfs_seq_start+0x34/0xf0
> [  442.633842][ T5224]  #2: b8ff009693eee398 (kn->count#45){++++}, at:
> kernfs_seq_start+0x44/0xf0
> [  442.642477][ T5224] 
> [  442.642477][ T5224] stack backtrace:
> [  442.648221][ T5224] CPU: 117 PID: 5224 Comm: cat Tainted:
> G             L    5.3.0-rc7-mm1+ #6
> [  442.656826][ T5224] Hardware name: HPE Apollo
> 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  442.667253][ T5224] Call trace:
> [  442.670391][ T5224]  dump_backtrace+0x0/0x248
> [  442.674743][ T5224]  show_stack+0x20/0x2c
> [  442.678750][ T5224]  dump_stack+0xd0/0x140
> [  442.682841][ T5224]  print_circular_bug+0x368/0x380
> [  442.687715][ T5224]  check_noncircular+0x248/0x250
> [  442.692501][ T5224]  validate_chain+0xd10/0x2bcc
> [  442.697115][ T5224]  __lock_acquire+0x7f4/0xb8c
> [  442.701641][ T5224]  lock_acquire+0x31c/0x360
> [  442.705993][ T5224]  get_online_mems+0x54/0x150
> [  442.710519][ T5224]  show_slab_objects+0x94/0x3a8
> [  442.715219][ T5224]  total_objects_show+0x28/0x34
> [  442.719918][ T5224]  slab_attr_show+0x38/0x54
> [  442.724271][ T5224]  sysfs_kf_seq_show+0x198/0x2d4
> [  442.729056][ T5224]  kernfs_seq_show+0xa4/0xcc
> [  442.733494][ T5224]  seq_read+0x30c/0x8a8
> [  442.737498][ T5224]  kernfs_fop_read+0xa8/0x314
> [  442.742025][ T5224]  __vfs_read+0x88/0x20c
> [  442.746118][ T5224]  vfs_read+0xd8/0x10c
> [  442.750036][ T5224]  ksys_read+0xb0/0x120
> [  442.754042][ T5224]  __arm64_sys_read+0x54/0x88
> [  442.758569][ T5224]  el0_svc_handler+0x170/0x240
> [  442.763180][ T5224]  el0_svc+0x8/0xc
> 


-- 

Thanks,

David / dhildenb
