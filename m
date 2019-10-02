Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B0C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21F621783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570054458;
	bh=kSN1Gyplw7RqXqxsJcmCMVoXdvIiOoy3KBYxUcNcQIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cvcl1ByMlxpmibh0B1pNGAKwjBt6FQlUcv2U/pluAGm4StQbCoEGlGIMkcjrrSJmq
	 xi/UJAY/SJj9fzLG4mrR4Wip1SewhLeyyvp2et4MqTPGkebGAEspUH0k/QwRGpUQSP
	 lgAjQXI0lokLcpFP5ISINIaLBf7hBsik99kvlR1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfJBWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJBWOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:14:17 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8175420659;
        Wed,  2 Oct 2019 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570054456;
        bh=kSN1Gyplw7RqXqxsJcmCMVoXdvIiOoy3KBYxUcNcQIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x3yRh+edFLTiTWrF/ExG8Ko/QBaRLNy2Q78XMIQfuf6mhooPQrPb7sYKoQRHgbNvu
         9fYeX4S4q9iMk3zKcAxMIMoyk5ceWMnVLy3jTGcCBTJOFlQT42tw4CGWjwHqIEHpBc
         6dwdmTJOkAs3aZYsITxs4nCguavz6OHjVwpJHYF8=
Date:   Wed, 2 Oct 2019 15:14:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] memory_hotplug: Add a bounds check to
 __add_pages
Message-Id: <20191002151416.42bc2e8228fdefc6eb802abc@linux-foundation.org>
In-Reply-To: <01def17b-1df8-a63a-4cfc-91e99614a2f0@redhat.com>
References: <20191001004617.7536-1-alastair@au1.ibm.com>
        <20191001004617.7536-2-alastair@au1.ibm.com>
        <01def17b-1df8-a63a-4cfc-91e99614a2f0@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 11:49:47 +0200 David Hildenbrand <david@redhat.com> wrote:

> > @@ -278,6 +278,22 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
> >  	return 0;
> >  }
> >  
> > +static int check_hotplug_memory_addressable(unsigned long pfn,
> > +					    unsigned long nr_pages)
> > +{
> > +	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> > +
> > +	if (max_addr >> MAX_PHYSMEM_BITS) {
> > +		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
> > +		WARN(1,
> > +		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
> > +		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
> > +		return -E2BIG;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Reasonably generic function for adding memory.  It is
> >   * expected that archs that support memory hotplug will
> > @@ -291,6 +307,10 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> >  	unsigned long nr, start_sec, end_sec;
> >  	struct vmem_altmap *altmap = restrictions->altmap;
> >  
> > +	err = check_hotplug_memory_addressable(pfn, nr_pages);
> > +	if (err)
> > +		return err;
> > +
> >  	if (altmap) {
> >  		/*
> >  		 * Validate altmap is within bounds of the total request
> > 
> 
> I actually wanted to give my RB to v7, not v6 :)
>

Given that check_hotplug_memory_addressable() is now static, I'll
assume that the old [2/2]
mm-add-a-bounds-check-in-devm_memremap_pages.patch is now obsolete.

From: Alastair D'Silva <alastair@d-silva.org>
Subject: mm/memremap.c: add a bounds check in devm_memremap_pages()

The call to check_hotplug_memory_addressable() validates that the memory
is fully addressable.

Without this call, it is possible that we may remap pages that is not
physically addressable, resulting in bogus section numbers being returned
from __section_nr().

Link: http://lkml.kernel.org/r/20190917010752.28395-3-alastair@au1.ibm.com
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memremap.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/mm/memremap.c~mm-add-a-bounds-check-in-devm_memremap_pages
+++ a/mm/memremap.c
@@ -185,6 +185,11 @@ void *memremap_pages(struct dev_pagemap
 	int error, is_ram;
 	bool need_devmap_managed = true;
 
+	error = check_hotplug_memory_addressable(res->start,
+						 resource_size(res));
+	if (error)
+		return ERR_PTR(error);
+
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
_

