Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51205C432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2223521D7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503378AbfIWWf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:35:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:21994 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503353AbfIWWf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:35:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 15:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="213480982"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2019 15:35:26 -0700
Date:   Mon, 23 Sep 2019 15:35:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] KVM: monolithic: x86: handle the
 request_immediate_exit variation
Message-ID: <20190923223526.GQ18195@linux.intel.com>
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-4-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920212509.2578-4-aarcange@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:24:55PM -0400, Andrea Arcangeli wrote:
> request_immediate_exit is one of those few cases where the pointer to
> function of the method isn't fixed at build time and it requires
> special handling because hardware_setup() may override it at runtime.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx_ops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx_ops.c b/arch/x86/kvm/vmx/vmx_ops.c
> index cdcad73935d9..25d441432901 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.c
> +++ b/arch/x86/kvm/vmx/vmx_ops.c
> @@ -498,7 +498,10 @@ int kvm_x86_ops_check_nested_events(struct kvm_vcpu *vcpu, bool external_intr)
>  
>  void kvm_x86_ops_request_immediate_exit(struct kvm_vcpu *vcpu)
>  {
> -	vmx_request_immediate_exit(vcpu);
> +	if (likely(enable_preemption_timer))
> +		vmx_request_immediate_exit(vcpu);
> +	else
> +		__kvm_request_immediate_exit(vcpu);

Rather than wrap this in VMX code, what if we instead take advantage of a
monolithic module and add an inline to query enable_preemption_timer?
That'd likely save a few CALL/RET/JMP instructions and eliminate
__kvm_request_immediate_exit.

E.g. something like:

	if (req_immediate_exit) {
		kvm_make_request(KVM_REQ_EVENT, vcpu);
		if (kvm_x86_has_request_immediate_exit())
			kvm_x86_request_immediate_exit(vcpu);
		else
			smp_send_reschedule(vcpu->cpu);
	}

>  }
>  
>  void kvm_x86_ops_sched_in(struct kvm_vcpu *kvm, int cpu)
