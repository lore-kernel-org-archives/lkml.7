Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A8C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52D52084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571736298;
	bh=E8d8bOHaDaWQFl7hsOunF2Da43rOVzJx9bv8he3CKdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sEWld6tBwGcL3vDmKyCEF40negTH8kWHjD3pMfWRZ3pW1sIMIPWu2SEvm/TsCg7nM
	 qaP1ERVB7u+xVUu3sa5Eyi3m6dgvfOOeSXMWwy9dNNQ4wVo3KjuF5ddgp+xfdwQhux
	 WlZuZvYWoNTxE05Vv+Z+ECdG9dC+gJxqYJ7H25I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfJVJY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:24:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfJVJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:24:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD1BDAC69;
        Tue, 22 Oct 2019 09:24:54 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:24:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
Message-ID: <20191022092454.GI9379@dhcp22.suse.cz>
References: <20191021172353.3056-1-david@redhat.com>
 <25d3f071-3268-298b-e0c8-9c307d1015fe@redhat.com>
 <20191022080835.GZ9379@dhcp22.suse.cz>
 <1f56744d-2c22-6c12-8fe8-4a71e791c467@redhat.com>
 <20191022082131.GC9379@dhcp22.suse.cz>
 <de39873c-ae55-88ed-0b4e-4f67a75ef81c@redhat.com>
 <20191022091431.GG9379@dhcp22.suse.cz>
 <68d6da35-276c-0491-99ea-8249dee8fd1d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d6da35-276c-0491-99ea-8249dee8fd1d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 11:17:24, David Hildenbrand wrote:
> On 22.10.19 11:14, Michal Hocko wrote:
> > On Tue 22-10-19 10:32:11, David Hildenbrand wrote:
> > [...]
> > > E.g., arch/x86/kvm/mmu.c:kvm_is_mmio_pfn()
> > 
> > Thanks for these references. I am not really familiar with kvm so I
> > cannot really comment on the specific code but I am wondering why
> > it simply doesn't check for ZONE_DEVICE explicitly? Also we do care
> > about holes in RAM (from the early boot), those should be reserved
> > already AFAIR. So we are left with hotplugged memory with holes and
> > I am not really sure we should bother with this until there is a clear
> > usecase in sight.
> 
> Well, checking for ZONE_DEVICE is only possible if you have an initialized
> memmap. And that is not guaranteed when you start mapping random stuff into
> your guest via /dev/mem.

Yes, I can understand that part but checking PageReserved on an
uninitialized memmap is pointless as well. So if you can test for it you
can very well test for ZONE_DEVICE as well. PageReserved -> ZONE_DEVICE
is a terrible assumption.

> I am reworking these patches right now and audit the whole kernel for
> PageReserved() checks that might affect ZONE_DEVICE. I'll send the
> collection of patches as RFC.

Thanks a lot!
-- 
Michal Hocko
SUSE Labs
