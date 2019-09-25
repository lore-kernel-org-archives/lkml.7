Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AABC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498902054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393610AbfIYHj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:39:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390395AbfIYHj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:39:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E828121AB5A8C424FF1;
        Wed, 25 Sep 2019 15:39:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 15:39:21 +0800
Subject: Re: [PATCH V3] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Wei Yang <richardw.yang@linux.intel.com>,
        <akpm@linux-foundation.org>, <osalvador@suse.de>, <mhocko@suse.co>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <cai@lca.pw>,
        <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e836da55-19f7-e505-7f2a-5f790d61b912@huawei.com>
 <20190925073239.GD1857@linux.ibm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <2899afd4-1501-d3e7-72fd-de94fa84cd80@huawei.com>
Date:   Wed, 25 Sep 2019 15:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190925073239.GD1857@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/25 15:32, Mike Rapoport wrote:
> On Wed, Sep 25, 2019 at 03:18:43PM +0800, Yunfeng Ye wrote:
>> sparse_buffer_init() use memblock_alloc_try_nid_raw() to allocate memory
>> for page management structure, if memory allocation fails from specified
>> node, it will fall back to allocate from other nodes.
>>
>> Normally, the page management structure will not exceed 2% of the total
>> memory, but a large continuous block of allocation is needed. In most
>> cases, memory allocation from the specified node will success always,
>> but a node memory become highly fragmented will fail. we expect to
>> allocate memory base section rather than by allocating a large block of
>> memory from other NUMA nodes
>>
>> Add memblock_alloc_exact_nid_raw() for this situation, which allocate
>> boot memory block on the exact node. If a large contiguous block memory
>> allocate fail in sparse_buffer_init(), it will fall back to allocate
>> small block memory base section.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> One nit below, otherwise
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
ok.

>> ---
>> v2 -> v3:
>>  - use "bool exact_nid" instead of "int need_exact_nid"
>>  - remove the comment "without panicking"
>>
>> v1 -> v2:
>>  - use memblock_alloc_exact_nid_raw() rather than using a flag
>>
>>  include/linux/memblock.h |  3 +++
>>  mm/memblock.c            | 65 ++++++++++++++++++++++++++++++++++++++++--------
>>  mm/sparse.c              |  2 +-
>>  3 files changed, 58 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f491690..b38bbef 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -358,6 +358,9 @@ static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
>>  					 MEMBLOCK_ALLOC_ACCESSIBLE);
>>  }
>>
>> +void *memblock_alloc_exact_nid_raw(phys_addr_t size, phys_addr_t align,
>> +				 phys_addr_t min_addr, phys_addr_t max_addr,
>> +				 int nid);
>>  void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
>>  				 phys_addr_t min_addr, phys_addr_t max_addr,
>>  				 int nid);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 7d4f61a..0de9d83 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1323,12 +1323,13 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>>   * @start: the lower bound of the memory region to allocate (phys address)
>>   * @end: the upper bound of the memory region to allocate (phys address)
>>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
>> + * @exact_nid: control the allocation fall back to other nodes
>>   *
>>   * The allocation is performed from memory region limited by
>>   * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
>>   *
>> - * If the specified node can not hold the requested memory the
>> - * allocation falls back to any node in the system
>> + * If the specified node can not hold the requested memory and @exact_nid
>> + * is zero, the allocation falls back to any node in the system
> 
>      ^ is false  ;-)
> 
sorry my negligence, thanks.

