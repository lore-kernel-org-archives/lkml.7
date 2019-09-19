Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082C921927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfISJ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:28:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19928 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388208AbfISJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:28:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8J9RfLY055780
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:28:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3vdf0jd2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:28:51 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 19 Sep 2019 10:28:44 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 10:28:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8J9SdK039846074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 09:28:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6FE411C052;
        Thu, 19 Sep 2019 09:28:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F178F11C04C;
        Thu, 19 Sep 2019 09:28:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Sep 2019 09:28:38 +0000 (GMT)
Date:   Thu, 19 Sep 2019 12:28:37 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.co,
        dan.j.williams@intel.com, david@redhat.com,
        richardw.yang@linux.intel.com, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Support memblock alloc on the exact node for
 sparse_buffer_init()
References: <af88d8ab-4088-e857-575f-9be57542e130@huawei.com>
 <20190919044753.GA20548@linux.ibm.com>
 <6d23d00c-f400-f486-dc6d-31b6f141d913@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d23d00c-f400-f486-dc6d-31b6f141d913@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19091909-0012-0000-0000-0000034E00F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091909-0013-0000-0000-000021888238
Message-Id: <20190919092836.GA22691@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:14:22PM +0800, Yunfeng Ye wrote:
> 
> 
> On 2019/9/19 12:47, Mike Rapoport wrote:
> > Hi,
> > 
> > On Wed, Sep 18, 2019 at 12:22:29PM +0800, Yunfeng Ye wrote:
> >> Currently, when memblock_find_in_range_node() fail on the exact node, it
> >> will use %NUMA_NO_NODE to find memblock from other nodes. At present,
> >> the work is good, but when the large memory is insufficient and the
> >> small memory is enough, we want to allocate the small memory of this
> >> node first, and do not need to allocate large memory from other nodes.
> >>
> >> In sparse_buffer_init(), it will prepare large chunks of memory for page
> >> structure. The page management structure requires a lot of memory, but
> >> if the node does not have enough memory, it can be converted to a small
> >> memory allocation without having to allocate it from other nodes.
> >>
> >> Add %MEMBLOCK_ALLOC_EXACT_NODE flag for this situation. Normally, the
> >> behavior is the same with %MEMBLOCK_ALLOC_ACCESSIBLE, only that it will
> >> not allocate from other nodes when a single node fails to allocate.
> >>
> >> If large contiguous block memory allocated fail in sparse_buffer_init(),
> >> it will allocates small block memmory section by section later.
> > 
> > Did you see the sparse_buffer_init() actually falling back to allocate from a
> > different node? If a node does not have enough memory to hold it's own
> > memory map, filling only it with parts of the memory map will not make such
> > node usable.
> >  
> Normally, it won't happen that sparse_buffer_init() falling back from a different
> node, because page structure size is 64 bytes per 4KB of memory, no more than 2%
> of total available memory. But in the special cases, for eaxmple, memory address
> is isolated by BIOS when memory failure, split the total memory many pieces,
> although we have enough memory, but no large contiguous block memory in one node.
> sparse_buffer_init() needs large contiguous block memory to be alloc in one time,
> 
> Eg, the size of memory is 1TB, sparse_buffer_init() need 1TB * 64/4096 = 16GB, but
> we have 100 blocks memory which every block only have 10GB, although total memory
> have almost 100*10GB=1TB, but no contiguous 16GB block.
 
An explanation that a node memory may become highly fragmented should be a
part of the changelog.

> Before commit 2a3cb8baef71 ("mm/sparse: delete old sparse_init and enable new one"),
> we have %CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER config to meeting this situation,
> after that, it fall back to allocate memory from other nodes, so have the performance
> impact by remote numa access.
> 
> commit 85c77f791390 ("mm/sparse: add new sparse_init_nid() and sparse_init()") wrote
> that:
>     "
>     sparse_init_nid(), which only
>     operates within one memory node, and thus allocates memory either in large
>     contiguous block or allocates section by section
>     "
> it means that allocates section by section is a normal choice too, so I think add
> %MEMBLOCK_ALLOC_EXACT_NODE is also a choice for this situation. Most cases,
> sparse_buffer_init() works good and not allocated from other nodes at present.

I'd prefer to see memblock_alloc_exact_nid_raw() wrapper for
memblock_find_in_range_node() rather than using a flag.
 
> thanks.
> Yunfeng Ye
> 
> >> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >> ---
> >>  include/linux/memblock.h | 1 +
> >>  mm/memblock.c            | 3 ++-
> >>  mm/sparse.c              | 2 +-
> >>  3 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >> index f491690..9a81d9c 100644
> >> --- a/include/linux/memblock.h
> >> +++ b/include/linux/memblock.h
> >> @@ -339,6 +339,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
> >>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
> >>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
> >>  #define MEMBLOCK_ALLOC_KASAN		1
> >> +#define MEMBLOCK_ALLOC_EXACT_NODE	2
> >>
> >>  /* We are using top down, so it is safe to use 0 here */
> >>  #define MEMBLOCK_LOW_LIMIT 0
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 7d4f61a..dbd52c3c 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -277,6 +277,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
> >>
> >>  	/* pump up @end */
> >>  	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
> >> +	    end == MEMBLOCK_ALLOC_EXACT_NODE ||
> >>  	    end == MEMBLOCK_ALLOC_KASAN)
> >>  		end = memblock.current_limit;
> >>
> >> @@ -1365,7 +1366,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >>  	if (found && !memblock_reserve(found, size))
> >>  		goto done;
> >>
> >> -	if (nid != NUMA_NO_NODE) {
> >> +	if (end != MEMBLOCK_ALLOC_EXACT_NODE && nid != NUMA_NO_NODE) {
> >>  		found = memblock_find_in_range_node(size, align, start,
> >>  						    end, NUMA_NO_NODE,
> >>  						    flags);
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index 72f010d..828db46 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -477,7 +477,7 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> >>  	sparsemap_buf =
> >>  		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> >>  						addr,
> >> -						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> >> +						MEMBLOCK_ALLOC_EXACT_NODE, nid);
> >>  	sparsemap_buf_end = sparsemap_buf + size;
> >>  }
> >>
> >> -- 
> >> 2.7.4.huawei.3
> >>
> >>
> > 
> 

-- 
Sincerely yours,
Mike.

