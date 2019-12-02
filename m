Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D657720833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfLBTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:30:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:54608 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfLBTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:30:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 11:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="242075360"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2019 11:30:28 -0800
Date:   Mon, 2 Dec 2019 11:30:27 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 03/15] KVM: Add build-time error check on kvm_run size
Message-ID: <20191202193027.GH4063@linux.intel.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129213505.18472-4-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 04:34:53PM -0500, Peter Xu wrote:
> It's already going to reach 2400 Bytes (which is over half of page
> size on 4K page archs), so maybe it's good to have this build-time
> check in case it overflows when adding new fields.

Please explain why exceeding PAGE_SIZE is a bad thing.  I realize it's
almost absurdly obvious when looking at the code, but a) the patch itself
does not provide that context and b) the changelog should hold up on its
own, e.g. in a mostly hypothetical case where the allocation of vcpu->run
were changed to something else.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8f8940cc4b84..681452d288cd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -352,6 +352,8 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  	}
>  	vcpu->run = page_address(page);
>  
> +	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
> +
>  	kvm_vcpu_set_in_spin_loop(vcpu, false);
>  	kvm_vcpu_set_dy_eligible(vcpu, false);
>  	vcpu->preempted = false;
> -- 
> 2.21.0
> 
