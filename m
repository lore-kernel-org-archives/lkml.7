Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF50D20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfDBNnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43666 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731519AbfDBNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:12 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002os-6Z; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004xd-Uq; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Miroslav Benes" <mbenes@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.203934992@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 89/99] mm, memory_hotplug: do not clear numa_node
 association after hot_remove
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 46a3679b8190101e4ebdfe252ef79e6150a4f2ac upstream.

Per-cpu numa_node provides a default node for each possible cpu.  The
association gets initialized during the boot when the architecture
specific code explores cpu->NUMA affinity.  When the whole NUMA node is
removed though we are clearing this association

try_offline_node
  check_and_unmap_cpu_on_node
    unmap_cpu_on_node
      numa_clear_node
        numa_set_node(cpu, NUMA_NO_NODE)

This means that whoever calls cpu_to_node for a cpu associated with such a
node will get NUMA_NO_NODE.  This is problematic for two reasons.  First
it is fragile because __alloc_pages_node would simply blow up on an
out-of-bound access.  We have encountered this when loading kvm module

  BUG: unable to handle kernel paging request at 00000000000021c0
  IP: __alloc_pages_nodemask+0x93/0xb70
  PGD 800000ffe853e067 PUD 7336bbc067 PMD 0
  Oops: 0000 [#1] SMP
  [...]
  CPU: 88 PID: 1223749 Comm: modprobe Tainted: G        W          4.4.156-94.64-default #1
  RIP: __alloc_pages_nodemask+0x93/0xb70
  RSP: 0018:ffff887354493b40  EFLAGS: 00010202
  RAX: 00000000000021c0 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00000000014000c0
  RBP: 00000000014000c0 R08: ffffffffffffffff R09: 0000000000000000
  R10: ffff88fffc89e790 R11: 0000000000014000 R12: 0000000000000101
  R13: ffffffffa0772cd4 R14: ffffffffa0769ac0 R15: 0000000000000000
  FS:  00007fdf2f2f1700(0000) GS:ffff88fffc880000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000021c0 CR3: 00000077205ee000 CR4: 0000000000360670
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
    alloc_vmcs_cpu+0x3d/0x90 [kvm_intel]
    hardware_setup+0x781/0x849 [kvm_intel]
    kvm_arch_hardware_setup+0x28/0x190 [kvm]
    kvm_init+0x7c/0x2d0 [kvm]
    vmx_init+0x1e/0x32c [kvm_intel]
    do_one_initcall+0xca/0x1f0
    do_init_module+0x5a/0x1d7
    load_module+0x1393/0x1c90
    SYSC_finit_module+0x70/0xa0
    entry_SYSCALL_64_fastpath+0x1e/0xb7
  DWARF2 unwinder stuck at entry_SYSCALL_64_fastpath+0x1e/0xb7

on an older kernel but the code is basically the same in the current Linus
tree as well.  alloc_vmcs_cpu could use alloc_pages_nodemask which would
recognize NUMA_NO_NODE and use alloc_pages_node which would translate it
to numa_mem_id but that is wrong as well because it would use a cpu
affinity of the local CPU which might be quite far from the original node.
It is also reasonable to expect that cpu_to_node will provide a sane
value and there might be many more callers like that.

The second problem is that __register_one_node relies on cpu_to_node to
properly associate cpus back to the node when it is onlined.  We do not
want to lose that link as there is no arch independent way to get it from
the early boot time AFAICS.

Drop the whole check_and_unmap_cpu_on_node machinery and keep the
association to fix both issues.  The NODE_DATA(nid) is not deallocated so
it will stay in place and if anybody wants to allocate from that node then
a fallback node will be used.

Thanks to Vlastimil Babka for his live system debugging skills that helped
debugging the issue.

Link: http://lkml.kernel.org/r/20181108100413.966-1-mhocko@kernel.org
Fixes: e13fe8695c57 ("cpu-hotplug,memory-hotplug: clear cpu_to_node() when offlining the node")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Debugged-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/memory_hotplug.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1880,34 +1880,6 @@ static int check_cpu_on_node(pg_data_t *
 	return 0;
 }
 
-static void unmap_cpu_on_node(pg_data_t *pgdat)
-{
-#ifdef CONFIG_ACPI_NUMA
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		if (cpu_to_node(cpu) == pgdat->node_id)
-			numa_clear_node(cpu);
-#endif
-}
-
-static int check_and_unmap_cpu_on_node(pg_data_t *pgdat)
-{
-	int ret;
-
-	ret = check_cpu_on_node(pgdat);
-	if (ret)
-		return ret;
-
-	/*
-	 * the node will be offlined when we come here, so we can clear
-	 * the cpu_to_node() now.
-	 */
-
-	unmap_cpu_on_node(pgdat);
-	return 0;
-}
-
 /**
  * try_offline_node
  *
@@ -1941,7 +1913,7 @@ void try_offline_node(int nid)
 		return;
 	}
 
-	if (check_and_unmap_cpu_on_node(pgdat))
+	if (check_cpu_on_node(pgdat))
 		return;
 
 	/*

