Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F75BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E0205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfGOQDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730415AbfGOQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:03:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FG2t7o099228
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:03:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tru9g4jpq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:03:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 15 Jul 2019 17:03:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 17:03:06 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FG35a753346516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 16:03:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 431014C040;
        Mon, 15 Jul 2019 16:03:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CE744C05A;
        Mon, 15 Jul 2019 16:03:00 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.70.182])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jul 2019 16:03:00 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/2] mm,sparse: Fix deactivate_section for early sections
In-Reply-To: <20190715081549.32577-2-osalvador@suse.de>
References: <20190715081549.32577-1-osalvador@suse.de> <20190715081549.32577-2-osalvador@suse.de>
Date:   Mon, 15 Jul 2019 21:32:57 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071516-4275-0000-0000-0000034D2E82
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071516-4276-0000-0000-0000385D3E1F
Message-Id: <87wogje15a.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> deactivate_section checks whether a section is early or not
> in order to either call free_map_bootmem() or depopulate_section_memmap().
> Being the former for sections added at boot time, and the latter for
> sections hotplugged.
>
> The problem is that we zero section_mem_map, so the last early_section()
> will always report false and the section will not be removed.
>
> Fix this checking whether a section is early or not at function
> entry.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: mmotm ("mm/sparsemem: Support sub-section hotplug")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/sparse.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3267c4001c6d..1e224149aab6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -738,6 +738,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>  	struct mem_section *ms = __pfn_to_section(pfn);
> +	bool section_is_early = early_section(ms);
>  	struct page *memmap = NULL;
>  	unsigned long *subsection_map = ms->usage
>  		? &ms->usage->subsection_map[0] : NULL;
> @@ -772,7 +773,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
> -		if (!early_section(ms)) {
> +		if (!section_is_early) {
>  			kfree(ms->usage);
>  			ms->usage = NULL;
>  		}
> @@ -780,7 +781,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
>  	}
>  
> -	if (early_section(ms) && memmap)
> +	if (section_is_early && memmap)
>  		free_map_bootmem(memmap);
>  	else
>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> -- 
> 2.12.3

