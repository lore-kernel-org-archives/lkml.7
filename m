Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB8FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBAB208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFZI2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:28:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZI17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD0FBAD7E;
        Wed, 26 Jun 2019 08:27:58 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:27:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190626082756.GD30863@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
 <20190626080249.GA30863@linux>
 <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
 <20190626081516.GC30863@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626081516.GC30863@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:15:16AM +0200, Oscar Salvador wrote:
> On Wed, Jun 26, 2019 at 10:11:06AM +0200, David Hildenbrand wrote:
> > Back then, I already mentioned that we might have some users that
> > remove_memory() they never added in a granularity it wasn't added. My
> > concerns back then were never fully sorted out.
> > 
> > arch/powerpc/platforms/powernv/memtrace.c
> > 
> > - Will remove memory in memory block size chunks it never added
> > - What if that memory resides on a DIMM added via MHP_MEMMAP_DEVICE?
> > 
> > Will it at least bail out? Or simply break?
> > 
> > IOW: I am not yet 100% convinced that MHP_MEMMAP_DEVICE is save to be
> > introduced.
> 
> Uhm, I will take a closer look and see if I can clear your concerns.
> TBH, I did not try to use arch/powerpc/platforms/powernv/memtrace.c
> yet.
> 
> I will get back to you once I tried it out.

On a second though, it would be quite trivial to implement a check in
remove_memory() that does not allow to remove memory used with MHP_MEMMAP_DEVICE
in a different granularity:

+static bool check_vmemmap_granularity(u64 start, u64 size);
+{
+	unsigned long pfn;
+	unsigned int nr_pages;
+	struct page *p;
+
+	pfn = PHYS_PFN(start);
+	p = pfn_to_page(pfn);
+	nr_pages = size >> PAGE_SIZE;
+
+	if (PageVmemmap(p)) {
+		struct page *h = vmemmap_get_head(p);
+		unsigned long sections = (unsigned long)h->private;
+
+		if (sections * PAGES_PER_SECTION > nr_pages)
+			fail;
+	}
+	no_fail;
+}
+		
+
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
 	mem_hotplug_begin();
 
+	rc = check_vmemmap_granularity(start, size);
+	if (rc)
+		goto done;


The above is quite hacky, but it gives an idea.
I will try the code from arch/powerpc/platforms/powernv/memtrace.c and see how
can I implement a check.

-- 
Oscar Salvador
SUSE L3
