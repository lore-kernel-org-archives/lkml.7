Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBEBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187B2208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfFGXjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:39:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:29886 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfFGXjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:39:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 16:39:13 -0700
X-ExtLoop1: 1
Received: from guptapadev.jf.intel.com (HELO guptapadev.amr) ([10.7.198.56])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2019 16:39:13 -0700
Date:   Fri, 7 Jun 2019 16:36:56 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190607233656.GB12952@guptapadev.amr>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <f7d51cdfc5672677084e0f4b01b28eabbcdd99a6.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d51cdfc5672677084e0f4b01b28eabbcdd99a6.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:49PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).
> 
> NOTE: there is still potential for siblings rivalry.
> NOTE: this is far too complicated; but thus far I've failed to
>       simplify it further.

Looks like there are still some race conditions while bringing cpu
online/offline. I am seeing an easy to reproduce panic when turning SMT on/off
in a loop with core scheduling ON. I dont see the panic with core scheduling
OFF.

Steps to reproduce:

mkdir /sys/fs/cgroup/cpu/group1
mkdir /sys/fs/cgroup/cpu/group2
echo 1 > /sys/fs/cgroup/cpu/group1/cpu.tag
echo 1 > /sys/fs/cgroup/cpu/group2/cpu.tag

echo $$ > /sys/fs/cgroup/cpu/group1/tasks

while [ 1 ];  do
	echo on	 > /sys/devices/system/cpu/smt/control
	echo off > /sys/devices/system/cpu/smt/control
done

Panic logs:
[  274.629437] BUG: unable to handle kernel NULL pointer dereference at
0000000000000024
[  274.630366] #PF error: [normal kernel read fault]
[  274.630933] PGD 800000003e52c067 P4D 800000003e52c067 PUD 0
[  274.631613] Oops: 0000 [#1] SMP PTI
[  274.632016] CPU: 0 PID: 1470 Comm: bash Tainted: G        W
5.1.4+ #33
[  274.632854] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29
04/01/2014
[  274.634248] RIP: 0010:__schedule+0x9d4/0x1350
[  274.634699] Code: da 0f 83 21 04 00 00 48 8b 35 70 f3 ab 00 48 c7 c7
51 1c a8 81 e8 4c 4e 6b ff 49 8b 85 b8 0b 00 00 48 85 c0 0f 84 2f 09 00
01
[  274.636648] RSP: 0018:ffffc900008f3ca8 EFLAGS: 00010046
[  274.637197] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
0000000000000040
[  274.637941] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffff82544890
[  274.638691] RBP: ffffc900008f3d40 R08: 00000000000004c7 R09:
0000000000000030
[  274.639449] R10: 0000000000000001 R11: ffffc900008f3b28 R12:
ffff88803d2d0e80
[  274.640172] R13: ffff88803eaa0a40 R14: ffff88803ea20a40 R15:
ffff88803d2d0e80
[  274.640915] FS:  0000000000000000(0000) GS:ffff88803ea00000(0063)
knlGS:00000000f7f8b780
[  274.641755] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  274.642355] CR2: 0000000000000024 CR3: 000000003c01a005 CR4:
0000000000360ef0
[  274.643135] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  274.643995] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  274.645023] Call Trace:
[  274.645336]  schedule+0x28/0x70
[  274.645621]  native_cpu_up+0x271/0x6d0
[  274.645959]  ? cpus_read_trylock+0x40/0x40
[  274.646324]  bringup_cpu+0x2d/0xe0
[  274.646631]  cpuhp_invoke_callback+0x94/0x550
[  274.647032]  ? ring_buffer_record_is_set_on+0x10/0x10
[  274.647478]  _cpu_up+0xa9/0x140
[  274.647763]  store_smt_control+0x1cb/0x260
[  274.648132]  kernfs_fop_write+0x108/0x190
[  274.648498]  vfs_write+0xa5/0x1a0
[  274.648794]  ksys_write+0x57/0xd0
[  274.649100]  do_fast_syscall_32+0x92/0x220
[  274.649468]  entry_SYSENTER_compat+0x7c/0x8e


NULL pointer exception is triggered when sibling is offline during core task
pick in pick_next_task() leaving rq_i->core_pick = NULL and if sibling comes
online before the "Reschedule siblings" block in the same function it causes
panic in is_idle_task(rq_i->core_pick).

Traces for the scenario:
[ 274.599567] bash-1470 0d... 273921815us : __schedule: cpu(0) is online during core_pick 
[ 274.600339] bash-1470 0d... 273921816us : __schedule: cpu(1) is offline during core_pick 
[ 274.601106] bash-1470 0d... 273921816us : __schedule: picked: bash/1470 ffff88803cb9c000 
[ 274.602106] bash-1470 0d... 273921816us : __schedule: cpu(0) is online.. during Reschedule siblings 
[ 274.603219] bash-1470 0d... 273921816us : __schedule: cpu(1) is online.. during Reschedule siblings 
[ 274.604333] <idle>-0 1d... 273921816us : start_secondary: cpu(1) is online now 
[ 274.605239] bash-1470 0d... 273922148us : __schedule: rq_i->core_pick on cpu(1) is NULL

I am not able to reproduce the panic after the below change. Not sure if this
is the right fix. Maybe we don't have to allow cpus to go online/offline while
pick_next_task() is executing.

-------------- 8< ---------------
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90655c9ad937..b230b095772a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3874,7 +3874,7 @@ next_class:;
        for_each_cpu(i, smt_mask) {
                struct rq *rq_i = cpu_rq(i);
 
-               if (cpu_is_offline(i))
+               if (cpu_is_offline(i) || !rq_i->core_pick)
                        continue;
 
                WARN_ON_ONCE(!rq_i->core_pick);
