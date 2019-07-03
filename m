Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBCAC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47801218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGCIbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:31:07 -0400
Received: from foss.arm.com ([217.140.110.172]:40972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfGCIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:31:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8526344;
        Wed,  3 Jul 2019 01:31:06 -0700 (PDT)
Received: from [10.1.28.153] (unknown [10.1.28.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C108F3F718;
        Wed,  3 Jul 2019 01:31:05 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: mm: Fix dead assignment of old_pte
To:     Nathan Huckleberry <nhuck@google.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CAJkfWY4yvVVmJoQ0WwyoFBkWYsUJnnQPNU+-g23-m-L3ETe_hQ@mail.gmail.com>
 <20190702234135.78780-1-nhuck@google.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <1895c6b5-645d-6a63-d486-efa20d6879db@arm.com>
Date:   Wed, 3 Jul 2019 09:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702234135.78780-1-nhuck@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/19 12:41 AM, Nathan Huckleberry wrote:
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

I'm wondering if it is a case for __maybe_unused?

Something like:

-       pte_t old_pte;
+       pte_t __maybe_unused old_pte;


Cheers
Vladimir


> 
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
> Changes from v1 -> v2
> * Added scope to avoid [-Wdeclaration-after-statement]
>  arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
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
> 

