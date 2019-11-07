Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75039C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC63214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ez26eB0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfKGK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:29:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGK36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:29:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47805b3GX7z9sPT;
        Thu,  7 Nov 2019 21:29:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573122595;
        bh=a4m1nWotTG2jewKpNRdw9eW8MeOxKL/KXr8bS4jNwEw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ez26eB0/Hao264oY8mdCEcLSGzesBH8ckKBuWVZsrTh7FwY+3G0FRpQcMW8t07TIL
         GxNEm5xTZqeXEz/Oge1/J59c/E03qxZuVJKwy5G52tt5n75byMSGD078yUa5X+WFeU
         jDJXX5hY6t9FhEANapoy+TL4hGXNpYWoe7eiypzProrFH+5clfz5BLdQgJOdh6jWTp
         uShCQT5qGdJROGj3Yv4OrneWx0IRvISROWJ7LC0GVYLQ/sqZiVa6FkMAFyCIW2DdVN
         /tk6hZpqkJw9/rPKaKSxObLxRbuQ7EDWVWPouPRR6KrI63QH1o8ucesuGyBhHK//Z0
         8Yqlq6lO/s81g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        linuxram@us.ibm.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor.
In-Reply-To: <1572902923-8096-2-git-send-email-linuxram@us.ibm.com>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com> <1572902923-8096-2-git-send-email-linuxram@us.ibm.com>
Date:   Thu, 07 Nov 2019 21:29:54 +1100
Message-ID: <87h83g568t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> writes:
> The hypervisor needs to access the contents of the page holding the TCE
> entries while setting up the TCE entries in the IOMMU's TCE table. For
> SecureVMs, since this page is encrypted, the hypervisor cannot access
> valid entries. Share the page with the hypervisor. This ensures that the
> hypervisor sees the valid entries.

Can you please give people some explanation of why this is safe. After
all the point of the Ultravisor is to protect the guest from a malicious
hypervisor. Giving the hypervisor access to a page of TCEs sounds
dangerous, so please explain why it's not.

cheers

> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 8d9c2b1..07f0847 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -37,6 +37,7 @@
>  #include <asm/mmzone.h>
>  #include <asm/plpar_wrappers.h>
>  #include <asm/svm.h>
> +#include <asm/ultravisor.h>
>  
>  #include "pseries.h"
>  
> @@ -179,6 +180,19 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  
>  static DEFINE_PER_CPU(__be64 *, tce_page);
>  
> +/*
> + * Allocate a tce page.  If secure VM, share the page with the hypervisor.
> + */
> +static __be64 *alloc_tce_page(void)
> +{
> +	__be64 *tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> +
> +	if (tcep && is_secure_guest())
> +		uv_share_page(PHYS_PFN(__pa(tcep)), 1);
> +
> +	return tcep;
> +}
> +
>  static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  				     long npages, unsigned long uaddr,
>  				     enum dma_data_direction direction,
> @@ -206,8 +220,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  	 * from iommu_alloc{,_sg}()
>  	 */
>  	if (!tcep) {
> -		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> -		/* If allocation fails, fall back to the loop implementation */
> +		tcep = alloc_tce_page();
>  		if (!tcep) {
>  			local_irq_restore(flags);
>  			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
> @@ -391,6 +404,7 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
>  	return rc;
>  }
>  
> +
>  static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
>  					unsigned long num_pfn, const void *arg)
>  {
> @@ -405,7 +419,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
>  	tcep = __this_cpu_read(tce_page);
>  
>  	if (!tcep) {
> -		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> +		tcep = alloc_tce_page();
>  		if (!tcep) {
>  			local_irq_enable();
>  			return -ENOMEM;
> -- 
> 1.8.3.1
