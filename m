Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DAFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68E218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfDYHnM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:43:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:44349 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfDYHnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:43:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="340645772"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 00:43:11 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:43:11 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:43:11 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.93]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:43:09 +0800
From:   "Du, Fan" <fan.du@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: RE: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Thread-Topic: [RFC PATCH 5/5] mm, page_alloc: Introduce
 ZONELIST_FALLBACK_SAME_TYPE fallback list
Thread-Index: AQHU+wg4wWYFBheblUa8IPBSvnCJwqZL5rWAgACUV7A=
Date:   Thu, 25 Apr 2019 07:43:09 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825785F04@SHSMSX104.ccr.corp.intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <1556155295-77723-6-git-send-email-fan.du@intel.com>
 <20190425063807.GK12751@dhcp22.suse.cz>
In-Reply-To: <20190425063807.GK12751@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjYxZGQ3ZDctMzlmZC00NGU1LTk5NWQtZDc4MTZiNDJhMzNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidkEyUDU5b1k3SDJFY2N0RkNxRWMrUFVTRkZQQWRLZ0cwa0d5eWl5VUZWdzF1WkRRXC9UT1hDQXVEdGdPd011RXUifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Michal Hocko [mailto:mhocko@kernel.org]
>Sent: Thursday, April 25, 2019 2:38 PM
>To: Du, Fan <fan.du@intel.com>
>Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
>Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 5/5] mm, page_alloc: Introduce
>ZONELIST_FALLBACK_SAME_TYPE fallback list
>
>On Thu 25-04-19 09:21:35, Fan Du wrote:
>> On system with heterogeneous memory, reasonable fall back lists woul be:
>> a. No fall back, stick to current running node.
>> b. Fall back to other nodes of the same type or different type
>>    e.g. DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3
>> c. Fall back to other nodes of the same type only.
>>    e.g. DRAM node 0 -> DRAM node 1
>>
>> a. is already in place, previous patch implement b. providing way to
>> satisfy memory request as best effort by default. And this patch of
>> writing build c. to fallback to the same node type when user specify
>> GFP_SAME_NODE_TYPE only.
>
>So an immediate question which should be answered by this changelog. Who
>is going to use the new gfp flag? Why cannot all allocations without an
>explicit numa policy fallback to all existing nodes?

PMEM is good for frequently read accessed page, e.g. page cache(implicit page
request), or user space data base (explicit page request)

For now this patch create GFP_SAME_NODE_TYPE for such cases, additional
Implementation will be followed up.

For example:
a. Open file
b. Populate pagecache with PMEM page if user set O_RDONLY
c. Migrate frequently read accessed page to PMEM from DRAM,
  for cases w/o O_RDONLY.


>> Signed-off-by: Fan Du <fan.du@intel.com>
>> ---
>>  include/linux/gfp.h    |  7 +++++++
>>  include/linux/mmzone.h |  1 +
>>  mm/page_alloc.c        | 15 +++++++++++++++
>>  3 files changed, 23 insertions(+)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index fdab7de..ca5fdfc 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -44,6 +44,8 @@
>>  #else
>>  #define ___GFP_NOLOCKDEP	0
>>  #endif
>> +#define ___GFP_SAME_NODE_TYPE	0x1000000u
>> +
>>  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>>
>>  /*
>> @@ -215,6 +217,7 @@
>>
>>  /* Disable lockdep for GFP context tracking */
>>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>> +#define __GFP_SAME_NODE_TYPE ((__force
>gfp_t)___GFP_SAME_NODE_TYPE)
>>
>>  /* Room for N __GFP_FOO bits */
>>  #define __GFP_BITS_SHIFT (23 + IS_ENABLED(CONFIG_LOCKDEP))
>> @@ -301,6 +304,8 @@
>>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT |
>__GFP_DIRECT_RECLAIM)
>>
>> +#define GFP_SAME_NODE_TYPE (__GFP_SAME_NODE_TYPE)
>> +
>>  /* Convert GFP flags to their corresponding migrate type */
>>  #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
>>  #define GFP_MOVABLE_SHIFT 3
>> @@ -438,6 +443,8 @@ static inline int gfp_zonelist(gfp_t flags)
>>  #ifdef CONFIG_NUMA
>>  	if (unlikely(flags & __GFP_THISNODE))
>>  		return ZONELIST_NOFALLBACK;
>> +	if (unlikely(flags & __GFP_SAME_NODE_TYPE))
>> +		return ZONELIST_FALLBACK_SAME_TYPE;
>>  #endif
>>  	return ZONELIST_FALLBACK;
>>  }
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 8c37e1c..2f8603e 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -583,6 +583,7 @@ static inline bool zone_intersects(struct zone *zone,
>>
>>  enum {
>>  	ZONELIST_FALLBACK,	/* zonelist with fallback */
>> +	ZONELIST_FALLBACK_SAME_TYPE,	/* zonelist with fallback to the
>same type node */
>>  #ifdef CONFIG_NUMA
>>  	/*
>>  	 * The NUMA zonelists are doubled because we need zonelists that
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a408a91..de797921 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5448,6 +5448,21 @@ static void
>build_zonelists_in_node_order(pg_data_t *pgdat, int *node_order,
>>  	}
>>  	zonerefs->zone = NULL;
>>  	zonerefs->zone_idx = 0;
>> +
>> +	zonerefs =
>pgdat->node_zonelists[ZONELIST_FALLBACK_SAME_TYPE]._zonerefs;
>> +
>> +	for (i = 0; i < nr_nodes; i++) {
>> +		int nr_zones;
>> +
>> +		pg_data_t *node = NODE_DATA(node_order[i]);
>> +
>> +		if (!is_node_same_type(node->node_id, pgdat->node_id))
>> +			continue;
>> +		nr_zones = build_zonerefs_node(node, zonerefs);
>> +		zonerefs += nr_zones;
>> +	}
>> +	zonerefs->zone = NULL;
>> +	zonerefs->zone_idx = 0;
>>  }
>>
>>  /*
>> --
>> 1.8.3.1
>>
>
>--
>Michal Hocko
>SUSE Labs
