Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1406217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554784247;
	bh=ovcgkNvUTRNhpQLDpzSrnSD7eK8UmR0Bob3F0soYNUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YLFeZbdQEuIm79+O0s9tSgJfBuSMsB7fuaBPS/vjbWHnO14lcUwhiP3pVgh1QzbLt
	 f9LfsbLiloplj44Fto1DNv/RBQyL2OqXmBmFVwrTeqO27QRklmPn0XOPtKMvjdaCD4
	 HhQBaDOQjNUBPRY3+W+rQ0ApNmFOcptoAAI24xhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfDIEap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:30:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIEap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:30:45 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8EC8E26;
        Tue,  9 Apr 2019 04:30:43 +0000 (UTC)
Date:   Mon, 8 Apr 2019 21:30:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@suse.com, david@redhat.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm, memory_hotplug: provide a more generic
 restrictions for memory hotplug
Message-Id: <20190408213041.50350dac32ed315839c57e09@linux-foundation.org>
In-Reply-To: <20190408082633.2864-3-osalvador@suse.de>
References: <20190408082633.2864-1-osalvador@suse.de>
        <20190408082633.2864-3-osalvador@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Apr 2019 10:26:33 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> arch_add_memory, __add_pages take a want_memblock which controls whether
> the newly added memory should get the sysfs memblock user API (e.g.
> ZONE_DEVICE users do not want/need this interface). Some callers even
> want to control where do we allocate the memmap from by configuring
> altmap.
> 
> Add a more generic hotplug context for arch_add_memory and __add_pages.
> struct mhp_restrictions contains flags which contains additional
> features to be enabled by the memory hotplug (MHP_MEMBLOCK_API
> currently) and altmap for alternative memmap allocator.
> 
> This patch shouldn't introduce any functional change.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-memory_hotplug-provide-a-more-generic-restrictions-for-memory-hotplug-fix

x86_64 allnoconfig:

In file included from ./include/linux/mmzone.h:744:0,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/umh.h:4,
                 from ./include/linux/kmod.h:22,
                 from ./include/linux/module.h:13,
                 from init/do_mounts.c:1:
./include/linux/memory_hotplug.h:353:11: warning: ‘struct mhp_restrictions’ declared inside parameter list will not be visible outside of this definition or declaration
    struct mhp_restrictions *restrictions);
           ^~~~~~~~~~~~~~~~

Fix this by moving the arch_add_memory() definition inside
CONFIG_MEMORY_HOTPLUG and moving the mhp_restrictions definition to a more
appropriate place.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/memory_hotplug.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/include/linux/memory_hotplug.h~mm-memory_hotplug-provide-a-more-generic-restrictions-for-memory-hotplug-fix
+++ a/include/linux/memory_hotplug.h
@@ -54,6 +54,16 @@ enum {
 };
 
 /*
+ * Restrictions for the memory hotplug:
+ * flags:  MHP_ flags
+ * altmap: alternative allocator for memmap array
+ */
+struct mhp_restrictions {
+	unsigned long flags;
+	struct vmem_altmap *altmap;
+};
+
+/*
  * Zone resizing functions
  *
  * Note: any attempt to resize a zone should has pgdat_resize_lock()
@@ -101,6 +111,8 @@ extern void __online_page_free(struct pa
 
 extern int try_online_node(int nid);
 
+extern int arch_add_memory(int nid, u64 start, u64 size,
+			struct mhp_restrictions *restrictions);
 extern u64 max_mem_size;
 
 extern bool memhp_auto_online;
@@ -126,16 +138,6 @@ extern int __remove_pages(struct zone *z
 
 #define MHP_MEMBLOCK_API               (1<<0)
 
-/*
- * Restrictions for the memory hotplug:
- * flags:  MHP_ flags
- * altmap: alternative allocator for memmap array
- */
-struct mhp_restrictions {
-	unsigned long flags;
-	struct vmem_altmap *altmap;
-};
-
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 		       struct mhp_restrictions *restrictions);
@@ -349,8 +351,6 @@ extern int walk_memory_range(unsigned lo
 extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
 extern int add_memory_resource(int nid, struct resource *resource);
-extern int arch_add_memory(int nid, u64 start, u64 size,
-			struct mhp_restrictions *restrictions);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern bool is_memblock_offlined(struct memory_block *mem);
_

