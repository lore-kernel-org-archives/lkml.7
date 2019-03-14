Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE3A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hUUgsGJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCNCjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:39:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15175 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCNCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:39:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c89bede0001>; Wed, 13 Mar 2019 19:39:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 19:39:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 19:39:29 -0700
Received: from [10.2.161.236] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Mar
 2019 02:39:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange two
 lists of pages.
Date:   Wed, 13 Mar 2019 19:39:26 -0700
X-Mailer: MailMate (1.12.4r5614)
Message-ID: <AD3BCC61-6604-4599-8A72-381A06122D2D@nvidia.com>
In-Reply-To: <749d5674-9e85-1fe9-4a3b-1d6ad06948b4@arm.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
 <20190217112943.GP12668@bombadil.infradead.org>
 <65A1FFA0-531C-4078-9704-3F44819C3C07@nvidia.com>
 <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
 <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
 <20190218175224.GT12668@bombadil.infradead.org>
 <C84D2490-B6C6-4C7C-870F-945E31719728@nvidia.com>
 <1ce6ae99-4865-df62-5f20-cb07ebb95327@arm.com>
 <20190219125619.GA12668@bombadil.infradead.org>
 <749d5674-9e85-1fe9-4a3b-1d6ad06948b4@arm.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552531168; bh=xJIrQmX705R7AVGApWmVmyxBr0jN9GIkrzbcU+tKZgM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=hUUgsGJCil8zLlXUy6cwoucyBshNWgwttk8FhqYputqqcPvToKCECSbT8xnSkQRGv
         xsgP7hhdXjQ7Q1MwQoYeSeiHBLU5hRMot/9hhUb7X+l0fcKMi27CRlLVe9f4rJBAsE
         uWAwk5VLG/XBFAANtmDME7GTUHyFrAva2sXpj0O/m8IaJ/gOcbdxMBliEJMeKbv6f+
         dzXKOxS7KsdOvrWpr/4nMFgTK/0/q7SpyWgAsLtsHZsQ+JVEVFW3io7lHYYn2173En
         7DJ38bIIpUA/RCPe6IVODaR0QBcvqmCGUXKaTfNH35q7NoFNBYDgeGH1465+QHsdIp
         bWd2An0dQg9PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2019, at 20:38, Anshuman Khandual wrote:

> On 02/19/2019 06:26 PM, Matthew Wilcox wrote:
>> On Tue, Feb 19, 2019 at 01:12:07PM +0530, Anshuman Khandual wrote:
>>> But the location of this temp page matters as well because you would 
>>> like to
>>> saturate the inter node interface. It needs to be either of the 
>>> nodes where
>>> the source or destination page belongs. Any other node would 
>>> generate two
>>> internode copy process which is not what you intend here I guess.
>> That makes no sense.  It should be allocated on the local node of the 
>> CPU
>> performing the copy.  If the CPU is in node A, the destination is in 
>> node B
>> and the source is in node C, then you're doing 4k worth of reads from 
>> node C,
>> 4k worth of reads from node B, 4k worth of writes to node C followed 
>> by
>> 4k worth of writes to node B.  Eventually the 4k of dirty cachelines 
>> on
>> node A will be written back from cache to the local memory (... or 
>> not,
>> if that page gets reused for some other purpose first).
>>
>> If you allocate the page on node B or node C, that's an extra 4k of 
>> writes
>> to be sent across the inter-node link.
>
> Thats right there will be an extra remote write. My assumption was 
> that the CPU
> performing the copy belongs to either node B or node C.


I have some interesting throughput results for exchange per u64 and 
exchange per 4KB page.
What I discovered is that using a 4KB page as the temporary storage for 
exchanging
2MB THPs does not improve the throughput. On contrary, when we are 
exchanging more than 2^4=16 THPs,
exchanging per 4KB page has lower throughput than exchanging per u64. 
Please see results below.

The experiments are done on a two socket machine with two Intel Xeon 
E5-2640 v3 CPUs.
All exchanges are done via the QPI link across two sockets.


Results
===

Throughput (GB/s) of exchanging 2 order-N 2MB pages between two NUMA 
nodes

| 2mb_page_order | 0    | 1    | 2    | 3    | 4    | 5    | 6    | 7    
| 8    | 9
|     u64        | 5.31 | 5.58 | 5.89 | 5.69 | 8.97 | 9.51 | 9.21 | 9.50 
| 9.57 | 9.62
|     per_page   | 5.85 | 6.48 | 6.20 | 5.26 | 7.22 | 7.25 | 7.28 | 7.30 
| 7.32 | 7.31

Normalized throughput (to per_page)

  2mb_page_order | 0    | 1    | 2    | 3    | 4    | 5    | 6    | 7    
| 8    | 9
      u64        | 0.90 | 0.86 | 0.94 | 1.08 | 1.24 | 1.31 |1.26  | 1.30 
| 1.30 | 1.31



Exchange page code
===

For exchanging per u64, I use the following function:

static void exchange_page(char *to, char *from)
{
	u64 tmp;
	int i;

	for (i = 0; i < PAGE_SIZE; i += sizeof(tmp)) {
		tmp = *((u64 *)(from + i));
		*((u64 *)(from + i)) = *((u64 *)(to + i));
		*((u64 *)(to + i)) = tmp;
	}
}


For exchange per 4KB, I use the following function:

static void exchange_page2(char *to, char *from)
{
	int cpu = smp_processor_id();

	VM_BUG_ON(!in_atomic());

	if (!page_tmp[cpu]) {
		int nid = cpu_to_node(cpu);
		struct page *page_tmp_page = alloc_pages_node(nid, GFP_KERNEL, 0);
		if (!page_tmp_page) {
			exchange_page(to, from);
			return;
		}
		page_tmp[cpu] = kmap(page_tmp_page);
	}

	copy_page(page_tmp[cpu], to);
	copy_page(to, from);
	copy_page(from, page_tmp[cpu]);
}

where page_tmp is pre-allocated local to each CPU and alloc_pages_node() 
above
is for hot-added CPUs, which is not used in the tests.


The kernel is available at: https://gitlab.com/ziy/linux-contig-mem-rfc
To do a comparison, you can clone this repo: 
https://gitlab.com/ziy/thp-migration-bench,
then make, ./run_test.sh, and ./get_results.sh using the kernel from 
above.

Let me know if I missed anything or did something wrong. Thanks.


--
Best Regards,
Yan Zi
