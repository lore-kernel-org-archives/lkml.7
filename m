Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99ED2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfDBPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:53:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53534 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD894374;
        Tue,  2 Apr 2019 08:53:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3793F3F721;
        Tue,  2 Apr 2019 08:53:09 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:53:07 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] kvm: arm: Skip stage2 huge mappings for unaligned ipa
 backed by THP
Message-ID: <20190402155307.GE53702@e119886-lin.cambridge.arm.com>
References: <1554203176-3958-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554203176-3958-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:06:16PM +0100, Suzuki K Poulose wrote:
> With commit a80868f398554842b14, we no longer ensure that the
> THP page is properly aligned in the guest IPA. Skip the stage2
> huge mapping for unaligned IPA backed by transparent hugepages.
> 
> Fixes: a80868f398554842b14 ("KVM: arm/arm64: Enforce PTE mappings at stage2 when needed")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Chirstoffer Dall <christoffer.dall@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Zheng Xiang <zhengxiang9@huawei.com>
> Tested-by: Eric Auger <eric.auger@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 27c9583..4a22f5b 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1412,7 +1412,9 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
>  		 * page accordingly.
>  		 */
>  		mask = PTRS_PER_PMD - 1;
> -		VM_BUG_ON((gfn & mask) != (pfn & mask));
> +		/* Skip memslots with unaligned IPA and user address */
> +		if ((gfn & mask) != (pfn & mask))
> +			return false;
>  		if (pfn & mask) {
>  			*ipap &= PMD_MASK;
>  			kvm_release_pfn_clean(pfn);
> -- 
> 2.7.4

I was able to reproduce this issue on v5.1-rc3 on a SoftIron Overdrive 1000
(AMD Seattle (Rev.B1)) with defconfig+ARM64_64K_PAGES with:

qemu-system-aarch64 -cpu host -machine type=virt,accel=kvm -nographic -smp 4
-m 4096 -kernel /boot/vmlinuz-4.9.0-7-arm64 --append "console=ttyAMA0
default_hugepagesz=2M hugepages=256"

The 'default_hugepagesz=2M hugepages=256' had no effect on the reproducibility,
however the guest only intermittently failed to boot. Applying the above
patch fixed this and the guest boots every time.

Tested-by: Andrew Murray <andrew.murray@arm.com>

Thanks,

Andrew Murray

> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
