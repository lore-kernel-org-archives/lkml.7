Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E790C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061520716
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 11:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfK3LvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 06:51:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65076 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfK3LvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 06:51:06 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAUBoMth024618;
        Sat, 30 Nov 2019 20:50:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Sat, 30 Nov 2019 20:50:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAUBoFgi024568
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Nov 2019 20:50:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: sleeping function called from invalid context in
 __alloc_pages_nodemask
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
References: <20191130083223.1568-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9b066e40-2d03-98d6-6475-e271778d7648@I-love.SAKURA.ne.jp>
Date:   Sat, 30 Nov 2019 20:50:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191130083223.1568-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/30 17:32, Hillf Danton wrote:
> 
> On Fri, 29 Nov 2019 23:35:08 -0800
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    419593da Add linux-next specific files for 20191129
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc369ce00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com
>>
>> BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2710, name:  
>> kworker/0:2
>> 4 locks held by kworker/0:2/2710:
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: __write_once_size  
>> include/linux/compiler.h:247 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set  
>> arch/x86/include/asm/atomic64_64.h:34 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic64_set  
>> include/asm-generic/atomic-instrumented.h:868 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic_long_set  
>> include/asm-generic/atomic-long.h:40 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: set_work_data  
>> kernel/workqueue.c:615 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
>> set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
>>   #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
>> process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
>>   #1: ffffc9000802fdc0 (pcpu_balance_work){+.+.}, at:  
>> process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
>>   #2: ffffffff8983ff20 (pcpu_alloc_mutex){+.+.}, at:  
>> pcpu_balance_workfn+0xb7/0x1310 mm/percpu.c:1845
>>   #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at: spin_lock  
>> include/linux/spinlock.h:338 [inline]
>>   #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at:  
>> pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
>> Preemption disabled at:
>> [<ffffffff81a89ce7>] spin_lock include/linux/spinlock.h:338 [inline]
>> [<ffffffff81a89ce7>] pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
>> CPU: 0 PID: 2710 Comm: kworker/0:2 Not tainted  
>> 5.4.0-next-20191129-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
>> Google 01/01/2011
>> Workqueue: events pcpu_balance_workfn
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>>   ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
>>   __might_sleep+0x95/0x190 kernel/sched/core.c:6753
>>   prepare_alloc_pages mm/page_alloc.c:4681 [inline]
>>   __alloc_pages_nodemask+0x523/0x910 mm/page_alloc.c:4730
>>   alloc_pages_current+0x107/0x210 mm/mempolicy.c:2211
>>   alloc_pages include/linux/gfp.h:532 [inline]
>>   __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
>>   kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
>>   kasan_populate_vmalloc_pte+0x2f/0x1c0 mm/kasan/common.c:753
>>   apply_to_pte_range mm/memory.c:2041 [inline]
>>   apply_to_pmd_range mm/memory.c:2068 [inline]
>>   apply_to_pud_range mm/memory.c:2088 [inline]
>>   apply_to_p4d_range mm/memory.c:2108 [inline]
>>   apply_to_page_range+0x445/0x700 mm/memory.c:2133
>>   kasan_populate_vmalloc+0x68/0x90 mm/kasan/common.c:791
>>   pcpu_get_vm_areas+0x3c77/0x3f00 mm/vmalloc.c:3439
>>   pcpu_create_chunk+0x24e/0x7f0 mm/percpu-vm.c:340
>>   pcpu_balance_workfn+0xf1b/0x1310 mm/percpu.c:1934
>>   process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
>>   worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>>   kthread+0x361/0x430 kernel/kthread.c:255
>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Replace the blocking gfp mask with a non-blocking one to survive
> checks like might_sleep.
> 
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -759,7 +759,7 @@ static int kasan_populate_vmalloc_pte(pt
>  	if (likely(!pte_none(*ptep)))
>  		return 0;
>  
> -	page = __get_free_page(GFP_KERNEL);
> +	page = __get_free_page(GFP_NOWAIT);
>  	if (!page)
>  		return -ENOMEM;
>  

Nope. This change would survive might_sleep() check, but the caller is
expecting that this is __GFP_NOFAIL allocation. Even if the caller can
tolerate allocation failures, __GFP_NOWARN should be added in order to
avoid flooding of allocation failure messages.

        /* insert all vm's */
        spin_lock(&vmap_area_lock);
        for (area = 0; area < nr_vms; area++) {
                insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);

                setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
                                 pcpu_get_vm_areas);

                /* assume success here */
                kasan_populate_vmalloc(sizes[area], vms[area]);
        }
        spin_unlock(&vmap_area_lock);
