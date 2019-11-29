Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE98520869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBYMKIdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfK2Knt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:43:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46902 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2Kns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:43:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id f5so6747222qkm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNKcPwP14dCsuwOlqDsykLyVDhKlBHISB9+4LszAs1E=;
        b=nBYMKIdo4bN34E3EPIXgQc5YN+71lf9DS22Yw2lMbp8we2gbCASP73qbMD/4ihM4q7
         VAsomzecOXGlDupxMxxVddm/OYWJT/9uDi2QqFgF6UWCj/maXYqrIKPCoWE/FF7VYHle
         PKO8tb43mG8X29mBNDhNhimCTrBPPQYYAEyX57WqcODF6XE0ypzVzAhNjLQ8mMDsqFNJ
         Ye8fYaw/uOIFHtWP6FN9P3SgyulmzCtbk0wfmL9cU7ca62S0Z9POgea7TtMmH9AqcV7N
         MZMvD4jmrgwI/dnqseW9KNFZGzuVKAwRCly/NWEjPNnq/TYhCnpxw6Vui0aO7gKZDqds
         Z2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNKcPwP14dCsuwOlqDsykLyVDhKlBHISB9+4LszAs1E=;
        b=MOxPmoux/pKmMX1Krl59JddBaJhLfIrkvgeasX/F2T++Y1BxmX1hIj/0B89uYkc+HZ
         BhMcOamDP+DdLyAhIniP4a58HSko/JexjalzKjZ/XyGe9jDbd7dwKtMuMkxjp7ywd53M
         ZfQgrxS+ospnFMJaGFGfvDmFcyusHVo+4JmfTh1/a7bzIZZ8QNohDrGK0KS9wbvMKxUO
         260g+AkdvimHN3aOu36/zHq+IjUQr4r1nhZ6KrTd3XzcLH/1FQwxnMSllnQZtfnKr4ga
         2P0BRidC6ZeokKrBmHvlppW9ot/gRiG47H/Vzx/COpLTAhYRi5R6RpzRXpOaDyobHbjz
         wzWA==
X-Gm-Message-State: APjAAAUinQR587NGk10OYU4t2G9MfI498ZwsHrnHBq0S+ttKuM+Dp+A8
        UVEZptoeelIH/qXBvBgek5BTlAPlv7cTUVtOlxCD8Q==
X-Google-Smtp-Source: APXvYqzOGamI1EY7SZL+szo1Y+msRsEDDsuPt89l2GqXlbXKeTf5q7E5hiDfxSk8eOZJVviOV1hYzHE3GXZCDDMX3U0=
X-Received: by 2002:a37:e312:: with SMTP id y18mr11683779qki.250.1575024226915;
 Fri, 29 Nov 2019 02:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net>
 <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net> <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com>
In-Reply-To: <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Nov 2019 11:43:35 +0100
Message-ID: <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
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

On Tue, Nov 19, 2019 at 10:54 AM Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 11/18/19 6:29 AM, Daniel Axtens wrote:
> > Qian Cai <cai@lca.pw> writes:
> >
> >> On Thu, 2019-10-31 at 20:39 +1100, Daniel Axtens wrote:
> >>>     /*
> >>>      * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> >>>      * flag. It means that vm_struct is not fully initialized.
> >>> @@ -3377,6 +3411,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >>>
> >>>             setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> >>>                              pcpu_get_vm_areas);
> >>> +
> >>> +           /* assume success here */
> >>> +           kasan_populate_vmalloc(sizes[area], vms[area]);
> >>>     }
> >>>     spin_unlock(&vmap_area_lock);
> >>
> >> Here it is all wrong. GFP_KERNEL with in_atomic().
> >
> > I think this fix will work, I will do a v12 with it included.
>
> You can send just the fix. Andrew will fold it into the original patch before sending it to Linus.
>
>
>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a4b950a02d0b..bf030516258c 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >
> >                 setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> >                                  pcpu_get_vm_areas);
> > +       }
> > +       spin_unlock(&vmap_area_lock);
> >
> > +       /* populate the shadow space outside of the lock */
> > +       for (area = 0; area < nr_vms; area++) {
> >                 /* assume success here */
> >                 kasan_populate_vmalloc(sizes[area], vms[area]);
> >         }
> > -       spin_unlock(&vmap_area_lock);
> >
> >         kfree(vas);
> >         return vms;

Hi,

I am testing this support on next-20191129 and seeing the following warnings:

BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/1:1
4 locks held by kworker/1:1/44:
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
__write_once_size include/linux/compiler.h:247 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: atomic64_set
include/asm-generic/atomic-instrumented.h:868 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: set_work_data
kernel/workqueue.c:615 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
process_one_work+0x88b/0x1750 kernel/workqueue.c:2235
 #1: ffffc900002afdf0 (pcpu_balance_work){+.+.}, at:
process_one_work+0x8c0/0x1750 kernel/workqueue.c:2239
 #2: ffffffff8943f080 (pcpu_alloc_mutex){+.+.}, at:
pcpu_balance_workfn+0xcc/0x13e0 mm/percpu.c:1845
 #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at: spin_lock
include/linux/spinlock.h:338 [inline]
 #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at:
pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
Preemption disabled at:
[<ffffffff81a84199>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81a84199>] pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.4.0-next-20191129+ #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
Workqueue: events pcpu_balance_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x199/0x216 lib/dump_stack.c:118
 ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
 __might_sleep+0x95/0x190 kernel/sched/core.c:6753
 prepare_alloc_pages mm/page_alloc.c:4681 [inline]
 __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
 alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
 alloc_pages include/linux/gfp.h:532 [inline]
 __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
 kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
 kasan_populate_vmalloc_pte+0x2f/0x1b0 mm/kasan/common.c:753
 apply_to_pte_range mm/memory.c:2041 [inline]
 apply_to_pmd_range mm/memory.c:2068 [inline]
 apply_to_pud_range mm/memory.c:2088 [inline]
 apply_to_p4d_range mm/memory.c:2108 [inline]
 apply_to_page_range+0x5ca/0xa00 mm/memory.c:2133
 kasan_populate_vmalloc+0x69/0xa0 mm/kasan/common.c:791
 pcpu_get_vm_areas+0x1596/0x3df0 mm/vmalloc.c:3439
 pcpu_create_chunk+0x240/0x7f0 mm/percpu-vm.c:340
 pcpu_balance_workfn+0x1033/0x13e0 mm/percpu.c:1934
 process_one_work+0x9b5/0x1750 kernel/workqueue.c:2264
 worker_thread+0x8b/0xd20 kernel/workqueue.c:2410
 kthread+0x365/0x450 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


Not sure if it's the same or not. Is it addressed by something in flight?

My config:
https://gist.githubusercontent.com/dvyukov/36c7be311fdec9cd51c649f7c3cb2ddb/raw/39c6f864fdd0ffc53f0822b14c354a73c1695fa1/gistfile1.txt
