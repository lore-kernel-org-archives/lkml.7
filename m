Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A62C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CA020821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfDPQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:30:55 -0400
Received: from foss.arm.com ([217.140.101.70]:59296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:30:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A27E015A2;
        Tue, 16 Apr 2019 09:30:54 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04FD13F59C;
        Tue, 16 Apr 2019 09:30:52 -0700 (PDT)
Date:   Tue, 16 Apr 2019 17:30:50 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/5] KVM: arm64: Add a vcpu flag to control ptrauth
 for guest
Message-ID: <20190416163050.GV3567@e103592.cambridge.arm.com>
References: <1555039236-10608-1-git-send-email-amit.kachhap@arm.com>
 <1555039236-10608-2-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555039236-10608-2-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 08:50:32AM +0530, Amit Daniel Kachhap wrote:
> A per vcpu flag is added to check if pointer authentication is
> enabled for the vcpu or not. This flag may be enabled according to
> the necessary user policies and host capabilities.
> 
> This patch also adds a helper to check the flag.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
> 
> Changes since v8:
> * Added a new per vcpu flag which will store Pointer Authentication enable
>   status instead of checking them again. [Dave Martin]
> 
>  arch/arm64/include/asm/kvm_host.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 9d57cf8..31dbc7c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -355,10 +355,14 @@ struct kvm_vcpu_arch {
>  #define KVM_ARM64_HOST_SVE_ENABLED	(1 << 4) /* SVE enabled for EL0 */
>  #define KVM_ARM64_GUEST_HAS_SVE		(1 << 5) /* SVE exposed to guest */
>  #define KVM_ARM64_VCPU_SVE_FINALIZED	(1 << 6) /* SVE config completed */
> +#define KVM_ARM64_GUEST_HAS_PTRAUTH	(1 << 7) /* PTRAUTH exposed to guest */
>  
>  #define vcpu_has_sve(vcpu) (system_supports_sve() && \
>  			    ((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_SVE))
>  
> +#define vcpu_has_ptrauth(vcpu)	\
> +			((vcpu)->arch.flags & KVM_ARM64_GUEST_HAS_PTRAUTH)
> +
>  #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
>  
>  /*
> -- 
> 2.7.4
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
