Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC95C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73C82070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfE0GXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:23:04 -0400
Received: from foss.arm.com ([217.140.101.70]:56244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE0GXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:23:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB861688;
        Sun, 26 May 2019 23:23:03 -0700 (PDT)
Received: from [10.162.40.17] (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794233F59C;
        Sun, 26 May 2019 23:23:01 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: mm: Implement pte_devmap support
To:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1558547956.git.robin.murphy@arm.com>
 <817d92886fc3b33bcbf6e105ee83a74babb3a5aa.1558547956.git.robin.murphy@arm.com>
 <20190524180805.GA9697@fuggles.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b94b23a7-4e6f-7787-aaa8-3c2d355fad03@arm.com>
Date:   Mon, 27 May 2019 11:53:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190524180805.GA9697@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/24/2019 11:38 PM, Will Deacon wrote:
> On Thu, May 23, 2019 at 04:03:16PM +0100, Robin Murphy wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 2c41b04708fe..a6378625d47c 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -90,6 +90,7 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>>  #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>>  #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
>> +#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
>>  
>>  #define pte_cont_addr_end(addr, end)						\
>>  ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
>> @@ -217,6 +218,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>>  }
>>  
>> +static inline pte_t pte_mkdevmap(pte_t pte)
>> +{
>> +	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
>> +}
>> +
>>  static inline void set_pte(pte_t *ptep, pte_t pte)
>>  {
>>  	WRITE_ONCE(*ptep, pte);
>> @@ -381,6 +387,9 @@ static inline int pmd_protnone(pmd_t pmd)
>>  
>>  #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
>>  
>> +#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
>> +#define pmd_mkdevmap(pmd)	pte_pmd(pte_mkdevmap(pmd_pte(pmd)))
>> +
>>  #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
>>  #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
>>  #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
>> @@ -537,6 +546,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>>  	return __pud_to_phys(pud);
>>  }
>>  
>> +static inline int pud_devmap(pud_t pud)
>> +{
>> +	return 0;
>> +}
>> +
>>  /* Find an entry in the second-level page table. */
>>  #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>>  
>> @@ -624,6 +638,11 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>>  
>>  #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
>>  
>> +static inline int pgd_devmap(pgd_t pgd)
>> +{
>> +	return 0;
>> +}
> 
> I think you need to guard this and pXd_devmap() with
> CONFIG_TRANSPARENT_HUGEPAGE, otherwise you'll conflict with the dummy
> definitions in mm.h and the build will fail.

Just curious why pgd_devmap() also needs to be wrapped in TRANSPARENT_HUGEPAGE
config (or use this dummy otherwise). IIUC in case of DAX mappings there can
never be a huge mapping at PGD level. It only supports PMD or PUD based ones.
