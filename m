Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168CCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321B4222D2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NCS4oSsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503770AbfJRFDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:03:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15260 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfJRFDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:03:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da947b00000>; Thu, 17 Oct 2019 22:03:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 22:03:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Oct 2019 22:03:33 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 05:03:32 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 05:03:32 +0000
Subject: Re: [PATCH V3] mm/page_alloc: Add alloc_contig_pages()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David Hildenbrand" <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <1571300646-32240-1-git-send-email-anshuman.khandual@arm.com>
 <d0b4a92b-825f-7b2f-4624-c76f218f064e@nvidia.com>
 <1b173827-b08c-b294-bf86-22228bdfd542@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0709de85-05f4-2a9d-e346-bd15b10e5a1a@nvidia.com>
Date:   Thu, 17 Oct 2019 22:03:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b173827-b08c-b294-bf86-22228bdfd542@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571375024; bh=l9NeihTw+1J1q2KFR+RjBhrVlNmj7LH0R3G4vYYzIeE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NCS4oSsVw6TmBPrs2DfZG3k3N7U9hdA8LAzF5SGSsK8PZkOuG2zAnlVxFzthpzQ78
         XcFGdXGcwWNLWCqhBjQJJ+2QRc2g8Y7spLYTvDMbbMjDuCRAu0WDfqbKYRRI78M8fC
         Tr7I5EcIwNX2s1B867KBxgjeMUZPy0cE9KCJ3ZuvEaJcIjaNvdx1KUJ4uj7/KOm1yz
         tmem2e2Ec6BEWM3aXSgSPnT0PmP60NOdvOnnb/vt/IEYOjobE4ZPGZFFx7Te9MK4Fv
         0qgIGmsYAiMiRRcIHnnFYROWO72OEPTYTf8oZhbSRe/r8dZCryl3SOciK/wXLqWaZX
         +A9TeWJ7ccegQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 8:28 PM, Anshuman Khandual wrote:
> On 10/18/2019 02:44 AM, John Hubbard wrote:
>> On 10/17/19 1:24 AM, Anshuman Khandual wrote:
... 
> Yeah, it is bit non-trivial because v5 of the pgtable tests are still
> on the latest linux-next (20191015 or 20191017). You will need to
> revert the following patches.
> 
> 1. mm/hugetlb: make alloc_gigantic_page() available for general use
> 2. mm/debug: add tests validating architecture page table helpers
> 3. mm-debug-add-tests-validating-architecture-page-table-helpers-fix
> 
> and apply the following patch (https://patchwork.kernel.org/patch/11190213/)
> 
> 1. hugetlbfs: don't access uninitialized memmaps in pfn_range_valid_gigantic()
> 
> After which this particular patch here will apply cleanly. Hope this helps.
> 

Yes, that helps, I wouldn't have worked that out on my own. :)

I'm not sure if I'll have anything to add, but I do want to take a peek,
so I can try to keep up with how huge pages are evolving.

thanks,

John Hubbard
NVIDIA
