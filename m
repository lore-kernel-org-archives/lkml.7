Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97934C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A921852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdxfy4ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfGEEQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:16:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34230 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfGEEQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:16:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so3694603pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kWttqF7CHQ114C55wMktQz7skpu5ho5Lb6fP5pPQp9U=;
        b=tdxfy4STGPcqwwVWzra7lbJ2JRjaFt7j2O9OWE+BzEFHYyy7rhg4R1uFb3dSKnGLmW
         ZCt3Zza9jr5O8XkYro2uVrqfJzZX4m1e2X4NSZFN2DLt3tppB6dd2MId876lZBeyDJIg
         pWx+tAlfOpCdbjgeKFQcK+Bw3riP8mWt8lSrCPrmQv6HhXTe5pidh2lqVRM7ODLVE6Fk
         S1mIB1P4eC2JFVTsX3qrJH/zMg5PDseN8c693FwIl4VoQvIHAhi+3FOyd7G41F28khlW
         73K7JZfbUW0mppJHDxGWLg96PZhZreiotoquMuq9xLdDDZYM6u6AR3jFZcvLY5ZxNSJy
         Te1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kWttqF7CHQ114C55wMktQz7skpu5ho5Lb6fP5pPQp9U=;
        b=H/RkpSPHgBZDKTiYcrdUnAgU0fqqVuLP4srARzhlYqpj8AZe+EaaIbhJwqPFSXXcjD
         pIy65EbEdQm75bA9A9SxaySsvhI0qNDQpmK4MWK3obGW5psQpRryCk4ETYPOsQSjjzlG
         WuHUS+MN4PU4tib8psiTrZqKg4jLnmLyZS9pZssbKYmK0stf/ibDaWcWfCYB1NaujZfE
         NADiZTIrRi/Q8EpzfhAq/Y3MFaPITtqg4AnK34mEnJAdcCufHfFYSPne9qWCIWNZoJzg
         Fm/F1Uy6Wq39ruCFjBEFimTyNqC9UwBr65frd5aFrep18VBiuL3afYpx/a/C2zeE8erc
         PNEw==
X-Gm-Message-State: APjAAAUeXrcxQl1+p4Yazk+TikgDHYnnCMrm37vaWQF/GDAwOL2EOrgf
        ZHzsal18JubTlY+h8YOr/g==
X-Google-Smtp-Source: APXvYqxLU0nY2JNq8NXLUQYCkAcGmqObHqea9+Ern1/7A8PbSiqDLInTHbwtAPI1qobvVjwX8+tKKw==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr2022832pjg.90.1562300204164;
        Thu, 04 Jul 2019 21:16:44 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7821:9e80:eaf2:5f81:4c66:c3d0])
        by smtp.gmail.com with ESMTPSA id l68sm16328638pjb.8.2019.07.04.21.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:16:43 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/numa: instance all parsed numa node
Date:   Fri,  5 Jul 2019 12:15:43 +0800
Message-Id: <1562300143-11671-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit a bug on an AMD machine, with kexec -l nr_cpus=4 option. nr_cpus option
is used to speed up kdump process, so it is not a rare case.

It turns out that some pgdat is not instanced when specifying nr_cpus, e.g, on
x86, not initialized by init_cpu_to_node()->init_memory_less_node(). But
device->numa_node info is used as preferred_nid param for
__alloc_pages_nodemask(), which causes NULL reference ac->zonelist =
node_zonelist(preferred_nid, gfp_mask);

Although this bug is detected on x86, it should affect all archs, where a
machine with a numa-node having no memory, if nr_cpus prevents the instance of
the node, and the device on the node tries to allocate memory with
device->numa_node info.

The patch takes the way by instancing all parsed numa node on x86. (for more
detail, please refer to section I and II)

I. Notes about the crashing info:
-1 kexec -l with nr_cpus=4
-2 system info
  NUMA node0 CPU(s):     0,8,16,24
  NUMA node1 CPU(s):     2,10,18,26
  NUMA node2 CPU(s):     4,12,20,28
  NUMA node3 CPU(s):     6,14,22,30
  NUMA node4 CPU(s):     1,9,17,25
  NUMA node5 CPU(s):     3,11,19,27
  NUMA node6 CPU(s):     5,13,21,29
  NUMA node7 CPU(s):     7,15,23,31
