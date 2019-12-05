Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B4DC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9F124651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575539671;
	bh=dP0yih1DextManN7eGzyZTOvVNUJSR4AjG5eS1tS0Tw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=Wz3+NTTTpATby2rtfUb39w+I0A3Bo6zbl7xWih9nitnOELiC01zCNClfa3cUjiTFu
	 c1huboYYU/32ZgCiAF0GZ2OwPRHNP0s88KM1zVFoVnJIn3CvNB5NWWGXlDmmLFePdn
	 u2lV1gWlYeruJxDMewI853heA89n3Hzs5lyVxbUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfLEJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:54:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37836 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729460AbfLEJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:54:14 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icnpr-0003j1-Co; Thu, 05 Dec 2019 10:54:11 +0100
To:     Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 1/3] KVM: arm64: pmu: Don't increment  =?UTF-8?Q?SW=5FINCR=20if=20PMCR=2EE=20is=20unset?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 09:54:11 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <eric.auger.pro@gmail.com>, <linux-kernel@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>, <james.morse@arm.com>,
        <andrew.murray@arm.com>, <suzuki.poulose@arm.com>,
        <drjones@redhat.com>
In-Reply-To: <20191204204426.9628-2-eric.auger@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-2-eric.auger@redhat.com>
Message-ID: <b84fb5e660e313eb790a8c53853ea36e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-04 20:44, Eric Auger wrote:
> The specification says PMSWINC increments PMEVCNTR<n>_EL1 by 1
> if PMEVCNTR<n>_EL0 is enabled and configured to count SW_INCR.
>
> For PMEVCNTR<n>_EL0 to be enabled, we need both PMCNTENSET to
> be set for the corresponding event counter but we also need
> the PMCR.E bit to be set.
>
> Fixes: 7a0adc7064b8 ("arm64: KVM: Add access handler for PMSWINC 
> register")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  virt/kvm/arm/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 8731dfeced8b..c3f8b059881e 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -486,6 +486,9 @@ void kvm_pmu_software_increment(struct kvm_vcpu
> *vcpu, u64 val)
>  	if (val == 0)
>  		return;
>
> +	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
> +		return;
> +
>  	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
>  	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
>  		if (!(val & BIT(i)))

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
