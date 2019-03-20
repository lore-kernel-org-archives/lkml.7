Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F538C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548802146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCTIAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:00:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbfCTIAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:00:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2K80QAu116565
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:00:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rbg4pmcch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:00:45 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 20 Mar 2019 07:59:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 07:59:07 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K7xBqe37683208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:59:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA091A4054;
        Wed, 20 Mar 2019 07:59:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 253ABA4060;
        Wed, 20 Mar 2019 07:59:11 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Mar 2019 07:59:11 +0000 (GMT)
Date:   Wed, 20 Mar 2019 09:59:09 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, rppt@linux.vnet.ibm.com,
        richard.weiyang@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm/sparse: Rename function related to section memmap
 allocation/free
References: <20190320075301.13994-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320075301.13994-1-bhe@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032007-4275-0000-0000-0000031D2374
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032007-4276-0000-0000-0000382BA65E
Message-Id: <20190320075908.GD13626@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:53:01PM +0800, Baoquan He wrote:
> These functions are used allocate/free section memmap, have nothing
> to do with kmalloc/free during the handling. Rename them to remove
> the confusion.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/sparse.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 054b99f74181..374206212d01 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -579,13 +579,13 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  #endif
> 
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
> +static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap)
>  {
>  	/* This will make the necessary allocations eventually. */
>  	return sparse_mem_map_populate(pnum, nid, altmap);
>  }
> -static void __kfree_section_memmap(struct page *memmap,
> +static void __free_section_memmap(struct page *memmap,
>  		struct vmem_altmap *altmap)
>  {
>  	unsigned long start = (unsigned long)memmap;
> @@ -603,7 +603,7 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  #else
> -static struct page *__kmalloc_section_memmap(void)
> +static struct page *__alloc_section_memmap(void)
>  {
>  	struct page *page, *ret;
>  	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> @@ -624,13 +624,13 @@ static struct page *__kmalloc_section_memmap(void)
>  	return ret;
>  }
> 
> -static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
> +static inline struct page *alloc_section_memmap(unsigned long pnum, int nid,
>  		struct vmem_altmap *altmap)
>  {
> -	return __kmalloc_section_memmap();
> +	return __alloc_section_memmap();
>  }
> 
> -static void __kfree_section_memmap(struct page *memmap,
> +static void __free_section_memmap(struct page *memmap,
>  		struct vmem_altmap *altmap)
>  {
>  	if (is_vmalloc_addr(memmap))
> @@ -701,7 +701,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	usemap = __kmalloc_section_usemap();
>  	if (!usemap)
>  		return -ENOMEM;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	memmap = alloc_section_memmap(section_nr, nid, altmap);
>  	if (!memmap) {
>  		kfree(usemap);
>  		return -ENOMEM;
> @@ -726,7 +726,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  out:
>  	if (ret < 0) {
>  		kfree(usemap);
> -		__kfree_section_memmap(memmap, altmap);
> +		__free_section_memmap(memmap, altmap);
>  	}
>  	return ret;
>  }
> @@ -777,7 +777,7 @@ static void free_section_usemap(struct page *memmap, unsigned long *usemap,
>  	if (PageSlab(usemap_page) || PageCompound(usemap_page)) {
>  		kfree(usemap);
>  		if (memmap)
> -			__kfree_section_memmap(memmap, altmap);
> +			__free_section_memmap(memmap, altmap);
>  		return;
>  	}
> 
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.

