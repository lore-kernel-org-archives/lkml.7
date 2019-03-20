Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8372146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCTNiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:38:13 -0400
Received: from foss.arm.com ([217.140.101.70]:40234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTNiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:38:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7A871650;
        Wed, 20 Mar 2019 06:38:11 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D6AF3F59C;
        Wed, 20 Mar 2019 06:38:08 -0700 (PDT)
Subject: Re: [PATCH v7 9/10] KVM: arm64: docs: document KVM support of pointer
 authentication
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
References: <1552984243-7689-1-git-send-email-amit.kachhap@arm.com>
 <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <7bf19035-02ba-ae47-b08c-7d7622a45dbf@arm.com>
Date:   Wed, 20 Mar 2019 13:37:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1552984243-7689-10-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 19/03/2019 08:30, Amit Daniel Kachhap wrote:
> This adds sections for KVM API extension for pointer authentication.
> A brief description about usage of pointer authentication for KVM guests
> is added in the arm64 documentations.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  Documentation/arm64/pointer-authentication.txt | 15 +++++++++++----
>  Documentation/virtual/kvm/api.txt              |  6 ++++++
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index 5baca42..4b769e6 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -87,7 +87,14 @@ used to get and set the keys for a thread.
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> -the feature will result in an UNDEFINED exception being injected into
> -the guest.
> +Pointer authentication is enabled in KVM guest when each virtual cpu is
> +initialised by passing flags KVM_ARM_VCPU_PTRAUTH_[ADDRESS/GENERIC] and
> +requesting this feature to be enabled. Without this flag, pointer

"Without these flags"*

> +authentication is not enabled in KVM guests and attempted use of the
> +feature will result in an UNDEFINED exception being injected into the
> +guest.
> +
> +Additionally, when these vcpu feature flags are not set then KVM will
> +filter out the Pointer Authentication system key registers from
> +KVM_GET/SET_REG_* ioctls and mask those features from cpufeature ID
> +register.
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 7de9eee..b5c66bc 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2659,6 +2659,12 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>  	  Depends on KVM_CAP_ARM_PMU_V3.
> +	- KVM_ARM_VCPU_PTRAUTH_ADDRESS:
> +	- KVM_ARM_VCPU_PTRAUTH_GENERIC:
> +	  Enables Pointer authentication for the CPU.
> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> +	  set, then the KVM guest allows the execution of pointer authentication
> +	  instructions. Otherwise, KVM treats these instructions as undefined.
>  

Overall I feel one could easily get confused to whether
PTRAUTH_ADDRESS/GENERIC are two individual features, whether one is a
superset of the other, if the names are just an alias of one another, etc...

I think the doc should at least stress out that *both* flags are
required to enable ptrauth in a guest. However it raises the question,
if we don't plan to support the features individually (because we
can't), should we really expose two feature flags? I seems odd to
introduce two flags that only do something if used together...

Cheers,

-- 
Julien Thierry
