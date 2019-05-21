Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092E52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfEUFPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:15:30 -0400
Received: from verein.lst.de ([213.95.11.211]:57345 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUFP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:15:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 71C1968B05; Tue, 21 May 2019 07:15:07 +0200 (CEST)
Date:   Tue, 21 May 2019 07:15:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/12] powerpc/pseries/svm: Force SWIOTLB for secure
 guests
Message-ID: <20190521051507.GD29120@lst.de>
References: <20190521044912.1375-1-bauerman@linux.ibm.com> <20190521044912.1375-12-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521044912.1375-12-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
> new file mode 100644
> index 000000000000..45d5e4d0e6e0
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mem_encrypt.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * SVM helper functions
> + *
> + * Copyright 2019 IBM Corporation
> + */
> +
> +#ifndef _ASM_POWERPC_MEM_ENCRYPT_H
> +#define _ASM_POWERPC_MEM_ENCRYPT_H
> +
> +#define sme_me_mask	0ULL
> +
> +static inline bool sme_active(void) { return false; }
> +static inline bool sev_active(void) { return false; }
> +
> +int set_memory_encrypted(unsigned long addr, int numpages);
> +int set_memory_decrypted(unsigned long addr, int numpages);
> +
> +#endif /* _ASM_POWERPC_MEM_ENCRYPT_H */

S/390 seems to be adding a stub header just like this.  Can you please
clean up the Kconfig and generic headers bits for memory encryption so
that we don't need all this boilerplate code?

>  config PPC_SVM
>  	bool "Secure virtual machine (SVM) support for POWER"
>  	depends on PPC_PSERIES
> +	select SWIOTLB
> +	select ARCH_HAS_MEM_ENCRYPT
>  	default n

n is the default default, no need to explictly specify it.
