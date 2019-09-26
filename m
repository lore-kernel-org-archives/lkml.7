Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0547F222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfIZJNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:13:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729001AbfIZJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:13:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8Q9CalT038643;
        Thu, 26 Sep 2019 05:13:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8t7n8x0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 05:12:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8Q9Cbl2038696;
        Thu, 26 Sep 2019 05:12:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8t7n8wx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 05:12:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8Q9Af87023062;
        Thu, 26 Sep 2019 09:12:55 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2v5bg7s5ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 09:12:55 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8Q9CsLZ53871090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 09:12:54 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4788A124054;
        Thu, 26 Sep 2019 09:12:54 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5FE2124052;
        Thu, 26 Sep 2019 09:12:51 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.158])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Sep 2019 09:12:51 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/8] mm/memory_hotplug: Don't access uninitialized memmaps in shrink_zone_span()
In-Reply-To: <20190830091428.18399-3-david@redhat.com>
References: <20190830091428.18399-1-david@redhat.com> <20190830091428.18399-3-david@redhat.com>
Date:   Thu, 26 Sep 2019 14:42:50 +0530
Message-ID: <87wodvo1yl.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-26_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> Let's limit shrinking to !ZONE_DEVICE so we can fix the current code. We
> should never try to touch the memmap of offline sections where we could
> have uninitialized memmaps and could trigger BUGs when calling
> page_to_nid() on poisoned pages.
>
> Stopping to shrink the ZONE_DEVICE is fine as set_zone_contiguous() cannot
> deal with ZONE_DEVICE either way. The zones will always be !contiguous
> already and zone shrinking is therefore of limited use.

Can you add more details w.r.t ZONE_DEVICE?

>
> Before commit d0dc12e86b31 ("mm/memory_hotplug: optimize memory
> hotplug"), the memmap was initialized with 0 and the node with the
> right value. So the zone might be wrong but not garbage. After that
> commit, both the zone and the node will be garbage when touching
> uninitialized memmaps.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index ddba8d786e4a..e0d1f6a9dfeb 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -331,7 +331,7 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>  				     unsigned long end_pfn)
>  {
>  	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
> -		if (unlikely(!pfn_valid(start_pfn)))
> +		if (unlikely(!pfn_to_online_page(start_pfn)))
>  			continue;
>  
>  		if (unlikely(pfn_to_nid(start_pfn) != nid))
> @@ -356,7 +356,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>  	/* pfn is the end pfn of a memory section. */
>  	pfn = end_pfn - 1;
>  	for (; pfn >= start_pfn; pfn -= PAGES_PER_SUBSECTION) {
> -		if (unlikely(!pfn_valid(pfn)))
> +		if (unlikely(!pfn_to_online_page(pfn)))
>  			continue;
>  
>  		if (unlikely(pfn_to_nid(pfn) != nid))
> @@ -415,7 +415,7 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>  	 */
>  	pfn = zone_start_pfn;
>  	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
> -		if (unlikely(!pfn_valid(pfn)))
> +		if (unlikely(!pfn_to_online_page(pfn)))
>  			continue;
>  
>  		if (page_zone(pfn_to_page(pfn)) != zone)
> @@ -463,6 +463,14 @@ static void __remove_zone(struct zone *zone, unsigned long start_pfn,
>  	struct pglist_data *pgdat = zone->zone_pgdat;
>  	unsigned long flags;
>  
> +	/*
> +	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
> +	 * we will not try to shrink the zones - which is okay as
> +	 * set_zone_contiguous() cannot deal with ZONE_DEVICE either way.
> +	 */
> +	if (zone_idx(zone) == ZONE_DEVICE)
> +		return;

Can you describe here what is special about ZONE_DEVICE?


>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
>  	shrink_zone_span(zone, start_pfn, start_pfn + nr_pages);
>  	update_pgdat_span(pgdat);
> -- 
> 2.21.0
