Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2515C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8738620811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556194456;
	bh=UNNZCP7UnE2TdH6vnYMm+8CBug89tFMvyQRVRDKUFuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zWCLvpIab3J9REeABmbUse97gLxzz0427MkyKnW0KdXqGy+3foiwBHGuFi01Nz2p6
	 TMlhFPPkQhZPCvm5weXjI31P6OH2L4sBWJ2w+HySt/+2uEctHPjjEZMENoqG7IAlrZ
	 UTZxXu4HGxqhDKReoyVfKCiIv8dS8CcKHxdf5WeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbfDYMOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387612AbfDYMOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:14:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B40E5ADC8;
        Thu, 25 Apr 2019 12:14:10 +0000 (UTC)
Date:   Thu, 25 Apr 2019 14:14:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH V2] mm: Allow userland to request that the kernel clear
 memory on release
Message-ID: <20190425121410.GC1144@dhcp22.suse.cz>
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190424211038.204001-1-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424211038.204001-1-matthewgarrett@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc linux-api for user visible API proposals (now done). Keep the
rest of the email intact for reference.

On Wed 24-04-19 14:10:39, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> Applications that hold secrets and wish to avoid them leaking can use
> mlock() to prevent the page from being pushed out to swap and
> MADV_DONTDUMP to prevent it from being included in core dumps. Applications
> can also use atexit() handlers to overwrite secrets on application exit.
> However, if an attacker can reboot the system into another OS, they can
> dump the contents of RAM and extract secrets. We can avoid this by setting
> CONFIG_RESET_ATTACK_MITIGATION on UEFI systems in order to request that the
> firmware wipe the contents of RAM before booting another OS, but this means
> rebooting takes a *long* time - the expected behaviour is for a clean
> shutdown to remove the request after scrubbing secrets from RAM in order to
> avoid this.
> 
> Unfortunately, if an application exits uncleanly, its secrets may still be
> present in RAM. This can't be easily fixed in userland (eg, if the OOM
> killer decides to kill a process holding secrets, we're not going to be able
> to avoid that), so this patch adds a new flag to madvise() to allow userland
> to request that the kernel clear the covered pages whenever the page
> reference count hits zero. Since vm_flags is already full on 32-bit, it
> will only work on 64-bit systems.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Modified to wipe when the VMA is released rather than on page freeing
> 
>  include/linux/mm.h                     |  6 ++++++
>  include/uapi/asm-generic/mman-common.h |  2 ++
>  mm/madvise.c                           | 21 +++++++++++++++++++++
>  mm/memory.c                            |  3 +++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6b10c21630f5..64bdab679275 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -257,6 +257,8 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>  #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +
> +#define VM_WIPEONRELEASE BIT(37)       /* Clear pages when releasing them */
>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -298,6 +300,10 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_GROWSUP	VM_NONE
>  #endif
>  
> +#ifndef VM_WIPEONRELEASE
> +# define VM_WIPEONRELEASE VM_NONE
> +#endif
> +
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index abd238d0f7a4..82dfff4a8e3d 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -64,6 +64,8 @@
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
>  
> +#define MADV_WIPEONRELEASE 20
> +#define MADV_DONTWIPEONRELEASE 21
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 21a7881a2db4..989c2fde15cf 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -92,6 +92,22 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  	case MADV_KEEPONFORK:
>  		new_flags &= ~VM_WIPEONFORK;
>  		break;
> +	case MADV_WIPEONRELEASE:
> +		/* MADV_WIPEONRELEASE is only supported on anonymous memory. */
> +		if (VM_WIPEONRELEASE == 0 || vma->vm_file ||
> +		    vma->vm_flags & VM_SHARED) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +		new_flags |= VM_WIPEONRELEASE;
> +		break;
> +	case MADV_DONTWIPEONRELEASE:
> +		if (VM_WIPEONRELEASE == 0) {
> +			error = -EINVAL;
> +			goto out;
> +		}
> +		new_flags &= ~VM_WIPEONRELEASE;
> +		break;
>  	case MADV_DONTDUMP:
>  		new_flags |= VM_DONTDUMP;
>  		break;
> @@ -727,6 +743,8 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DODUMP:
>  	case MADV_WIPEONFORK:
>  	case MADV_KEEPONFORK:
> +	case MADV_WIPEONRELEASE:
> +	case MADV_DONTWIPEONRELEASE:
>  #ifdef CONFIG_MEMORY_FAILURE
>  	case MADV_SOFT_OFFLINE:
>  	case MADV_HWPOISON:
> @@ -785,6 +803,9 @@ madvise_behavior_valid(int behavior)
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_WIPEONRELEASE - clear the contents of the memory after the last
> + *		reference to it has been released
> + *  MADV_DONTWIPEONRELEASE - cancel MADV_WIPEONRELEASE
>   *
>   * return values:
>   *  zero    - success
> diff --git a/mm/memory.c b/mm/memory.c
> index ab650c21bccd..ff78b527660e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1091,6 +1091,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			page_remove_rmap(page, false);
>  			if (unlikely(page_mapcount(page) < 0))
>  				print_bad_pte(vma, addr, ptent, page);
> +			if (unlikely(vma->vm_flags & VM_WIPEONRELEASE) &&
> +			    page_mapcount(page) == 0)
> +				clear_highpage(page);
>  			if (unlikely(__tlb_remove_page(tlb, page))) {
>  				force_flush = 1;
>  				addr += PAGE_SIZE;
> -- 
> 2.21.0.593.g511ec345e18-goog

-- 
Michal Hocko
SUSE Labs
