Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C28C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B126217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgjOmxEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfK2LCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:02:36 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46548 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2LCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:02:36 -0500
Received: by mail-qv1-f67.google.com with SMTP id t9so1322317qvh.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUXiN1jVXt44HLAwzWJlzAbonJeKoTnOjciuM0nUVO0=;
        b=kgjOmxEyFXxtSpIwMEeEoQh8awykhy3UuOYork1RUnXma0iIwJIKCqrxDExlB1/Wde
         34V8ICyhsy+NbjUqM1ZbjRcQNVDA7lbw84tapRMHCxdHWKo1RxgnEapN0Jaem5WsXXHf
         JxMLCp4Zgfk2HWaRAwXf5JBZ2p06BhPiaOXQLg6V6PFIFYfafTbI62QuHbQvevH0kZbo
         uVhyERvVcxauQ8rvrxEL9WTNX9b4SV3YEJSSTjpE9n6bhBO6smIu081p1zvKFK3vy5lD
         3d8Mdwadhf5s+emeJ+wlMaXRaDCfPger0oPwo9ifc5/jrHOCXfYp81CRUr4kwOohOL/F
         jVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUXiN1jVXt44HLAwzWJlzAbonJeKoTnOjciuM0nUVO0=;
        b=tl7SYaZFRasU1YnlKMSBCKqbHwh/JJQNWL/0Yp5SAC0GtUOLs78bSJjBySrIkgaa+7
         Y/T50mR0pqhqR0lRIgSRG/hY1Bay+MZFVcswg7QZYxV1tVARBhZWEcRX4bkQ49WtEYJ9
         dU1W56KuRJWLNpDwTxZr2IOvedcN84+VfKI1QoihwAU/TYRrGeyeTG/qB7Z6kSchd8lC
         E9v+AmRA+GYQweN2TI1/dKldC/QsydskxzlSMakX5qr82p0mu7v5nX8kg+YGUDfVw5lq
         Od7EMHx03jGd67uBVJhgUT+yKoPFPP/XWvXdylzQzcoHzJSTL5MTLERtNz1tIavgfxVQ
         pjIQ==
X-Gm-Message-State: APjAAAXE4Aa7eUQjj3uxKCiWqaFWwwDE2vBz+rl1TBI2NiXMO5n9/ScA
        YPkZ/ixL1dUOfGzsoYnWMyY1qn0WW34Uaepny3TR7w==
X-Google-Smtp-Source: APXvYqx5pPrI1YZnbLcRiiMCADhLD+RF0kvW8KGgIsYZxCde0wBR0lzDEsyyp8LoxuqLKq+HhbvBK1e/yDJHEA8rtH8=
X-Received: by 2002:a0c:b446:: with SMTP id e6mr16469317qvf.159.1575025350172;
 Fri, 29 Nov 2019 03:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net>
 <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
 <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com> <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
 <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Nov 2019 12:02:18 +0100
Message-ID: <CACT4Y+Yog=PHF1SsLuoehr2rcbmfvLUW+dv7Vo+1RfdTOx7AUA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real
 shadow memory
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Nov 29, 2019 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Nov 19, 2019 at 10:54 AM Andrey Ryabinin
> > <aryabinin@virtuozzo.com> wrote:
> > > On 11/18/19 6:29 AM, Daniel Axtens wrote:
> > > > Qian Cai <cai@lca.pw> writes:
> > > >
> > > >> On Thu, 2019-10-31 at 20:39 +1100, Daniel Axtens wrote:
> > > >>>     /*
> > > >>>      * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> > > >>>      * flag. It means that vm_struct is not fully initialized.
> > > >>> @@ -3377,6 +3411,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > > >>>
> > > >>>             setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> > > >>>                              pcpu_get_vm_areas);
> > > >>> +
> > > >>> +           /* assume success here */
> > > >>> +           kasan_populate_vmalloc(sizes[area], vms[area]);
> > > >>>     }
> > > >>>     spin_unlock(&vmap_area_lock);
> > > >>
> > > >> Here it is all wrong. GFP_KERNEL with in_atomic().
> > > >
> > > > I think this fix will work, I will do a v12 with it included.
> > >
> > > You can send just the fix. Andrew will fold it into the original patch before sending it to Linus.
> > >
> > >
> > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index a4b950a02d0b..bf030516258c 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > > >
> > > >                 setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> > > >                                  pcpu_get_vm_areas);
> > > > +       }
> > > > +       spin_unlock(&vmap_area_lock);
> > > >
> > > > +       /* populate the shadow space outside of the lock */
> > > > +       for (area = 0; area < nr_vms; area++) {
> > > >                 /* assume success here */
> > > >                 kasan_populate_vmalloc(sizes[area], vms[area]);
> > > >         }
> > > > -       spin_unlock(&vmap_area_lock);
> > > >
> > > >         kfree(vas);
> > > >         return vms;
> >
> > Hi,
> >
> > I am testing this support on next-20191129 and seeing the following warnings:
> >
> > BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/1:1
> > 4 locks held by kworker/1:1/44:
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> > __write_once_size include/linux/compiler.h:247 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> > arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: atomic64_set
> > include/asm-generic/atomic-instrumented.h:868 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> > atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: set_work_data
> > kernel/workqueue.c:615 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> > set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
> >  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> > process_one_work+0x88b/0x1750 kernel/workqueue.c:2235
> >  #1: ffffc900002afdf0 (pcpu_balance_work){+.+.}, at:
> > process_one_work+0x8c0/0x1750 kernel/workqueue.c:2239
> >  #2: ffffffff8943f080 (pcpu_alloc_mutex){+.+.}, at:
> > pcpu_balance_workfn+0xcc/0x13e0 mm/percpu.c:1845
> >  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at: spin_lock
> > include/linux/spinlock.h:338 [inline]
> >  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at:
> > pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> > Preemption disabled at:
> > [<ffffffff81a84199>] spin_lock include/linux/spinlock.h:338 [inline]
> > [<ffffffff81a84199>] pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> > CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.4.0-next-20191129+ #5
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> > Workqueue: events pcpu_balance_workfn
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x199/0x216 lib/dump_stack.c:118
> >  ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
> >  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
> >  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
> >  __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
> >  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
> >  alloc_pages include/linux/gfp.h:532 [inline]
> >  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
> >  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
> >  kasan_populate_vmalloc_pte+0x2f/0x1b0 mm/kasan/common.c:753
> >  apply_to_pte_range mm/memory.c:2041 [inline]
> >  apply_to_pmd_range mm/memory.c:2068 [inline]
> >  apply_to_pud_range mm/memory.c:2088 [inline]
> >  apply_to_p4d_range mm/memory.c:2108 [inline]
> >  apply_to_page_range+0x5ca/0xa00 mm/memory.c:2133
> >  kasan_populate_vmalloc+0x69/0xa0 mm/kasan/common.c:791
> >  pcpu_get_vm_areas+0x1596/0x3df0 mm/vmalloc.c:3439
> >  pcpu_create_chunk+0x240/0x7f0 mm/percpu-vm.c:340
> >  pcpu_balance_workfn+0x1033/0x13e0 mm/percpu.c:1934
> >  process_one_work+0x9b5/0x1750 kernel/workqueue.c:2264
> >  worker_thread+0x8b/0xd20 kernel/workqueue.c:2410
> >  kthread+0x365/0x450 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> >
> > Not sure if it's the same or not. Is it addressed by something in flight?
> >
> > My config:
> > https://gist.githubusercontent.com/dvyukov/36c7be311fdec9cd51c649f7c3cb2ddb/raw/39c6f864fdd0ffc53f0822b14c354a73c1695fa1/gistfile1.txt
>
>
> I've tried this fix for pcpu_get_vm_areas:
> https://groups.google.com/d/msg/kasan-dev/t_F2X1MWKwk/h152Z3q2AgAJ
> and it helps. But this will break syzbot on linux-next soon.


