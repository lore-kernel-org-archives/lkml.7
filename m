Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD8320663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iCH1ACl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfDLTOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:14:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41808 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:14:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so12495675qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jk3IJK+uxHlhLyrLET/ST/TNlQnf1/FQ3O8nqOSpEFI=;
        b=iCH1ACl4Hdu/o0ka6oGZ8Np8tyxSsP4SGRofKiyvr9IVJaT2nHST1I2XmSqIemkWDN
         ap0nMLW5C6RMWwpsla7uNhFS9v7xsD7YJNOVcL7Ygk2HE5+wTy+keL7nWBwPrlgMuZT7
         EeTNpGZgL3L685aoebvERv/i0ioLq9J70k63XGmUiwUCwmHaLr3Bfa83E4UnTqiFNpHz
         2j5cz2e/FLX5CCNXj3ylqpVo+LHIESL0jQsNq4YMaLobX8W06mbPEVBRecwCmBJl+mEM
         ciSL75XMEc9UmnNY0p2rBJ+PI2vzWkJuzQhPhY5bsQ0Eh+SDGGwkeEd5KIac4W0pG5PN
         ITZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jk3IJK+uxHlhLyrLET/ST/TNlQnf1/FQ3O8nqOSpEFI=;
        b=Dzp+NOTv0iswgesTNbKTwCsYC496n3VGrtk42DJTXRF4ZauLlVKYvO8siakS4+KIPB
         127he+IrSzjgfqxL6JQSJ8HLPWHOyF5W8ZKTElfRUr1Qr8B6oqZfLYKlQA/l/sm9Z6CT
         xI5TKaRVYqbZGsZASXZPeryqaKr9xGpc9eAaNGLs4OzgkdpAGsGNfNtquoAtJwwk1ydw
         26f1dLjy5AhP85d6L4EpVTUt/B7Jgmgnxk3LvGOoFGWmAkGIuA36RUw+ON3Zj3TlGbQZ
         XkThfbdmOY+Kp0uCmwH4GHP4ktIRX6pk5LWbiJxB0J/Mu6j8nZHR+eYwJFFfw0TWcLz4
         lldw==
X-Gm-Message-State: APjAAAUVX8JYrexbuGKHQ1PXZFpdhXHkvZQnlb8VQHnyk/JLbXBOhR92
        8tO2KAaD+bObW6c611deV+wVNw==
X-Google-Smtp-Source: APXvYqyq9m+9i3ZW5k79jf7gkbdIwV2ZR0Pd/jS51R7EpZ/dKoI/BFsiDH4JSZThJ3QHwWWtbpTbYg==
X-Received: by 2002:ac8:72c4:: with SMTP id o4mr48777855qtp.88.1555096460622;
        Fri, 12 Apr 2019 12:14:20 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id u16sm34952720qtc.84.2019.04.12.12.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 12:14:19 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: fix false-positive OVERCOMMIT_GUESS failures
Date:   Fri, 12 Apr 2019 15:14:18 -0400
Message-Id: <20190412191418.26333-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the default overcommit==guess we occasionally run into mmap
rejections despite plenty of memory that would get dropped under
pressure but just isn't accounted reclaimable. One example of this is
dying cgroups pinned by some page cache. A previous case was auxiliary
path name memory associated with dentries; we have since annotated
those allocations to avoid overcommit failures (see d79f7aa496fc ("mm:
treat indirectly reclaimable memory as free in overcommit logic")).

But trying to classify all allocated memory reliably as reclaimable
and unreclaimable is a bit of a fool's errand. There could be a myriad
of dependencies that constantly change with kernel versions.

It becomes even more questionable of an effort when considering how
this estimate of available memory is used: it's not compared to the
system-wide allocated virtual memory in any way. It's not even
compared to the allocating process's address space. It's compared to
the single allocation request at hand!

So we have an elaborate left-hand side of the equation that tries to
assess the exact breathing room the system has available down to a
page - and then compare it to an isolated allocation request with no
additional context. We could fail an allocation of N bytes, but for
two allocations of N/2 bytes we'd do this elaborate dance twice in a
row and then still let N bytes of virtual memory through. This doesn't
make a whole lot of sense.

Let's take a step back and look at the actual goal of the
heuristic. From the documentation:

   Heuristic overcommit handling. Obvious overcommits of address
   space are refused. Used for a typical system. It ensures a
   seriously wild allocation fails while allowing overcommit to
   reduce swap usage.  root is allowed to allocate slightly more
   memory in this mode. This is the default.

If all we want to do is catch clearly bogus allocation requests
irrespective of the general virtual memory situation, the physical
memory counter-part doesn't need to be that complicated, either.

When in GUESS mode, catch wild allocations by comparing their request
size to total amount of ram and swap in the system.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/util.c | 51 +++++----------------------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 05a464929b3e..e2e4f8c3fa12 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -652,7 +652,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  */
 int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
-	long free, allowed, reserve;
+	long allowed;
 
 	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
 			-(s64)vm_committed_as_batch * num_online_cpus(),
@@ -667,51 +667,9 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 		return 0;
 
 	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
-		free = global_zone_page_state(NR_FREE_PAGES);
-		free += global_node_page_state(NR_FILE_PAGES);
-
-		/*
-		 * shmem pages shouldn't be counted as free in this
-		 * case, they can't be purged, only swapped out, and
-		 * that won't affect the overall amount of available
-		 * memory in the system.
-		 */
-		free -= global_node_page_state(NR_SHMEM);
-
-		free += get_nr_swap_pages();
-
-		/*
-		 * Any slabs which are created with the
-		 * SLAB_RECLAIM_ACCOUNT flag claim to have contents
-		 * which are reclaimable, under pressure.  The dentry
-		 * cache and most inode caches should fall into this
-		 */
-		free += global_node_page_state(NR_SLAB_RECLAIMABLE);
-
-		/*
-		 * Part of the kernel memory, which can be released
-		 * under memory pressure.
-		 */
-		free += global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
-
-		/*
-		 * Leave reserved pages. The pages are not for anonymous pages.
-		 */
-		if (free <= totalreserve_pages)
+		if (pages > totalram_pages() + total_swap_pages)
 			goto error;
-		else
-			free -= totalreserve_pages;
-
-		/*
-		 * Reserve some for root
-		 */
-		if (!cap_sys_admin)
-			free -= sysctl_admin_reserve_kbytes >> (PAGE_SHIFT - 10);
-
-		if (free > pages)
-			return 0;
-
-		goto error;
+		return 0;
 	}
 
 	allowed = vm_commit_limit();
@@ -725,7 +683,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 	 * Don't let a single process grow so big a user can't recover
 	 */
 	if (mm) {
-		reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
+		long reserve = sysctl_user_reserve_kbytes >> (PAGE_SHIFT - 10);
+
 		allowed -= min_t(long, mm->total_vm / 32, reserve);
 	}
 
-- 
2.21.0

