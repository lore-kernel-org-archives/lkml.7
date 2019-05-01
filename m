Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5CBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46D720835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEAKsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:48:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfEAKsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:48:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32D8780D;
        Wed,  1 May 2019 03:48:05 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D26A3F719;
        Wed,  1 May 2019 03:48:03 -0700 (PDT)
Date:   Wed, 1 May 2019 11:48:01 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the kvm-arm
 tree
Message-ID: <20190501104758.GM3567@e103592.cambridge.arm.com>
References: <20190501160902.49dcf348@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501160902.49dcf348@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 04:09:02PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-ppc tree got a conflict in:
> 
>   include/uapi/linux/kvm.h
> 
> between commits:
> 
>   555f3d03e7fb ("KVM: arm64: Add a capability to advertise SVE support")
>   a243c16d18be ("KVM: arm64: Add capability to advertise ptrauth for guest")
> 
> from the kvm-arm tree and commit:
> 
>   eacc56bb9de3 ("KVM: PPC: Book3S HV: XIVE: Introduce a new capability KVM_CAP_PPC_IRQ_XIVE")
> 
> from the kvm-ppc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc include/uapi/linux/kvm.h
> index 4dc34f8e29f6,52bf74a1616e..000000000000
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@@ -988,9 -988,7 +988,10 @@@ struct kvm_ppc_resize_hpt 
>   #define KVM_CAP_ARM_VM_IPA_SIZE 165
>   #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
>   #define KVM_CAP_HYPERV_CPUID 167
>  -#define KVM_CAP_PPC_IRQ_XIVE 168
>  +#define KVM_CAP_ARM_SVE 168
>  +#define KVM_CAP_ARM_PTRAUTH_ADDRESS 169
>  +#define KVM_CAP_ARM_PTRAUTH_GENERIC 170
> ++#define KVM_CAP_PPC_IRQ_XIVE 171

Looks good to me.

Cheers
---Dave
