Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A4C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1642166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406089AbfHIJKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:10:08 -0400
Received: from foss.arm.com ([217.140.110.172]:43896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfHIJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8043515A2;
        Fri,  9 Aug 2019 02:10:07 -0700 (PDT)
Received: from [10.163.1.243] (unknown [10.163.1.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6A33F575;
        Fri,  9 Aug 2019 02:10:03 -0700 (PDT)
Subject: Re: [PATCH] mm/sparse: use __nr_to_section(section_nr) to get
 mem_section
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        pasha.tatashin@oracle.com, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190809010242.29797-1-richardw.yang@linux.intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e17278f0-94dc-e0c6-379b-b7694cec3247@arm.com>
Date:   Fri, 9 Aug 2019 14:39:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190809010242.29797-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2019 06:32 AM, Wei Yang wrote:
> __pfn_to_section is defined as __nr_to_section(pfn_to_section_nr(pfn)).

Right.

> 
> Since we already get section_nr, it is not necessary to get mem_section
> from start_pfn. By doing so, we reduce one redundant operation.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Looks right.

With this applied, memory hot add still works on arm64.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d9bff5..95158a148cd1 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -867,7 +867,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	 */
>  	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>  
> -	ms = __pfn_to_section(start_pfn);
> +	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
>  	section_mark_present(ms);
>  
> 
