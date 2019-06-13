Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A4CC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E233206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfFMP0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729195AbfFMLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:45:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DBh49I028836
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:45:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3ky85dfx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:45:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 13 Jun 2019 12:44:54 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 12:44:48 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DBilLX6160570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 11:44:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97E7A405F;
        Thu, 13 Jun 2019 11:44:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4BDDA4054;
        Thu, 13 Jun 2019 11:44:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.162])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Jun 2019 11:44:45 +0000 (GMT)
Date:   Thu, 13 Jun 2019 14:44:44 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 1/3] arm64: map FDT as RW for early_init_dt_scan()
References: <20190612043258.166048-1-hsinyi@chromium.org>
 <20190612043258.166048-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612043258.166048-2-hsinyi@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19061311-4275-0000-0000-00000341FE8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061311-4276-0000-0000-000038521813
Message-Id: <20190613114443.GA25164@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:32:58PM +0800, Hsin-Yi Wang wrote:
> Currently in arm64, FDT is mapped to RO before it's passed to
> early_init_dt_scan(). However, there might be some codes
> (eg. commit "fdt: add support for rng-seed") that need to modify FDT
> during init. Map FDT to RO after early fixups are done.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> change log v5->v6:
> * no change.
> ---
>  arch/arm64/include/asm/mmu.h |  2 +-
>  arch/arm64/kernel/kaslr.c    |  5 +----
>  arch/arm64/kernel/setup.c    |  9 ++++++++-
>  arch/arm64/mm/mmu.c          | 15 +--------------
>  4 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 67ef25d037ea..27f6f17aae36 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -137,7 +137,7 @@ extern void init_mem_pgprot(void);
>  extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			       unsigned long virt, phys_addr_t size,
>  			       pgprot_t prot, bool page_mappings_only);
> -extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
> +extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
>  
>  #define INIT_MM_CONTEXT(name)	\
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 06941c1fe418..92bb53460401 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -65,9 +65,6 @@ static __init const u8 *kaslr_get_cmdline(void *fdt)
>  	return default_cmdline;
>  }
>  
> -extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
> -				       pgprot_t prot);
> -
>  /*
>   * This routine will be executed with the kernel mapped at its default virtual
>   * address, and if it returns successfully, the kernel will be remapped, and
> @@ -96,7 +93,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  	 * attempt at mapping the FDT in setup_machine()
>  	 */
>  	early_fixmap_init();
> -	fdt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
> +	fdt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
>  	if (!fdt)
>  		return 0;
>  
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566405d1..6a7050319b5b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -181,9 +181,13 @@ static void __init smp_build_mpidr_hash(void)
>  
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
> -	void *dt_virt = fixmap_remap_fdt(dt_phys);
> +	int size;
> +	void *dt_virt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
>  	const char *name;
>  
> +	if (dt_virt)
> +		memblock_reserve(dt_phys, size);
> +
>  	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>  		pr_crit("\n"
>  			"Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
> @@ -195,6 +199,9 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  			cpu_relax();
>  	}
>  
> +	/* Early fixups are done, map the FDT as read-only now */
> +	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> +
>  	name = of_flat_dt_get_machine_name();
>  	if (!name)
>  		return;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 93ed0df4df79..5d01365a4333 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -887,7 +887,7 @@ void __set_fixmap(enum fixed_addresses idx,
>  	}
>  }
>  
> -void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
> +void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  {
>  	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
>  	int offset;
> @@ -940,19 +940,6 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  	return dt_virt;
>  }
>  
> -void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
> -{
> -	void *dt_virt;
> -	int size;
> -
> -	dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> -	if (!dt_virt)
> -		return NULL;
> -
> -	memblock_reserve(dt_phys, size);
> -	return dt_virt;
> -}
> -
>  int __init arch_ioremap_pud_supported(void)
>  {
>  	/*
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

