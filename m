Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D5C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E922084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfDYD0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:26:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49503 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388900AbfDYD0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:26:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=qiuxishi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TQAj6H9_1556162771;
Received: from 10.211.55.3(mailfrom:qiuxishi@linux.alibaba.com fp:SMTPD_---0TQAj6H9_1556162771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Apr 2019 11:26:12 +0800
Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <a0728518-a067-4f89-a8ae-3fa279f768f2.xishi.qiuxishi@alibaba-inc.com>
From:   Xishi Qiu <qiuxishi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Fengguang Wu <fengguang.wu@intel.com>, fan.du@intel.com
Message-ID: <2158298b-d4db-671e-6cff-395e9184ecf3@linux.alibaba.com>
Date:   Thu, 25 Apr 2019 11:26:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a0728518-a067-4f89-a8ae-3fa279f768f2.xishi.qiuxishi@alibaba-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fan Du,

I think we should change the print in mminit_verify_zonelist too.

This patch changes the order of ZONELIST_FALLBACK, so the default numa policy can
alloc DRAM first, then PMEM, right?

Thanks,
Xishi Qiu
>     On system with heterogeneous memory, reasonable fall back lists woul be:
>     a. No fall back, stick to current running node.
>     b. Fall back to other nodes of the same type or different type
>        e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3
>     c. Fall back to other nodes of the same type only.
>        e.g. DRAM node 0 -> DRAM node 1
> 
>     a. is already in place, previous patch implement b. providing way to
>     satisfy memory request as best effort by default. And this patch of
>     writing build c. to fallback to the same node type when user specify
>     GFP_SAME_NODE_TYPE only.
> 
>     Signed-off-by: Fan Du <fan.du@intel.com>
>     ---
>      include/linux/gfp.h    |  7 +++++++
>      include/linux/mmzone.h |  1 +
>      mm/page_alloc.c        | 15 +++++++++++++++
>      3 files changed, 23 insertions(+)
> 
>     diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>     index fdab7de..ca5fdfc 100644
>     --- a/include/linux/gfp.h
>     +++ b/include/linux/gfp.h
>     @@ -44,6 +44,8 @@
>      #else
>      #define ___GFP_NOLOCKDEP 0
>      #endif
>     +#define ___GFP_SAME_NODE_TYPE 0x1000000u
>     +
>      /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>      
>      /*
>     @@ -215,6 +217,7 @@
>      
>      /* Disable lockdep for GFP context tracking */
>      #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>     +#define __GFP_SAME_NODE_TYPE ((__force gfp_t)___GFP_SAME_NODE_TYPE)
>      
>      /* Room for N __GFP_FOO bits */
>      #define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
>     @@ -301,6 +304,8 @@
>          __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>      #define GFP_TRANSHUGE (GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
>      
>     +#define GFP_SAME_NODE_TYPE (__GFP_SAME_NODE_TYPE)
>     +
>      /* Convert GFP flags to their corresponding migrate type */
>      #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
>      #define GFP_MOVABLE_SHIFT 3
>     @@ -438,6 +443,8 @@ static inline int gfp_zonelist(gfp_t flags)
>      #ifdef CONFIG_NUMA
>       if (unlikely(flags & __GFP_THISNODE))
>        return ZONELIST_NOFALLBACK;
>     + if (unlikely(flags & __GFP_SAME_NODE_TYPE))
>     +  return ZONELIST_FALLBACK_SAME_TYPE;
>      #endif
>       return ZONELIST_FALLBACK;
>      }
>     diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>     index 8c37e1c..2f8603e 100644
>     --- a/include/linux/mmzone.h
>     +++ b/include/linux/mmzone.h
>     @@ -583,6 +583,7 @@ static inline bool zone_intersects(struct zone *zone,
>      
>      enum {
>       ZONELIST_FALLBACK, /* zonelist with fallback */
>     + ZONELIST_FALLBACK_SAME_TYPE, /* zonelist with fallback to the same type node */
>      #ifdef CONFIG_NUMA
>       /*
>        * The NUMA zonelists are doubled because we need zonelists that
>     diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>     index a408a91..de797921 100644
>     --- a/mm/page_alloc.c
>     +++ b/mm/page_alloc.c
>     @@ -5448,6 +5448,21 @@ static void build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
>       }
>       zonerefs->zone = NULL;
>       zonerefs->zone_idx = 0;
>     +
>     + zonerefs = pgdat->node_zonelists[ZONELIST_FALLBACK_SAME_TYPE]._zonerefs;
>     +
>     + for (i = 0; i < nr_nodes; i++) {
>     +  int nr_zones;
>     +
>     +  pg_data_t *node = NODE_DATA(node_order[i]);
>     +
>     +  if (!is_node_same_type(node->node_id, pgdat->node_id))
>     +   continue;
>     +  nr_zones = build_zonerefs_node(node, zonerefs);
>     +  zonerefs += nr_zones;
>     + }
>     + zonerefs->zone = NULL;
>     + zonerefs->zone_idx = 0;
>      }
>      
>      /*
>     -- 
>     1.8.3.1
> 
> 
