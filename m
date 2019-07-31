Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87716C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513352089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="FDcn/+VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfGaGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:34:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfGaGet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:34:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so12376162pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5/aeGLYPf40z7c7ppyzA+em+8QsWfsCwbNPz1NrmSfc=;
        b=FDcn/+VGMhd3AFLSGRxxc0ERstH9u8zJmdpiIHH9DiQPqQ9Qnhu11hTUMJEN20oFNc
         iPGKLMVHSSpEqy1powl+lyVtUCkBET/ZV+wabOcsEKoBsxiAMP1R8izx/C0BPQaDycs3
         IExeyvBmroZWFBeArYaRD8lIIzOzSRgnUxzgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5/aeGLYPf40z7c7ppyzA+em+8QsWfsCwbNPz1NrmSfc=;
        b=lJUtDy790kUCbeGBcNkQoL1gmXwgI3z2SSK/mTWDBNl3Ru6KVFuus3PZYqoaAg4Vpn
         r6ll4W5Fa3CHu8hsNLS03E7qNiNzzzHDmpSYzkNS2p5XVwUZ5Egu/nHeM4PQ8+t6WFA4
         9zBlg6fZVAsuaNESlF18ZtS6mRxS4lIpS973E4Bq6Nrifgt3kWvYOkdLqPuoFgES2vkG
         3f6T4aMazFTVeOzZhzeXZSQUrO+eAaUeIx9ptlN/BTFrku+mRWMjiBrhGtEtHyk6vsYW
         z7aJSJo50IvH54jHxYnNY6Egm00pbi3LtKoCUsj9cNa+mfX6mltNJm7h9Zc7QJTHFE9G
         vVxw==
X-Gm-Message-State: APjAAAXcrZonk8F3C6FXdkA1xhFpINEZq0dt4pfrtEH1D7onKEsZcKoj
        0SyJLQN2M3W406eqJImRplw=
X-Google-Smtp-Source: APXvYqx1lpIOiRAjCalxYjrDAlog5LflfdWiSAmc8+ozj1KTusqNLfJQyI7BNh6Zlnb5iGrp5CoWvg==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr1286047pjt.29.1564554888522;
        Tue, 30 Jul 2019 23:34:48 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id e11sm80266144pfm.35.2019.07.30.23.34.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:34:47 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH v2 1/3] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <877e7zhq7c.fsf@dja-thinkpad.axtens.net>
