Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A25C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C9218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCLXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:23:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfGCLXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6045E344;
        Wed,  3 Jul 2019 04:23:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76C263F703;
        Wed,  3 Jul 2019 04:23:17 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:23:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: mm: Fix dead assignment of old_pte
Message-ID: <20190703112139.GA29570@lakrids.cambridge.arm.com>
References: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
 <20190702234135.78780-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702234135.78780-1-nhuck@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:41:35PM -0700, Nathan Huckleberry wrote:
> When analyzed with the clang static analyzer the
> following warning occurs
> 
> line 251, column 2
> Value stored to 'old_pte' is never read
> 
> This warning is repeated every time pgtable.h is
> included by another file and produces ~3500
> extra warnings.
> 
> Moving old_pte into preprocessor guard.
> 
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
> Changes from v1 -> v2
> * Added scope to avoid [-Wdeclaration-after-statement]
>  arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)

As Will asked, does this also trigger in linux-next?

I rewrote this code to avoid to only perform the READ_ONCE() when we'd
use the value, and IIUC that may be sufficient to avoid the warning:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=9b604722059039a1a3ff69fb8dfd024264046024

Thanks,
Mark.

> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index fca26759081a..12b7f08db40d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -238,8 +238,6 @@ extern void __sync_icache_dcache(pte_t pteval);
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
> -	pte_t old_pte;
> -
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
>  
> @@ -248,16 +246,23 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	 * hardware updates of the pte (ptep_set_access_flags safely changes
>  	 * valid ptes without going through an invalid entry).
>  	 */
> -	old_pte = READ_ONCE(*ptep);
> -	if (IS_ENABLED(CONFIG_DEBUG_VM) && pte_valid(old_pte) && pte_valid(pte) &&
> -	   (mm == current->active_mm || atomic_read(&mm->mm_users) > 1)) {
> -		VM_WARN_ONCE(!pte_young(pte),
> -			     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> -			     __func__, pte_val(old_pte), pte_val(pte));
> -		VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
> -			     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> -			     __func__, pte_val(old_pte), pte_val(pte));
> +	#if IS_ENABLED(CONFIG_DEBUG_VM)
> +	{
> +		pte_t old_pte;
> +
> +		old_pte = READ_ONCE(*ptep);
> +		if (pte_valid(old_pte) && pte_valid(pte) &&
> +		  (mm == current->active_mm ||
> +		   atomic_read(&mm->mm_users) > 1)) {
> +			VM_WARN_ONCE(!pte_young(pte),
> +				     "%s: racy access flag clearing: 0x%016llx -> 0x%016llx",
> +				     __func__, pte_val(old_pte), pte_val(pte));
> +			VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
> +				     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
> +				     __func__, pte_val(old_pte), pte_val(pte));
> +		}
>  	}
> +	#endif
>  
>  	set_pte(ptep, pte);
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
