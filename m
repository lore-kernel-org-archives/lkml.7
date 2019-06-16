Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB7C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F86C216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFPHts convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 03:49:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfFPHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 03:49:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5G7l1qM001584
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 03:49:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t5dn0ntjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 03:49:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Sun, 16 Jun 2019 08:49:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Jun 2019 08:49:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5G7nerW29622376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 07:49:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D64F4C04E;
        Sun, 16 Jun 2019 07:49:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FD194C046;
        Sun, 16 Jun 2019 07:49:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.86.48])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jun 2019 07:49:38 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        osalvador@suse.de
Subject: Re: [PATCH v9 10/12] mm/devm_memremap_pages: Enable sub-section remap
In-Reply-To: <155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com> <155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Sun, 16 Jun 2019 13:19:36 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19061607-0020-0000-0000-0000034A7E9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061607-0021-0000-0000-0000219DBFAE
Message-Id: <87zhmigeb3.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Teach devm_memremap_pages() about the new sub-section capabilities of
> arch_{add,remove}_memory(). Effectively, just replace all usage of
> align_start, align_end, and align_size with res->start, res->end, and
> resource_size(res). The existing sanity check will still make sure that
> the two separate remap attempts do not collide within a sub-section (2MB
> on x86).
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  kernel/memremap.c |   61 +++++++++++++++++++++--------------------------------
>  1 file changed, 24 insertions(+), 37 deletions(-)
>
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 57980ed4e571..a0e5f6b91b04 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -58,7 +58,7 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap)
>  	struct vmem_altmap *altmap = &pgmap->altmap;
>  	unsigned long pfn;
>  
> -	pfn = res->start >> PAGE_SHIFT;
> +	pfn = PHYS_PFN(res->start);
>  	if (pgmap->altmap_valid)
>  		pfn += vmem_altmap_offset(altmap);
>  	return pfn;
> @@ -86,7 +86,6 @@ static void devm_memremap_pages_release(void *data)
>  	struct dev_pagemap *pgmap = data;
>  	struct device *dev = pgmap->dev;
>  	struct resource *res = &pgmap->res;
> -	resource_size_t align_start, align_size;
>  	unsigned long pfn;
>  	int nid;
>  
> @@ -96,25 +95,21 @@ static void devm_memremap_pages_release(void *data)
>  	pgmap->cleanup(pgmap->ref);
>  
>  	/* pages are dead and unused, undo the arch mapping */
> -	align_start = res->start & ~(PA_SECTION_SIZE - 1);
> -	align_size = ALIGN(res->start + resource_size(res), PA_SECTION_SIZE)
> -		- align_start;
> -
> -	nid = page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
> +	nid = page_to_nid(pfn_to_page(PHYS_PFN(res->start)));

Why do we not require to align things to subsection size now? 

-aneesh

