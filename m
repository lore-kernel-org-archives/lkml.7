Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD91C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E02086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406406AbfHILCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfHILCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A13D530941C4;
        Fri,  9 Aug 2019 11:02:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F06E60481;
        Fri,  9 Aug 2019 11:02:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2] drivers/base/memory.c: Don't store end_section_nr in memory blocks
Date:   Fri,  9 Aug 2019 13:02:00 +0200
Message-Id: <20190809110200.2746-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 09 Aug 2019 11:02:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each memory block spans the same amount of sections/pages/bytes. The size
is determined before the first memory block is created. No need to store
what we can easily calculate - and the calculations even look simpler now.

Michal brought up the idea of variable-sized memory blocks. However, if
we ever implement something like this, we will need an API compatibility
switch and reworks at various places (most code assumes a fixed memory
block size). So let's cleanup what we have right now.

While at it, fix the variable naming in register_mem_sect_under_node() -
we no longer talk about a single section.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Drop the macro for calculating the pfns per memory block

---
 drivers/base/memory.c  |  1 -
 drivers/base/node.c    | 10 +++++-----
 include/linux/memory.h |  1 -
 mm/memory_hotplug.c    |  2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 154d5d4a0779..cb80f2bdd7de 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -670,7 +670,6 @@ static int init_memory_block(struct memory_block **memory,
 		return -ENOMEM;
 
 	mem->start_section_nr = block_id * sections_per_block;
-	mem->end_section_nr = mem->start_section_nr + sections_per_block - 1;
 	mem->state = state;
 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 840c95baa1d8..257449cf061f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -756,13 +756,13 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 static int register_mem_sect_under_node(struct memory_block *mem_blk,
 					 void *arg)
 {
+	unsigned long memory_block_pfns = memory_block_size_bytes() / PAGE_SIZE;
+	unsigned long start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
+	unsigned long end_pfn = start_pfn + memory_block_pfns - 1;
 	int ret, nid = *(int *)arg;
-	unsigned long pfn, sect_start_pfn, sect_end_pfn;
+	unsigned long pfn;
 
-	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
-	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
-	sect_end_pfn += PAGES_PER_SECTION - 1;
-	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
+	for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
 		int page_nid;
 
 		/*
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 02e633f3ede0..704215d7258a 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -25,7 +25,6 @@
 
 struct memory_block {
 	unsigned long start_section_nr;
-	unsigned long end_section_nr;
 	unsigned long state;		/* serialized by the dev->lock */
 	int section_count;		/* serialized by mem_sysfs_mutex */
 	int online_type;		/* for passing data to online routine */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9a82e12bd0e7..db33a0ffcb1f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1650,7 +1650,7 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 		phys_addr_t beginpa, endpa;
 
 		beginpa = PFN_PHYS(section_nr_to_pfn(mem->start_section_nr));
-		endpa = PFN_PHYS(section_nr_to_pfn(mem->end_section_nr + 1))-1;
+		endpa = beginpa + memory_block_size_bytes() - 1;
 		pr_warn("removing memory fails, because memory [%pa-%pa] is onlined\n",
 			&beginpa, &endpa);
 
-- 
2.21.0

