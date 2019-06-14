Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A00C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DCB2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfFNPfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfFNPfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:35:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E91E2ACAC;
        Fri, 14 Jun 2019 15:35:41 +0000 (UTC)
Date:   Fri, 14 Jun 2019 17:35:39 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Qian Cai <cai@lca.pw>, Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
Message-ID: <20190614153535.GA9900@linux>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
 <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw>
 <87lfy4ilvj.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy4ilvj.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:28:40PM +0530, Aneesh Kumar K.V wrote:
> Can you check with this change on ppc64.  I haven't reviewed this series yet.
> I did limited testing with change . Before merging this I need to go
> through the full series again. The vmemmap poplulate on ppc64 needs to
> handle two translation mode (hash and radix). With respect to vmemap
> hash doesn't setup a translation in the linux page table. Hence we need
> to make sure we don't try to setup a mapping for a range which is
> arleady convered by an existing mapping. 
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index a4e17a979e45..15c342f0a543 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -88,16 +88,23 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>   * which overlaps this vmemmap page is initialised then this page is
>   * initialised already.
>   */
> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
>  {
>  	unsigned long end = start + page_size;
>  	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>  
> -	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> -		if (pfn_valid(page_to_pfn((struct page *)start)))
> -			return 1;
> +	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page))) {
>  
> -	return 0;
> +		struct mem_section *ms;
> +		unsigned long pfn = page_to_pfn((struct page *)start);
> +
> +		if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> +			return 0;

I might be missing something, but is this right?
Having a section_nr above NR_MEM_SECTIONS is invalid, but if we return 0 here,
vmemmap_populate will go on and populate it.

-- 
Oscar Salvador
SUSE L3
