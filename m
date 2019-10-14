Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD55ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848532133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="e19PdnTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfJNN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:57:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40788 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfJNN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:57:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id e13so1973108pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=w+qQ12zqF6/LBMHQ5Fp2IFcdj8n4Em4zE18BXC0o5qc=;
        b=e19PdnTITiRHT8BkzMqzQslGAm0ePSp/Ygo3EPANA7IZYnPaqVYFwlLTDbRE6C315S
         Fq2C21+LeOwUqC/5Q0/LhjsGkUjHkd4DrizycDmZ0CIZWjRjTpzT65GyR2KpdrUv/NzQ
         ty+P8L2qB0/AsSbQ6iwuWlgckd43Y8kX2DTOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w+qQ12zqF6/LBMHQ5Fp2IFcdj8n4Em4zE18BXC0o5qc=;
        b=tojO0MpQmrans5+dQ8hSg3a1c9c+Bmct+Gk/x93DC++2OcFoTWSXFDpvlt05uGNHBT
         Jo6pvyYPC3oxDHF9GWNXIfDfeYo+SrCuwTNgiskBz1iAFAtZyoFybtf4Wtc3LZtmG3Xz
         vCxjbzTWCXLNI0VmbcAs5Ng42vvCM9RMZNKoQMqsbIMi5ZNn+AU8m5R2tCSYgmib1nGZ
         CG/vJa01xwyzFUIy1/FCCWHMDqeYSTElYsp7ldlFoBw6KAsA2ZEs5llObjaPPs1aC3/B
         5RzYc0Uz3d6Mf6tt6ZKC+UaXiBDnnZfjF22GycZayIZOYG28j8ut8wya8nW6yoCq6dK1
         ENpA==
X-Gm-Message-State: APjAAAXgWIB5MsXeEvU4z1MftiW8p0uw0clxwZwURYkqLyY43Z2PuLJQ
        UVoaVtzTHqFgTHx4IS/NJ2uhNQ==
X-Google-Smtp-Source: APXvYqxv6ZzjyfwcTFL8mtTDtffryluSc6uc9hQ8Klc9iZGNvmBj4sktnP0dv9DvdOb4Ap0KWjNLDQ==
X-Received: by 2002:a63:1d8:: with SMTP id 207mr17320083pgb.366.1571061468959;
        Mon, 14 Oct 2019 06:57:48 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id z4sm15608752pjt.17.2019.10.14.06.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:57:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
Date:   Tue, 15 Oct 2019 00:57:44 +1100
Message-ID: <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,


>> +	/*
>> +	 * Ensure poisoning is visible before the shadow is made visible
>> +	 * to other CPUs.
>> +	 */
>> +	smp_wmb();
>
> I'm not quite understand what this barrier do and why it needed.
> And if it's really needed there should be a pairing barrier
> on the other side which I don't see.

Mark might be better able to answer this, but my understanding is that
we want to make sure that we never have a situation where the writes are
reordered so that PTE is installed before all the poisioning is written
out. I think it follows the logic in __pte_alloc() in mm/memory.c:

	/*
	 * Ensure all pte setup (eg. pte page lock and page clearing) are
	 * visible before the pte is made visible to other CPUs by being
	 * put into page tables.
	 *
	 * The other side of the story is the pointer chasing in the page
	 * table walking code (when walking the page table without locking;
	 * ie. most of the time). Fortunately, these data accesses consist
	 * of a chain of data-dependent loads, meaning most CPUs (alpha
	 * being the notable exception) will already guarantee loads are
	 * seen in-order. See the alpha page table accessors for the
	 * smp_read_barrier_depends() barriers in page table walking code.
	 */
	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */

I can clarify the comment.

>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +	if (likely(pte_none(*ptep))) {
>> +		set_pte_at(&init_mm, addr, ptep, pte);
>> +		page = 0;
>> +	}
>> +	spin_unlock(&init_mm.page_table_lock);
>> +	if (page)
>> +		free_page(page);
>> +	return 0;
>> +}
>> +
>
>
> ...
>
>> @@ -754,6 +769,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
>>  	}
>>  
>>  insert:
>> +	kasan_release_vmalloc(orig_start, orig_end, va->va_start, va->va_end);
>> +
>>  	if (!merged) {
>>  		link_va(va, root, parent, link, head);
>>  		augment_tree_propagate_from(va);
>> @@ -2068,6 +2085,22 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>>  
>>  	setup_vmalloc_vm(area, va, flags, caller);
>>  
>> +	/*
>> +	 * For KASAN, if we are in vmalloc space, we need to cover the shadow
>> +	 * area with real memory. If we come here through VM_ALLOC, this is
>> +	 * done by a higher level function that has access to the true size,
>> +	 * which might not be a full page.
>> +	 *
>> +	 * We assume module space comes via VM_ALLOC path.
>> +	 */
>> +	if (is_vmalloc_addr(area->addr) && !(area->flags & VM_ALLOC)) {
>> +		if (kasan_populate_vmalloc(area->size, area)) {
>> +			unmap_vmap_area(va);
>> +			kfree(area);
>> +			return NULL;
>> +		}
>> +	}
>> +
>>  	return area;
>>  }
>>  
>> @@ -2245,6 +2278,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
>>  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
>>  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>>  
>> +	if (area->flags & VM_KASAN)
>> +		kasan_poison_vmalloc(area->addr, area->size);
>> +
>>  	vm_remove_mappings(area, deallocate_pages);
>>  
>>  	if (deallocate_pages) {
>> @@ -2497,6 +2533,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>  	if (!addr)
>>  		return NULL;
>>  
>> +	if (kasan_populate_vmalloc(real_size, area))
>> +		return NULL;
>> +
>
> KASAN itself uses __vmalloc_node_range() to allocate and map shadow in memory online callback.
> So we should either skip non-vmalloc and non-module addresses here or teach kasan's memory online/offline
> callbacks to not use __vmalloc_node_range() (do something similar to kasan_populate_vmalloc() perhaps?). 

Ah, right you are. I haven't been testing that.

I am a bit nervous about further restricting kasan_populate_vmalloc: I
seem to remember having problems with code using the vmalloc family of
functions to map memory that doesn't lie within vmalloc space but which
still has instrumented accesses.

On the other hand, I'm not keen on rewriting any of the memory
on/offline code if I can avoid it!

I'll have a look and get back you as soon as I can.

Thanks for catching this.

Kind regards,
Daniel

>
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/352cb4fa-2e57-7e3b-23af-898e113bbe22%40virtuozzo.com.
