Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF06F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfB1NBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:01:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfB1NBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:01:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE50730D0301;
        Thu, 28 Feb 2019 13:01:49 +0000 (UTC)
Received: from localhost (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD92F1001DFC;
        Thu, 28 Feb 2019 13:01:48 +0000 (UTC)
Date:   Thu, 28 Feb 2019 21:01:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190228130144.GT14858@MiWiFi-R3L-srv>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
 <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
 <20190228100419.GS14858@MiWiFi-R3L-srv>
 <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 28 Feb 2019 13:01:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/19 at 01:30pm, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index 754b5da91d43..131e08a10a68 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -226,74 +226,68 @@ void __init kernel_randomize_memory(void)
> >  
> >  static void __meminit init_trampoline_pud(void)
> >  {
> > -	unsigned long paddr, paddr_next;
> > +	unsigned long paddr, vaddr;
> >  	pgd_t *pgd;
> > -	pud_t *pud_page, *pud_page_tramp;
> > -	int i;
> > +
> 
> Unneeded empty line.

Right, I will remove it, and move it to the top since it's the longest
line.

> 
> > +	pud_t *pud_page, *pud_page_tramp, *pud, *pud_tramp;
> >  
> >  	pud_page_tramp = alloc_low_page();
> >  
> >  	paddr = 0;
> > +	vaddr = (unsigned long)__va(paddr);
> 
> Maybe just
> 
> 	vaddr = PAGE_OFFSET;
> 
> ?

An obvious 0 to PAGE_OFFSET converting can explain the page table
borrowing from the direct mapping in some extent. While both is fine to
me if you prefer PAGE_OFFSET.

> 
> >  	pgd = pgd_offset_k((unsigned long)__va(paddr));
> 
> We do have 'vaddr' already.

Yeah, will replace it.

> 
> 	pgd = pgd_offset_k(vaddr);
> 
> > -	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
> > -
> > -	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
> > -		pud_t *pud, *pud_tramp;
> > -		unsigned long vaddr = (unsigned long)__va(paddr);
> >  
> > -		pud_tramp = pud_page_tramp + pud_index(paddr);
> > -		pud = pud_page + pud_index(vaddr);
> > -		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
> > -
> > -		*pud_tramp = *pud;
> > -	}
> > +	if (pgtable_l5_enabled()) {
> > +		p4d_t *p4d_page, *p4d_page_tramp, *p4d, *p4d_tramp;
> > +		p4d_page_tramp = alloc_low_page();
> >  
> > -	set_pgd(&trampoline_pgd_entry,
> > -		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> > -}
> > +		p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
> > +		p4d = p4d_page + p4d_index(vaddr);
> >  
> > -static void __meminit init_trampoline_p4d(void)
> > -{
> > -	unsigned long paddr, paddr_next;
> > -	pgd_t *pgd;
> > -	p4d_t *p4d_page, *p4d_page_tramp;
> > -	int i;
> > +		pud_page = (pud_t *) p4d_page_vaddr(*p4d);
> > +		pud = pud_page + pud_index(vaddr);
> >  
> > -	p4d_page_tramp = alloc_low_page();
> > +		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> > +		pud_tramp = pud_page_tramp + pud_index(paddr);
> 
> p?d_index() has to be called on the virtual address. It shouldn't break
> anything, but it's wrong from conceptual point of view.
> I don't think need paddr at all in the function.

Hmm, here the tramp table is for identity mapping real mode. Its paddr
equals to its vaddr. Using paddr here can tell it's the identity mapping
which is handling.

> 
> BTW, any reason we cannot use p?d_offset() instead of playing with
> p?d_index() directly?

Sure, p?d_offset() looks better. Just took it from the old code. I will
use it instead.

Thanks for careful reviewing.
