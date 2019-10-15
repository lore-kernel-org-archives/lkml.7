Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D721BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17FE20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfJOPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:23:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:37513 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfJOPXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:23:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 08:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="220454839"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Oct 2019 08:23:05 -0700
Date:   Tue, 15 Oct 2019 08:23:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 02/14] KVM: monolithic: x86: disable linking vmx and svm
 at the same time into the kernel
Message-ID: <20191015152305.GB15015@linux.intel.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-3-aarcange@redhat.com>
 <20191015031619.GD24895@linux.intel.com>
 <94f1e36e-90b8-8b7d-57a5-031c65e415c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f1e36e-90b8-8b7d-57a5-031c65e415c4@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:21:59AM +0200, Paolo Bonzini wrote:
> On 15/10/19 05:16, Sean Christopherson wrote:
> > I think short and sweet is enough for the prompt, with the details of how
> > build both buried in the help text.
> > 
> > choice
> > 	prompt "KVM built-in support"
> > 	help
> > 	  Here be a long and detailed help text.
> > 
> > config KVM_AMD_STATIC
> > 	select KVM_AMD
> > 	bool "KVM AMD"
> > 
> > config KVM_INTEL_STATIC
> > 	select KVM_INTEL
> > 	bool "KVM Intel"
> 
> Or even just
> 
> 	bool "AMD"
> 	...
> 	bool "Intel"

Ya.

> > endchoice
> > 
> > The ends up looking like:
> > 
> >    <*>   Kernel-based Virtual Machine (KVM) support
> >            KVM built-in support (KVM Intel)  --->
> >    -*-   KVM for Intel processors support
> 
> On top of this, it's also nice to hide the KVM_INTEL/KVM_AMD prompts if
> linking statically.  You can achieve that with
> 
> config KVM_INTEL
>     tristate
>     prompt "KVM for Intel processors support" if KVM=m

That's painfully obvious now that I see it.  I always forget about putting
conditionals at the end...

>     depends on (KVM=m && m) || KVM_INTEL_STATIC
> 
> config KVM_AMD
>     tristate
>     prompt "KVM for AMD processors support" if KVM=m
>     depends on (KVM=m && m) || KVM_AMD_STATIC
> 
> The left side of the "||" ensures that, if KVM=m, you can only choose
> module build for both KVM_INTEL and KVM_AMD.  Having just "depends on
> KVM" would allow a pre-existing .config to choose the now-invalid
> combination
> 
> 	CONFIG_KVM=y
> 	CONFIG_KVM_INTEL=y
> 	CONFIG_KVM_AMD=y
> 
> The right side of the "||" part is just for documentation, to avoid that
> a selected symbol does not satisfy its dependencies.
> 
> Thanks,
> 
> Paolo
