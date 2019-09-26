Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C9BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB250207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391728AbfIZDtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733197AbfIZDtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:49:19 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 349F27FDEC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:49:19 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id f4so666817plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 20:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShKNQbErac64XK8TSPHgRCKqoTFkkgB8tmVFA50VI9E=;
        b=FYVhb64Uf5Rac1JMcT4M4hjvGQpgHNtLt/I/Ck8UYneR1tQbqAlm33V7oT7KBsSpQZ
         p28Yxs7eTaZD98MQsrTLCuNoKhM3O8IRbOmhCJFpdcLghzPF0FoLO7CEiovdsglaltwA
         K7Jb+cH6+XD9Z3FfeKSGiMy6shrpbACRHjsjlvctZY3eHTcQjrqU/oJMPGberlusU6s5
         6WSlkPjbfFLTnW4PCxRuP6CNKOHShMuAbs164heiL1v8XgTGkkS/bk96sDQmLRRM5IIt
         6NXtkfm76QHXl3S2E6ut15Sk6waf5ryk7mCdjjrSepP6pbWxPaDiV8NlTTQ2jRTKnrxK
         KADg==
X-Gm-Message-State: APjAAAXuE5EEIS5+yKFPgXZvVA/y9aTQ4aLK2SUax9ARF+bChVTHxd0d
        tspFtRM7mc+/Ck+FGlWcGVSMTZ48PxPE8VGi57N0n9eRK7sR2oFwi7eJhCq8Lnr9zK/ACMbPyv4
        VgtSxyHlTlrnu0UNDey2E+3j8
X-Received: by 2002:a63:df02:: with SMTP id u2mr1326649pgg.62.1569469758379;
        Wed, 25 Sep 2019 20:49:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxs4/hDxEwwNdVu+EpMWqbEMaG9qmJxTI8+9ub9yU1tkFZwOu/oob4U27J3j3Xho1yCL2C8Xw==
X-Received: by 2002:a63:df02:: with SMTP id u2mr1326630pgg.62.1569469758054;
        Wed, 25 Sep 2019 20:49:18 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f74sm576418pfa.34.2019.09.25.20.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 20:49:17 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:49:05 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
        ashok.raj@intel.com, kvm@vger.kernel.org, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190926034905.GW28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
 <20190923122454.9888-3-baolu.lu@linux.intel.com>
 <20190925052157.GL28074@xz-x1>
 <c9792e0b-bf42-1dbb-f060-0b1a43125f47@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9792e0b-bf42-1dbb-f060-0b1a43125f47@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:35:24AM +0800, Lu Baolu wrote:

[...]

