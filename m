Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C7C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15D221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411898AbfIYGg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:36:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411872AbfIYGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:36:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8P6WBIt134301
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:36:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v81bput27-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 02:36:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 25 Sep 2019 07:36:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Sep 2019 07:36:19 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8P6aI5515007882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 06:36:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7002AAE061;
        Wed, 25 Sep 2019 06:36:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97836AE04D;
        Wed, 25 Sep 2019 06:36:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.153])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Sep 2019 06:36:17 +0000 (GMT)
Date:   Wed, 25 Sep 2019 09:36:15 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     richardw.yang@linux.intel.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.co, dan.j.williams@intel.com,
        david@redhat.com, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
References: <883454ec-3a96-c93d-81a4-ed4db844b72f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883454ec-3a96-c93d-81a4-ed4db844b72f@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19092506-0012-0000-0000-000003504BD5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092506-0013-0000-0000-0000218ADE52
Message-Id: <20190925063615.GA1857@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:09:32PM +0800, Yunfeng Ye wrote:
> sparse_buffer_init() use memblock_alloc_try_nid_raw() to allocate memory
> for page management structure, if memory allocation fails from specified
> node, it will fall back to allocate from other nodes.
> 
> Normally, the page management structure will not exceed 2% of the total
> memory, but a large continuous block of allocation is needed. In most
> cases, memory allocation from the specified node will success always,
> but a node memory become highly fragmented will fail. we expect to
> allocate memory base section rather than by allocating a large block of
> memory from other NUMA nodes
> 
> Add memblock_alloc_exact_nid_raw() for this situation, which allocate
> boot memory block on the exact node. If a large contiguous block memory
> allocate fail in sparse_buffer_init(), it will fall back to allocate
> small block memory base section.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2:
>  - use memblock_alloc_exact_nid_raw() rather than using a flag
> 
>  include/linux/memblock.h |  3 +++
>  mm/memblock.c            | 66 ++++++++++++++++++++++++++++++++++++++++--------
>  mm/sparse.c              |  2 +-
>  3 files changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f491690..b38bbef 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -358,6 +358,9 @@ static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
>  					 MEMBLOCK_ALLOC_ACCESSIBLE);
>  }
> 
> +void *memblock_alloc_exact_nid_raw(phys_addr_t size, phys_addr_t align,
> +				 phys_addr_t min_addr, phys_addr_t max_addr,
> +				 int nid);
>  void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
>  				 phys_addr_t min_addr, phys_addr_t max_addr,
>  				 int nid);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7d4f61a..a71869e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1323,12 +1323,13 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>   * @start: the lower bound of the memory region to allocate (phys address)
>   * @end: the upper bound of the memory region to allocate (phys address)
>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> + * @need_exact_nid: control the allocation fall back to other nodes
>   *
>   * The allocation is performed from memory region limited by
>   * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
>   *
> - * If the specified node can not hold the requested memory the
> - * allocation falls back to any node in the system
> + * If the specified node can not hold the requested memory and @need_exact_nid
> + * is zero, the allocation falls back to any node in the system
>   *
>   * For systems with memory mirroring, the allocation is attempted first
>   * from the regions with mirroring enabled and then retried from any
> @@ -1342,7 +1343,8 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>   */
>  static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  					phys_addr_t align, phys_addr_t start,
> -					phys_addr_t end, int nid)
> +					phys_addr_t end, int nid,
> +					int need_exact_nid)

Please make it 'bool exact_nid'

