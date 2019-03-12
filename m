Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5017E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCLHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:33:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51902 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbfCLHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:33:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TMXFWBE_1552376019;
Received: from h07e11201.sqa.eu95(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TMXFWBE_1552376019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 15:33:46 +0800
Date:   Tue, 12 Mar 2019 15:33:39 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Greg Kerr <kerrnel@google.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, Greg Kerr <greg@kerrnel.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190312073338.GA7958@h07e11201.sqa.eu95>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
 <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
 <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
 <CAJGSLMuLVDXhffOWbnzt8-P7u68OODkN_pwvSt9MBH5mbyAfQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJGSLMuLVDXhffOWbnzt8-P7u68OODkN_pwvSt9MBH5mbyAfQQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:20:19PM -0700, Greg Kerr wrote:
> On Mon, Mar 11, 2019 at 4:36 PM Subhra Mazumdar
> <subhra.mazumdar@oracle.com> wrote:
> >
> >
> > On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
> > >
> > > On 3/10/19 9:23 PM, Aubrey Li wrote:
> > >> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
> > >> <subhra.mazumdar@oracle.com> wrote:
> > >>> expected. Most of the performance recovery happens in patch 15 which,
> > >>> unfortunately, is also the one that introduces the hard lockup.
> > >>>
> > >> After applied Subhra's patch, the following is triggered by enabling
> > >> core sched when a cgroup is
> > >> under heavy load.
> > >>
> > > It seems you are facing some other deadlock where printk is involved.
> > > Can you
> > > drop the last patch (patch 16 sched: Debug bits...) and try?
> > >
> > > Thanks,
> > > Subhra
> > >
> > Never Mind, I am seeing the same lockdep deadlock output even w/o patch
> > 16. Btw
> > the NULL fix had something missing, following works.
> 
> Is this panic below, which occurs when I tag the first process,
> related or known? If not, I will debug it tomorrow.
> 
> [   46.831828] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000000
> [   46.831829] core sched enabled
> [   46.834261] #PF error: [WRITE]
> [   46.834899] PGD 0 P4D 0
> [   46.835438] Oops: 0002 [#1] SMP PTI
> [   46.836158] CPU: 0 PID: 11 Comm: migration/0 Not tainted
> 5.0.0everyday-glory-03949-g2d8fdbb66245-dirty #7
> [   46.838206] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014

Probably due to SMT not enabled for this qemu setup.

rq->core can be NULL for cpu0: sched_cpu_starting() won't be called for
CPU0 and since it doesn't have any siblings, its rq->core remains
un-initialized(NULL).

> [   46.839844] RIP: 0010:_raw_spin_lock+0x7/0x20
> [   46.840448] Code: 00 00 00 65 81 05 25 ca 5c 51 00 02 00 00 31 c0
> ba ff 00 00 00 f0 0f b1 17 74 05 e9 93 80 46 ff f3 c3 90 31 c0 ba 01
> 00 00 00 <f0> 0f b1 17 74 07 89 c6 e9 1c 6e 46 ff f3 c3 66 2e 0f 1f 84
> 00 00
> [   46.843000] RSP: 0018:ffffb9d300cabe38 EFLAGS: 00010046
> [   46.843744] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [   46.844709] RDX: 0000000000000001 RSI: ffffffffaea435ae RDI: 0000000000000000
> [   46.845689] RBP: ffffb9d300cabed8 R08: 0000000000000000 R09: 0000000000020800
> [   46.846651] R10: ffffffffaf603ea0 R11: 0000000000000001 R12: ffffffffaf6576c0
> [   46.847619] R13: ffff9a57366c8000 R14: ffff9a5737401300 R15: ffffffffade868f0
> [   46.848584] FS:  0000000000000000(0000) GS:ffff9a5737a00000(0000)
> knlGS:0000000000000000
> [   46.849680] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.850455] CR2: 0000000000000000 CR3: 00000001d36fa000 CR4: 00000000000006f0
> [   46.851415] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.852371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   46.853326] Call Trace:
> [   46.853678]  __schedule+0x139/0x11f0
> [   46.854167]  ? cpumask_next+0x16/0x20
> [   46.854668]  ? cpu_stop_queue_work+0xc0/0xc0
> [   46.855252]  ? sort_range+0x20/0x20
> [   46.855742]  schedule+0x4e/0x60
> [   46.856171]  smpboot_thread_fn+0x12a/0x160
> [   46.856725]  kthread+0x112/0x120
> [   46.857164]  ? kthread_stop+0xf0/0xf0
> [   46.857661]  ret_from_fork+0x35/0x40
> [   46.858146] Modules linked in:
> [   46.858562] CR2: 0000000000000000
> [   46.859022] ---[ end trace e9fff08f17bfd2be ]---
