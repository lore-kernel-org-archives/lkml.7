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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BAC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4104B2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtLdXNwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFEVV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:21:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41133 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:21:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so4447665eds.8;
        Wed, 05 Jun 2019 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmqIL302FliKztrku23iEbel/vN8Om9KZr4KoJVUQBs=;
        b=HtLdXNwlPpU1RFxmpHZq/rH78NiFyUbMRNR4XLHGl5DFaciTYXzczF+YOEaOthAltb
         LzfrkniAfXeG9XfS8k8l9WWdWJTCb5t0Qydwrx9HDSWfQxVverG9o6eBxNShll611+Xk
         D8MDiZNeQ9S8YaEkKYI92ohNxvxiKGjBgdANYmGfcUxcUcAmDq0kOuCUWCUGDd+d7T8p
         u6tdGt0M3uFblUt67ApuYvpm2psLcK1H66EYwESimtXZEx5o8tKBJ+DBxrVlRNPstQNp
         2xk+bEsv5+yigah3/6Lj+npsGt7LKO/9d2Bkh2IRQhSgPxae7KCEIl0WkMOEkno6k2FP
         1Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmqIL302FliKztrku23iEbel/vN8Om9KZr4KoJVUQBs=;
        b=koJKcjNK3t9Pa3UyL1yc0Wrz5vhAFSHaE2QlOK4opiGgGhjcnL6Lc+6PBpJVdryrwH
         +IBMTu312jUeJpVWBTSyo0KYN3vSPvI028EB95Lm6roN6m6jpJjPGIC1K9K7eW9V2+OI
         SejDtgM8BE5ICPclug6oiStUEeupApBuCgl9lpnLzdESyS/aoYvjbZSfsDFMzRThy4Z9
         adwVoilq6arO+Zagnqm8RnoZN5iLVuL1TiGbZCyCq0NDuB4erTWZj8opj9UOweZwf9dG
         AeUlaw5UwSknO6r2biKUAoy8RGJBSoSXJbCPVcJ/HCKK0SnF17rGdMyAXCSvzNwv8Cpj
         0pjQ==
X-Gm-Message-State: APjAAAXB03nuvAtfwLjENKn2jBpL3NBZrEQCtSuZeshnnyclVUDfplyT
        obCfsomMjTsziW9UvVsGH+8=
X-Google-Smtp-Source: APXvYqxldygk3PkHMpihOlAqhwTjzhXRQF4Z9tCxVu286QjlehnozfaHCkEEtI5NYMQPFpu5SuYeWg==
X-Received: by 2002:a50:ca48:: with SMTP id e8mr45737760edi.101.1559769687081;
        Wed, 05 Jun 2019 14:21:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e19sm3550413edy.36.2019.06.05.14.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 14:21:26 -0700 (PDT)
Date:   Wed, 5 Jun 2019 21:21:25 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 11/11] mm/memory_hotplug: Remove "zone" parameter from
 sparse_remove_one_section
Message-ID: <20190605212125.gwmvjjicylhp3wcz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-12-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:11:52PM +0200, David Hildenbrand wrote:
>The parameter is unused, so let's drop it. Memory removal paths should
>never care about zones. This is the job of memory offlining and will
>require more refactorings.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> include/linux/memory_hotplug.h | 2 +-
> mm/memory_hotplug.c            | 2 +-
> mm/sparse.c                    | 4 ++--
> 3 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index 2f1f87e13baa..1a4257c5f74c 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -346,7 +346,7 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> extern bool is_memblock_offlined(struct memory_block *mem);
> extern int sparse_add_one_section(int nid, unsigned long start_pfn,
> 				  struct vmem_altmap *altmap);
>-extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
>+extern void sparse_remove_one_section(struct mem_section *ms,
> 		unsigned long map_offset, struct vmem_altmap *altmap);
> extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
> 					  unsigned long pnum);
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 82136c5b4c5f..e48ec7b9dee2 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -524,7 +524,7 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
> 	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
> 	__remove_zone(zone, start_pfn);
> 
>-	sparse_remove_one_section(zone, ms, map_offset, altmap);
>+	sparse_remove_one_section(ms, map_offset, altmap);
> }
> 
> /**
>diff --git a/mm/sparse.c b/mm/sparse.c
>index d1d5e05f5b8d..1552c855d62a 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -800,8 +800,8 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
> 		free_map_bootmem(memmap);
> }
> 
>-void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
>-		unsigned long map_offset, struct vmem_altmap *altmap)
>+void sparse_remove_one_section(struct mem_section *ms, unsigned long map_offset,
>+			       struct vmem_altmap *altmap)
> {
> 	struct page *memmap = NULL;
> 	unsigned long *usemap = NULL;
>-- 
>2.20.1

-- 
Wei Yang
Help you, Help me