-3 panic stack
[...]
[    5.721547] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    5.729187] pcieport 0000:00:01.1: Signaling PME with IRQ 34
[    5.735187] pcieport 0000:00:01.2: Signaling PME with IRQ 35
[    5.741168] pcieport 0000:00:01.3: Signaling PME with IRQ 36
[    5.747189] pcieport 0000:00:07.1: Signaling PME with IRQ 37
[    5.754061] pcieport 0000:00:08.1: Signaling PME with IRQ 39
[    5.760727] pcieport 0000:20:07.1: Signaling PME with IRQ 40
[    5.766955] pcieport 0000:20:08.1: Signaling PME with IRQ 42
[    5.772742] BUG: unable to handle kernel paging request at 0000000000002088
[    5.773618] PGD 0 P4D 0
[    5.773618] Oops: 0000 [#1] SMP NOPTI
[    5.773618] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc1+ #3
[    5.773618] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.4.3 06/29/2018
[    5.773618] RIP: 0010:__alloc_pages_nodemask+0xe2/0x2a0
[    5.773618] Code: 00 00 44 89 ea 80 ca 80 41 83 f8 01 44 0f 44 ea 89 da c1 ea 08 83 e2 01 88 54 24 20 48 8b 54 24 08 48 85 d2 0f 85 46 01 00 00 <3b> 77 08 0f 82 3d 01 00 00 48 89 f8 44 89 ea 48 89
e1 44 89 e6 89
[    5.773618] RSP: 0018:ffffaa600005fb20 EFLAGS: 00010246
[    5.773618] RAX: 0000000000000000 RBX: 00000000006012c0 RCX: 0000000000000000
[    5.773618] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
[    5.773618] RBP: 00000000006012c0 R08: 0000000000000000 R09: 0000000000000002
[    5.773618] R10: 00000000006080c0 R11: 0000000000000002 R12: 0000000000000000
[    5.773618] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
[    5.773618] FS:  0000000000000000(0000) GS:ffff8c69afe00000(0000) knlGS:0000000000000000
[    5.773618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.773618] CR2: 0000000000002088 CR3: 000000087e00a000 CR4: 00000000003406e0
[    5.773618] Call Trace:
[    5.773618]  new_slab+0xa9/0x570
[    5.773618]  ___slab_alloc+0x375/0x540
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  __slab_alloc+0x1c/0x38
[    5.773618]  __kmalloc_node_track_caller+0xc8/0x270
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  devm_kmalloc+0x28/0x60
[    5.773618]  pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  really_probe+0x73/0x420
[    5.773618]  driver_probe_device+0x115/0x130
[    5.773618]  __driver_attach+0x103/0x110
[    5.773618]  ? driver_probe_device+0x130/0x130
[    5.773618]  bus_for_each_dev+0x67/0xc0
[    5.773618]  ? klist_add_tail+0x3b/0x70
[    5.773618]  bus_add_driver+0x41/0x260
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  driver_register+0x5b/0xe0
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  do_one_initcall+0x4e/0x1d4
[    5.773618]  ? init_setup+0x25/0x28
[    5.773618]  kernel_init_freeable+0x1c1/0x26e
[    5.773618]  ? loglevel+0x5b/0x5b
[    5.773618]  ? rest_init+0xb0/0xb0
[    5.773618]  kernel_init+0xa/0x110
[    5.773618]  ret_from_fork+0x22/0x40
[    5.773618] Modules linked in:
[    5.773618] CR2: 0000000000002088
[    5.773618] ---[ end trace 1030c9120a03d081 ]---
[...]

-4 other notes about the reproduction of this bug:
On my test machine, this bug is covered by 'commit 0d76bcc960e6 ("Revert
"ACPI/PCI: Pay attention to device-specific _PXM node values"")', but the
crack caused by dev->numa_node is still exposed from other path.

II. history

I had a original try on [1], which took the way by deferring the instance of
offline node.

Later Michal has suggested a fix [2], which only consider node with memory as
online. Beside fixing this bug, that patch also aimed at excluding memory-less
node as a candidate when iterating the zones. It is a pity that the method
conflicts with the scheduler code, which assumes node with cpu as online too.
You can find the broken by "git grep for_each_online_node | grep sched" or the
discussion in tail of [3].

Since Michal has no time to continue on this issue. I pick it up again.  This
patch drops the change of "node online" definition in [2], i.e. still consider
node as online if it has either cpu or memory. And keeps the rest main idea in
[2] of initializing all parsed node on x86. For other archs, they need extra
dedicated effort.

[1]: https://patchwork.kernel.org/patch/10738733/
[2]: https://lkml.org/lkml/2019/2/13/253
[3]: https://lore.kernel.org/lkml/20190528182011.GG1658@dhcp22.suse.cz/T/

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Qian Cai <cai@lca.pw>
Cc: Barret Rhoden <brho@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/mm/numa.c | 17 ++++++++++++-----
 mm/page_alloc.c    | 11 ++++++++---
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index b48d507..5f5b558 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -732,6 +732,15 @@ static void __init init_memory_less_node(int nid)
 	 */
 }
 
+static void __init init_parsed_rest_node(void)
+{
+	int node;
+
+	for_each_node_mask(node, node_possible_map)
+		if (!node_online(node))
+			init_memory_less_node(node);
+}
+
 /*
  * Setup early cpu_to_node.
  *
@@ -752,6 +761,7 @@ void __init init_cpu_to_node(void)
 	u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
 
 	BUG_ON(cpu_to_apicid == NULL);
+	init_parsed_rest_node();
 
 	for_each_possible_cpu(cpu) {
 		int node = numa_cpu_node(cpu);
@@ -759,11 +769,8 @@ void __init init_cpu_to_node(void)
 		if (node == NUMA_NO_NODE)
 			continue;
 
-		if (!node_online(node)) {
-			init_memory_less_node(node);
-			node_set_online(nid);
-		}
-
+		if (!node_online(node))
+			node_set_online(node);
 		numa_set_node(cpu, node);
 	}
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8a..5d8db00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5662,10 +5662,15 @@ static void __build_all_zonelists(void *data)
 	if (self && !node_online(self->node_id)) {
 		build_zonelists(self);
 	} else {
-		for_each_online_node(nid) {
+		/* In rare case, node_zonelist() hits offline node */
+		for_each_node(nid) {
 			pg_data_t *pgdat = NODE_DATA(nid);
-
-			build_zonelists(pgdat);
+			/*
+			 * This condition can be removed on archs, with all
+			 * possible node instanced.
+			 */
+			if (pgdat)
+				build_zonelists(pgdat);
 		}
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.7.5

