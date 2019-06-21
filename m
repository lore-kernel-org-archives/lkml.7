Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C1AC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C7021530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFUJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFUJDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEE7F88305;
        Fri, 21 Jun 2019 09:02:55 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0F360FAB;
        Fri, 21 Jun 2019 09:02:52 +0000 (UTC)
Date:   Fri, 21 Jun 2019 17:02:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kyle Pelton <kyle.d.pelton@intel.com>
Subject: Re: [PATCH] x86/mm: Handle physical-virtual alignment mismatch in
 phys_p4d_init()
Message-ID: <20190621090249.GL24419@MiWiFi-R3L-srv>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 21 Jun 2019 09:03:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 06/20/19 at 02:22pm, Kirill A. Shutemov wrote:
> Kyle has reported that kernel crashes sometimes when it boots in
> 5-level paging mode with KASLR enabled:

This is a great finding, thanks for the fix. I ever have modified codes
to make them accommodate PMD level of randomization, this
phys_p4d_init() part is included. Not sure why I missed it when later
took PUD level randomization for 5-level.

https://github.com/baoquan-he/linux/commit/dc91f5292bf1f55666c9139b6621d830b5b38aa5

Have some concerns, please check.

> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/init_64.c:87 phys_p4d_init+0x1d4/0x1ea
...... 
> Kyle bisected the issue to commmit b569c1843498 ("x86/mm/KASLR: Reduce
> randomization granularity for 5-level paging to 1GB")
> 
> The commit relaxes KASLR alignment requirements and it can lead to
> mismatch bentween 'i' and 'p4d_index(vaddr)' inside the loop in
           ^ between
> phys_p4d_init(). The mismatch in its turn leads to clearing wrong p4d
> entry and eventually to the oops.
> 
> The fix is to make phys_p4d_init() walk virtual address space, not
> physical one.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-and-tested-by: Kyle Pelton <kyle.d.pelton@intel.com>
> Fixes: b569c1843498 ("x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB")
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/init_64.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 693aaf28d5fe..4628ac9105a2 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -671,41 +671,34 @@ static unsigned long __meminit
>  phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
>  	      unsigned long page_size_mask, bool init)
>  {
> -	unsigned long paddr_next, paddr_last = paddr_end;
> -	unsigned long vaddr = (unsigned long)__va(paddr);
> -	int i = p4d_index(vaddr);
> +	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
> +
> +	paddr_last = paddr_end;
> +	vaddr = (unsigned long)__va(paddr);
> +	vaddr_end = (unsigned long)__va(paddr_end);
> +	vaddr_start = vaddr;

Variable vaddr_start is not used in this patch, redundent?

>  
>  	if (!pgtable_l5_enabled())
>  		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
>  				     page_size_mask, init);
>  
> -	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
> -		p4d_t *p4d;
> +	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> +		p4d_t *p4d = p4d_page + p4d_index(vaddr);
>  		pud_t *pud;
>  
> -		vaddr = (unsigned long)__va(paddr);
> -		p4d = p4d_page + p4d_index(vaddr);
> -		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
> +		vaddr_next = (vaddr & P4D_MASK) + P4D_SIZE;
>  

The code block as below is to zero p4d entries which are not coverred by
the current memory range, and if haven't been mapped already. It's
clearred away in this patch, could you also mention it in log, and tell
why it doesn't matter now?

If it doesn't matter, should we clear away the simillar code in
phys_pud_init/phys_pmd_init/phys_pte_init? Maybe a prep patch to do the
clean up?

Thanks
Baoquan

> -		if (paddr >= paddr_end) {
> -			if (!after_bootmem &&
> -			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
> -					     E820_TYPE_RAM) &&
> -			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
> -					     E820_TYPE_RESERVED_KERN))
> -				set_p4d_init(p4d, __p4d(0), init);
> -			continue;
> -		}
> -
> -		if (!p4d_none(*p4d)) {
> -			pud = pud_offset(p4d, 0);
> -			paddr_last = phys_pud_init(pud, paddr, paddr_end,
> -						   page_size_mask, init);
> +		if (p4d_val(*p4d)) {
> +			pud = (pud_t *)p4d_page_vaddr(*p4d);
> +			paddr_last = phys_pud_init(pud, __pa(vaddr),
> +						   __pa(vaddr_end),
> +						   page_size_mask,
> +						   init);
>  			continue;
>  		}
>  
>  		pud = alloc_low_page();
> -		paddr_last = phys_pud_init(pud, paddr, paddr_end,
> +		paddr_last = phys_pud_init(pud, __pa(vaddr), __pa(vaddr_end),
>  					   page_size_mask, init);
>  
>  		spin_lock(&init_mm.page_table_lock);
> -- 
> 2.21.0
> 
