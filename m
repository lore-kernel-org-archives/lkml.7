Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD896C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716EC2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cee1tRDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDCE6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:58:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11910 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfDCE6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:58:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Yv462mQhz9v10H;
        Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cee1tRDV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b0OESs7l_U4k; Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Yv460ZLGz9v10G;
        Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554267526; bh=5Xx4genmEdABRp8M8MXS027ZxRTOx9uvlqGNm1L1b1w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cee1tRDVuPk9wSU+tEnnQ/bqtnIB5O5LeGWg8FraP8t+qFAlORylURzsAbMcexA+8
         rbq0YKaqgPsiURROfC97Dzbpi1QrJaIY8STSv1SrtJEOXOHVl4ivLJQtVHkBK/e0Si
         TvHGEndf7CYwgGWe2XUMvsFHDZCQPBHUv3IGPccE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD5C68B77E;
        Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fYq4xKXsmjq7; Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 455128B754;
        Wed,  3 Apr 2019 06:58:46 +0200 (CEST)
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        akpm@linux-foundation.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
Date:   Wed, 3 Apr 2019 06:58:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402204158.27582-6-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/04/2019 à 22:41, Daniel Jordan a écrit :
> With locked_vm now an atomic, there is no need to take mmap_sem as
> writer.  Delete and refactor accordingly.

Could you please detail the change ? It looks like this is not the only 
change. I'm wondering what the consequences are.

Before we did:
- lock
- calculate future value
- check the future value is acceptable
- update value if future value acceptable
- return error if future value non acceptable
- unlock

Now we do:
- atomic update with future (possibly too high) value
- check the new value is acceptable
- atomic update back with older value if new value not acceptable and 
return error

So if a concurrent action wants to increase locked_vm with an acceptable 
step while another one has temporarily set it too high, it will now fail.

I think we should keep the previous approach and do a cmpxchg after 
validating the new value.

Christophe

> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: <linux-mm@kvack.org>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>   arch/powerpc/mm/mmu_context_iommu.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index 8038ac24a312..a4ef22b67c07 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -54,34 +54,29 @@ struct mm_iommu_table_group_mem_t {
>   static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
>   		unsigned long npages, bool incr)
>   {
> -	long ret = 0, locked, lock_limit;
> +	long ret = 0;
> +	unsigned long lock_limit;
>   	s64 locked_vm;
>   
>   	if (!npages)
>   		return 0;
>   
> -	down_write(&mm->mmap_sem);
> -	locked_vm = atomic64_read(&mm->locked_vm);
>   	if (incr) {
> -		locked = locked_vm + npages;
>   		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> +		locked_vm = atomic64_add_return(npages, &mm->locked_vm);
> +		if (locked_vm > lock_limit && !capable(CAP_IPC_LOCK)) {
>   			ret = -ENOMEM;
> -		else
> -			atomic64_add(npages, &mm->locked_vm);
> +			atomic64_sub(npages, &mm->locked_vm);
> +		}
>   	} else {
> -		if (WARN_ON_ONCE(npages > locked_vm))
> -			npages = locked_vm;
> -		atomic64_sub(npages, &mm->locked_vm);
> +		locked_vm = atomic64_sub_return(npages, &mm->locked_vm);
> +		WARN_ON_ONCE(locked_vm < 0);
>   	}
>   
> -	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
> -			current ? current->pid : 0,
> -			incr ? '+' : '-',
> -			npages << PAGE_SHIFT,
> -			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
> +	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%lu %lld/%lu\n",
> +			current ? current->pid : 0, incr ? '+' : '-',
> +			npages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
>   			rlimit(RLIMIT_MEMLOCK));
> -	up_write(&mm->mmap_sem);
>   
>   	return ret;
>   }
> 
