Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE40AC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD9E217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfDQMqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:46:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731454AbfDQMqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:46:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF28AAE43;
        Wed, 17 Apr 2019 12:46:02 +0000 (UTC)
Message-ID: <1555505146.3139.26.camel@suse.de>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Make
 unregister_memory_section() never fail
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Apr 2019 14:45:46 +0200
In-Reply-To: <20190409100148.24703-3-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
         <20190409100148.24703-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 12:01 +0200, David Hildenbrand wrote:
> Failing while removing memory is mostly ignored and cannot really be
> handled. Let's treat errors in unregister_memory_section() in a nice
> way, warning, but continuing.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Banman <andrew.banman@hpe.com>
> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c  | 16 +++++-----------
>  include/linux/memory.h |  2 +-
>  mm/memory_hotplug.c    |  4 +---
>  3 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 0c9e22ffa47a..f180427e48f4 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -734,15 +734,18 @@ unregister_memory(struct memory_block *memory)
>  {
>  	BUG_ON(memory->dev.bus != &memory_subsys);
>  
> -	/* drop the ref. we got in remove_memory_section() */
> +	/* drop the ref. we got via find_memory_block() */
>  	put_device(&memory->dev);
>  	device_unregister(&memory->dev);
>  }
>  
> -static int remove_memory_section(struct mem_section *section)
> +void unregister_memory_section(struct mem_section *section)
>  {
>  	struct memory_block *mem;
>  
> +	if (WARN_ON_ONCE(!present_section(section)))
> +		return;
> +
>  	mutex_lock(&mem_sysfs_mutex);
>  
>  	/*
> @@ -763,15 +766,6 @@ static int remove_memory_section(struct
> mem_section *section)
>  
>  out_unlock:
>  	mutex_unlock(&mem_sysfs_mutex);
> -	return 0;
> -}
> -
> -int unregister_memory_section(struct mem_section *section)
> -{
> -	if (!present_section(section))
> -		return -EINVAL;
> -
> -	return remove_memory_section(section);
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index a6ddefc60517..e1dc1bb2b787 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -113,7 +113,7 @@ extern int
> register_memory_isolate_notifier(struct notifier_block *nb);
>  extern void unregister_memory_isolate_notifier(struct notifier_block
> *nb);
>  int hotplug_memory_register(int nid, struct mem_section *section);
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -extern int unregister_memory_section(struct mem_section *);
> +extern void unregister_memory_section(struct mem_section *);
>  #endif
>  extern int memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 696ed7ee5e28..b0cb05748f99 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -527,9 +527,7 @@ static int __remove_section(struct zone *zone,
> struct mem_section *ms,
>  	if (!valid_section(ms))
>  		return ret;
>  
> -	ret = unregister_memory_section(ms);
> -	if (ret)
> -		return ret;
> +	unregister_memory_section(ms);

So, technically unregister_memory_section() can __only__ fail in case
the section is not present, returning -EINVAL.

Now, I was checking how the pair valid/present sections work.
Unless I am mistaken, we only mark sections as memmap those sections
that are present.

This can come from two paths:

- Early boot:
  * memblocks_present
     memory_present           - mark sections as present
    sparse_init               - iterates only over present sections
     sparse_init_nid
      sparse_init_one_section - mark section as valid

- Hotplug path:
  * sparse_add_one_section
     section_mark_present     - mark section as present
     sparse_init_one_section  - mark section as valid
   

During early boot, sparse_init iterates __only__ over present sections,
so only those are marked valid as well, and during hotplug, the section
is both marked present and valid.

All in all, I think that we are safe if we remove the present_section
check in your new unregister_memory_section(), as a valid_section
cannot be non-present, and we do already catch those early in
__remove_section().

Then, the only thing missing to be completely error-less in that
codepath is to make unregister_mem_sect_under_nodes() void return-type.
Not that it matters a lot as we are already ignoring its return code,
but I find that quite disturbing and wrong.

So, would you like to take this patch in your patchset in case you re-
submit?

From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 17 Apr 2019 14:41:32 +0200
Subject: [PATCH] mm,memory_hotplug: Refactor
unregister_mem_sect_under_nodes

Currently, the return code of unregister_mem_sect_under_nodes gets
ignored.
It can only fail in case we are not able to allocate a nodemask_t,
but such allocation is too small, so it is not really clear
we can actually fail.

The maximum a nodemask_t can be is 128 bytes, so we can make the whole
thing more simple if we simply allocate a nodemask_t within the stack.

With this change, we can convert unregister_mem_sect_under_nodes to
be void-return type.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/node.c  | 16 ++++------------
 include/linux/node.h |  5 ++---
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 8598fcbd2a17..fcd0f442e73d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -802,19 +802,13 @@ int register_mem_sect_under_node(struct
memory_block *mem_blk, void *arg)
 }
 
 /* unregister memory section under all nodes that it spans */
-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
+void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 				    unsigned long phys_index)
 {
-	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
+	nodemask_t unlinked_nodes;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!mem_blk) {
-		NODEMASK_FREE(unlinked_nodes);
-		return -EFAULT;
-	}
-	if (!unlinked_nodes)
-		return -ENOMEM;
-	nodes_clear(*unlinked_nodes);
+	nodes_clear(unlinked_nodes);
 
 	sect_start_pfn = section_nr_to_pfn(phys_index);
 	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
@@ -826,15 +820,13 @@ int unregister_mem_sect_under_nodes(struct
memory_block *mem_blk,
 			continue;
 		if (!node_online(nid))
 			continue;
-		if (node_test_and_set(nid, *unlinked_nodes))
+		if (node_test_and_set(nid, unlinked_nodes))
 			continue;
 		sysfs_remove_link(&node_devices[nid]->dev.kobj,
 			 kobject_name(&mem_blk->dev.kobj));
 		sysfs_remove_link(&mem_blk->dev.kobj,
 			 kobject_name(&node_devices[nid]->dev.kobj));
 	}
-	NODEMASK_FREE(unlinked_nodes);
-	return 0;
 }
 
 int link_mem_sections(int nid, unsigned long start_pfn, unsigned long
end_pfn)
diff --git a/include/linux/node.h b/include/linux/node.h
index 1a557c589ecb..094ec9922bf5 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -139,7 +139,7 @@ extern int register_cpu_under_node(unsigned int
cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int
nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 						void *arg);
-extern int unregister_mem_sect_under_nodes(struct memory_block
*mem_blk,
+extern void unregister_mem_sect_under_nodes(struct memory_block
*mem_blk,
 					   unsigned long phys_index);
 
 extern int register_memory_node_under_compute_node(unsigned int
mem_nid,
@@ -176,10 +176,9 @@ static inline int
register_mem_sect_under_node(struct memory_block *mem_blk,
 {
 	return 0;
 }
-static inline int unregister_mem_sect_under_nodes(struct memory_block
*mem_blk,
+static inline void unregister_mem_sect_under_nodes(struct memory_block
*mem_blk,
 						  unsigned long
phys_index)
 {
-	return 0;
 }
 
 static inline void
register_hugetlbfs_with_node(node_registration_func_t reg,
-- 
2.12.3


-- 
Oscar Salvador
SUSE L3
