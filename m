Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8431C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA16A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfFXRyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:54:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbfFXRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:54:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D36E8ABE1;
        Mon, 24 Jun 2019 17:54:31 +0000 (UTC)
Message-ID: <1561398869.3073.4.camel@suse.de>
Subject: Re: [PATCH v10 02/13] mm/sparsemem: Introduce a SECTION_IS_EARLY
 flag
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 19:54:29 +0200
In-Reply-To: <156092350358.979959.5817209875548072819.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156092350358.979959.5817209875548072819.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 22:51 -0700, Dan Williams wrote:
> In preparation for sub-section hotplug, track whether a given section
> was created during early memory initialization, or later via memory
> hotplug.  This distinction is needed to maintain the coarse
> expectation
> that pfn_valid() returns true for any pfn within a given section even
> if
> that section has pages that are reserved from the page allocator.
> 
> For example one of the of goals of subsection hotplug is to support
> cases where the system physical memory layout collides System RAM and
> PMEM within a section. Several pfn_valid() users expect to just check
> if
> a section is valid, but they are not careful to check if the given
> pfn
> is within a "System RAM" boundary and instead expect pgdat
> information
> to further validate the pfn.
> 
> Rather than unwind those paths to make their pfn_valid() queries more
> precise a follow on patch uses the SECTION_IS_EARLY flag to maintain
> the
> traditional expectation that pfn_valid() returns true for all early
> sections.
> 
> Link: https://lore.kernel.org/lkml/1560366952-10660-1-git-send-email-
> cai@lca.pw/
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

[...]
> @@ -731,7 +732,7 @@ int __meminit sparse_add_one_section(int nid,
> unsigned long start_pfn,
>  	page_init_poison(memmap, sizeof(struct page) *
> PAGES_PER_SECTION);
>  
>  	section_mark_present(ms);
> -	sparse_init_one_section(ms, section_nr, memmap, usage);
> +	sparse_init_one_section(ms, section_nr, memmap, usage, 0);

I think this is an improvment, and I really like the idea of leveraring
a new section's flag for this, but I have mixed feelings about the way
to mark a section as an early one.
IMHO, I think that a new "section_mark_early" function would be better
than passing a new flag parameter to sparse_init_one_section().

But I do not feel strong on this:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
