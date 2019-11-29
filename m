Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF9BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8485217BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbGOPNvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfK2K6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:58:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38190 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2K6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:58:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id 14so32067974qtf.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUIDLOf0hRQ3RLmdINFRjn4uoKtHaDbKGQ7fzoYrou4=;
        b=HbGOPNvmiiiCZ/j1yCCoKqiPrvZLX2t7YVwXEkgut7gZ95+y0mPNR0/ZtLCTpaw9DD
         WJEoBwNakNEF2r4YPs/LlLyn67E06cALw5PVMpTGIid16QHkKSqXn0l/9bEgzhXOKA5p
         2FLScBLcdYmxlKmKpeOvLcQr9DQDesoPBtUdfcc0aleRDGM5U9kIYplxgzbswWqF461r
         5H1EVBMKmggDdFtb8pyP8ghRSPK8Rq49G91oS9PDTdpznD+AWBmVi+l+eyDNTAajYCU3
         YqMYBzdsTMyBkNbI3HkpkLSpsmKLR0cMKKD2abKcPTirrw8Pn+J1JEMC99DAhfYrjvCP
         XtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUIDLOf0hRQ3RLmdINFRjn4uoKtHaDbKGQ7fzoYrou4=;
        b=AQbu+tRt5FWO9ltrR93PgdsMA10I8G/Ive6BVoCRSWdq7gg5MizNa+9iII4VdtGQbg
         uxZh1hyc2F7a3gciegZxPoUNZ5cF3xFhfMIAHqDXER4d83KzLUBl3S+VMJPrlcOybNSx
         jiFhnEZ9WhZDXfIyRqN/2dTVuK5DxHIHL09Vi8m5hH9J7y6u63dRlSDkgy9xpYDo57aH
         ZDwYgl9LOM0vq/+GyonaTJRcpKyMJc2jbbd0iH+GsSEeGvqCEGy5DPjLJ5jozacjupXV
         FS80aQzbK0k9FhvgR3kRySRD50zwyY+7pfUnF+JuRosdL9XFLybh7AxpepRzreP130XU
         3yMg==
X-Gm-Message-State: APjAAAXBT1Cfm7YvXkv+S3Z8pg9EXtOK0Y8iMQP7IG/OBb9+i5OEriZf
        CBCP15RHQNzgFcCfq7uXS/pIuZKewKvKPfKy+lRf0A==
X-Google-Smtp-Source: APXvYqzmTm00YaxOk5QyuJyVpmUo+i94HacVdMZ3EaBY4/9axWBercF3NxDgpI7oReuLBkdksdPsz3Uz4nfqSfm8CDU=
X-Received: by 2002:ac8:610a:: with SMTP id a10mr41103027qtm.50.1575025118594;
 Fri, 29 Nov 2019 02:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net>
 <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
 <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com> <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Nov 2019 11:58:27 +0100
Message-ID: <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
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

On Fri, Nov 29, 2019 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Nov 19, 2019 at 10:54 AM Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
> > On 11/18/19 6:29 AM, Daniel Axtens wrote:
> > > Qian Cai <cai@lca.pw> writes:
> > >
> > >> On Thu, 2019-10-31 at 20:39 +1100, Daniel Axtens wrote:
> > >>>     /*
> > >>>      * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> > >>>      * flag. It means that vm_struct is not fully initialized.
> > >>> @@ -3377,6 +3411,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > >>>
> > >>>             setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> > >>>                              pcpu_get_vm_areas);
> > >>> +
> > >>> +           /* assume success here */
> > >>> +           kasan_populate_vmalloc(sizes[area], vms[area]);
> > >>>     }
> > >>>     spin_unlock(&vmap_area_lock);
> > >>
> > >> Here it is all wrong. GFP_KERNEL with in_atomic().
> > >
> > > I think this fix will work, I will do a v12 with it included.
> >
> > You can send just the fix. Andrew will fold it into the original patch before sending it to Linus.
> >
> >
> >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index a4b950a02d0b..bf030516258c 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3417,11 +3417,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > >
> > >                 setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> > >                                  pcpu_get_vm_areas);
> > > +       }
> > > +       spin_unlock(&vmap_area_lock);
> > >
> > > +       /* populate the shadow space outside of the lock */
> > > +       for (area = 0; area < nr_vms; area++) {
> > >                 /* assume success here */
> > >                 kasan_populate_vmalloc(sizes[area], vms[area]);
> > >         }
> > > -       spin_unlock(&vmap_area_lock);
> > >
> > >         kfree(vas);
> > >         return vms;
>
> Hi,
>
> I am testing this support on next-20191129 and seeing the following warnings:
>
> BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/1:1
> 4 locks held by kworker/1:1/44:
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> __write_once_size include/linux/compiler.h:247 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: atomic64_set
> include/asm-generic/atomic-instrumented.h:868 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: set_work_data
> kernel/workqueue.c:615 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> process_one_work+0x88b/0x1750 kernel/workqueue.c:2235
>  #1: ffffc900002afdf0 (pcpu_balance_work){+.+.}, at:
> process_one_work+0x8c0/0x1750 kernel/workqueue.c:2239
>  #2: ffffffff8943f080 (pcpu_alloc_mutex){+.+.}, at:
> pcpu_balance_workfn+0xcc/0x13e0 mm/percpu.c:1845
>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at: spin_lock
> include/linux/spinlock.h:338 [inline]
>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at:
> pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> Preemption disabled at:
> [<ffffffff81a84199>] spin_lock include/linux/spinlock.h:338 [inline]
> [<ffffffff81a84199>] pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.4.0-next-20191129+ #5
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> Workqueue: events pcpu_balance_workfn
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x199/0x216 lib/dump_stack.c:118
>  ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
>  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
>  __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
>  alloc_pages include/linux/gfp.h:532 [inline]
>  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
>  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
>  kasan_populate_vmalloc_pte+0x2f/0x1b0 mm/kasan/common.c:753
>  apply_to_pte_range mm/memory.c:2041 [inline]
>  apply_to_pmd_range mm/memory.c:2068 [inline]
>  apply_to_pud_range mm/memory.c:2088 [inline]
>  apply_to_p4d_range mm/memory.c:2108 [inline]
>  apply_to_page_range+0x5ca/0xa00 mm/memory.c:2133
>  kasan_populate_vmalloc+0x69/0xa0 mm/kasan/common.c:791
>  pcpu_get_vm_areas+0x1596/0x3df0 mm/vmalloc.c:3439
>  pcpu_create_chunk+0x240/0x7f0 mm/percpu-vm.c:340
>  pcpu_balance_workfn+0x1033/0x13e0 mm/percpu.c:1934
>  process_one_work+0x9b5/0x1750 kernel/workqueue.c:2264
>  worker_thread+0x8b/0xd20 kernel/workqueue.c:2410
>  kthread+0x365/0x450 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
>
> Not sure if it's the same or not. Is it addressed by something in flight?
>
> My config:
> https://gist.githubusercontent.com/dvyukov/36c7be311fdec9cd51c649f7c3cb2ddb/raw/39c6f864fdd0ffc53f0822b14c354a73c1695fa1/gistfile1.txt


I've tried this fix for pcpu_get_vm_areas:
https://groups.google.com/d/msg/kasan-dev/t_F2X1MWKwk/h152Z3q2AgAJ
and it helps. But this will break syzbot on linux-next soon.
