Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA455C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA95C2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="YSP7XlpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfLEOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:08:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:45132 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfLEOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:08:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id r11so1335764pjp.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gDPaTgf8omrU7t5A7U4CSa0w+DMkgZN9EG6vHr/qYkw=;
        b=YSP7XlpR2jJ7qCKyKlGeGTKNGaIJuuFdmrfOw19RyX8iEXsgcnk3K/q0SsrsWSPXo3
         xs7UU7shhfC6KRV1pJfAWCc1rOROffV3+7afWsBdLjun4bJwylWpJ5qGMFBybIJfNtL0
         V9/YDFf75kg42W296KYmdgpwI/Xa1KJaLBDEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gDPaTgf8omrU7t5A7U4CSa0w+DMkgZN9EG6vHr/qYkw=;
        b=Mj9yVlyQ0QaqNUM9rFiequxWXyXjx8Mxf4tS9vZu1YRB2+wdBwVVVg9yTFMafamtuG
         zEfh1dafMn5vjnPwmvTUQ5HqbtCAaWIOp+t0iO+ceeJ9B6DuEqhf5PBDFw0oHukNLapy
         uhR/C/j2ESyNcJcK6HvVTlC/pIejtjN9K/0YCWLOpKu6DSuB2HOz0VRCryDc6PXGQmqf
         zxFLSLE6dmLadOKLDu6p/Z4EahzOtOdpVrcbctHXlEFYxq4ktOZRext4PZssqWmOxSTM
         PxTGA3sRLwAHSVnrPpgxyTuMN2GQJTx4Zi6Io7FRfN8dldhu8ZyfkwwmV9iibDvN/jBV
         mnBA==
X-Gm-Message-State: APjAAAVVOIzGMCXOcctg2SZlcs9AAuC5enSLj6B3x1+cTC0enIZ3xQT7
        fUR5i4kAXvXa552CsgVq+lKkwADsfPM=
X-Google-Smtp-Source: APXvYqx2OuJizyreJW2uKgN4cgwgLo7td5SIERtcLheczecEWOStUAIOpWbG0OB6XPz1Otxk3fGjTg==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr9477111pjn.119.1575554886778;
        Thu, 05 Dec 2019 06:08:06 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-61b9-031c-bed1-3502.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:61b9:31c:bed1:3502])
        by smtp.gmail.com with ESMTPSA id n26sm11980521pgd.46.2019.12.05.06.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:08:05 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 2/2] kasan: Don't allocate page tables in kasan_release_vmalloc()
In-Reply-To: <87eexjekml.fsf@dja-thinkpad.axtens.net>
References: <20191204204534.32202-1-aryabinin@virtuozzo.com> <20191204204534.32202-2-aryabinin@virtuozzo.com> <87eexjekml.fsf@dja-thinkpad.axtens.net>
Date:   Fri, 06 Dec 2019 01:08:02 +1100
Message-ID: <87y2vqdfwd.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
>
> Ah you beat me by a few hours, I was going to send a similar but
> slightly simpler patch - we should be able to use apply_to_page_range
> for the 'inner' part of the range and just walk the page table for the
> possible pages on the edges of the range. That means we could avoid a
> full, loop-driven page table walker. But I'd also be very open to
> generalising apply_to_page_range(); I think I'd add
> apply_to_existing_pages() and add an argument to the static walker
> functions.
>
> Let me try that out and we'll see what it looks like.

I had a go, it's here:

https://lore.kernel.org/linux-mm/20191205140407.1874-1-dja@axtens.net/T/#t

I think it's ugly but not so ugly as to not be worth it. There's also
another patch for syzkaller bugs that Dmitry picked up as patch 3 of the
series, it works and is needed whether you want to go with my approach
or Andrey's.

Regards,
Daniel

