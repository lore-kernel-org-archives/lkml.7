Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0653FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11C320821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfDPQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:32:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfDPQcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:32:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D23080D;
        Tue, 16 Apr 2019 09:32:16 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07A53F59C;
        Tue, 16 Apr 2019 09:32:14 -0700 (PDT)
Date:   Tue, 16 Apr 2019 17:32:12 +0100
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
Subject: Re: [PATCH v9 4/5] KVM: arm64: Add capability to advertise ptrauth
 for guest
Message-ID: <20190416163212.GX3567@e103592.cambridge.arm.com>
References: <1555039236-10608-1-git-send-email-amit.kachhap@arm.com>
 <1555039236-10608-5-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555039236-10608-5-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 08:50:35AM +0530, Amit Daniel Kachhap wrote:
> This patch advertises the capability of two cpu feature called address
> pointer authentication and generic pointer authentication. These
> capabilities depend upon system support for pointer authentication and
> VHE mode.
> 
> The current arm64 KVM partially implements pointer authentication and
> support of address/generic authentication are tied together. However,
> separate ABI requirements for both of them is added so that any future
> isolated implementation will not require any ABI changes.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
> Changes since v8:
> *  Keep the capability check same for the 2 vcpu ptrauth features. [Dave Martin]
> 
>  Documentation/virtual/kvm/api.txt | 2 ++
>  arch/arm64/kvm/reset.c            | 5 +++++
>  include/uapi/linux/kvm.h          | 2 ++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 9d202f4..56021d0 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2756,9 +2756,11 @@ Possible features:
>  	- KVM_ARM_VCPU_PTRAUTH_ADDRESS: Enables Address Pointer authentication
>  	  for the CPU and supported only on arm64 architecture.
>  	  Must be requested if KVM_ARM_VCPU_PTRAUTH_GENERIC is also requested.
> +	  Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.

What if KVM_CAP_ARM_PTRAUTH_ADDRESS is absent and
KVM_ARM_VCPU_PTRAUTH_GENERIC is requested?  By these rules, we have a
contradiction: userspace both must request and must not request
KVM_ARM_VCPU_PTRAUTH_ADDRESS.

We could qualify as follows:

	Depends on KVM_CAP_ARM_PTRAUTH_ADDRESS.
	Must be requested if KVM_CAP_ARM_PTRAUTH_ADDRESS is present and
	KVM_ARM_VCPU_PTRAUTH_GENERIC is also requested.

>  	- KVM_ARM_VCPU_PTRAUTH_GENERIC: Enables Generic Pointer authentication
>  	  for the CPU and supported only on arm64 architecture.
>  	  Must be requested if KVM_ARM_VCPU_PTRAUTH_ADDRESS is also requested.
> +	  Depends on KVM_CAP_ARM_PTRAUTH_GENERIC.

Similarly.

Or, we go back to having a single cap and a single feature, and add
more caps/features later on if we decide it's possible to support
address/generic auth separately later on.

Otherwise, we end up with complex rules that can't be tested.  This is a
high price to pay for forwards compatibility: userspace's conformance to
the rules can't be fully tested, so there's a fair chance it won't work
properly anyway when hardware/KVM with just one auth type appears.

[...]

Thoughts?

Cheers
---Dave