> > > @@ -0,0 +1,342 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/**
> > > + * intel-pgtable.c - Intel IOMMU page table manipulation library
> > 
> > Could this be a bit misleading?  Normally I'll use "IOMMU page table"
> > to refer to the 2nd level page table only, and I'm always
> > understanding it as "the new IOMMU will understand MMU page table as
> > the 1st level".  At least mention "IOMMU 1st level page table"?
> > 
> 
> This file is a place holder for all code that manipulating iommu page
> tables (both first level and second level). Instead of putting
> everything in intel_iommu.c, let's make the code more structured so that
> it's easier for reading and maintaining. This is the motivation of this
> file.

I see.

> 
> > > + *
> > > + * Copyright (C) 2019 Intel Corporation
> > > + *
> > > + * Author: Lu Baolu <baolu.lu@linux.intel.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt)     "DMAR: " fmt
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/io.h>
> > > +#include <linux/export.h>
> > > +#include <linux/intel-iommu.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/pgtable.h>
> > > +#include <asm/pgalloc.h>
> > > +#include <trace/events/intel_iommu.h>
> > > +
> > > +#ifdef CONFIG_X86
> > > +/*
> > > + * mmmap: Map a range of IO virtual address to physical addresses.
> > 
> > "... to physical addresses using MMU page table"?
> > 
> > Might be clearer?
> 
> Yes.
> 
> > 
> > > + */
> > > +#define pgtable_populate(domain, nm)					\
> > > +do {									\
> > > +	void *__new = alloc_pgtable_page(domain->nid);			\
> > > +	if (!__new)							\
> > > +		return -ENOMEM;						\
> > > +	smp_wmb();							\
> > 
> > Could I ask what's this wmb used for?
> 
> Sure. This is answered by a comment in __pte_alloc() in mm/memory.c. Let
> me post it here.
> 
>         /*
>          * Ensure all pte setup (eg. pte page lock and page clearing) are
>          * visible before the pte is made visible to other CPUs by being
>          * put into page tables.
>          *
>          * The other side of the story is the pointer chasing in the page
>          * table walking code (when walking the page table without locking;
>          * ie. most of the time). Fortunately, these data accesses consist
>          * of a chain of data-dependent loads, meaning most CPUs (alpha
>          * being the notable exception) will already guarantee loads are
>          * seen in-order. See the alpha page table accessors for the
>          * smp_read_barrier_depends() barriers in page table walking code.
>          */
>         smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */

Ok.  I don't understand the rationale much behind but the comment
seems to make sense...  Could you help to comment above, like "please
reference to comment in __pte_alloc" above the line?

> 
> > 
> > > +	spin_lock(&(domain)->page_table_lock);				\
> > 
> > Is this intended to lock here instead of taking the lock during the
> > whole page table walk?  Is it safe?
> > 
> > Taking the example where nm==PTE: when we reach here how do we
> > guarantee that the PMD page that has this PTE is still valid?
> 
> We will always keep the non-leaf pages in the table,

I see.  Though, could I ask why?  It seems to me that the existing 2nd
level page table does not keep these when unmap, and it's not even use
locking at all by leveraging cmpxchg()?

> hence we only need
> a spin lock to serialize multiple tries of populating a entry for pde.
> As for pte, we can assume there is only single thread which can access
> it at a time because different mappings will have different iova's.

Ah yes sorry nm will never be pte here... so do you mean the upper
layer, e.g., the iova allocator will make sure the ranges to be mapped
will never collapse with each other so setting PTEs do not need lock?

> 
> > 
> > > +	if (nm ## _present(*nm)) {					\
> > > +		free_pgtable_page(__new);				\
> > > +	} else {							\
> > > +		set_##nm(nm, __##nm(__pa(__new) | _PAGE_TABLE));	\
> > 
> > It seems to me that PV could trap calls to set_pte().  Then these
> > could also be trapped by e.g. Xen?  Are these traps needed?  Is there
> > side effect?  I'm totally not familiar with this, but just ask aloud...
> 
> Good catch. But I don't think a vIOMMU could get a chance to run in a PV
> environment. I might miss something?

I don't know... Is there reason to not allow a Xen guest to use 1st
level mapping?

While on the other side... If the PV interface will never be used,
then could native_set_##nm() be used directly?

[...]

> > > +static struct page *
> > > +mmunmap_pte_range(struct dmar_domain *domain, pmd_t *pmd,
> > > +		  unsigned long addr, unsigned long end,
> > > +		  struct page *freelist, bool reclaim)
> > > +{
> > > +	int i;
> > > +	unsigned long start;
> > > +	pte_t *pte, *first_pte;
> > > +
> > > +	start = addr;
> > > +	pte = pte_offset_kernel(pmd, addr);
> > > +	first_pte = pte;
> > > +	do {
> > > +		set_pte(pte, __pte(0));
> > > +	} while (pte++, addr += PAGE_SIZE, addr != end);
> > > +
> > > +	domain_flush_cache(domain, first_pte, (void *)pte - (void *)first_pte);
> > > +
> > > +	/* Add page to free list if all entries are empty. */
> > > +	if (reclaim) {
> > 
> > Shouldn't we know whether to reclaim if with (addr, end) specified as
> > long as they cover the whole range of this PMD?
> 
> Current policy is that we don't reclaim any pages until the whole page
> table will be torn down.

Ah OK.  But I saw that you're passing in relaim==!start_addr.
Shouldn't that errornously trigger if one wants to unmap the 1st page
as well even if not the whole address space?

> The gain is that we don't have to use a
> spinlock when map/unmap a pmd entry anymore.

So this question should also related to above on the locking - have
you thought about using the same way (IIUC) as the 2nd level page
table to use cmpxchg()?  AFAIU that does not need any lock?

For me it's perfectly fine to use a lock at least for initial version,
I just want to know the considerations behind in case I missed
anything important.

Thanks,

-- 
Peter Xu
