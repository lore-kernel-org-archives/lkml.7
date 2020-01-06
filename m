Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB3FC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDBC21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAFGbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:31:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbgAFGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:31:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0066RdNO115859
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jan 2020 01:31:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb97b7kdc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:31:35 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 6 Jan 2020 06:31:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 06:31:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0066VTP650790644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 06:31:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F33E011C2FC;
        Mon,  6 Jan 2020 06:05:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174F611C2F8;
        Mon,  6 Jan 2020 06:05:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Jan 2020 06:04:59 +0000 (GMT)
Date:   Mon, 6 Jan 2020 08:04:58 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memblock: Define memblock_physmem_add()
References: <1578283835-21969-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578283835-21969-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 20010606-0012-0000-0000-0000037ACAA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010606-0013-0000-0000-000021B6E2A9
Message-Id: <20200106060458.GB5413@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_01:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001060059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 09:40:35AM +0530, Anshuman Khandual wrote:
> On s390 platform memblock.physmem array is being built by directly calling
> into memblock_add_range() which is a low level function not intended to be
> used outside of memblock. Hence lets conditionally add helper functions for
> physmem array when HAVE_MEMBLOCK_PHYS_MAP is enabled. Also use MAX_NUMNODES
> instead of 0 as node ID similar to memblock_add() and memblock_reserve().
> Make memblock_add_range() a static function as it is no longer getting used
> outside of memblock.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> Only build tested for s390, will appreciate if some one can give it a try
> on a real system.
> 
> Changes from RFC:
> 
> - Dropped all memblock_dbg() changes per Mike
> - Renamed memblock_physmem() as memblock_physmem_add() per Mike
> - Made memblock_add_range() a static function per Mike
> - Updated the commit message
> 
> RFC: (https://patchwork.kernel.org/patch/11316627/)
> 
>  arch/s390/kernel/setup.c | 12 +++---------
>  include/linux/memblock.h |  7 +++----
>  mm/memblock.c            | 14 +++++++++++++-
>  3 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b9104ae162f4..424cb8fd2c35 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -762,14 +762,6 @@ static void __init free_mem_detect_info(void)
>  		memblock_free(start, size);
>  }
>  
> -static void __init memblock_physmem_add(phys_addr_t start, phys_addr_t size)
> -{
> -	memblock_dbg("memblock_physmem_add: [%#016llx-%#016llx]\n",
> -		     start, start + size - 1);
> -	memblock_add_range(&memblock.memory, start, size, 0, 0);
> -	memblock_add_range(&memblock.physmem, start, size, 0, 0);
> -}
> -
>  static const char * __init get_mem_info_source(void)
>  {
>  	switch (mem_detect.info_source) {
> @@ -794,8 +786,10 @@ static void __init memblock_add_mem_detect_info(void)
>  		     get_mem_info_source(), mem_detect.info_source);
>  	/* keep memblock lists close to the kernel */
>  	memblock_set_bottom_up(true);
> -	for_each_mem_detect_block(i, &start, &end)
> +	for_each_mem_detect_block(i, &start, &end) {
> +		memblock_add(start, end - start);
>  		memblock_physmem_add(start, end - start);
> +	}
>  	memblock_set_bottom_up(false);
>  	memblock_dump_all();
>  }
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b38bbefabfab..079d17d96410 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -113,6 +113,9 @@ int memblock_add(phys_addr_t base, phys_addr_t size);
>  int memblock_remove(phys_addr_t base, phys_addr_t size);
>  int memblock_free(phys_addr_t base, phys_addr_t size);
>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
> +#endif
>  void memblock_trim_memory(phys_addr_t align);
>  bool memblock_overlaps_region(struct memblock_type *type,
>  			      phys_addr_t base, phys_addr_t size);
> @@ -127,10 +130,6 @@ void reset_node_managed_pages(pg_data_t *pgdat);
>  void reset_all_zones_managed_pages(void);
>  
>  /* Low level functions */
> -int memblock_add_range(struct memblock_type *type,
> -		       phys_addr_t base, phys_addr_t size,
> -		       int nid, enum memblock_flags flags);
> -
>  void __next_mem_range(u64 *idx, int nid, enum memblock_flags flags,
>  		      struct memblock_type *type_a,
>  		      struct memblock_type *type_b, phys_addr_t *out_start,
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4bc2c7d8bf42..fc0d4db1d646 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -575,7 +575,7 @@ static void __init_memblock memblock_insert_region(struct memblock_type *type,
>   * Return:
>   * 0 on success, -errno on failure.
>   */
> -int __init_memblock memblock_add_range(struct memblock_type *type,
> +static int __init_memblock memblock_add_range(struct memblock_type *type,
>  				phys_addr_t base, phys_addr_t size,
>  				int nid, enum memblock_flags flags)
>  {
> @@ -830,6 +830,18 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>  	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
>  }
>  
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
> +{
> +	phys_addr_t end = base + size - 1;
> +
> +	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
> +		     &base, &end, (void *)_RET_IP_);
> +
> +	return memblock_add_range(&memblock.physmem, base, size, MAX_NUMNODES, 0);
> +}
> +#endif
> +
>  /**
>   * memblock_setclr_flag - set or clear flag for a memory region
>   * @base: base address of the region
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

