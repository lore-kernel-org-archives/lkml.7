Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB6E20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLCXVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:21:07 -0500
Received: from foss.arm.com ([217.140.110.172]:50546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfLCXVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:21:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD93B30E;
        Tue,  3 Dec 2019 15:21:05 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B6A3F718;
        Tue,  3 Dec 2019 15:21:04 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     John Stultz <john.stultz@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c61cf647-ecb6-b9fa-51f2-8efa36134757@arm.com>
Date:   Tue, 3 Dec 2019 23:20:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 03/12/2019 19:15, John Stultz wrote:
> With today's linus/master on db845c running android, I'm able to
> fairly easily reproduce the following crash. I've not had a chance to
> bisect it yet, but I'm suspecting its connected to Vincent's recent
> rework.
> 

Thanks for reporting this.

> If you have any suggestions, or need me to test anything, please let me know.
> 
> thanks
> -john
> 
> [  136.157069] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000010
> [  136.165937] Mem abort info:
> [  136.168765]   ESR = 0x96000005
> [  136.171862]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  136.177229]   SET = 0, FnV = 0
> [  136.180320]   EA = 0, S1PTW = 0
> [  136.183502] Data abort info:
> [  136.186426]   ISV = 0, ISS = 0x00000005
> [  136.190302]   CM = 0, WnR = 0
> [  136.193316] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000175f7e000
> [  136.199814] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
> [  136.206666] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  136.212295] Modules linked in:
> [  136.215397] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
>  5.4.0-mainline-11225-g9c5add21ff63 #1252
> [  136.225390] Hardware name: Thundercomm Dragonboard 845c (DT)
> [  136.231111] pstate: 60c00085 (nZCv daIf +PAN +UAO)
> [  136.235971] pc : find_idlest_group.isra.95+0x368/0x690
> [  136.241159] lr : find_idlest_group.isra.95+0x210/0x690
> [  136.246347] sp : ffffffc01036b890
> [  136.249708] x29: ffffffc01036b890 x28: ffffffe7d7450480
> [  136.255077] x27: ffffff80f81f0000 x26: 0000000000000000
> [  136.260445] x25: 0000000000000000 x24: ffffffc01036b998
> [  136.265810] x23: ffffff80f8e40a00 x22: ffffffe7d7719e30
> [  136.271175] x21: ffffff80f8f16520 x20: ffffff80f8f16180
> [  136.276539] x19: ffffffe7d771a610 x18: ffffffe7d71d1ef0
> [  136.281908] x17: 0000000000000000 x16: 0000000000000000
> [  136.287274] x15: 0000000000000001 x14: 6f3a753d74786574
> [  136.292644] x13: 6e6f637420383637 x12: 632c323135633a30
> [  136.298007] x11: 0000000000000070 x10: 0000000000000002
> [  136.303371] x9 : 0000000000000000 x8 : 0000000000000075
> [  136.308737] x7 : ffffff80f8f16000 x6 : ffffffe7d7450000
> [  136.314099] x5 : 0000000000000004 x4 : 0000000000000000
> [  136.319465] x3 : 000000000000025c x2 : ffffff80f8f16780
> [  136.324836] x1 : 0000000000000000 x0 : 0000000000000002
> [  136.330198] Call trace:
> [  136.332680]  find_idlest_group.isra.95+0x368/0x690
> [  136.337528]  select_task_rq_fair+0x4e4/0xd88
> [  136.341848]  try_to_wake_up+0x21c/0x7f8
> [  136.345735]  default_wake_function+0x34/0x48
> [  136.350053]  pollwake+0x98/0xc8
> [  136.353233]  __wake_up_common+0x90/0x158
> [  136.357202]  __wake_up_common_lock+0x88/0xd0
> [  136.361519]  __wake_up_sync_key+0x40/0x50
> [  136.365584]  sock_def_readable+0x44/0x78
> [  136.369560]  __netlink_sendskb+0x44/0x58
> [  136.373525]  netlink_unicast+0x220/0x258
> [  136.377496]  kauditd_send_queue+0xa4/0x158
> [  136.381643]  kauditd_thread+0xf4/0x248
> [  136.385438]  kthread+0x130/0x138
> [  136.388706]  ret_from_fork+0x10/0x1c
> [  136.392332] Code: 54001340 7100081f 540016e1 a9478ba1 (f9400821)
> [  136.398493] ---[ end trace 47d254973801b2c4 ]---
> [  136.403162] Kernel panic - not syncing: Fatal exception
> [  136.408445] SMP: stopping secondary CPUs
> [  136.412440] Kernel Offset: 0x27c6200000 from 0xffffffc010000000
> [  136.418417] PHYS_OFFSET: 0xffffffe140000000
> [  136.422655] CPU features: 0x00002,2a80a218
> 

I fed this to decode_stacktrace.sh using your branch, I get:

