Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BB3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F772054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHTNH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:07:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:59853 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbfHTNH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:07:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:07:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="180689683"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2019 06:07:54 -0700
Date:   Tue, 20 Aug 2019 21:09:24 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for
 SPP
Message-ID: <20190820130924.GC4828@local-michael-cet-test.sh.intel.com>
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-6-weijiang.yang@intel.com>
 <16b32cb7-9719-5744-d6c0-2846d3d5591c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b32cb7-9719-5744-d6c0-2846d3d5591c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:13:47PM +0200, Paolo Bonzini wrote:
> On 14/08/19 09:03, Yang Weijiang wrote:
> >  static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
> >  	.cpu_has_kvm_support = cpu_has_kvm_support,
> >  	.disabled_by_bios = vmx_disabled_by_bios,
> > @@ -7740,6 +7783,11 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
> >  	.get_vmcs12_pages = NULL,
> >  	.nested_enable_evmcs = NULL,
> >  	.need_emulation_on_page_fault = vmx_need_emulation_on_page_fault,
> > +
> > +	.get_spp_status = vmx_get_spp_status,
> > +	.get_subpages = vmx_get_subpages,
> > +	.set_subpages = vmx_set_subpages,
> > +	.init_spp = vmx_init_spp,
> >  };
> 
> There's no need for the get_subpages kvm_x86_ops.  You do need init_spp
> of course, but you do not need get_spp_status either; instead you can
> check if init_spp is NULL (if NULL, SPP is not supported).
So first set .init_spp = NULL, then if all SPP preconditions meet, set
.init_spp = vmx_init_spp?

> In addition, kvm_mmu_set_subpages should not set up the SPP pages.  This
> should be handled entirely by handle_spp when the processor reports an
> SPPT miss, so you do not need that callback either.  You may need a
> flush_subpages callback, called by kvm_mmu_set_subpages to clear the SPP
> page tables for a given GPA range.  The next access then will cause an
> SPPT miss.
Good suggestion, thanks! Will do change.

> Finally, please move all SPP-related code to arch/x86/kvm/vmx/{spp.c,spp.h}.
>
Sure.

> Thanks,
> 
> Paolo
> 
 