>>   *
>>   * For systems with memory mirroring, the allocation is attempted first
>>   * from the regions with mirroring enabled and then retried from any
>> @@ -1342,7 +1343,8 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>>   */
>>  static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>  					phys_addr_t align, phys_addr_t start,
>> -					phys_addr_t end, int nid)
>> +					phys_addr_t end, int nid,
>> +					bool exact_nid)
>>  {
>>  	enum memblock_flags flags = choose_memblock_flags();
>>  	phys_addr_t found;
>> @@ -1365,7 +1367,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>  	if (found && !memblock_reserve(found, size))
>>  		goto done;
>>
>> -	if (nid != NUMA_NO_NODE) {
>> +	if (nid != NUMA_NO_NODE && !exact_nid) {
>>  		found = memblock_find_in_range_node(size, align, start,
>>  						    end, NUMA_NO_NODE,
>>  						    flags);
>> @@ -1413,7 +1415,8 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>>  					     phys_addr_t start,
>>  					     phys_addr_t end)
>>  {
>> -	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
>> +	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
>> +					false);
>>  }
>>
>>  /**
>> @@ -1432,7 +1435,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>>  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
>>  {
>>  	return memblock_alloc_range_nid(size, align, 0,
>> -					MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>> +					MEMBLOCK_ALLOC_ACCESSIBLE, nid, false);
>>  }
>>
>>  /**
>> @@ -1442,6 +1445,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>>   * @min_addr: the lower bound of the memory region to allocate (phys address)
>>   * @max_addr: the upper bound of the memory region to allocate (phys address)
>>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
>> + * @exact_nid: control the allocation fall back to other nodes
>>   *
>>   * Allocates memory block using memblock_alloc_range_nid() and
>>   * converts the returned physical address to virtual.
>> @@ -1457,7 +1461,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>>  static void * __init memblock_alloc_internal(
>>  				phys_addr_t size, phys_addr_t align,
>>  				phys_addr_t min_addr, phys_addr_t max_addr,
>> -				int nid)
>> +				int nid, bool exact_nid)
>>  {
>>  	phys_addr_t alloc;
>>
>> @@ -1469,11 +1473,13 @@ static void * __init memblock_alloc_internal(
>>  	if (WARN_ON_ONCE(slab_is_available()))
>>  		return kzalloc_node(size, GFP_NOWAIT, nid);
>>
>> -	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid);
>> +	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid,
>> +					exact_nid);
>>
>>  	/* retry allocation without lower limit */
>>  	if (!alloc && min_addr)
>> -		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid);
>> +		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
>> +						exact_nid);
>>
>>  	if (!alloc)
>>  		return NULL;
>> @@ -1482,6 +1488,43 @@ static void * __init memblock_alloc_internal(
>>  }
>>
>>  /**
>> + * memblock_alloc_exact_nid_raw - allocate boot memory block on the exact node
>> + * without zeroing memory
>> + * @size: size of memory block to be allocated in bytes
>> + * @align: alignment of the region and block's size
>> + * @min_addr: the lower bound of the memory region from where the allocation
>> + *	  is preferred (phys address)
>> + * @max_addr: the upper bound of the memory region from where the allocation
>> + *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
>> + *	      allocate only from memory limited by memblock.current_limit value
>> + * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
>> + *
>> + * Public function, provides additional debug information (including caller
>> + * info), if enabled. Does not zero allocated memory.
>> + *
>> + * Return:
>> + * Virtual address of allocated memory block on success, NULL on failure.
>> + */
>> +void * __init memblock_alloc_exact_nid_raw(
>> +			phys_addr_t size, phys_addr_t align,
>> +			phys_addr_t min_addr, phys_addr_t max_addr,
>> +			int nid)
>> +{
>> +	void *ptr;
>> +
>> +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
>> +		     __func__, (u64)size, (u64)align, nid, &min_addr,
>> +		     &max_addr, (void *)_RET_IP_);
>> +
>> +	ptr = memblock_alloc_internal(size, align,
>> +					   min_addr, max_addr, nid, true);
>> +	if (ptr && size > 0)
>> +		page_init_poison(ptr, size);
>> +
>> +	return ptr;
>> +}
>> +
>> +/**
>>   * memblock_alloc_try_nid_raw - allocate boot memory block without zeroing
>>   * memory and without panicking
>>   * @size: size of memory block to be allocated in bytes
>> @@ -1512,7 +1555,7 @@ void * __init memblock_alloc_try_nid_raw(
>>  		     &max_addr, (void *)_RET_IP_);
>>
>>  	ptr = memblock_alloc_internal(size, align,
>> -					   min_addr, max_addr, nid);
>> +					   min_addr, max_addr, nid, false);
>>  	if (ptr && size > 0)
>>  		page_init_poison(ptr, size);
>>
>> @@ -1547,7 +1590,7 @@ void * __init memblock_alloc_try_nid(
>>  		     __func__, (u64)size, (u64)align, nid, &min_addr,
>>  		     &max_addr, (void *)_RET_IP_);
>>  	ptr = memblock_alloc_internal(size, align,
>> -					   min_addr, max_addr, nid);
>> +					   min_addr, max_addr, nid, false);
>>  	if (ptr)
>>  		memset(ptr, 0, size);
>>
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 72f010d..1a06471 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -475,7 +475,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>>  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
>>  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
>>  	sparsemap_buf =
>> -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>> +		memblock_alloc_exact_nid_raw(size, PAGE_SIZE,
>>  						addr,
>>  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>  	sparsemap_buf_end = sparsemap_buf + size;
>> -- 
>> 2.7.4
>>
> 

