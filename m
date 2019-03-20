Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7089CC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE372175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfCTL1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:27:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbfCTL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:27:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KBJW3A136000
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:27:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbkbemtar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:27:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 20 Mar 2019 11:27:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 11:27:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KBRXLT42729566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 11:27:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40EB84C05A;
        Wed, 20 Mar 2019 11:27:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F7704C062;
        Wed, 20 Mar 2019 11:27:32 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Mar 2019 11:27:32 +0000 (GMT)
Date:   Wed, 20 Mar 2019 13:27:30 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/sparse: Optimize sparse_add_one_section()
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320073540.12866-2-bhe@redhat.com>
 <20190320075649.GC13626@rapoport-lnx>
 <20190320101318.GP18740@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320101318.GP18740@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032011-0016-0000-0000-000002651946
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032011-0017-0000-0000-000032C0329E
Message-Id: <20190320112730.GE13626@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:13:18PM +0800, Baoquan He wrote:
> Hi Mike,
> 
> On 03/20/19 at 09:56am, Mike Rapoport wrote:
>  > @@ -697,16 +697,17 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> > >  	ret = sparse_index_init(section_nr, nid);
> > >  	if (ret < 0 && ret != -EEXIST)
> > >  		return ret;
> > > -	ret = 0;
> > > -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > > -	if (!memmap)
> > > -		return -ENOMEM;
> > > +
> > >  	usemap = __kmalloc_section_usemap();
> > > -	if (!usemap) {
> > > -		__kfree_section_memmap(memmap, altmap);
> > > +	if (!usemap)
> > > +		return -ENOMEM;
> > > +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> > > +	if (!memmap) {
> > > +		kfree(usemap);
> > 
> > If you are anyway changing this why not to switch to goto's for error
> > handling?
> 
> I update code change as below, could you check if it's OK to you?
> 
> Thanks
> Baoquan
> 
> From 39b679b6f34f6acbc05351be8569d23bae3c0458 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Fri, 15 Mar 2019 16:03:52 +0800
> Subject: [PATCH] mm/sparse: Optimize sparse_add_one_section()
> 
> Reorder the allocation of usemap and memmap since usemap allocation
> is much smaller and simpler. Otherwise hard work is done to make
> memmap ready, then have to rollback just because of usemap allocation
> failure.
> 
> Meanwhile update the error handler to cover usemap allocation failure
> too.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index a99e0b253927..0e842b924be6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -699,20 +699,21 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
> -	ret = 0;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> +
>  	usemap = __kmalloc_section_usemap();
> -	if (!usemap) {
> -		__kfree_section_memmap(memmap, altmap);
> +	if (!usemap)
>  		return -ENOMEM;
> +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	if (!memmap) {
> +		ret = -ENOMEM;
> +		goto out2;

I'd name the label out_free_usemap.

>  	}
>  
> +	ret = 0;
>  	ms = __pfn_to_section(start_pfn);
>  	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
>  		ret = -EEXIST;
> -		goto out;
> +		goto out2;
>  	}

I've missed this previously, but it seems that this check can be moved
before the allocations, which simplifies the code a bit more.

>  
>  	/*
> @@ -724,11 +725,11 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	section_mark_present(ms);
>  	sparse_init_one_section(ms, section_nr, memmap, usemap);
>  
> +	return ret;
>  out:
> -	if (ret < 0) {
> -		kfree(usemap);
> -		__kfree_section_memmap(memmap, altmap);
> -	}
> +	__kfree_section_memmap(memmap, altmap);
> +out2:
> +	kfree(usemap);
>  	return ret;
>  }
>  
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.

