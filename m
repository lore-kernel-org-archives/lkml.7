Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9476F208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 01:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="qNSbQf4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfHKBcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 21:32:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40596 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHKBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 21:32:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so46441946pla.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xDbdhPQ3QT7gF9yHOSPbJa8hYNyqWu2iQmr6Xb0YzUA=;
        b=qNSbQf4q28lHSOKSvi+eAA78dUYvFPX9rJCfEplQ4Z2aSSFGg3Nb9Rk1hLvpFiapB9
         LVTHjAPonjlFWPuwTolGzJhJLsNPucQEZ0LUNoDJaqec8qPKBwLZRu7Fj44fc4cFjOom
         IU6mWfxAX7aox+P7Qqm5RnLv70xxgPrVuF7QzL52X01r8h5M2EbF4DK7V45kjINdHSqf
         gZNx5aQ5bXmq8HjLY42FAYFG6DJ6OQYJbq1qmsnpykIj1MW71cj+iCMMBls8ww212b48
         A1Lgil3AiZK36Mo37rOAxeBn5bvfiE3kTN25iG560apIB/9rI8rNPMtzVy0LASeJQtjW
         kULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xDbdhPQ3QT7gF9yHOSPbJa8hYNyqWu2iQmr6Xb0YzUA=;
        b=BB/NwGh5fgazOumND76M3WQjtPz7Ind/97ldKsaXBrhD4GRV/7SXbGz/WuFxBpPwo5
         6saOtzvMbuiaK2bNBVG4rdvaj7PSadXCyr+Q8Hm8KikWnsb/itT7ffkkJYuHiNRK4qmj
         V+mFgvqFPdZLm9QJdo9LdjNmCzpyp9/rbZnlcS2L01BAgZIjZQr+l/bQN7aUoT4brfi0
         oh7dXtjguxOqwkqsP1Jigz0LtXLs7zFeO4c9yymfSreF52En/wvcQEXe7WWgxONZyDZA
         EAlFZztRtBfeTIA3pJeTrYIwp/Ab03RQHVoARA88ceY9ScUE/zY8YlTWktdhDAGpUXpo
         dJsA==
X-Gm-Message-State: APjAAAXOFL5GSTEplcb+QM7V4DrulUcgoj+ukyI5oAWIc7umUbL7uDY5
        yjPGgwNsHj1Tsnuu8u9LA37A2Q==
X-Google-Smtp-Source: APXvYqzaQlGlI3jqb5AY7EeLc6Mh9LKfAj2eQ8o/ZNlKoLUwacolB1HYd1iDASAP51gabqn4/ndXEw==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr26575152plp.61.1565487160141;
        Sat, 10 Aug 2019 18:32:40 -0700 (PDT)
Received: from localhost ([183.82.18.139])
        by smtp.gmail.com with ESMTPSA id v27sm146159299pgn.76.2019.08.10.18.32.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 18:32:39 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
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
Subject: Re: [PATCH v8 3/7] powerpc/mce: Fix MCE handling for huge pages
In-Reply-To: <9b3e144e-8f12-de24-ff6a-ea599dc6e021@linux.vnet.ibm.com>
References: <20190807145700.25599-1-santosh@fossix.org> <20190807145700.25599-4-santosh@fossix.org> <9b3e144e-8f12-de24-ff6a-ea599dc6e021@linux.vnet.ibm.com>
Date:   Sun, 11 Aug 2019 07:02:36 +0530
Message-ID: <87pnlc8p1n.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 8/7/19 8:26 PM, Santosh Sivaraj wrote:
>> From: Balbir Singh <bsingharora@gmail.com>
>> 
>> The current code would fail on huge pages addresses, since the shift would
>> be incorrect. Use the correct page shift value returned by
>> __find_linux_pte() to get the correct physical address. The code is more
>> generic and can handle both regular and compound pages.
>> 
>> Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> [arbab@linux.ibm.com: Fixup pseries_do_memory_failure()]
>> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
>> Co-developed-by: Santosh Sivaraj <santosh@fossix.org>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>>  arch/powerpc/include/asm/mce.h       |  2 +-
>>  arch/powerpc/kernel/mce_power.c      | 50 ++++++++++++++--------------
>>  arch/powerpc/platforms/pseries/ras.c |  9 ++---
>>  3 files changed, 29 insertions(+), 32 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
>> index a4c6a74ad2fb..f3a6036b6bc0 100644
>> --- a/arch/powerpc/include/asm/mce.h
>> +++ b/arch/powerpc/include/asm/mce.h
>> @@ -209,7 +209,7 @@ extern void release_mce_event(void);
>>  extern void machine_check_queue_event(void);
>>  extern void machine_check_print_event_info(struct machine_check_event *evt,
>>  					   bool user_mode, bool in_guest);
>> -unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr);
>> +unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr);
>>  #ifdef CONFIG_PPC_BOOK3S_64
>>  void flush_and_reload_slb(void);
>>  #endif /* CONFIG_PPC_BOOK3S_64 */
>> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
>> index a814d2dfb5b0..bed38a8e2e50 100644
>> --- a/arch/powerpc/kernel/mce_power.c
>> +++ b/arch/powerpc/kernel/mce_power.c
>> @@ -20,13 +20,14 @@
>>  #include <asm/exception-64s.h>
>>  
>>  /*
>> - * Convert an address related to an mm to a PFN. NOTE: we are in real
>> - * mode, we could potentially race with page table updates.
>> + * Convert an address related to an mm to a physical address.
>> + * NOTE: we are in real mode, we could potentially race with page table updates.
>>   */
>> -unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>> +unsigned long addr_to_phys(struct pt_regs *regs, unsigned long addr)
>>  {
>> -	pte_t *ptep;
>> -	unsigned long flags;
>> +	pte_t *ptep, pte;
>> +	unsigned int shift;
>> +	unsigned long flags, phys_addr;
>>  	struct mm_struct *mm;
>>  
>>  	if (user_mode(regs))
>> @@ -35,14 +36,21 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>>  		mm = &init_mm;
>>  
>>  	local_irq_save(flags);
>> -	if (mm == current->mm)
>> -		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
>> -	else
>> -		ptep = find_init_mm_pte(addr, NULL);
>> +	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
>>  	local_irq_restore(flags);
>> +
>>  	if (!ptep || pte_special(*ptep))
>>  		return ULONG_MAX;
>> -	return pte_pfn(*ptep);
>> +
>> +	pte = *ptep;
>> +	if (shift > PAGE_SHIFT) {
>> +		unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
>> +
>> +		pte = __pte(pte_val(pte) | (addr & rpnmask));
>> +	}
>> +	phys_addr = pte_pfn(pte) << PAGE_SHIFT;
>> +
>> +	return phys_addr;
>>  }
>>  
>>  /* flush SLBs and reload */
>> @@ -354,18 +362,16 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
>
> Now that we have addr_to_phys() can we change this function name as well
> to mce_find_instr_ea_and_phys() ?

Makes sense, will avoid confusions.

>
> Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> This should go to stable tree. Can you move this patch to 2nd position ?

Thanks for testing. Sure. Will reorder and mark stable as well.

Thanks,
Santosh
>
> Thanks,
> -Mahesh.
>
