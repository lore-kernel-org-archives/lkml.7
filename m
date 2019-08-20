Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DFBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16DA2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfHTASI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHTASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46CBG53TVsz9s4Y;
        Tue, 20 Aug 2019 10:18:05 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 08/10] powerpc/mm: move __ioremap_at() and __iounmap_at() into ioremap.c
In-Reply-To: <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr> <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
Date:   Tue, 20 Aug 2019 10:18:00 +1000
Message-ID: <87tvac666f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 57d742509cec..889ee656cf64 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -103,3 +103,46 @@ void iounmap(volatile void __iomem *token)
>  	vunmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
> +
> +#ifdef CONFIG_PPC64
> +/**
> + * __ioremap_at - Low level function to establish the page tables
> + *                for an IO mapping
> + */
> +void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
> +{
> +	/* We don't support the 4K PFN hack with ioremap */
> +	if (pgprot_val(prot) & H_PAGE_4K_PFN)
> +		return NULL;
> +
> +	if ((ea + size) >= (void *)IOREMAP_END) {
> +		pr_warn("Outside the supported range\n");
> +		return NULL;
> +	}
> +
> +	WARN_ON(pa & ~PAGE_MASK);
> +	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
> +	WARN_ON(size & ~PAGE_MASK);
> +
> +	if (ioremap_range((unsigned long)ea, pa, size, prot, NUMA_NO_NODE))

This doesn't build.

Adding ...

extern int ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, pgprot_t prot, int nid);

... above, until the next patch, fixes it.

cheers
