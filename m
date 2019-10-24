Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1655CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D59521D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439841AbfJXQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:24:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39128 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733261AbfJXQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:24:27 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iNfuB-0004s9-36; Thu, 24 Oct 2019 10:24:08 -0600
To:     Yash Shah <yash.shah@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "sorear2@gmail.com" <sorear2@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will@kernel.org" <will@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>
References: <1571908438-4802-1-git-send-email-yash.shah@sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4817ec1-4e50-5646-68f0-caeb0ab6f0bf@deltatee.com>
Date:   Thu, 24 Oct 2019 10:24:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571908438-4802-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: allison@lohutok.net, will@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org, greentime.hu@g.sifive.com, sachin.ghadi@sifive.com, rppt@linux.ibm.com, Anup.Patel@wdc.com, catalin.marinas@arm.com, alex@ghiti.fr, aou@eecs.berkeley.edu, sorear2@gmail.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@g.sifive.com, paul.walmsley@g.sifive.com, yash.shah@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] RISC-V: Add PCIe I/O BAR memory mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-24 3:14 a.m., Yash Shah wrote:
> For I/O BARs to work correctly on RISC-V Linux, we need to establish a
> reserved memory region for them, so that drivers that wish to use I/O BARs
> can issue reads and writes against a memory region that is mapped to the
> host PCIe controller's I/O BAR MMIO mapping.

I don't think other arches do this. ioremap() typically just uses
virtual address space in the VMALLOC region, PCI doesn't need it's own
range. As far as I know the ioremap() implementation in riscv already
does this.

In any case, 16MB for PCI bar space seems woefully inadequate.

Logan


> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/include/asm/io.h      | 7 +++++++
>  arch/riscv/include/asm/pgtable.h | 7 ++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index fc1189a..3ba4d93 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/types.h>
>  #include <asm/mmiowb.h>
> +#include <asm/pgtable.h>
>  
>  extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
>  
> @@ -162,6 +163,12 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #endif
>  
>  /*
> + *  I/O port access constants.
> + */
> +#define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
> +#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
> +
> +/*
>   * Emulation routines for the port-mapped IO space used by some PCI drivers.
>   * These are defined as being "fully synchronous", but also "not guaranteed to
>   * be fully ordered with respect to other memory and I/O operations".  We're
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7fc5e4a..d78cc74 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -7,6 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_H
>  
>  #include <linux/mmzone.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/pgtable-bits.h>
>  
> @@ -88,6 +89,7 @@ extern pgd_t swapper_pg_dir[];
>  #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
>  #define VMALLOC_END      (PAGE_OFFSET - 1)
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> +#define PCI_IO_SIZE      SZ_16M
>  
>  /*
>   * Roughly size the vmemmap space to be large enough to fit enough
> @@ -102,7 +104,10 @@ extern pgd_t swapper_pg_dir[];
>  
>  #define vmemmap		((struct page *)VMEMMAP_START)
>  
> -#define FIXADDR_TOP      (VMEMMAP_START)
> +#define PCI_IO_END       VMEMMAP_START
> +#define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
> +#define FIXADDR_TOP      PCI_IO_START
> +
>  #ifdef CONFIG_64BIT
>  #define FIXADDR_SIZE     PMD_SIZE
>  #else
> 
