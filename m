Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B12207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8eh4ERe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFDWHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:07:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39341 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFDWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:07:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so2661699edv.6;
        Tue, 04 Jun 2019 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PpKRuZzE7T8mOmzox/3fZWCQGJE/CKE/yKMFRhJ3Gf8=;
        b=r8eh4EReBOdbIPu4A1NNDGdXjFzs0/kcbitZHKKZAYaKNhXocwZblb/UDa/qHzpM4n
         H2elaGGk/e0gnNHPNwXKeHcAQnQ8whjG7luxPB1MehVQyRYd3L+0WhuLTmYgNONF0vQW
         /gT+d74vRjcqjUKUEja8QETsFhVds03K5SF2Vi+Gp28hsN/co8yAmDLlQo3XBDCsBx2t
         f10hoB3oefeCwKc/mwr3FNtMVXdQwW6jVfZhmt0IMWacdGBiHQOhNJfFHpgBzQfAMbQK
         Rzmp33l1qbOkzsE3obd4pS9v0hxJDLo8arS3ayyMB+ypJKFinJf8JyWlCou/md606BC2
         cf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PpKRuZzE7T8mOmzox/3fZWCQGJE/CKE/yKMFRhJ3Gf8=;
        b=VVMn/M3UcxAeVwwvprb9DeDiiwL5J6gpdhUqqppY08Q/uqGMGj00bkWfL6+9K2OWtD
         BQdkStQguQ15mSQMGoV1OOWUXlUj7ylH7Ii48Xy9jTCLTk9baJB8WUl9ViIGmdlhqqQi
         /KTkD6uvxXJBcM+yn0+BLyTPZC9dxoPryqCWaPRnxAGw8m3f9Ww017vbWMQppByKlIiS
         bXnGog0NuAnfRHaGvxCGHFOkPCKl/DdhylZqR+b50h3Cim3buckkLFMAN8oJ4uF8T9sN
         gAsW7Av7R9VgpRTFksYCayhyiufW18kgRNE0ZsWW/JK7i7EkspMNaiS+8fhv39f3qTfw
         VEcQ==
X-Gm-Message-State: APjAAAUYAUHT/6RRT5msgFlZh/T1sK+ER6tj4X+ppYuTw1cOL1WZ/taF
        hen9duoHKLNcVo5a44HCPv8=
X-Google-Smtp-Source: APXvYqylJIv8N/2T6SjJp9NjY4VYtrcjtyg9w7oKoH7rUr1NCX7/8z5VGMCfO72kUy5fqWBqTC3/4A==
X-Received: by 2002:aa7:c3c9:: with SMTP id l9mr30726945edr.23.1559686037033;
        Tue, 04 Jun 2019 15:07:17 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g18sm5036344edh.13.2019.06.04.15.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 15:07:16 -0700 (PDT)
Date:   Tue, 4 Jun 2019 22:07:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v3 09/11] mm/memory_hotplug: Remove memory block devices
 before arch_remove_memory()
Message-ID: <20190604220715.d4d2ctwjk25vd5sq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-10-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:11:50PM +0200, David Hildenbrand wrote:
>Let's factor out removing of memory block devices, which is only
>necessary for memory added via add_memory() and friends that created
>memory block devices. Remove the devices before calling
>arch_remove_memory().
>
>This finishes factoring out memory block device handling from
>arch_add_memory() and arch_remove_memory().
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Andrew Banman <andrew.banman@hpe.com>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Alex Deucher <alexander.deucher@amd.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Mark Brown <broonie@kernel.org>
>Cc: Chris Wilson <chris@chris-wilson.co.uk>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>Cc: Arun KS <arunks@codeaurora.org>
>Cc: Mathieu Malaterre <malat@debian.org>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/base/memory.c  | 37 ++++++++++++++++++-------------------
> drivers/base/node.c    | 11 ++++++-----
> include/linux/memory.h |  2 +-
> include/linux/node.h   |  6 ++----
> mm/memory_hotplug.c    |  5 +++--
> 5 files changed, 30 insertions(+), 31 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 5a0370f0c506..f28efb0bf5c7 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -763,32 +763,31 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
> 	return ret;
> }
> 
>-void unregister_memory_section(struct mem_section *section)
>+/*
>+ * Remove memory block devices for the given memory area. Start and size
>+ * have to be aligned to memory block granularity. Memory block devices
>+ * have to be offline.
>+ */
>+void remove_memory_block_devices(unsigned long start, unsigned long size)
> {
>+	const int start_block_id = pfn_to_block_id(PFN_DOWN(start));
>+	const int end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
> 	struct memory_block *mem;
>+	int block_id;
> 
>-	if (WARN_ON_ONCE(!present_section(section)))
>+	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
>+			 !IS_ALIGNED(size, memory_block_size_bytes())))
> 		return;
> 
> 	mutex_lock(&mem_sysfs_mutex);
>-
>-	/*
>-	 * Some users of the memory hotplug do not want/need memblock to
>-	 * track all sections. Skip over those.
>-	 */
>-	mem = find_memory_block(section);
>-	if (!mem)
>-		goto out_unlock;
>-
>-	unregister_mem_sect_under_nodes(mem, __section_nr(section));
>-
>-	mem->section_count--;
>-	if (mem->section_count == 0)
>+	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
>+		mem = find_memory_block_by_id(block_id, NULL);
>+		if (WARN_ON_ONCE(!mem))
>+			continue;
>+		mem->section_count = 0;