Can this be related as well?
Crashes on accesses to shadow on the ion memory...

BUG: unable to handle page fault for address: fffff52006000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7ffcd067 P4D 7ffcd067 PUD 2cd10067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 3472 Comm: ion_system_heap Not tainted 5.4.0-next-20191129+ #6
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x83/0x1d0 mm/kasan/generic.c:192
Code: 83 fb 10 0f 8e a9 00 00 00 45 89 c8 41 83 e0 07 75 66 4c 8d 43
07 48 85 db 4c 0f 49 c3 49 c1 f8 03 45 85 c0 0f 84 3f 01 00 00 <48> 83
38 00 75 1c 41 83 e8 01 4e 8d 44 c0 08 48 83 c0 08 49 39 c0
RSP: 0018:ffffc900011c7b10 EFLAGS: 00010206
RAX: fffff52006000000 RBX: 0000000000004000 RCX: ffffffff85988df8
RDX: 0000000000000001 RSI: 0000000000020000 RDI: ffffc90030000000
RBP: ffffc900011c7b28 R08: 0000000000000800 R09: fffff52006000000
R10: fffff52006003fff R11: ffffc9003001ffff R12: fffff52006004000
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff52006000000 CR3: 00000000680fb004 CR4: 0000000000760ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 memset+0x23/0x40 mm/kasan/common.c:107
 memset include/linux/string.h:410 [inline]
 ion_heap_clear_pages+0x48/0x70 drivers/staging/android/ion/ion_heap.c:106
 ion_heap_sglist_zero+0x1f9/0x260 drivers/staging/android/ion/ion_heap.c:123
 ion_heap_buffer_zero+0xf8/0x150 drivers/staging/android/ion/ion_heap.c:145
 ion_system_heap_free+0x227/0x290
drivers/staging/android/ion/ion_system_heap.c:163
 ion_buffer_destroy+0x15a/0x2d0 drivers/staging/android/ion/ion.c:93
 ion_heap_deferred_free+0x267/0x5e0 drivers/staging/android/ion/ion_heap.c:239
 kthread+0x365/0x450 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: fffff52006000000
---[ end trace c101f19526ce3d42 ]---
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x83/0x1d0 mm/kasan/generic.c:192
Code: 83 fb 10 0f 8e a9 00 00 00 45 89 c8 41 83 e0 07 75 66 4c 8d 43
07 48 85 db 4c 0f 49 c3 49 c1 f8 03 45 85 c0 0f 84 3f 01 00 00 <48> 83
38 00 75 1c 41 83 e8 01 4e 8d 44 c0 08 48 83 c0 08 49 39 c0
RSP: 0018:ffffc900011c7b10 EFLAGS: 00010206
RAX: fffff52006000000 RBX: 0000000000004000 RCX: ffffffff85988df8
RDX: 0000000000000001 RSI: 0000000000020000 RDI: ffffc90030000000
RBP: ffffc900011c7b28 R08: 0000000000000800 R09: fffff52006000000
R10: fffff52006003fff R11: ffffc9003001ffff R12: fffff52006004000
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802d400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff52006000000 CR3: 00000000680fb004 CR4: 0000000000760ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
