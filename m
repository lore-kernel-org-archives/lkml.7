Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E881C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0799221479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfDTKbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:31:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTKbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:31:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44mTf91SR8z9s70;
        Sat, 20 Apr 2019 20:31:28 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
References: <20190401141549.3F4721FE@viggo.jf.intel.com> <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
Date:   Sat, 20 Apr 2019 20:31:27 +1000
Message-ID: <87d0lht1c0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> On Mon, 1 Apr 2019, Dave Hansen wrote:
>> diff -puN mm/mmap.c~mpx-rss-pass-no-vma mm/mmap.c
>> --- a/mm/mmap.c~mpx-rss-pass-no-vma	2019-04-01 06:56:53.409411123 -0700
>> +++ b/mm/mmap.c	2019-04-01 06:56:53.423411123 -0700
>> @@ -2731,9 +2731,17 @@ int __do_munmap(struct mm_struct *mm, un
>>  		return -EINVAL;
>>  
>>  	len = PAGE_ALIGN(len);
>> +	end = start + len;
>>  	if (len == 0)
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * arch_unmap() might do unmaps itself.  It must be called
>> +	 * and finish any rbtree manipulation before this code
>> +	 * runs and also starts to manipulate the rbtree.
>> +	 */
>> +	arch_unmap(mm, start, end);
>
> ...
>   
>> -static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
>> -			      unsigned long start, unsigned long end)
>> +static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
>> +			      unsigned long end)
>
> While you fixed up the asm-generic thing, this breaks arch/um and
> arch/unicorn32. For those the fixup is trivial by removing the vma
> argument.
>
> But itt also breaks powerpc and there I'm not sure whether moving
> arch_unmap() to the beginning of __do_munmap() is safe. Micheal???

I don't know for sure but I think it should be fine. That code is just
there to handle CRIU unmapping/remapping the VDSO. So that either needs
to happen while the process is stopped or it needs to handle races
anyway, so I don't see how the placement within the unmap path should
matter.

> Aside of that the powerpc variant looks suspicious:
>
> static inline void arch_unmap(struct mm_struct *mm,
>                               unsigned long start, unsigned long end)
> {
>  	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
>                 mm->context.vdso_base = 0;
> }
>
> Shouldn't that be: 
>
>  	if (start >= mm->context.vdso_base && mm->context.vdso_base < end)
>
> Hmm?

Yeah looks pretty suspicious. I'll follow-up with Laurent who wrote it.
Thanks for spotting it!

cheers
