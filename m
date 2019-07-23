Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035BC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76F223D1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfGWIeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:34:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfGWIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:34:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6N8X7nE034131
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:34:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2twuteers9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 04:34:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 23 Jul 2019 09:34:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 09:33:58 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6N8XveP43909290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 08:33:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01C1352051;
        Tue, 23 Jul 2019 08:33:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 47CAC5205F;
        Tue, 23 Jul 2019 08:33:56 +0000 (GMT)
Date:   Tue, 23 Jul 2019 11:33:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jia He <hejianet@gmail.com>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/2] mm: page_alloc: reduce unnecessary binary search
 in memblock_next_valid_pfn
References: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
 <1563861073-47071-3-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563861073-47071-3-git-send-email-guohanjun@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19072308-0012-0000-0000-000003356235
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072308-0013-0000-0000-0000216EF17F
Message-Id: <20190723083353.GC4896@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:51:13PM +0800, Hanjun Guo wrote:
> From: Jia He <hejianet@gmail.com>
> 
> After skipping some invalid pfns in memmap_init_zone(), there is still
> some room for improvement.
> 
> E.g. if pfn and pfn+1 are in the same memblock region, we can simply pfn++
> instead of doing the binary search in memblock_next_valid_pfn.
> 
> Furthermore, if the pfn is in a gap of two memory region, skip to next
> region directly to speedup the binary search.

How much speed up do you see with this improvements relatively to simple
binary search in memblock_next_valid_pfn()?
  
> Signed-off-by: Jia He <hejianet@gmail.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  mm/memblock.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index d57ba51bb9cd..95d5916716a0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1256,28 +1256,53 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>  unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>  {
>  	struct memblock_type *type = &memblock.memory;
> +	struct memblock_region *regions = type->regions;
>  	unsigned int right = type->cnt;
>  	unsigned int mid, left = 0;
> +	unsigned long start_pfn, end_pfn, next_start_pfn;
>  	phys_addr_t addr = PFN_PHYS(++pfn);
> +	static int early_region_idx __initdata_memblock = -1;
>  
> +	/* fast path, return pfn+1 if next pfn is in the same region */
> +	if (early_region_idx != -1) {
> +		start_pfn = PFN_DOWN(regions[early_region_idx].base);
> +		end_pfn = PFN_DOWN(regions[early_region_idx].base +
> +				regions[early_region_idx].size);
> +
> +		if (pfn >= start_pfn && pfn < end_pfn)
> +			return pfn;
> +
> +		/* try slow path */
> +		if (++early_region_idx == type->cnt)
> +			goto slow_path;
> +
> +		next_start_pfn = PFN_DOWN(regions[early_region_idx].base);
> +
> +		if (pfn >= end_pfn && pfn <= next_start_pfn)
> +			return next_start_pfn;
> +	}
> +
> +slow_path:
> +	/* slow path, do the binary searching */
>  	do {
>  		mid = (right + left) / 2;
>  
> -		if (addr < type->regions[mid].base)
> +		if (addr < regions[mid].base)
>  			right = mid;
> -		else if (addr >= (type->regions[mid].base +
> -				  type->regions[mid].size))
> +		else if (addr >= (regions[mid].base + regions[mid].size))
>  			left = mid + 1;
>  		else {
> -			/* addr is within the region, so pfn is valid */
> +			early_region_idx = mid;
>  			return pfn;
>  		}
>  	} while (left < right);
>  
>  	if (right == type->cnt)
>  		return -1UL;
> -	else
> -		return PHYS_PFN(type->regions[right].base);
> +
> +	early_region_idx = right;
> +
> +	return PHYS_PFN(regions[early_region_idx].base);
>  }
>  EXPORT_SYMBOL(memblock_next_valid_pfn);
>  #endif /* CONFIG_HAVE_MEMBLOCK_PFN_VALID */
> -- 
> 2.19.1
> 

-- 
Sincerely yours,
Mike.

