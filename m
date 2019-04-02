Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D16EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DE020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfDBOvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:51:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:3064 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfDBOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:51:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="219845310"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2019 07:51:09 -0700
Date:   Tue, 2 Apr 2019 07:51:09 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: move KVM_CAP_NR_MEMSLOTS to common code
Message-ID: <20190402145109.GA29004@linux.intel.com>
References: <1553793000-53968-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553793000-53968-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:10:00PM +0100, Paolo Bonzini wrote:
> All architectures except MIPS were defining it in the same way,
> and memory slots are handled entirely by common code so there
> is no point in keeping the definition per-architecture.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt | 5 ++---
>  arch/powerpc/kvm/powerpc.c        | 3 ---
>  arch/s390/kvm/kvm-s390.c          | 3 ---
>  arch/x86/kvm/x86.c                | 3 ---
>  virt/kvm/arm/arm.c                | 3 ---
>  virt/kvm/kvm_main.c               | 2 ++
>  6 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 67068c47c591..b62ad0d94234 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1117,9 +1117,8 @@ struct kvm_userspace_memory_region {
>  This ioctl allows the user to create, modify or delete a guest physical
>  memory slot.  Bits 0-15 of "slot" specify the slot id and this value
>  should be less than the maximum number of user memory slots supported per
> -VM.  The maximum allowed slots can be queried using KVM_CAP_NR_MEMSLOTS,
> -if this capability is supported by the architecture.  Slots may not
> -overlap in guest physical address space.
> +VM.  The maximum allowed slots can be queried using KVM_CAP_NR_MEMSLOTS.
> +Slots may not overlap in guest physical address space.

Nit: s/may/must in that last sentence while you're at it?

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  
>  If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 of "slot"
>  specifies the address space which is being modified.  They must be
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 8885377ec3e0..92910b7c5bcc 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -644,9 +644,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		else
>  			r = num_online_cpus();
>  		break;
> -	case KVM_CAP_NR_MEMSLOTS:
> -		r = KVM_USER_MEM_SLOTS;
> -		break;
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4638303ba6a8..28f35d2b06cb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -513,9 +513,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		else if (sclp.has_esca && sclp.has_64bscao)
>  			r = KVM_S390_ESCA_CPU_SLOTS;
>  		break;
> -	case KVM_CAP_NR_MEMSLOTS:
> -		r = KVM_USER_MEM_SLOTS;
> -		break;
>  	case KVM_CAP_S390_COW:
>  		r = MACHINE_HAS_ESOP;
>  		break;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 099b851dabaf..9b64d3359c93 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3073,9 +3073,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> -	case KVM_CAP_NR_MEMSLOTS:
> -		r = KVM_USER_MEM_SLOTS;
> -		break;
>  	case KVM_CAP_PV_MMU:	/* obsolete */
>  		r = 0;
>  		break;
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 99c37384ba7b..be4ec5f3ba5f 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -224,9 +224,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> -	case KVM_CAP_NR_MEMSLOTS:
> -		r = KVM_USER_MEM_SLOTS;
> -		break;
>  	case KVM_CAP_MSI_DEVID:
>  		if (!kvm)
>  			r = -EINVAL;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 55fe8e20d8fd..31c28e0b067c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3061,6 +3061,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  #endif
>  	case KVM_CAP_MAX_VCPU_ID:
>  		return KVM_MAX_VCPU_ID;
> +	case KVM_CAP_NR_MEMSLOTS:
> +		return KVM_USER_MEM_SLOTS;
>  	default:
>  		break;
>  	}
> -- 
> 1.8.3.1
> 
