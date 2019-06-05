Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC5C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF89D20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI2GOFin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFEVVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:21:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46150 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:21:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id h10so7709623edi.13;
        Wed, 05 Jun 2019 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbESKGjaSdEzS+8K4ZZpYJHwCVMJbIIgpVyCBcGmoDA=;
        b=uI2GOFinAV8sZvL+69rPUYkiOvfq/P6RaIvMP/TCLE7Eigu+OsAMxrlQ7M56dpfeaB
         KXnPuGlaLKfjVW4OK022oY9x2O84uuKCnTuTJ2Hy/rU4g60rDzrdLH9+Tx5dD+CSiY7P
         MZd6Gt4WuEMmALvkc+6OxkvqFlyqE8pj0B+RKWqsERmaO6rCiyUFNdAQJaK+bn+j6ZDo
         3+Ozb7/fHxX66bj8rSxIxrArPzuRzb+SpAu32sfxsWnMui2GD+nbp3sZ5ByAMfIb0inB
         TyCDQNWvPlw0yG17KhNWZpYS35pRM3rqQaLlQ7Rzw4ggssD4+ZfqKxNNHceKsI3nMqCT
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbESKGjaSdEzS+8K4ZZpYJHwCVMJbIIgpVyCBcGmoDA=;
        b=FzvGTNKn5LE6VkjWKZLPUGq6II1chgo7rlCQah2lnt6j1Sef/fD06PtaEBLUEg/68u
         Llm1DAlbL0agPfzbYF8KjuDkY8DKBpz95zF2qjvMz3cErDte1pdCy2hhjnWTb6V4v0P3
         QIcDoLkUsYnuBjPaly6Cv1bO40rKmyp7gzSa7paJJmVBYFHIqblVxGRYa/7/qdq7pPn3
         GZm3JPtP+A0fLUzVzNiutRuN+tMgWPN1azZUBmRym7dAvFmUln1jF9WHQTsszPP+4vkT
         FWGji+6Og8Mvsu2x6/6c83zwLxV9mJJH4X8hFLdl9Q/5kLWjNXOlnrhKFjZdWRc4yfdD
         pinA==
X-Gm-Message-State: APjAAAWK0VvuMcnhFcPA+h2BBY4it2UHg1hrmGYQf4RFb0yfwZghgXhL
        QVIH4VIKcsOFy1Cwm/GdyOQ8LK3vK04=
X-Google-Smtp-Source: APXvYqyuNRjvHNzTb2gEE1mIj1supSxm4qc3GPA7ju0Tg73FF069vkjl4Ke6VX7sPJnRrK6BAE1EDw==
X-Received: by 2002:a50:b523:: with SMTP id y32mr38680719edd.209.1559769668613;
        Wed, 05 Jun 2019 14:21:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x19sm3180078edq.9.2019.06.05.14.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 14:21:07 -0700 (PDT)
Date:   Wed, 5 Jun 2019 21:21:06 +0000
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
        Alex Deucher <alexander.deucher@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 10/11] mm/memory_hotplug: Make
 unregister_memory_block_under_nodes() never fail
Message-ID: <20190605212106.6folqx2zawbvzzmm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-11-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:11:51PM +0200, David Hildenbrand wrote:
>We really don't want anything during memory hotunplug to fail.
>We always pass a valid memory block device, that check can go. Avoid
>allocating memory and eventually failing. As we are always called under
>lock, we can use a static piece of memory. This avoids having to put
>the structure onto the stack, having to guess about the stack size
>of callers.
>
>Patch inspired by a patch from Oscar Salvador.
>
>In the future, there might be no need to iterate over nodes at all.
>mem->nid should tell us exactly what to remove. Memory block devices
>with mixed nodes (added during boot) should properly fenced off and never
>removed.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Alex Deucher <alexander.deucher@amd.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Mark Brown <broonie@kernel.org>
>Cc: Chris Wilson <chris@chris-wilson.co.uk>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> drivers/base/node.c  | 18 +++++-------------
> include/linux/node.h |  5 ++---
> 2 files changed, 7 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/base/node.c b/drivers/base/node.c
>index 04fdfa99b8bc..9be88fd05147 100644
>--- a/drivers/base/node.c
>+++ b/drivers/base/node.c
>@@ -803,20 +803,14 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
> 
> /*
>  * Unregister memory block device under all nodes that it spans.
>+ * Has to be called with mem_sysfs_mutex held (due to unlinked_nodes).
>  */
>-int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>+void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
> {
>-	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
> 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
>+	static nodemask_t unlinked_nodes;
> 
>-	if (!mem_blk) {
>-		NODEMASK_FREE(unlinked_nodes);
>-		return -EFAULT;
>-	}
>-	if (!unlinked_nodes)
>-		return -ENOMEM;
>-	nodes_clear(*unlinked_nodes);
>-
>+	nodes_clear(unlinked_nodes);
> 	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
> 	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
> 	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>@@ -827,15 +821,13 @@ int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
> 			continue;
> 		if (!node_online(nid))
> 			continue;
>-		if (node_test_and_set(nid, *unlinked_nodes))
>+		if (node_test_and_set(nid, unlinked_nodes))
> 			continue;
> 		sysfs_remove_link(&node_devices[nid]->dev.kobj,
> 			 kobject_name(&mem_blk->dev.kobj));
> 		sysfs_remove_link(&mem_blk->dev.kobj,
> 			 kobject_name(&node_devices[nid]->dev.kobj));
> 	}
>-	NODEMASK_FREE(unlinked_nodes);
>-	return 0;
> }
> 
> int link_mem_sections(int nid, unsigned long start_pfn, unsigned long end_pfn)
>diff --git a/include/linux/node.h b/include/linux/node.h
>index 02a29e71b175..548c226966a2 100644
>--- a/include/linux/node.h
>+++ b/include/linux/node.h
>@@ -139,7 +139,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
> extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
> extern int register_mem_sect_under_node(struct memory_block *mem_blk,
> 						void *arg);
>-extern int unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>+extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
> 
> extern int register_memory_node_under_compute_node(unsigned int mem_nid,
> 						   unsigned int cpu_nid,
>@@ -175,9 +175,8 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
> {
> 	return 0;
> }
>-static inline int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>+static inline void unregister_memory_block_under_nodes(struct memory_block *mem_blk)
> {
>-	return 0;
> }
> 
> static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
