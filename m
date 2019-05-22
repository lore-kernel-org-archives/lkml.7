Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B0FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DE220879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zI6588Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfEVOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:40:14 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:38576 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbfEVOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:40:13 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7979E2E162C;
        Wed, 22 May 2019 17:40:10 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bZCXAvv80Q-e9pKJDIN;
        Wed, 22 May 2019 17:40:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558536010; bh=BqAJnQpienbKWE5dL9MJToB57FsyWv+8oBcom0L+rQE=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=zI6588Es4FHMRdleL27Ulp8kfH0we6Y2IcZS0/LtI9lsyEyFwMfLABAPCut1wupcR
         i2U7k+QMHxHDczYHK2kWdIh16SyYAaoNIuzzdo7rdbUzb76a5eV9cy6CS+s07hZI89
         MbG6e6bYQaFWTzRv5iu41z9n5LRQh6JMRdG/2PtI=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:e47f:4b1d:b053:2762])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 60MI0YGxhR-e9d4Vdmq;
        Wed, 22 May 2019 17:40:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] proc/meminfo: add MemKernel counter
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 22 May 2019 17:40:09 +0300
Message-ID: <155853600919.381.8172097084053782598.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kinds of kernel allocations are not accounted or not show in meminfo.
For example vmalloc allocations are tracked but overall size is not shown
for performance reasons. There is no information about network buffers.

In most cases detailed statistics is not required. At first place we need
information about overall kernel memory usage regardless of its structure.

This patch estimates kernel memory usage by subtracting known sizes of
free, anonymous, hugetlb and caches from total memory size: MemKernel =
MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/filesystems/proc.txt |    5 +++++
 fs/proc/meminfo.c                  |   20 +++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..a0ab7f273ea0 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -860,6 +860,7 @@ varies by architecture and compile options.  The following is from a
 
 MemTotal:     16344972 kB
 MemFree:      13634064 kB
+MemKernel:      862600 kB
 MemAvailable: 14836172 kB
 Buffers:          3656 kB
 Cached:        1195708 kB
@@ -908,6 +909,10 @@ MemAvailable: An estimate of how much memory is available for starting new
               page cache to function well, and that not all reclaimable
               slab will be reclaimable, due to items being in use. The
               impact of those factors will vary from system to system.
+   MemKernel: The sum of all kinds of kernel memory allocations: Slab,
+              Vmalloc, Percpu, KernelStack, PageTables, socket buffers,
+              and some other untracked allocations. Does not include
+              MemFree, Buffers, Cached, SwapCached, AnonPages, Hugetlb.
      Buffers: Relatively temporary storage for raw disk blocks
               shouldn't get tremendously large (20MB or so)
       Cached: in-memory cache for files read from the disk (the
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..b27d56dd619a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,17 +39,27 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long anon_pages, file_pages, swap_cached;
+	long kernel_pages;
 	int lru;
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
 	committed = percpu_counter_read_positive(&vm_committed_as);
 
-	cached = global_node_page_state(NR_FILE_PAGES) -
-			total_swapcache_pages() - i.bufferram;
+	anon_pages = global_node_page_state(NR_ANON_MAPPED);
+	file_pages = global_node_page_state(NR_FILE_PAGES);
+	swap_cached = total_swapcache_pages();
+
+	cached = file_pages - swap_cached - i.bufferram;
 	if (cached < 0)
 		cached = 0;
 
+	kernel_pages = i.totalram - i.freeram - anon_pages - file_pages -
+		       hugetlb_total_pages();
+	if (kernel_pages < 0)
+		kernel_pages = 0;
+
 	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
 		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
@@ -60,9 +70,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
+	show_val_kb(m, "MemKernel:      ", kernel_pages);
 	show_val_kb(m, "Buffers:        ", i.bufferram);
 	show_val_kb(m, "Cached:         ", cached);
-	show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
+	show_val_kb(m, "SwapCached:     ", swap_cached);
 	show_val_kb(m, "Active:         ", pages[LRU_ACTIVE_ANON] +
 					   pages[LRU_ACTIVE_FILE]);
 	show_val_kb(m, "Inactive:       ", pages[LRU_INACTIVE_ANON] +
@@ -92,8 +103,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_FILE_DIRTY));
 	show_val_kb(m, "Writeback:      ",
 		    global_node_page_state(NR_WRITEBACK));
-	show_val_kb(m, "AnonPages:      ",
-		    global_node_page_state(NR_ANON_MAPPED));
+	show_val_kb(m, "AnonPages:      ", anon_pages);
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);