[  136.157069] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000010
[  136.165937] Mem abort info:
[  136.168765]   ESR = 0x96000005
[  136.171862]   EC = 0x25: DABT (current EL), IL = 32 bits
[  136.177229]   SET = 0, FnV = 0
[  136.180320]   EA = 0, S1PTW = 0
[  136.183502] Data abort info:
[  136.186426]   ISV = 0, ISS = 0x00000005
[  136.190302]   CM = 0, WnR = 0
[  136.193316] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000175f7e000
[  136.199814] [0000000000000010] pgd=0000000000000000, pud=0000000000000000
[  136.206666] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[  136.212295] Modules linked in:
[  136.215397] CPU: 7 PID: 50 Comm: kauditd Tainted: G        W
5.4.0-mainline-11225-g9c5add21ff63 #1252
[  136.225390] Hardware name: Thundercomm Dragonboard 845c (DT)
[  136.231111] pstate: 60c00085 (nZCv daIf +PAN +UAO)
[  136.235971] pc : find_idlest_group.isra.95+0x368/0x690
[  136.241159] lr : find_idlest_group.isra.95+0x210/0x690
[  136.246347] sp : ffffffc01036b890
[  136.249708] x29: ffffffc01036b890 x28: ffffffe7d7450480
[  136.255077] x27: ffffff80f81f0000 x26: 0000000000000000
[  136.260445] x25: 0000000000000000 x24: ffffffc01036b998
[  136.265810] x23: ffffff80f8e40a00 x22: ffffffe7d7719e30
[  136.271175] x21: ffffff80f8f16520 x20: ffffff80f8f16180
[  136.276539] x19: ffffffe7d771a610 x18: ffffffe7d71d1ef0
[  136.281908] x17: 0000000000000000 x16: 0000000000000000
[  136.287274] x15: 0000000000000001 x14: 6f3a753d74786574
[  136.292644] x13: 6e6f637420383637 x12: 632c323135633a30
[  136.298007] x11: 0000000000000070 x10: 0000000000000002
[  136.303371] x9 : 0000000000000000 x8 : 0000000000000075
[  136.308737] x7 : ffffff80f8f16000 x6 : ffffffe7d7450000
[  136.314099] x5 : 0000000000000004 x4 : 0000000000000000
[  136.319465] x3 : 000000000000025c x2 : ffffff80f8f16780
[  136.324836] x1 : 0000000000000000 x0 : 0000000000000002
[  136.330198] Call trace:
[  136.332680] find_idlest_group.isra.95+0x368/0x690
[  136.337528] select_task_rq_fair (kernel/sched/fair.c:5663 kernel/sched/fair.c:6387)
[  136.341848] try_to_wake_up (kernel/sched/core.c:2397 kernel/sched/core.c:2644)
[  136.345735] default_wake_function (kernel/sched/core.c:4350)
[  136.350053] pollwake (fs/select.c:218)
[  136.353233] __wake_up_common (kernel/sched/wait.c:93)
[  136.357202] __wake_up_common_lock (./include/linux/spinlock.h:393 (discriminator 1) kernel/sched/wait.c:125 (discriminator 1))
[  136.361519] __wake_up_sync_key (kernel/sched/wait.c:191)
[  136.365584] sock_def_readable (./include/asm-generic/bitops/non-atomic.h:106 ./include/net/sock.h:837 ./include/net/sock.h:2208 net/core/sock.c:2798)
[  136.369560] __netlink_sendskb (net/netlink/af_netlink.c:1251)
[  136.373525] netlink_unicast (./include/linux/refcount.h:255 ./include/linux/refcount.h:281 ./include/net/sock.h:1728 net/netlink/af_netlink.c:1257 net/netlink/af_netlink.c:1343)
[  136.377496] kauditd_send_queue (kernel/audit.c:734)
[  136.381643] kauditd_thread (kernel/audit.c:858 (discriminator 4))
[  136.385438] kthread (kernel/kthread.c:684)
[  136.388706] ret_from_fork (arch/arm64/kernel/entry.S:909)
[ 136.392332] Code: 54001340 7100081f 540016e1 a9478ba1 (f9400821)
All code
========
   0:	54001340	b.eq	0x268
   4:	7100081f	cmp	w0, #0x2
   8:	540016e1	b.ne	0x2e4
   c:	a9478ba1	ldp	x1, x2, [x29,#120]
  10:*	f9400821	ldr	x1, [x1,#16]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	f9400821	ldr	x1, [x1,#16]
[  136.398493] ---[ end trace 47d254973801b2c4 ]---
[  136.403162] Kernel panic - not syncing: Fatal exception
[  136.408445] SMP: stopping secondary CPUs
[  136.412440] Kernel Offset: 0x27c6200000 from 0xffffffc010000000
[  136.418417] PHYS_OFFSET: 0xffffffe140000000

The ISRA makes this a bit annoying to figure out the faulty line.

On a sidenote, I never really looked at what fipa-sra does, so I scrounged
this from GCC:

"""
IPA-SRA is an interprocedural pass that removes unused function return
values (turning functions returning a value which is never used into void
functions), removes unused function parameters.  It can also replace an
aggregate parameter by a set of other parameters representing part of the
original, turning those passed by reference into new ones which pass the
value directly.
"""

I suspect this is GCC getting rid of the 'sd_flag' parameter of
find_idlest_group() which is now unused. 


Back to the thing, the interesting bit is 

   0:	54001340	b.eq	0x268
   4:	7100081f	cmp	w0, #0x2
   8:	540016e1	b.ne	0x2e4
   c:	a9478ba1	ldp	x1, x2, [x29,#120]
  10:*	f9400821	ldr	x1, [x1,#16]		<-- trapping instruction

The misfit task cases seem to match the pattern of the last two lines. Here's
one:

        case group_misfit_task:                                                                                                                                                                             
                /* Select group with the highest max capacity */                                                                                                                                            
                if (local->sgc->max_capacity >= idlest->sgc->max_capacity)                                                                                                                                  
    1754:       a94783a2        ldp     x2, x0, [x29,#120]                                                                                                                                                  
    1758:       f9400801        ldr     x1, [x0,#16]  


Looking at the code, I think I got it. In find_idlest_group() we do
initialize 'idlest_sgs' (just like busiest_stat in LB) but 'idlest' is just
NULL. The latter is dereferenced in update_pick_idlest() just for the misfit
case, which goes boom. And I reviewed the damn thing... Bleh.

Fixup looks easy enough, lemme write one up.
