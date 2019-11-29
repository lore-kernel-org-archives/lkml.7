Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73FAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF382086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKA8tIwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfK2MPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:15:48 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35749 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2MPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:15:48 -0500
Received: by mail-vk1-f195.google.com with SMTP id o187so3153222vka.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WhiOTotl5RS7Nhgu+DEp8rXQD1OdZR5GYdZuvSwXtw=;
        b=DKA8tIwm6GhRCI9jM01jburuNuRhJ9QKdTdbOs1G37L+s6Y84DB70YpPu9dvJ0cNtF
         Uka7bGagc7OvWyNoYKY8oy4QG+CFzlkkq6alj2Wt8PV3ObRe30ZzTKHjwx9k9UbD+PK6
         Dsfm+mu1P++SkcE26EBwMnGR+EIDsC8P8XC3apJsDfSmFjHqcH7KL371QwS66TG96Hrp
         J/VzqfGjBEr1phEyAO5fWXe2ScSBThqXw/XpPrJQv61UFTK5sR7110dRnlg5+HYiHNpf
         x/kYVtL8fEmkrkiltG3cClKNjjITwZg4zzF2bzjZIQCKjaJ4iEmJf2f/U5CkrJ/Edn7x
         Z4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WhiOTotl5RS7Nhgu+DEp8rXQD1OdZR5GYdZuvSwXtw=;
        b=n1wdDHU7MCyLLuT1l7PJYanjP6tBxjH13sAPoM3lRvLO1KOIHDBsntQxCz2HuRzJ7V
         r2cKdN7tSHAClueetPsvcfCXOr3FvaT3RbVVxG+H+zNL3kEhwmNhFMbEvRxry66Ts821
         Mi03tTMJDROR536Ey/I7HFYQ+wKqS4xxfGFyscICDPX0m6szyCry+hObMozO2YD0Xzzr
         PZ++6KTKpwsGP/AM6Vd/ey2qF4YDBg+zcg+cdOXi4FLN8tTmcqoLSOPNbjfji4QLaAoH
         830iUNx/UKLUwu/T0Iv2wWE5Nlb27G4hH80FXe3gDTQSKzXlov1hZWWdZ2JNDhJ7xfJb
         3H0w==
X-Gm-Message-State: APjAAAX21d+uwko59A24B5q7EwQIG2NNRokvJGAdZeEqvyOEBm4z8eJO
        jUg9JMfqMa7bvq1aVgEOimPDFbtCKtf4I7aMg9NggQ==
X-Google-Smtp-Source: APXvYqzNZ/VvYg4NgWBljroyp/35Y0lyzRyZZphFXvnh/ws+m4BYhBTRf2ctuzvd8hjgkzeO3o6i1ZU1oOdDWXm3mYA=
X-Received: by 2002:a1f:e784:: with SMTP id e126mr9488593vkh.102.1575029743872;
 Fri, 29 Nov 2019 04:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net>
 <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
 <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com> <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
 <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com> <874kymg9zc.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <874kymg9zc.fsf@dja-thinkpad.axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Nov 2019 13:15:28 +0100
Message-ID: <CACT4Y+bOBUDO9BuPQ4PX6e42_skqsWfXdfojgX+yx8RX2DGHzA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, Qian Cai <cai@lca.pw>,
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

On Fri, Nov 29, 2019 at 1:09 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Hi Dmitry,
>
> >> I am testing this support on next-20191129 and seeing the following warnings:
> >>
> >> BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
> >> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 44, name: kworker/1:1
> >> 4 locks held by kworker/1:1/44:
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> >> __write_once_size include/linux/compiler.h:247 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> >> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: atomic64_set
> >> include/asm-generic/atomic-instrumented.h:868 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> >> atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at: set_work_data
> >> kernel/workqueue.c:615 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> >> set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
> >>  #0: ffff888067c26d28 ((wq_completion)events){+.+.}, at:
> >> process_one_work+0x88b/0x1750 kernel/workqueue.c:2235
> >>  #1: ffffc900002afdf0 (pcpu_balance_work){+.+.}, at:
> >> process_one_work+0x8c0/0x1750 kernel/workqueue.c:2239
> >>  #2: ffffffff8943f080 (pcpu_alloc_mutex){+.+.}, at:
> >> pcpu_balance_workfn+0xcc/0x13e0 mm/percpu.c:1845
> >>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at: spin_lock
> >> include/linux/spinlock.h:338 [inline]
> >>  #3: ffffffff89450c78 (vmap_area_lock){+.+.}, at:
> >> pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> >> Preemption disabled at:
> >> [<ffffffff81a84199>] spin_lock include/linux/spinlock.h:338 [inline]
> >> [<ffffffff81a84199>] pcpu_get_vm_areas+0x1449/0x3df0 mm/vmalloc.c:3431
> >> CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.4.0-next-20191129+ #5
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> >> Workqueue: events pcpu_balance_workfn
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:77 [inline]
> >>  dump_stack+0x199/0x216 lib/dump_stack.c:118
> >>  ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
> >>  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
> >>  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
> >>  __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
> >>  alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
> >>  alloc_pages include/linux/gfp.h:532 [inline]
> >>  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
> >>  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
> >>  kasan_populate_vmalloc_pte+0x2f/0x1b0 mm/kasan/common.c:753
> >>  apply_to_pte_range mm/memory.c:2041 [inline]
> >>  apply_to_pmd_range mm/memory.c:2068 [inline]
> >>  apply_to_pud_range mm/memory.c:2088 [inline]
> >>  apply_to_p4d_range mm/memory.c:2108 [inline]
> >>  apply_to_page_range+0x5ca/0xa00 mm/memory.c:2133
> >>  kasan_populate_vmalloc+0x69/0xa0 mm/kasan/common.c:791
> >>  pcpu_get_vm_areas+0x1596/0x3df0 mm/vmalloc.c:3439
> >>  pcpu_create_chunk+0x240/0x7f0 mm/percpu-vm.c:340
> >>  pcpu_balance_workfn+0x1033/0x13e0 mm/percpu.c:1934
> >>  process_one_work+0x9b5/0x1750 kernel/workqueue.c:2264
> >>  worker_thread+0x8b/0xd20 kernel/workqueue.c:2410
> >>  kthread+0x365/0x450 kernel/kthread.c:255
> >>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >>
> >>
> >> Not sure if it's the same or not. Is it addressed by something in flight?
>
> It looks like this one is the same.
>
> There is a patch to fix it:
> https://lore.kernel.org/linux-mm/20191120052719.7201-1-dja@axtens.net/
>
> Andrew said he had picked it up on the 22nd:
> https://marc.info/?l=linux-mm-commits&m=157438241512561&w=2
> It's landed in mmots but not mmotm, so hopefully that will happen and
> then it will land in -next very soon!
>
> I will look into your other bug report shortly.

Thanks for the quick responses, Andrey, Daniel.


> Regards,
> Daniel
>
> >>
> >> My config:
> >> https://gist.githubusercontent.com/dvyukov/36c7be311fdec9cd51c649f7c3cb2ddb/raw/39c6f864fdd0ffc53f0822b14c354a73c1695fa1/gistfile1.txt
> >
> >
> > I've tried this fix for pcpu_get_vm_areas:
> > https://groups.google.com/d/msg/kasan-dev/t_F2X1MWKwk/h152Z3q2AgAJ
> > and it helps. But this will break syzbot on linux-next soon.
