Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47DBFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E321835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571296294;
	bh=JvuF51h8KxllgVPcRQiZS5LFyHfBMMsnxNTMBDZ7fCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmPZUR8yZHEmoVKeOsk4O+U2pvSBPS0IqUXbL11dBi4TxZrTZXpjMYajkwYk8H0cT
	 7f3d6wuqodGHmR7HnaqvFfmxN67y0JX9PIJV2nlXrn3CJrkIgi/fDJIL1hLAFSpH0U
	 EJLLbsmc43KzzMLCChmeY0lWTUZUfZV9OmTr3uOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407927AbfJQHLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:11:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390955AbfJQHLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:11:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09BBEB3B1;
        Thu, 17 Oct 2019 07:11:31 +0000 (UTC)
Date:   Thu, 17 Oct 2019 09:11:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
Message-ID: <20191017071129.GB24485@dhcp22.suse.cz>
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
 <20191016115119.GA317@dhcp22.suse.cz>
 <fe8cae46-6bd8-88eb-d3fe-2740bb79ee58@redhat.com>
 <20191016124149.GB317@dhcp22.suse.cz>
 <97cadd99-d05e-3174-6532-fe18f0301ba7@arm.com>
 <e37c16f5-7068-5359-a539-bee58e705122@redhat.com>
 <c60b9e95-5c6c-fcb2-c8bb-13e7646ba8ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60b9e95-5c6c-fcb2-c8bb-13e7646ba8ea@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 10:44:41, Anshuman Khandual wrote:
[...]
> Does this add-on documentation look okay ? Should we also mention about the
> possible reduction in chances of success during pfn block search for the
> non-power-of-two cases as the implicit alignment will probably turn out to
> be bigger than nr_pages itself ?
> 
>  * Requested nr_pages may or may not be power of two. The search for suitable
>  * memory range in a zone happens in nr_pages aligned pfn blocks. But in case
>  * when nr_pages is not power of two, an implicitly aligned pfn block search
>  * will happen which in turn will impact allocated memory block's alignment.
>  * In these cases, the size (i.e nr_pages) and the alignment of the allocated
>  * memory will be different. This problem does not exist when nr_pages is power
>  * of two where the size and the alignment of the allocated memory will always
>  * be nr_pages.

I dunno, it sounds more complicated than really necessary IMHO. Callers
shouldn't really be bothered by memory blocks and other really deep
implementation details.. Wouldn't be the below sufficient?

The allocated memory is always aligned to a page boundary. If nr_pages
is a power of two then the alignement is guaranteed to be to the given
nr_pages (e.g. 1GB request would be aligned to 1GB).
-- 
Michal Hocko
SUSE Labs
