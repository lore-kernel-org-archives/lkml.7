Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503EB213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553277942;
	bh=yk+jdsre7IF4ppic9lSAyk3IP1ZUhdGmseC6r1Ix4jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y0wd80HNOrc0kzYP7vD/OuTF1lYZOAwlVnwkNaAwebLnm3btHdYpzOmP9R6qWZvWJ
	 FTqLKbmFTWNTd9GAw06N2UtVTzsNGCnx98J3Nn2zz9fxk0MKTaM/KE+1PxuA2u5iZN
	 RrfW6L1IbQGTIaSoHVjTi1yii5DL5rmPR6FdnpXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfCVSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:05:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53952 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728471AbfCVSFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:05:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F17FAEE3;
        Fri, 22 Mar 2019 18:05:38 +0000 (UTC)
Date:   Fri, 22 Mar 2019 19:05:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] mm: Sub-section memory hotplug support
Message-ID: <20190322180532.GM32418@dhcp22.suse.cz>
References: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-03-19 09:57:54, Dan Williams wrote:
> Changes since v4 [1]:
> - Given v4 was from March of 2017 the bulk of the changes result from
>   rebasing the patch set from a v4.11-rc2 baseline to v5.1-rc1.
> 
> - A unit test is added to ndctl to exercise the creation and dax
>   mounting of multiple independent namespaces in a single 128M section.
> 
> [1]: https://lwn.net/Articles/717383/
> 
> ---
> 
> Quote patch7:
> 
> "The libnvdimm sub-system has suffered a series of hacks and broken
>  workarounds for the memory-hotplug implementation's awkward
>  section-aligned (128MB) granularity. For example the following backtrace
>  is emitted when attempting arch_add_memory() with physical address
>  ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
>  within a given section:
>  
>   WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
>   devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
>   [..]
>   Call Trace:
>     dump_stack+0x86/0xc3
>     __warn+0xcb/0xf0
>     warn_slowpath_fmt+0x5f/0x80
>     devm_memremap_pages+0x3b5/0x4c0
>     __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
>     pmem_attach_disk+0x19a/0x440 [nd_pmem]
>  
>  Recently it was discovered that the problem goes beyond RAM vs PMEM
>  collisions as some platform produce PMEM vs PMEM collisions within a
>  given section. The libnvdimm workaround for that case revealed that the
>  libnvdimm section-alignment-padding implementation has been broken for a
>  long while. A fix for that long-standing breakage introduces as many
>  problems as it solves as it would require a backward-incompatible change
>  to the namespace metadata interpretation. Instead of that dubious route
>  [2], address the root problem in the memory-hotplug implementation."
> 
> The approach is taken is to observe that each section already maintains
> an array of 'unsigned long' values to hold the pageblock_flags. A single
> additional 'unsigned long' is added to house a 'sub-section active'
> bitmask. Each bit tracks the mapped state of one sub-section's worth of
> capacity which is SECTION_SIZE / BITS_PER_LONG, or 2MB on x86-64.

So the hotplugable unit is pageblock now, right? Why is this
sufficient? What prevents new and creative HW to come up with
alignements that do not fit there? Do not get me wrong but the section
as a unit is deeply carved into the memory hotplug and removing all those
assumptions is a major undertaking and I would like to know that you are
not just shifting the problem to a smaller unit and a new/creative HW
will force us to go even more complicated.

What is the fundamental reason that pmem sections cannot be assigned
to a section aligned memory range? The physical address space is
quite large to impose 128MB sections IMHO. I thought this is merely a
configuration issue. How often this really happens and how often it is
unavoidable.

> The implication of allowing sections to be piecemeal mapped/unmapped is
> that the valid_section() helper is no longer authoritative to determine
> if a section is fully mapped. Instead pfn_valid() is updated to consult
> the section-active bitmask. Given that typical memory hotplug still has
> deep "section" dependencies the sub-section capability is limited to
> 'want_memblock=false' invocations of arch_add_memory(), effectively only
> devm_memremap_pages() users for now.

Does this mean that pfn_valid is more expensive now? How much? For any
pfn? Also what about the section life time? Who is removing section now?

I will probably have much more question, but it's friday and I am mostly
offline already. I would just like to hear much more about the new
design and resulting assumptions.
-- 
Michal Hocko
SUSE Labs
