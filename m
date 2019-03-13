Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A67C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A362075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCMQUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:20:38 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:42006 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:20:38 -0400
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h46cN-0008P8-3S; Wed, 13 Mar 2019 16:20:35 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h46cK-0004Yp-Jn; Wed, 13 Mar 2019 16:20:33 +0000
Subject: Re: [PATCH] um: define set_pte_at() as a static inline function, not
 a macro
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190313101439.7092-1-brgl@bgdev.pl>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <ba8a9e10-cd10-c847-af2b-c41f31cf5f30@cambridgegreys.com>
Date:   Wed, 13 Mar 2019 16:20:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313101439.7092-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/2019 10:14, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> When defined as macro, the mm argument is unused and subsequently the
> variable passed as mm is considered unused by the compiler. This fixes
> a build warning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/um/include/asm/pgtable.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 9c04562310b3..b377df76cc28 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -263,7 +263,12 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
>   	*pteptr = pte_mknewpage(*pteptr);
>   	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
>   }
> -#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
> +
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *pteptr, pte_t pteval)
> +{
> +	set_pte(pteptr, pteval);
> +}
>   
>   #define __HAVE_ARCH_PTE_SAME
>   static inline int pte_same(pte_t pte_a, pte_t pte_b)
> 
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
