Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C9C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B180420833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfFRDgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:36:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:34862 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFRDgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:36:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 20:36:10 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2019 20:36:09 -0700
Date:   Tue, 18 Jun 2019 11:35:46 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, osalvador@suse.de
Subject: Re: [PATCH v9 06/12] mm: Kill is_dev_zone() helper
Message-ID: <20190618033546.GE18161@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977191260.2443951.15908146523735681570.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155977191260.2443951.15908146523735681570.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 02:58:32PM -0700, Dan Williams wrote:
>Given there are no more usages of is_dev_zone() outside of 'ifdef
>CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.
>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> include/linux/mmzone.h |   12 ------------
> mm/page_alloc.c        |    2 +-
> 2 files changed, 1 insertion(+), 13 deletions(-)
>
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index 6dd52d544857..49e7fb452dfd 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -855,18 +855,6 @@ static inline int local_memory_node(int node_id) { return node_id; };
>  */
> #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
> 
>-#ifdef CONFIG_ZONE_DEVICE
>-static inline bool is_dev_zone(const struct zone *zone)
>-{
>-	return zone_idx(zone) == ZONE_DEVICE;
>-}
>-#else
>-static inline bool is_dev_zone(const struct zone *zone)
>-{
>-	return false;
>-}
>-#endif
>-
> /*
>  * Returns true if a zone has pages managed by the buddy allocator.
>  * All the reclaim decisions have to use this function rather than
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index bd773efe5b82..5dff3f49a372 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5865,7 +5865,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
> 	unsigned long start = jiffies;
> 	int nid = pgdat->node_id;
> 
>-	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
>+	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
> 		return;
> 
> 	/*
>
>_______________________________________________
>Linux-nvdimm mailing list
>Linux-nvdimm@lists.01.org
>https://lists.01.org/mailman/listinfo/linux-nvdimm

-- 
Wei Yang
Help you, Help me
