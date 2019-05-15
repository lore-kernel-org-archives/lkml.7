Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F2AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5B820843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="znIzqg9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfEOLty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:49:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60224 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730379AbfEOLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:49:52 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D60B82E149B;
        Wed, 15 May 2019 14:49:48 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id pJ6tum1Z9K-nm0OmG23;
        Wed, 15 May 2019 14:49:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557920988; bh=alH5k1PNJm4GaPT+kDtijaHC8uREaNw9t/O/7YUmZy4=;
        h=Message-ID:Date:To:From:Subject;
        b=znIzqg9/ngOeS3fHiE8MN2BO+J2dJ6ks5jQ+p1cRHJMbe2W0/uzVk8wq6yhiG8zns
         ChZzw7O3mUfGMNH/9nEcuU1BXNh9cFalHl9jlGpnxrwSrOeivKTgLSg5XTMhV9ZXh5
         znBZ2y+31vvCp6gcMKP0r2/TwqssR19FpPwgEXCE=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id b7fTz8WA2V-nml8HR87;
        Wed, 15 May 2019 14:49:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] proc/meminfo: add KernelMisc counter
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 14:49:48 +0300
Message-ID: <155792098821.1536.17069603544573830315.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel memory allocations are not accounted anywhere.
This adds easy-read counter for them by subtracting all tracked kinds.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/filesystems/proc.txt |    2 ++
 fs/proc/meminfo.c                  |   41 +++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..f11ce167124c 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -891,6 +891,7 @@ VmallocTotal:   112216 kB
 VmallocUsed:       428 kB
 VmallocChunk:   111088 kB
 Percpu:          62080 kB
+KernelMisc:     212856 kB
 HardwareCorrupted:   0 kB
 AnonHugePages:   49152 kB
 ShmemHugePages:      0 kB
@@ -988,6 +989,7 @@ VmallocTotal: total size of vmalloc memory area
 VmallocChunk: largest contiguous block of vmalloc area which is free
       Percpu: Memory allocated to the percpu allocator used to back percpu
               allocations. This stat excludes the cost of metadata.
+  KernelMisc: All other kinds of kernel memory allocaitons
 
 ..............................................................................
 
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..7bc14716fc5d 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -38,15 +38,21 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long cached;
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
-	unsigned long sreclaimable, sunreclaim;
+	unsigned long sreclaimable, sunreclaim, misc_reclaimable;
+	unsigned long kernel_stack_kb, page_tables, percpu_pages;
+	unsigned long anon_pages, file_pages, swap_cached;
+	long kernel_misc;
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
 
@@ -56,13 +62,25 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	available = si_mem_available();
 	sreclaimable = global_node_page_state(NR_SLAB_RECLAIMABLE);
 	sunreclaim = global_node_page_state(NR_SLAB_UNRECLAIMABLE);
+	misc_reclaimable = global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
+	kernel_stack_kb = global_zone_page_state(NR_KERNEL_STACK_KB);
+	page_tables = global_zone_page_state(NR_PAGETABLE);
+	percpu_pages = pcpu_nr_pages();
+
+	/* all other kinds of kernel memory allocations */
+	kernel_misc = i.totalram - i.freeram - anon_pages - file_pages
+		      - sreclaimable - sunreclaim - misc_reclaimable
+		      - (kernel_stack_kb >> (PAGE_SHIFT - 10))
+		      - page_tables - percpu_pages;
+	if (kernel_misc < 0)
+		kernel_misc = 0;
 
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
 	show_val_kb(m, "Buffers:        ", i.bufferram);
 	show_val_kb(m, "Cached:         ", cached);
-	show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
+	show_val_kb(m, "SwapCached:     ", swap_cached);
 	show_val_kb(m, "Active:         ", pages[LRU_ACTIVE_ANON] +
 					   pages[LRU_ACTIVE_FILE]);
 	show_val_kb(m, "Inactive:       ", pages[LRU_INACTIVE_ANON] +
@@ -92,20 +110,16 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_node_page_state(NR_FILE_DIRTY));
 	show_val_kb(m, "Writeback:      ",
 		    global_node_page_state(NR_WRITEBACK));
-	show_val_kb(m, "AnonPages:      ",
-		    global_node_page_state(NR_ANON_MAPPED));
+	show_val_kb(m, "AnonPages:      ", anon_pages);
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
-	show_val_kb(m, "KReclaimable:   ", sreclaimable +
-		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
+	show_val_kb(m, "KReclaimable:   ", sreclaimable + misc_reclaimable);
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
-	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_zone_page_state(NR_KERNEL_STACK_KB));
-	show_val_kb(m, "PageTables:     ",
-		    global_zone_page_state(NR_PAGETABLE));
+	seq_printf(m, "KernelStack:    %8lu kB\n", kernel_stack_kb);
+	show_val_kb(m, "PageTables:     ", page_tables);
 #ifdef CONFIG_QUICKLIST
 	show_val_kb(m, "Quicklists:     ", quicklist_total_size());
 #endif
@@ -122,7 +136,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   (unsigned long)VMALLOC_TOTAL >> 10);
 	show_val_kb(m, "VmallocUsed:    ", 0ul);
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
-	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
+	show_val_kb(m, "Percpu:         ", percpu_pages);
+	show_val_kb(m, "KernelMisc:     ", kernel_misc);
 
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",

