Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9361FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6315120B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfIWQNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:13:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:43957 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbfIWQNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:13:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 09:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="213374766"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2019 09:13:52 -0700
Date:   Mon, 23 Sep 2019 09:13:52 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] KVM: monolithic: x86: convert the kvm_x86_ops
 methods to external functions
Message-ID: <20190923161352.GC18195@linux.intel.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-3-aarcange@redhat.com>
 <9b188fb8-b930-047f-d1c0-fe27cbe27338@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b188fb8-b930-047f-d1c0-fe27cbe27338@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:19:30PM +0200, Paolo Bonzini wrote:
> On 20/09/19 23:24, Andrea Arcangeli wrote:
> > diff --git a/arch/x86/kvm/svm_ops.c b/arch/x86/kvm/svm_ops.c
> > new file mode 100644
> > index 000000000000..2aaabda92179
> > --- /dev/null
> > +++ b/arch/x86/kvm/svm_ops.c
> > @@ -0,0 +1,672 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  arch/x86/kvm/svm_ops.c
> > + *
> > + *  Copyright 2019 Red Hat, Inc.
> > + */
> > +
> > +int kvm_x86_ops_cpu_has_kvm_support(void)
> > +{
> > +	return has_svm();
> > +}
> 
> Can you just rename all the functions in vmx/ and svm.c, instead of
> adding forwarders?

Yeah, having kvm_x86_ be analogous to kvm_arch_ seems like the obvious
approach.  The necessary VMX and SVM renaming can be done in separate
preparatory patches, and the conversion from kvm_x86_ops to direct calls
would be fairly straightforward.

Alternatively, what if we use macros in the call sites, e.g. keep/require
vmx_ and svm_ prefixes for all functions, renaming VMX and SVM code as
needed?  E.g.:

  cpu_has_vmx_support -> vmx_supported_by_cpu 
  cpu_has_svm_support -> svm_supported_by_cpu

  int vmx_disabled_by_bios(void)
  int svm_disabled_by_bios(void)


  #define X86_OP(name) kvm_x86_vendor##_##name

  int kvm_arch_init(void *opaque)
  {
	if (X86_OP(supported_by_cpu())) {
		printk(KERN_ERR "kvm: no hardware support\n");
		r = -EOPNOTSUPP;
		goto out;
	}
	if (X86_OP(disabled_by_bios())) {
		printk(KERN_ERR "kvm: disabled by bios\n");
		r = -EOPNOTSUPP;
		goto out;
	}	
  }

Pros:
  - Smaller patches due to less renaming in VMX and SVM
  - Calls to vendor code are very obvious
  - Stack traces contain vmx vs. svm instead of kvm_x86

Cons:
  - Macros
  - Annoying development environment, e.g. editors tend to struggle with
    macrofied funtion/variable names.
