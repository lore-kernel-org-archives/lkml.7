Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B267C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA8206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDCRdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:33:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36998 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:33:31 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.206])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hBjky-0003uq-Cx; Wed, 03 Apr 2019 11:33:01 -0600
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        pasha.tatashin@oracle.com, david@redhat.com, cai@lca.pw,
        Stephen Bates <sbates@raithlin.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f2ea761c-49b2-88f6-14fa-5aaec57952cb@deltatee.com>
Date:   Wed, 3 Apr 2019 11:32:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, cai@lca.pw, david@redhat.com, pasha.tatashin@oracle.com, osalvador@suse.de, dan.j.williams@intel.com, arunks@codeaurora.org, cpandya@codeaurora.org, robin.murphy@arm.com, mark.rutland@arm.com, james.morse@arm.com, mgorman@techsingularity.net, mhocko@suse.com, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, anshuman.khandual@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-04-02 10:30 p.m., Anshuman Khandual wrote:
> Memory removal from an arch perspective involves tearing down two different
> kernel based mappings i.e vmemmap and linear while releasing related page
> table pages allocated for the physical memory range to be removed.
> 
> Define a common kernel page table tear down helper remove_pagetable() which
> can be used to unmap given kernel virtual address range. In effect it can
> tear down both vmemap or kernel linear mappings. This new helper is called
> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
> The argument 'direct' here identifies kernel linear mappings.
> 
> Vmemmap mappings page table pages are allocated through sparse mem helper
> functions like vmemmap_alloc_block() which does not cycle the pages through
> pgtable_page_ctor() constructs. Hence while removing it skips corresponding
> destructor construct pgtable_page_dtor().
> 
> While here update arch_add_mempory() to handle __add_pages() failures by
> just unmapping recently added kernel linear mapping. Now enable memory hot
> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
> 
> This implementation is overall inspired from kernel page table tear down
> procedure on X86 architecture.

I've been working on very similar things for RISC-V. In fact, I'm
currently in progress on a very similar stripped down version of
remove_pagetable(). (Though I'm fairly certain I've done a bunch of
stuff wrong.)

Would it be possible to move this work into common code that can be used
by all arches? Seems like, to start, we should be able to support both
arm64 and RISC-V... and maybe even x86 too.

I'd be happy to help integrate and test such functions in RISC-V.

Thanks,

Logan


