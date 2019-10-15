Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122EDC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ABF20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJODQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:16:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:22884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfJODQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:16:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 20:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,297,1566889200"; 
   d="scan'208";a="208093307"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2019 20:16:19 -0700
Date:   Mon, 14 Oct 2019 20:16:19 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 02/14] KVM: monolithic: x86: disable linking vmx and svm
 at the same time into the kernel
Message-ID: <20191015031619.GD24895@linux.intel.com>
References: <20190928172323.14663-1-aarcange@redhat.com>
 <20190928172323.14663-3-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190928172323.14663-3-aarcange@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 01:23:11PM -0400, Andrea Arcangeli wrote:
> Linking both vmx and svm into the kernel at the same time isn't
> possible anymore or the kvm_x86/kvm_x86_pmu external function names
> would collide.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/Kconfig | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 840e12583b85..e1601c54355e 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -59,9 +59,29 @@ config KVM
>  
>  	  If unsure, say N.
>  
> +if KVM=y

Hmm, I see why the previous patch left KVM as a tristate.  I tried a
variety of hacks to let KVM be a bool but nothing worked.

> +
> +choice
> +	prompt "To link KVM statically into the kernel you need to choose"
> +	help
> +	  In order to build a kernel with support for both AMD and Intel
> +	  CPUs, you need to set CONFIG_KVM=m.
> +
> +config KVM_AMD_STATIC
> +	select KVM_AMD
> +	bool "Link KVM AMD statically into the kernel"
> +
> +config KVM_INTEL_STATIC
> +	select KVM_INTEL
> +	bool "Link KVM Intel statically into the kernel"

The prompt and choice text is way too long, e.g. in my usual window it
cuts off at:

  To link KVM statically into the kernel you need to choose (Link KVM Intel statically into

Without the full text (the -> at the end), it's not obvious it's an option
menu (AMD was selected by default for me and it took me a second to figure
out what to hit enter on).

I think short and sweet is enough for the prompt, with the details of how
build both buried in the help text.

choice
	prompt "KVM built-in support"
	help
	  Here be a long and detailed help text.

config KVM_AMD_STATIC
	select KVM_AMD
	bool "KVM AMD"

config KVM_INTEL_STATIC
	select KVM_INTEL
	bool "KVM Intel"

endchoice


The ends up looking like:

   <*>   Kernel-based Virtual Machine (KVM) support
           KVM built-in support (KVM Intel)  --->
   -*-   KVM for Intel processors support

> +
> +endchoice
> +
> +endif
> +
>  config KVM_INTEL
>  	tristate "KVM for Intel processors support"
> -	depends on KVM
> +	depends on (KVM && !KVM_AMD_STATIC) || KVM_INTEL_STATIC
>  	# for perf_guest_get_msrs():
>  	depends on CPU_SUP_INTEL
>  	---help---
> @@ -73,7 +93,7 @@ config KVM_INTEL
>  
>  config KVM_AMD
>  	tristate "KVM for AMD processors support"
> -	depends on KVM
> +	depends on (KVM && !KVM_INTEL_STATIC) || KVM_AMD_STATIC
>  	---help---
>  	  Provides support for KVM on AMD processors equipped with the AMD-V
>  	  (SVM) extensions.
