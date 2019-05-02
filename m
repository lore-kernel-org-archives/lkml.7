Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E576C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80A42085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEBMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:02:09 -0400
Received: from ozlabs.org ([203.11.71.1]:45015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:02:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vv5B0821z9s9N;
        Thu,  2 May 2019 22:02:05 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 01/17] powerpc/mm: Don't BUG() in hugepd_page()
In-Reply-To: <ff4366d14b3ef4de6af835a880a772477577139f.1556258135.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr> <ff4366d14b3ef4de6af835a880a772477577139f.1556258135.git.christophe.leroy@c-s.fr>
Date:   Thu, 02 May 2019 22:02:05 +1000
Message-ID: <87o94lxdxe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Use VM_BUG_ON() instead of BUG_ON(), as those BUG_ON()
> are not there to catch runtime errors but to catch errors
> during development cycle only.

I've dropped this one and the next, because I don't like VM_BUG_ON().

Why not? Because it's contradictory. It's a condition that's so
important that we should BUG, but only if the kernel has been built
specially for debugging.

I don't really buy the development cycle distinction, it's not like we
have a rigorous test suite that we run and then we declare everything's
gold and ship a product. We often don't find bugs until they're hit in
the wild.

For example the recent corruption Joel discovered with STRICT_KERNEL_RWX
could have been caught by a BUG_ON() to check we weren't patching kernel
text in radix__change_memory_range(), but he wouldn't have been using
CONFIG_DEBUG_VM. (See 8adddf349fda)

I know Aneesh disagrees with me on this, so maybe you two can convince
me otherwise.

cheers

> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 8d40565ad0c3..7f1867e428c0 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -14,7 +14,7 @@
>   */
>  static inline pte_t *hugepd_page(hugepd_t hpd)
>  {
> -	BUG_ON(!hugepd_ok(hpd));
> +	VM_BUG_ON(!hugepd_ok(hpd));
>  	/*
>  	 * We have only four bits to encode, MMU page size
>  	 */
> @@ -42,7 +42,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>  
>  static inline pte_t *hugepd_page(hugepd_t hpd)
>  {
> -	BUG_ON(!hugepd_ok(hpd));
> +	VM_BUG_ON(!hugepd_ok(hpd));
>  #ifdef CONFIG_PPC_8xx
>  	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
>  #else
> -- 
> 2.13.3
