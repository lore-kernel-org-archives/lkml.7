Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55314C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D5021823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575632633;
	bh=7Pm9MaZt86Xv+5NGCVZ52/IHn2x0TE1yZLZt81xfGuY=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=ZDcgy0TscrRqYbEqITgT9nT2QJYh3wu9dxQr4/lXBwMmvMbhxVhauLLC+eCh8Rmfi
	 YgGXa6Ji1QxIVc1VnsyI6pQxAFCIaJW5AjlR/lZ875plqt91BkMNT0VyOsK9kldTzR
	 0itT1vnGvVAohg2rtnXvf92/q20n6gytQOuVZfZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFLnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:43:52 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35708 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfLFLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:43:51 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1idC1U-0001s8-GU; Fri, 06 Dec 2019 12:43:48 +0100
To:     Jia He <justin.he@arm.com>
Subject: Re: [PATCH] KVM: arm: remove excessive permission check in  =?UTF-8?Q?kvm=5Farch=5Fprepare=5Fmemory=5Fregion?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 11:43:48 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
In-Reply-To: <20191206020802.196108-1-justin.he@arm.com>
References: <20191206020802.196108-1-justin.he@arm.com>
Message-ID: <128917a0fe502137f7575932bbf48fd0@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: justin.he@arm.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-06 02:08, Jia He wrote:
> In kvm_arch_prepare_memory_region, arm kvm regards the memory region 
> as
> writable if the flag has no KVM_MEM_READONLY, and the vm is readonly 
> if
> !VM_WRITE.
>
> But there is common usage for setting kvm memory region as follows:
> e.g. qemu side (see the PROT_NONE flag)
> 1. mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>    memory_region_init_ram_ptr()
> 2. re mmap the above area with read/write authority.
>
> Such example is used in virtio-fs qemu codes which hasn't been 
> upstreamed
> [1]. But seems we can't forbid this example.
>
> Without this patch, it will cause an EPERM during 
> kvm_set_memory_region()
> and cause qemu boot crash.
>
> As told by Ard, "the underlying assumption is incorrect, i.e., that 
> the
> value of vm_flags at this point in time defines how the VMA is used
> during its lifetime. There may be other cases where a VMA is created
> with VM_READ vm_flags that are changed to VM_READ|VM_WRITE later, and
> we are currently rejecting this use case as well."
>
> [1]
> 
> https://gitlab.com/virtio-fs/qemu/blob/5a356e/hw/virtio/vhost-user-fs.c#L488
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 38b4c910b6c3..a48994af70b8 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -2301,15 +2301,6 @@ int kvm_arch_prepare_memory_region(struct kvm 
> *kvm,
>  		if (!vma || vma->vm_start >= reg_end)
>  			break;
>
> -		/*
> -		 * Mapping a read-only VMA is only allowed if the
> -		 * memory region is configured as read-only.
> -		 */
> -		if (writable && !(vma->vm_flags & VM_WRITE)) {
> -			ret = -EPERM;
> -			break;
> -		}
> -
>  		/*
>  		 * Take the intersection of this VMA with the memory region
>  		 */

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