>
> Regards,
> Daniel
>
>> The purpose of kasan_release_vmalloc() is to unmap and deallocate shadow
>> memory. The usage of apply_to_page_range() isn't suitable in that scenario
>> because it allocates pages to fill missing page tables entries.
>> This also cause sleep in atomic bug:
>>
>> 	BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
>> 	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15087, name:
>>
>> 	Call Trace:
>> 	 __dump_stack lib/dump_stack.c:77 [inline]
>> 	 dump_stack+0x199/0x216 lib/dump_stack.c:118
>> 	 ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
>> 	 __might_sleep+0x95/0x190 kernel/sched/core.c:6753
>> 	 prepare_alloc_pages mm/page_alloc.c:4681 [inline]
>> 	 __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
>> 	 alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
>> 	 alloc_pages include/linux/gfp.h:532 [inline]
>> 	 __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
>> 	 __pte_alloc_one_kernel include/asm-generic/pgalloc.h:21 [inline]
>> 	 pte_alloc_one_kernel include/asm-generic/pgalloc.h:33 [inline]
>> 	 __pte_alloc_kernel+0x1d/0x200 mm/memory.c:459
>> 	 apply_to_pte_range mm/memory.c:2031 [inline]
>> 	 apply_to_pmd_range mm/memory.c:2068 [inline]
>> 	 apply_to_pud_range mm/memory.c:2088 [inline]
>> 	 apply_to_p4d_range mm/memory.c:2108 [inline]
>> 	 apply_to_page_range+0x77d/0xa00 mm/memory.c:2133
>> 	 kasan_release_vmalloc+0xa7/0xc0 mm/kasan/common.c:970
>> 	 __purge_vmap_area_lazy+0xcbb/0x1f30 mm/vmalloc.c:1313
>> 	 try_purge_vmap_area_lazy mm/vmalloc.c:1332 [inline]
>> 	 free_vmap_area_noflush+0x2ca/0x390 mm/vmalloc.c:1368
>> 	 free_unmap_vmap_area mm/vmalloc.c:1381 [inline]
>> 	 remove_vm_area+0x1cc/0x230 mm/vmalloc.c:2209
>> 	 vm_remove_mappings mm/vmalloc.c:2236 [inline]
>> 	 __vunmap+0x223/0xa20 mm/vmalloc.c:2299
>> 	 __vfree+0x3f/0xd0 mm/vmalloc.c:2356
>> 	 __vmalloc_area_node mm/vmalloc.c:2507 [inline]
>> 	 __vmalloc_node_range+0x5d5/0x810 mm/vmalloc.c:2547
>> 	 __vmalloc_node mm/vmalloc.c:2607 [inline]
>> 	 __vmalloc_node_flags mm/vmalloc.c:2621 [inline]
>> 	 vzalloc+0x6f/0x80 mm/vmalloc.c:2666
>> 	 alloc_one_pg_vec_page net/packet/af_packet.c:4233 [inline]
>> 	 alloc_pg_vec net/packet/af_packet.c:4258 [inline]
>> 	 packet_set_ring+0xbc0/0x1b50 net/packet/af_packet.c:4342
>> 	 packet_setsockopt+0xed7/0x2d90 net/packet/af_packet.c:3695
>> 	 __sys_setsockopt+0x29b/0x4d0 net/socket.c:2117
>> 	 __do_sys_setsockopt net/socket.c:2133 [inline]
>> 	 __se_sys_setsockopt net/socket.c:2130 [inline]
>> 	 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2130
>> 	 do_syscall_64+0xfa/0x780 arch/x86/entry/common.c:294
>> 	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Add kasan_unmap_page_range() which skips empty page table entries instead
>> of allocating them.
>>
>> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
>> Reported-by: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> ---
>>  mm/kasan/common.c | 82 +++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 68 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index a1e6273be8c3..e9ba7d8ad324 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -857,22 +857,77 @@ void kasan_unpoison_vmalloc(const void *start, unsigned long size)
>>  	kasan_unpoison_shadow(start, size);
>>  }
>>  
>> -static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>> -					void *unused)
>> +static void kasan_unmap_pte_range(pmd_t *pmd, unsigned long addr,
>> +				unsigned long end)
>>  {
>> -	unsigned long page;
>> +	pte_t *pte;
>>  
>> -	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
>> +	pte = pte_offset_kernel(pmd, addr);
>> +	do {
>> +		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
>>  
>> -	spin_lock(&init_mm.page_table_lock);
>> +		if (!pte_none(ptent))
>> +			__free_page(pte_page(ptent));
>> +	} while (pte++, addr += PAGE_SIZE, addr != end);
>> +}
>>  
>> -	if (likely(!pte_none(*ptep))) {
>> -		pte_clear(&init_mm, addr, ptep);
>> -		free_page(page);
>> -	}
>> -	spin_unlock(&init_mm.page_table_lock);
>> +static void kasan_unmap_pmd_range(pud_t *pud, unsigned long addr,
>> +				unsigned long end)
>> +{
>> +	pmd_t *pmd;
>> +	unsigned long next;
>>  
>> -	return 0;
>> +	pmd = pmd_offset(pud, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		if (pmd_none_or_clear_bad(pmd))
>> +			continue;
>> +		kasan_unmap_pte_range(pmd, addr, next);
>> +	} while (pmd++, addr = next, addr != end);
>> +}
>> +
>> +static void kasan_unmap_pud_range(p4d_t *p4d, unsigned long addr,
>> +				unsigned long end)
>> +{
>> +	pud_t *pud;
>> +	unsigned long next;
>> +
>> +	pud = pud_offset(p4d, addr);
>> +	do {
>> +		next = pud_addr_end(addr, end);
>> +		if (pud_none_or_clear_bad(pud))
>> +			continue;
>> +		kasan_unmap_pmd_range(pud, addr, next);
>> +	} while (pud++, addr = next, addr != end);
>> +}
>> +
>> +static void kasan_unmap_p4d_range(pgd_t *pgd, unsigned long addr,
>> +				unsigned long end)
>> +{
>> +	p4d_t *p4d;
>> +	unsigned long next;
>> +
>> +	p4d = p4d_offset(pgd, addr);
>> +	do {
>> +		next = p4d_addr_end(addr, end);
>> +		if (p4d_none_or_clear_bad(p4d))
>> +			continue;
>> +		kasan_unmap_pud_range(p4d, addr, next);
>> +	} while (p4d++, addr = next, addr != end);
>> +}
>> +
>> +static void kasan_unmap_page_range(unsigned long addr, unsigned long end)
>> +{
>> +	pgd_t *pgd;
>> +	unsigned long next;
>> +
>> +	pgd = pgd_offset_k(addr);
>> +	do {
>> +		next = pgd_addr_end(addr, end);
>> +		if (pgd_none_or_clear_bad(pgd))
>> +			continue;
>> +		kasan_unmap_p4d_range(pgd, addr, next);
>> +	} while (pgd++, addr = next, addr != end);
>>  }
>>  
>>  /*
>> @@ -978,9 +1033,8 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>>  	shadow_end = kasan_mem_to_shadow((void *)region_end);
>>  
>>  	if (shadow_end > shadow_start) {
>> -		apply_to_page_range(&init_mm, (unsigned long)shadow_start,
>> -				    (unsigned long)(shadow_end - shadow_start),
>> -				    kasan_depopulate_vmalloc_pte, NULL);
>> +		kasan_unmap_page_range((unsigned long)shadow_start,
>> +				    (unsigned long)shadow_end);
>>  		flush_tlb_kernel_range((unsigned long)shadow_start,
>>  				       (unsigned long)shadow_end);
>>  	}
>> -- 
>> 2.23.0