References: <20190729142108.23343-1-dja@axtens.net> <20190729142108.23343-2-dja@axtens.net> <20190729154426.GA51922@lakrids.cambridge.arm.com> <877e7zhq7c.fsf@dja-thinkpad.axtens.net>
Date:   Wed, 31 Jul 2019 16:34:42 +1000
Message-ID: <871ry6hful.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> Hi Mark,
>
> Thanks for your email - I'm very new to mm stuff and the feedback is
> very helpful.
>
>>> +#ifndef CONFIG_KASAN_VMALLOC
>>>  int kasan_module_alloc(void *addr, size_t size)
>>>  {
>>>  	void *ret;
>>> @@ -603,6 +604,7 @@ void kasan_free_shadow(const struct vm_struct *vm)
>>>  	if (vm->flags & VM_KASAN)
>>>  		vfree(kasan_mem_to_shadow(vm->addr));
>>>  }
>>> +#endif
>>
>> IIUC we can drop MODULE_ALIGN back to PAGE_SIZE in this case, too.
>
> Yes, done.
>
>>>  core_initcall(kasan_memhotplug_init);
>>>  #endif
>>> +
>>> +#ifdef CONFIG_KASAN_VMALLOC
>>> +void kasan_cover_vmalloc(unsigned long requested_size, struct vm_struct *area)
>>
>> Nit: I think it would be more consistent to call this
>> kasan_populate_vmalloc().
>>
>
> Absolutely. I didn't love the name but just didn't 'click' that populate
> would be a better verb.
>
>>> +{
>>> +	unsigned long shadow_alloc_start, shadow_alloc_end;
>>> +	unsigned long addr;
>>> +	unsigned long backing;
>>> +	pgd_t *pgdp;
>>> +	p4d_t *p4dp;
>>> +	pud_t *pudp;
>>> +	pmd_t *pmdp;
>>> +	pte_t *ptep;
>>> +	pte_t backing_pte;
>>
>> Nit: I think it would be preferable to use 'page' rather than 'backing',
>> and 'pte' rather than 'backing_pte', since there's no otehr namespace to
>> collide with here. Otherwise, using 'shadow' rather than 'backing' would
>> be consistent with the existing kasan code.
>
> Not a problem, done.
>
>>> +	addr = shadow_alloc_start;
>>> +	do {
>>> +		pgdp = pgd_offset_k(addr);
>>> +		p4dp = p4d_alloc(&init_mm, pgdp, addr);
>>> +		pudp = pud_alloc(&init_mm, p4dp, addr);
>>> +		pmdp = pmd_alloc(&init_mm, pudp, addr);
>>> +		ptep = pte_alloc_kernel(pmdp, addr);
>>> +
>>> +		/*
>>> +		 * we can validly get here if pte is not none: it means we
>>> +		 * allocated this page earlier to use part of it for another
>>> +		 * allocation
>>> +		 */
>>> +		if (pte_none(*ptep)) {
>>> +			backing = __get_free_page(GFP_KERNEL);
>>> +			backing_pte = pfn_pte(PFN_DOWN(__pa(backing)),
>>> +					      PAGE_KERNEL);
>>> +			set_pte_at(&init_mm, addr, ptep, backing_pte);
>>> +		}
>>
>> Does anything prevent two threads from racing to allocate the same
>> shadow page?
>>
>> AFAICT it's possible for two threads to get down to the ptep, then both
>> see pte_none(*ptep)), then both try to allocate the same page.
>>
>> I suspect we have to take init_mm::page_table_lock when plumbing this
>> in, similarly to __pte_alloc().
>
> Good catch. I think you're right, I'll add the lock.
>
>>> +	} while (addr += PAGE_SIZE, addr != shadow_alloc_end);
>>> +
>>> +	kasan_unpoison_shadow(area->addr, requested_size);
>>> +	requested_size = round_up(requested_size, KASAN_SHADOW_SCALE_SIZE);
>>> +	kasan_poison_shadow(area->addr + requested_size,
>>> +			    area->size - requested_size,
>>> +			    KASAN_VMALLOC_INVALID);
>>
>> IIUC, this could leave the final portion of an allocated page
>> unpoisoned.
>>
>> I think it might make more sense to poison each page when it's
>> allocated, then plumb it into the page tables, then unpoison the object.
>>
>> That way, we can rely on any shadow allocated by another thread having
>> been initialized to KASAN_VMALLOC_INVALID, and only need mutual
>> exclusion when allocating the shadow, rather than when poisoning
>> objects.

I've come a bit unstuck on this one. If a vmalloc address range is
reused, we can end up with the following sequence:

 - p = vmalloc(PAGE_SIZE) allocates ffffc90000000000

 - kasan_populate_shadow allocates a shadow page, fills it with
   KASAN_VMALLOC_INVALID, and then unpoisions
   PAGE_SIZE >> KASAN_SHADOW_SHIFT_SIZE bytes

 - vfree(p)

 - p = vmalloc(3000) also allocates ffffc90000000000 because of address
   reuse in vmalloc.

 - Now kasan_populate_shadow doesn't allocate a page, so does no
   poisioning.

 - kasan_populate_shadow unpoisions 3000 >> KASAN_SHADOW_SHIFT_SIZE
   bytes, but the PAGE_SIZE-3000 extra bytes are still unpoisioned, so
   accesses that are out-of-bounds for the 3000 byte allocation are
   missed.

So I think we do need to poision the shadow of the [requested_size,
area->size) region each time. However, I don't think we need mutual
exclusion to be able to do this safely. I think the safety is guaranteed
by vmalloc not giving the same page to multiple allocations. Because no
two threads are going to get overlapping vmalloc/vmap allocations, their
shadow ranges are not going to overlap, and so they're not going to
trample over each other.

I think it's probably still worth poisioning the pages on allocation:
for one thing, you are right that part of the shadow page will not be
poisioned otherwise, and secondly it means you migh get a kasan splat
before you get a page-not-present fault if you access beyond an
allocation, at least if the shadow happens to fall helpfully within an
already-allocated page.

v3 to come soon.

Regards,
Daniel

>
> Yes, that makes sense, will do.
>
> Thanks again,
> Daniel
