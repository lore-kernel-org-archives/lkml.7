Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5679C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CC32084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gb5wc+hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfKGK0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:26:34 -0500
Received: from ozlabs.org ([203.11.71.1]:38627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGK0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:26:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47801f5SWCz9sPT;
        Thu,  7 Nov 2019 21:26:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573122391;
        bh=ubT6PqHfq+AeskgzniFZvOikXlHxhlqZ5cQjsrS0lnQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gb5wc+hWL6b3Ya0OtGZix/sJtUue+204GeoQas8US15HICstxZ6MRb2umgOieCFtU
         tWQs99Bxp0Yj0OgxFyw4ItXJq4B85MoXu32FHmXJJtfQiAdj9aPEQuBwaVDllUDxP9
         MlFZLvd+TSUoWnRv7YTnrRClNDLH+hhP9lW0oGcog0c7uzG6s7VUjNqKW16QFJzZz4
         Un9NpYnNSvlucUMGeg00xE+Az8F/e3URCB2Vmrgw9mC+/DpXJ4g6RLVQUSmjbstMi8
         Q1ima+wUoaMn0mwroazcEZk4jB2LBbwIrH7yCZRdQn4SD1BvK3hc26dAmxSnzbKCP8
         xJKrpXUcxgaIg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        linuxram@us.ibm.com, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs aswell.
In-Reply-To: <1572902923-8096-3-git-send-email-linuxram@us.ibm.com>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com> <1572902923-8096-2-git-send-email-linuxram@us.ibm.com> <1572902923-8096-3-git-send-email-linuxram@us.ibm.com>
Date:   Thu, 07 Nov 2019 21:26:28 +1100
Message-ID: <87k18c56ej.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> writes:
> This enables IOMMU support for pseries Secure VMs.

Can you give us some more explanation please?

This is basically a revert of commit:
  edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on secure guests")

But neglects to remove the now unnecessary include of svm.h.

> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 07f0847..189717b 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1333,15 +1333,7 @@ void iommu_init_early_pSeries(void)
>  	of_reconfig_notifier_register(&iommu_reconfig_nb);
>  	register_memory_notifier(&iommu_mem_nb);
>  
> -	/*
> -	 * Secure guest memory is inacessible to devices so regular DMA isn't
> -	 * possible.
> -	 *
> -	 * In that case keep devices' dma_map_ops as NULL so that the generic
> -	 * DMA code path will use SWIOTLB to bounce buffers for DMA.

Please explain what has changed to make this no longer necessary.

cheers

> -	 */
> -	if (!is_secure_guest())
> -		set_pci_dma_ops(&dma_iommu_ops);
> +	set_pci_dma_ops(&dma_iommu_ops);
>  }
>  
>  static int __init disable_multitce(char *str)
> -- 
> 1.8.3.1