Is this step necessary?

>+		unregister_memory_block_under_nodes(mem);
> 		unregister_memory(mem);
>-	else
>-		put_device(&mem->dev);
>-
>-out_unlock:
>+	}
> 	mutex_unlock(&mem_sysfs_mutex);
> }
> 
>diff --git a/drivers/base/node.c b/drivers/base/node.c
>index 8598fcbd2a17..04fdfa99b8bc 100644
>--- a/drivers/base/node.c
>+++ b/drivers/base/node.c
>@@ -801,9 +801,10 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
> 	return 0;
> }
> 
>-/* unregister memory section under all nodes that it spans */
>-int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>-				    unsigned long phys_index)
>+/*
>+ * Unregister memory block device under all nodes that it spans.
>+ */
>+int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
> {
> 	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
> 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
>@@ -816,8 +817,8 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> 		return -ENOMEM;
> 	nodes_clear(*unlinked_nodes);
> 
>-	sect_start_pfn = section_nr_to_pfn(phys_index);
>-	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
>+	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
>+	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
> 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> 		int nid;
> 
>diff --git a/include/linux/memory.h b/include/linux/memory.h
>index db3e8567f900..f26a5417ec5d 100644
>--- a/include/linux/memory.h
>+++ b/include/linux/memory.h
>@@ -112,7 +112,7 @@ extern void unregister_memory_notifier(struct notifier_block *nb);
> extern int register_memory_isolate_notifier(struct notifier_block *nb);
> extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
> int create_memory_block_devices(unsigned long start, unsigned long size);
>-extern void unregister_memory_section(struct mem_section *);
>+void remove_memory_block_devices(unsigned long start, unsigned long size);
> extern int memory_dev_init(void);
> extern int memory_notify(unsigned long val, void *v);
> extern int memory_isolate_notify(unsigned long val, void *v);
>diff --git a/include/linux/node.h b/include/linux/node.h
>index 1a557c589ecb..02a29e71b175 100644
>--- a/include/linux/node.h
>+++ b/include/linux/node.h
>@@ -139,8 +139,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
> extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
> extern int register_mem_sect_under_node(struct memory_block *mem_blk,
> 						void *arg);
>-extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>-					   unsigned long phys_index);
>+extern int unregister_memory_block_under_nodes(struct memory_block *mem_blk);
> 
> extern int register_memory_node_under_compute_node(unsigned int mem_nid,
> 						   unsigned int cpu_nid,
>@@ -176,8 +175,7 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
> {
> 	return 0;
> }
>-static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>-						  unsigned long phys_index)
>+static inline int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
> {
> 	return 0;
> }
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 9a92549ef23b..82136c5b4c5f 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -520,8 +520,6 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> 	if (WARN_ON_ONCE(!valid_section(ms)))
> 		return;
> 
>-	unregister_memory_section(ms);
>-
> 	scn_nr = __section_nr(ms);
> 	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
> 	__remove_zone(zone, start_pfn);
>@@ -1845,6 +1843,9 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
> 	memblock_free(start, size);
> 	memblock_remove(start, size);
> 
>+	/* remove memory block devices before removing memory */
>+	remove_memory_block_devices(start, size);
>+
> 	arch_remove_memory(nid, start, size, NULL);
> 	__release_memory_resource(start, size);
> 
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
