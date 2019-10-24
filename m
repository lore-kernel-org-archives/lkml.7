Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0BC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439470AbfJXLxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:53:03 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:58691 "EHLO
        7.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJXLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:53:03 -0400
X-Greylist: delayed 12499 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 07:53:02 EDT
Received: from player788.ha.ovh.net (unknown [10.109.159.69])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id D98AF138D5B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:04:46 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id CA63BB4D6960;
        Thu, 24 Oct 2019 07:04:07 +0000 (UTC)
Date:   Thu, 24 Oct 2019 09:04:03 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/45] KVM: PPC: Book3S HV: Uninit vCPU if vcore
 creation fails
Message-ID: <20191024090403.5e564e39@bahia.lan>
In-Reply-To: <20191022015925.31916-2-sean.j.christopherson@intel.com>
References: <20191022015925.31916-1-sean.j.christopherson@intel.com>
        <20191022015925.31916-2-sean.j.christopherson@intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5552375392181655889
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledtgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 18:58:41 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> Call kvm_vcpu_uninit() if vcore creation fails to avoid leaking any
> resources allocated by kvm_vcpu_init(), i.e. the vcpu->run page.
> 
> Fixes: 371fefd6f2dc4 ("KVM: PPC: Allow book3s_hv guests to use SMT processor modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 709cf1fd4cf4..36abbe3c346d 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2354,7 +2354,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  	mutex_unlock(&kvm->lock);
>  
>  	if (!vcore)
> -		goto free_vcpu;
> +		goto uninit_vcpu;
>  
>  	spin_lock(&vcore->lock);
>  	++vcore->num_threads;
> @@ -2371,6 +2371,8 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  
>  	return vcpu;
>  
> +uninit_vcpu:
> +	kvm_vcpu_uninit(vcpu);
>  free_vcpu:
>  	kmem_cache_free(kvm_vcpu_cache, vcpu);
>  out:

