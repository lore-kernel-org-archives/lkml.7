Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D06C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA022133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 09:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfEYJbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 05:31:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbfEYJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:31:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4P9SB6e015961
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 05:31:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sq1sj9yyf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 05:31:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 25 May 2019 10:30:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 25 May 2019 10:30:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4P9UqPT61014152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 May 2019 09:30:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7C6611C054;
        Sat, 25 May 2019 09:30:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0478411C04A;
        Sat, 25 May 2019 09:30:51 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 25 May 2019 09:30:50 +0000 (GMT)
Date:   Sat, 25 May 2019 12:30:49 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
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
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 1/3] amr64: map FDT as RW for early_init_dt_scan()
References: <20190519160446.320-1-hsinyi@chromium.org>
 <5ce73503.1c69fb81.5f889.1d84@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce73503.1c69fb81.5f889.1d84@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19052509-0028-0000-0000-000003714C55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052509-0029-0000-0000-00002431045F
Message-Id: <20190525093048.GB31026@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905250067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:04:18PM -0700, Stephen Boyd wrote:
> Quoting Hsin-Yi Wang (2019-05-19 09:04:44)
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index a170c6369a68..29648e86f7e5 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -940,12 +940,12 @@ void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
> >         return dt_virt;
> >  }
> >  
> > -void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
> > +void *__init fixmap_remap_fdt(phys_addr_t dt_phys, pgprot_t prot)
> >  {
> >         void *dt_virt;
> >         int size;
> >  
> > -       dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> > +       dt_virt = __fixmap_remap_fdt(dt_phys, &size, prot);
> >         if (!dt_virt)
> >                 return NULL;
> >  
> 
> Sorry, I'm still confused why we want to call memblock_reserve() again.
> Why not avoid it?
 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 67ef25d037ea..d0d9de9da5c1 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -137,7 +137,7 @@ extern void init_mem_pgprot(void);
>  extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			       unsigned long virt, phys_addr_t size,
>  			       pgprot_t prot, bool page_mappings_only);
> -extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
> +extern void *__fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);

I'd drop '__' prefix from __fixmap_remap_fdt is it's the only function to
remain.
Otherwise makes perfect sense.

>  extern void mark_linear_text_alias_ro(void);
>  
>  #define INIT_MM_CONTEXT(name)	\
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index b09b6f75f759..0701c2cf1534 100644
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
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 413d566405d1..3e97354566ff 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -181,9 +181,13 @@ static void __init smp_build_mpidr_hash(void)
>  
>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  {
> -	void *dt_virt = fixmap_remap_fdt(dt_phys);
> +	int size;
> +	void *dt_virt = __fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
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
> +	__fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> +
>  	name = of_flat_dt_get_machine_name();
>  	if (!name)
>  		return;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a170c6369a68..ddf6086cd9dd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
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
>  	/* only 4k granule supports level 1 block mappings */
> 

-- 
Sincerely yours,
Mike.

