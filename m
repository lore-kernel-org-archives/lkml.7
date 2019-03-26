Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B950EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E7F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfCZN5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:57:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731739AbfCZN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:57:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QDsAbl039997
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:57:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfmymhfbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:57:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 26 Mar 2019 13:57:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 13:57:11 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QDvAUu53018786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 13:57:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22B614204F;
        Tue, 26 Mar 2019 13:57:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B08142042;
        Tue, 26 Mar 2019 13:57:09 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.52])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Mar 2019 13:57:09 +0000 (GMT)
Date:   Tue, 26 Mar 2019 15:57:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
 <20190326092936.GK28406@dhcp22.suse.cz>
 <20190326100817.GV3659@MiWiFi-R3L-srv>
 <20190326101710.GN28406@dhcp22.suse.cz>
 <20190326134522.GB21943@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326134522.GB21943@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032613-0028-0000-0000-000003587834
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032613-0029-0000-0000-00002417302C
Message-Id: <20190326135706.GB23024@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:45:22PM +0800, Baoquan He wrote:
> On 03/26/19 at 11:17am, Michal Hocko wrote:
> > On Tue 26-03-19 18:08:17, Baoquan He wrote:
> > > On 03/26/19 at 10:29am, Michal Hocko wrote:
> > > > On Tue 26-03-19 17:02:25, Baoquan He wrote:
> > > > > Reorder the allocation of usemap and memmap since usemap allocation
> > > > > is much simpler and easier. Otherwise hard work is done to make
> > > > > memmap ready, then have to rollback just because of usemap allocation
> > > > > failure.
> > > > 
> > > > Is this really worth it? I can see that !VMEMMAP is doing memmap size
> > > > allocation which would be 2MB aka costly allocation but we do not do
> > > > __GFP_RETRY_MAYFAIL so the allocator backs off early.
> > > 
> > > In !VMEMMAP case, it truly does simple allocation directly. surely
> > > usemap which size is 32 is smaller. So it doesn't matter that much who's
> > > ahead or who's behind. However, this benefit a little in VMEMMAP case.
> > 
> > How does it help there? The failure should be even much less probable
> > there because we simply fall back to a small 4kB pages and those
> > essentially never fail.
> 
> OK, I am fine to drop it. Or only put the section existence checking
> earlier to avoid unnecessary usemap/memmap allocation?
> 
> 
> From 7594b86ebf5d6fcc8146eca8fc5625f1961a15b1 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 26 Mar 2019 18:48:39 +0800
> Subject: [PATCH] mm/sparse: Check section's existence earlier in
>  sparse_add_one_section()
> 
> No need to allocate usemap and memmap if section has been present.
> And can clean up the handling on failure.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 363f9d31b511..f564b531e0f7 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -714,7 +714,13 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
> -	ret = 0;
> +
> +	ms = __pfn_to_section(start_pfn);
> +	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> +		ret = -EEXIST;
> +		goto out;

		return -EEXIST; ?

> +	}
> +
>  	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
>  	if (!memmap)
>  		return -ENOMEM;
> @@ -724,12 +730,6 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  		return -ENOMEM;
>  	}
>  
> -	ms = __pfn_to_section(start_pfn);
> -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> -		ret = -EEXIST;
> -		goto out;
> -	}
> -
>  	/*
>  	 * Poison uninitialized struct pages in order to catch invalid flags
>  	 * combinations.
> @@ -739,12 +739,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
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

