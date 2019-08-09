Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A1C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A3214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406394AbfHITGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:06:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbfHITGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:06:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79J32Za113526
        for <linux-kernel@vger.kernel.org>; Fri, 9 Aug 2019 15:06:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9efsgfh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:06:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Fri, 9 Aug 2019 20:06:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 20:06:12 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79J6AoB48234732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 19:06:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 852B85204F;
        Fri,  9 Aug 2019 19:06:10 +0000 (GMT)
Received: from [9.102.2.183] (unknown [9.102.2.183])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 863E452051;
        Fri,  9 Aug 2019 19:06:08 +0000 (GMT)
Subject: Re: [PATCH v8 3/7] powerpc/mce: Fix MCE handling for huge pages
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
References: <20190807145700.25599-1-santosh@fossix.org>
 <20190807145700.25599-4-santosh@fossix.org>
From:   Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date:   Sat, 10 Aug 2019 00:36:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807145700.25599-4-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080919-0012-0000-0000-0000033CD158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080919-0013-0000-0000-00002176D860
Message-Id: <9b3e144e-8f12-de24-ff6a-ea599dc6e021@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 8:26 PM, Santosh Sivaraj wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> The current code would fail on huge pages addresses, since the shift would
> be incorrect. Use the correct page shift value returned by
> __find_linux_pte() to get the correct physical address. The code is more
> generic and can handle both regular and compound pages.
> 
> Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> [arbab@linux.ibm.com: Fixup pseries_do_memory_failure()]
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> Co-developed-by: Santosh Sivaraj <santosh@fossix.org>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/include/asm/mce.h       |  2 +-
>  arch/powerpc/kernel/mce_power.c      | 50 ++++++++++++++--------------
>  arch/powerpc/platforms/pseries/ras.c |  9 ++---
>  3 files changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index a4c6a74ad2fb..f3a6036b6bc0 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -209,7 +209,7 @@ extern void release_mce_event(void);
>  extern void machine_check_queue_event(void);
>  extern void machine_check_print_event_info(struct machine_check_event *evt,
>  					   bool user_mode, bool in_guest);
> -unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr);
> +unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr);
>  #ifdef CONFIG_PPC_BOOK3S_64
>  void flush_and_reload_slb(void);
>  #endif /* CONFIG_PPC_BOOK3S_64 */
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index a814d2dfb5b0..bed38a8e2e50 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -20,13 +20,14 @@
>  #include <asm/exception-64s.h>
>  
>  /*
> - * Convert an address related to an mm to a PFN. NOTE: we are in real
> - * mode, we could potentially race with page table updates.
> + * Convert an address related to an mm to a physical address.
> + * NOTE: we are in real mode, we could potentially race with page table updates.
>   */
> -unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
> +unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr)
>  {
> -	pte_t *ptep;
> -	unsigned long flags;
> +	pte_t *ptep, pte;
> +	unsigned int shift;
> +	unsigned long flags, phys_addr;
>  	struct mm_struct *mm;
>  
>  	if (user_mode(regs))
> @@ -35,14 +36,21 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>  		mm = &init_mm;
>  
>  	local_irq_save(flags);
> -	if (mm == current->mm)
> -		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
> -	else
> -		ptep = find_init_mm_pte(addr, NULL);
> +	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
>  	local_irq_restore(flags);
> +
>  	if (!ptep || pte_special(*ptep))
>  		return ULONG_MAX;
> -	return pte_pfn(*ptep);
> +
> +	pte = *ptep;
> +	if (shift > PAGE_SHIFT) {
> +		unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
> +
> +		pte = __pte(pte_val(pte) | (addr & rpnmask));
> +	}
> +	phys_addr = pte_pfn(pte) << PAGE_SHIFT;
> +
> +	return phys_addr;
>  }
>  
>  /* flush SLBs and reload */
> @@ -354,18 +362,16 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,

Now that we have addr_to_phys() can we change this function name as well
to mce_find_instr_ea_and_phys() ?

Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This should go to stable tree. Can you move this patch to 2nd position ?

Thanks,
-Mahesh.