>  {
>  	enum memblock_flags flags = choose_memblock_flags();
>  	phys_addr_t found;
> @@ -1365,7 +1367,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  	if (found && !memblock_reserve(found, size))
>  		goto done;
> 
> -	if (nid != NUMA_NO_NODE) {
> +	if (nid != NUMA_NO_NODE && !need_exact_nid) {
>  		found = memblock_find_in_range_node(size, align, start,
>  						    end, NUMA_NO_NODE,
>  						    flags);
> @@ -1413,7 +1415,8 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  					     phys_addr_t start,
>  					     phys_addr_t end)
>  {
> -	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
> +	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
> +					0);
>  }
> 
>  /**
> @@ -1432,7 +1435,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
>  phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
>  {
>  	return memblock_alloc_range_nid(size, align, 0,
> -					MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +					MEMBLOCK_ALLOC_ACCESSIBLE, nid, 0);
>  }
> 
>  /**
> @@ -1442,6 +1445,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>   * @min_addr: the lower bound of the memory region to allocate (phys address)
>   * @max_addr: the upper bound of the memory region to allocate (phys address)
>   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> + * @need_exact_nid: control the allocation fall back to other nodes
>   *
>   * Allocates memory block using memblock_alloc_range_nid() and
>   * converts the returned physical address to virtual.
> @@ -1457,7 +1461,7 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>  static void * __init memblock_alloc_internal(
>  				phys_addr_t size, phys_addr_t align,
>  				phys_addr_t min_addr, phys_addr_t max_addr,
> -				int nid)
> +				int nid, int need_exact_nid)

Ditto.

>  {
>  	phys_addr_t alloc;
> 
> @@ -1469,11 +1473,13 @@ static void * __init memblock_alloc_internal(
>  	if (WARN_ON_ONCE(slab_is_available()))
>  		return kzalloc_node(size, GFP_NOWAIT, nid);
> 
> -	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid);
> +	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid,
> +					need_exact_nid);
> 
>  	/* retry allocation without lower limit */
>  	if (!alloc && min_addr)
> -		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid);
> +		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
> +						need_exact_nid);
> 
>  	if (!alloc)
>  		return NULL;
> @@ -1482,6 +1488,44 @@ static void * __init memblock_alloc_internal(
>  }
> 
>  /**
> + * memblock_alloc_exact_nid_raw - allocate boot memory block on the exact node,
> + * without zeroing memory and without panicking

No need to mention "without panicking" as none of the memblock APIs panic
any more.

> + * @size: size of memory block to be allocated in bytes
> + * @align: alignment of the region and block's size
> + * @min_addr: the lower bound of the memory region from where the allocation
> + *	  is preferred (phys address)
> + * @max_addr: the upper bound of the memory region from where the allocation
> + *	      is preferred (phys address), or %MEMBLOCK_ALLOC_ACCESSIBLE to
> + *	      allocate only from memory limited by memblock.current_limit value
> + * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> + *
> + * Public function, provides additional debug information (including caller
> + * info), if enabled. Does not zero allocated memory, does not panic if request
> + * cannot be satisfied.
> + *
> + * Return:
> + * Virtual address of allocated memory block on success, NULL on failure.
> + */
> +void * __init memblock_alloc_exact_nid_raw(
> +			phys_addr_t size, phys_addr_t align,
> +			phys_addr_t min_addr, phys_addr_t max_addr,
> +			int nid)
> +{
> +	void *ptr;
> +
> +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> +		     &max_addr, (void *)_RET_IP_);
> +
> +	ptr = memblock_alloc_internal(size, align,
> +					   min_addr, max_addr, nid, 1);
> +	if (ptr && size > 0)
> +		page_init_poison(ptr, size);
> +
> +	return ptr;
> +}
> +
> +/**
>   * memblock_alloc_try_nid_raw - allocate boot memory block without zeroing
>   * memory and without panicking
>   * @size: size of memory block to be allocated in bytes
> @@ -1512,7 +1556,7 @@ void * __init memblock_alloc_try_nid_raw(
>  		     &max_addr, (void *)_RET_IP_);
> 
>  	ptr = memblock_alloc_internal(size, align,
> -					   min_addr, max_addr, nid);
> +					   min_addr, max_addr, nid, 0);
>  	if (ptr && size > 0)
>  		page_init_poison(ptr, size);
> 
> @@ -1547,7 +1591,7 @@ void * __init memblock_alloc_try_nid(
>  		     __func__, (u64)size, (u64)align, nid, &min_addr,
>  		     &max_addr, (void *)_RET_IP_);
>  	ptr = memblock_alloc_internal(size, align,
> -					   min_addr, max_addr, nid);
> +					   min_addr, max_addr, nid, 0);
>  	if (ptr)
>  		memset(ptr, 0, size);
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d..1a06471 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -475,7 +475,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>  	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
>  	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
>  	sparsemap_buf =
> -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> +		memblock_alloc_exact_nid_raw(size, PAGE_SIZE,
>  						addr,
>  						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  	sparsemap_buf_end = sparsemap_buf + size;
> -- 
> 2.7.4.huawei.3
> 

-- 
Sincerely yours,
Mike.

