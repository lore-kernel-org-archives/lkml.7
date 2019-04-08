Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3084C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75545208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfDHED5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:03:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:6259 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfDHED4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:03:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 21:03:54 -0700
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="132298528"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2019 21:03:54 -0700
Date:   Sun, 7 Apr 2019 21:03:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>, james.morse@arm.com,
        Mark Rutland <mark.rutland@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org, osalvador@suse.de,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>, cai@lca.pw,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
Message-ID: <20190408040346.GA26243@iweiny-DESK2.sc.intel.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com>
 <0d72db39-e20d-1cbd-368e-74dda9b6c936@arm.com>
 <CAPcyv4h5YskvjR306FsHnVHpPjnT4s2JPJXgk6CxiMz8bjhqkg@mail.gmail.com>
 <a16a9867-7019-10ab-1901-c114bcd8712b@arm.com>
 <CAPcyv4j0Z2ASeJGgS18Bpgr_2F8XdZdCq4T9W5fgkG1oWKtNHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j0Z2ASeJGgS18Bpgr_2F8XdZdCq4T9W5fgkG1oWKtNHg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 03:11:00PM -0700, Dan Williams wrote:
> On Thu, Apr 4, 2019 at 2:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 04/04/2019 06:04, Dan Williams wrote:
> > > On Wed, Apr 3, 2019 at 9:42 PM Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:
> > >>
> > >>
> > >>
> > >> On 04/03/2019 07:28 PM, Robin Murphy wrote:
> > >>> [ +Dan, Jerome ]
> > >>>
> > >>> On 03/04/2019 05:30, Anshuman Khandual wrote:
> > >>>> Arch implementation for functions which create or destroy vmemmap mapping
> > >>>> (vmemmap_populate, vmemmap_free) can comprehend and allocate from inside
> > >>>> device memory range through driver provided vmem_altmap structure which
> > >>>> fulfils all requirements to enable ZONE_DEVICE on the platform. Hence just
> > >>>
> > >>> ZONE_DEVICE is about more than just altmap support, no?
> > >>
> > >> Hot plugging the memory into a dev->numa_node's ZONE_DEVICE and initializing the
> > >> struct pages for it has stand alone and self contained use case. The driver could
> > >> just want to manage the memory itself but with struct pages either in the RAM or
> > >> in the device memory range through struct vmem_altmap. The driver may not choose
> > >> to opt for HMM, FS DAX, P2PDMA (use cases of ZONE_DEVICE) where it may have to
> > >> map these pages into any user pagetable which would necessitate support for
> > >> pte|pmd|pud_devmap.
> > >
> > > What's left for ZONE_DEVICE if none of the above cases are used?
> > >
> > >> Though I am still working towards getting HMM, FS DAX, P2PDMA enabled on arm64,
> > >> IMHO ZONE_DEVICE is self contained and can be evaluated in itself.
> > >
> > > I'm not convinced. What's the specific use case.
> >
> > The fundamental "roadmap" reason we've been doing this is to enable
> > further NVDIMM/pmem development (libpmem/Qemu/etc.) on arm64. The fact
> > that ZONE_DEVICE immediately opens the door to the various other stuff
> > that the CCIX folks have interest in is a definite bonus, so it would
> > certainly be preferable to get arm64 on par with the current state of
> > things rather than try to subdivide the scope further.
> >
> > I started working on this from the ZONE_DEVICE end, but got bogged down
> > in trying to replace my copied-from-s390 dummy hot-remove implementation
> > with something proper. Anshuman has stepped in to help with hot-remove
> > (since we also have cloud folks wanting that for its own sake), so is
> > effectively coming at the problem from the opposite direction, and I'll
> > be the first to admit that we've not managed the greatest job of meeting
> > in the middle and coordinating our upstream story; sorry about that :)
> >
> > Let me freshen up my devmap patches and post them properly, since that
> > discussion doesn't have to happen in the context of hot-remove; they're
> > effectively just parallel dependencies for ZONE_DEVICE.
> 
> Sounds good. It's also worth noting that Ira's recent patches for
> supporting get_user_pages_fast() for "longterm" pins relies on
> PTE_DEVMAP to determine when fast-GUP is safe to proceed, or whether
> it needs to fall back to slow-GUP. So it really is the case that
> "devmap" support is an assumption for ZONE_DEVICE.

Could you cc me on the patches when you post?

Thanks,
Ira

