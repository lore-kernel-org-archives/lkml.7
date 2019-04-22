Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106CAC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB720811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfDVMUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfDVMUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:20:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38D87859FC;
        Mon, 22 Apr 2019 12:20:24 +0000 (UTC)
Received: from xz-x1 (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5330E26E63;
        Mon, 22 Apr 2019 12:20:14 +0000 (UTC)
Date:   Mon, 22 Apr 2019 20:20:10 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 14/28] userfaultfd: wp: handle COW properly for uffd-wp
Message-ID: <20190422122010.GA25896@xz-x1>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-15-peterx@redhat.com>
 <20190418202558.GK3288@redhat.com>
 <20190419062650.GF13323@xz-x1>
 <20190419150253.GA3311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419150253.GA3311@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 22 Apr 2019 12:20:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 11:02:53AM -0400, Jerome Glisse wrote:

[...]

> > > > +			if (uffd_wp_resolve) {
> > > > +				/* If the fault is resolved already, skip */
> > > > +				if (!pte_uffd_wp(*pte))
> > > > +					continue;
> > > > +				page = vm_normal_page(vma, addr, oldpte);
> > > > +				if (!page || page_mapcount(page) > 1) {
> > > > +					struct vm_fault vmf = {
> > > > +						.vma = vma,
> > > > +						.address = addr & PAGE_MASK,
> > > > +						.page = page,
> > > > +						.orig_pte = oldpte,
> > > > +						.pmd = pmd,
> > > > +						/* pte and ptl not needed */
> > > > +					};
> > > > +					vm_fault_t ret;
> > > > +
> > > > +					if (page)
> > > > +						get_page(page);
> > > > +					arch_leave_lazy_mmu_mode();
> > > > +					pte_unmap_unlock(pte, ptl);
> > > > +					ret = wp_page_copy(&vmf);
> > > > +					/* PTE is changed, or OOM */
> > > > +					if (ret == 0)
> > > > +						/* It's done by others */
> > > > +						continue;
> > > 
> > > This is wrong if ret == 0 you still need to remap the pte before
> > > continuing as otherwise you will go to next pte without the page
> > > table lock for the directory. So 0 case must be handled after
> > > arch_enter_lazy_mmu_mode() below.
> > > 
> > > Sorry i should have catch that in previous review.
> > 
> > My fault to not have noticed it since the very beginning... thanks for
> > spotting that.
> > 
> > I'm squashing below changes into the patch:
> 
> 
> Well thinking of this some more i think you should use do_wp_page() and
> not wp_page_copy() it would avoid bunch of code above and also you are
> not properly handling KSM page or page in the swap cache. Instead of
> duplicating same code that is in do_wp_page() it would be better to call
> it here.

Yeah it makes sense to me.  Then here's my plan:

- I'll need to drop previous patch "export wp_page_copy" since then
  it'll be not needed

- I'll introduce another patch to split current do_wp_page() and
  introduce function "wp_page_copy_cont" (better suggestion on the
  naming would be welcomed) which contains most of the wp handling
  that'll be needed for change_pte_range() in this patch and isolate
  the uffd handling:

static vm_fault_t do_wp_page(struct vm_fault *vmf)
	__releases(vmf->ptl)
{
	struct vm_area_struct *vma = vmf->vma;

	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
		pte_unmap_unlock(vmf->pte, vmf->ptl);
		return handle_userfault(vmf, VM_UFFD_WP);
	}

	return do_wp_page_cont(vmf);
}

Then I can probably use do_wp_page_cont() in this patch.

Thanks,

-- 
Peter Xu
