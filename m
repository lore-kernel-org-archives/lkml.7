Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15BE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfCZJXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:23:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbfCZJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:23:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q99CoM003970
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:23:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfftw457p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:23:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Mar 2019 09:23:44 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 09:23:41 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2Q9NerH58196084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 09:23:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A9BA405B;
        Tue, 26 Mar 2019 09:23:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA7CA405C;
        Tue, 26 Mar 2019 09:23:40 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Mar 2019 09:23:39 +0000 (GMT)
Date:   Tue, 26 Mar 2019 11:23:38 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326090227.3059-3-bhe@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032609-0028-0000-0000-000003585CF7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032609-0029-0000-0000-000024171387
Message-Id: <20190326092337.GC6297@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:02:25PM +0800, Baoquan He wrote:
> Reorder the allocation of usemap and memmap since usemap allocation
> is much simpler and easier. Otherwise hard work is done to make
> memmap ready, then have to rollback just because of usemap allocation
> failure.
> 
> And also check if section is present earlier. Then don't bother to
> allocate usemap and memmap if yes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v1->v2:
>   Do section existence checking earlier to further optimize code.
> 
>  mm/sparse.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b2111f996aa6..f4f34d69131e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -714,20 +714,18 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
> -	ret = 0;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> -	usemap = __kmalloc_section_usemap();
> -	if (!usemap) {
> -		__kfree_section_memmap(memmap, altmap);
> -		return -ENOMEM;
> -	}
>  
>  	ms = __pfn_to_section(start_pfn);
> -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> -		ret = -EEXIST;
> -		goto out;
> +	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
> +		return -EEXIST;
> +
> +	usemap = __kmalloc_section_usemap();
> +	if (!usemap)
> +		return -ENOMEM;
> +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	if (!memmap) {
> +		kfree(usemap);
> +		return  -ENOMEM;
>  	}
>  
>  	/*
> @@ -739,12 +737,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	section_mark_present(ms);
>  	sparse_init_one_section(ms, section_nr, memmap, usemap);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usemap);
> -		__kfree_section_memmap(memmap, altmap);
> -	}
> -	return ret;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.

