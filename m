Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A895C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B10620656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEHOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:20:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:60209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfEHOUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:20:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 07:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169650244"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 07:20:23 -0700
Date:   Wed, 8 May 2019 07:20:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Shier <pshier@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH v2] kvm: nVMX: Set nested_run_pending in
 vmx_set_nested_state after checks complete
Message-ID: <20190508142023.GA13834@linux.intel.com>
References: <1557317799-39866-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557317799-39866-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 02:16:39PM +0200, Paolo Bonzini wrote:
> From: Aaron Lewis <aaronlewis@google.com>

If this is actually attributed to Aaron it needs his SOB.

> nested_run_pending=1 implies we have successfully entered guest mode.
> Move setting from external state in vmx_set_nested_state() until after
> all other checks are complete.

It'd be helpful to at least mention the flag is consumed by
nested_vmx_enter_non_root_mode().

> Based on a patch by Aaron Lewis.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

For the code itself:

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com> 

>  arch/x86/kvm/vmx/nested.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cec77f30f61c..e58caff92694 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5420,9 +5420,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>  	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>  		return 0;
>  
> -	vmx->nested.nested_run_pending =
> -		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
> -
>  	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
>  	    vmcs12->vmcs_link_pointer != -1ull) {
>  		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
> @@ -5446,9 +5443,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>  		return -EINVAL;
>  
>  	vmx->nested.dirty_vmcs12 = true;
> +	vmx->nested.nested_run_pending =
> +		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
> +
>  	ret = nested_vmx_enter_non_root_mode(vcpu, false);
> -	if (ret)
> +	if (ret) {
> +		vmx->nested.nested_run_pending = 0;
>  		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 
