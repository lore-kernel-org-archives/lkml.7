Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA2C7D606
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942C324741
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfLMRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:50:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:29881 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbfLMRuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:50:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 09:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="415709726"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2019 09:50:31 -0800
Date:   Fri, 13 Dec 2019 09:50:31 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Barret Rhoden <brho@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20191213175031.GC31552@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
 <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 07:31:55PM +0200, Liran Alon wrote:
> 
> > On 13 Dec 2019, at 19:19, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > Then allowed_hugepage_adjust() would look something like:
> > 
> > static void allowed_hugepage_adjust(struct kvm_vcpu *vcpu, gfn_t gfn,
> > 				    kvm_pfn_t *pfnp, int *levelp, int max_level)
> > {
> > 	kvm_pfn_t pfn = *pfnp;
> > 	int level = *levelp;	
> > 	unsigned long mask;
> > 
> > 	if (is_error_noslot_pfn(pfn) || !kvm_is_reserved_pfn(pfn) ||
> > 	    level == PT_PAGE_TABLE_LEVEL)
> > 		return;
> > 
> > 	/*
> > 	 * mmu_notifier_retry() was successful and mmu_lock is held, so
> > 	 * the pmd/pud can't be split from under us.
> > 	 */
> > 	level = host_pfn_mapping_level(vcpu->kvm, gfn, pfn);
> > 
> > 	*levelp = level = min(level, max_level);
> > 	mask = KVM_PAGES_PER_HPAGE(level) - 1;
> > 	VM_BUG_ON((gfn & mask) != (pfn & mask));
> > 	*pfnp = pfn & ~mask;
> 
> Why don’t you still need to kvm_release_pfn_clean() for original pfn and
> kvm_get_pfn() for new huge-page start pfn?

That code is gone in kvm/queue.  thp_adjust() is now called from
__direct_map() and FNAME(fetch), and so its pfn adjustment doesn't bleed
back to the page fault handlers.  The only reason the put/get pfn code
existed was because the page fault handlers called kvm_release_pfn_clean()
on the pfn, i.e. they would have put the wrong pfn.
