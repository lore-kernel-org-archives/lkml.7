Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAAF218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="s3OiMvgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfB1Ka6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:30:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfB1Ka5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:30:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id c4so9526680pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zxEZrCB0Wgc/NCx8Hnp+bZnUbk6C015eIc77mGkJzw=;
        b=s3OiMvglGm7u5UX3smTz7sOBLFQbRQhJ5IPamwhpY6Lw3Pjkaoi1RoaT/Hr9aauyIa
         jzcrQERQtXPIFN5NwGv5IOtc7Sgc6aIWzHY/1fukaSog5V5cOz/r7J08+5Mo1Qull4GR
         A6OQLuVmJeh6LzBPF0ZIiwpuwM/Wn8RyCMYX/KRCJ59/3El7I+Rli/me6yeqj1T4c3E4
         4bnb3qqoWIme8s6/jOIMDf9xHhdZWBe0n2FcpV3kMOyfAfZU0rc+DDLdes6kZVjrMF5Q
         assKYaYyr4pgXE2qiBpPzrzVT807oDw+zdCj0nI9q5urake9m3sn1VCasjfDItVfvcE+
         JKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zxEZrCB0Wgc/NCx8Hnp+bZnUbk6C015eIc77mGkJzw=;
        b=QeVVsQeZtMfKbu2w/GxHaMZ7s0g3gM15WdfvzhtBMmsC7zwp1HAoys47LHMvoMjgH4
         +l3P5M8iDS8RUbfTE1sy4417/iMTjROKZWOe4T/D4lxWd9M4/V7pJJaDKQTH+8e0RqOk
         v9OAD4RkCcoohIjhESj5nUKVbS7IejFg4CKDnaRao+OXjtS9W7Z4eh+4L0DfBxUQbT+X
         RJpf1Q4nHRn6fIaEZWIXpBP8pcEaSl8WO6qk6/3XGwWVSPdmOMHuUb1B02jNePNFbsuN
         XoGYdkyahMABGw4xpu5q6zTg/fK7Qv8ucp8S0wiUHNcir3meb3FiwhIno65IvlsB7WQ+
         dbaQ==
X-Gm-Message-State: AHQUAuYo2rYfTb0WlQvTUvvsZRCCUQPs1xVNUYdEyqdZxNH3+UnTHsyh
        Q4AknPnmBwJ7EWvjxQZR94NSJg==
X-Google-Smtp-Source: AHgI3IauMbwDcRYxolvj7ZHJx4ULEIMQDiyCjdlK9ZBhIRlPpKHr4AfF6mDGSE1zA+LCLWGX+neHpQ==
X-Received: by 2002:a17:902:e60e:: with SMTP id cm14mr7242890plb.192.1551349856378;
        Thu, 28 Feb 2019 02:30:56 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id g3sm24577027pfo.125.2019.02.28.02.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 02:30:55 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id CC68C3000E5; Thu, 28 Feb 2019 13:30:51 +0300 (+03)
Date:   Thu, 28 Feb 2019 13:30:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190228103051.dvqiy2slwwt56ag2@kshutemo-mobl1>
References: <20190228003522.9957-1-bhe@redhat.com>
 <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
 <20190228092346.GQ14858@MiWiFi-R3L-srv>
 <20190228095503.jy44nwqhtmr4qeaq@kshutemo-mobl1>
 <20190228100419.GS14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228100419.GS14858@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:04:19PM +0800, Baoquan He wrote:
> On 02/28/19 at 12:55pm, Kirill A. Shutemov wrote:
> > I cannot apply the first patch too. Hm?
> 
> It's weird. I use 'git cherry-pick' and it can be cleanly applied.
> 
> And git formatted patch can be applied too. Could you try below one? 
> git am works for me with it, based on this commit on linus's tree.
> 7d762d69145a  afs: Fix manually set volume location server list.
> 
> 
> From dcbe8e4846102fdd051deb3c2946125c17b270fb Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Thu, 21 Feb 2019 11:46:59 +0800
> Subject: [PATCH v3] x86/mm/KASLR: Only build one PUD entry of area for real mode
>  trampoline
> 
> The current code builds identity mapping for real mode treampoline by
> borrowing page tables from the direct mapping section if KASLR is
> enabled. It will copy present entries of the first PUD table in 4-level
> paging mode, or the first P4D table in 5-level paging mode.
> 
> However, there's only a very small area under low 1 MB reserved
> for real mode trampoline in reserve_real_mode(). Makes no sense
> to build up so large area of mapping for it. Since the randomization
> granularity in 4-level is 1 GB, and 512 GB in 5-level, only copying
> one PUD entry is enough.
> 
> Hence, only copy one PUD entry of area where physical address 0
> resides. And this is preparation for later changing the randomization
> granularity of 5-level paging mode from 512 GB to 1 GB.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 82 +++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 754b5da91d43..131e08a10a68 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -226,74 +226,68 @@ void __init kernel_randomize_memory(void)
>  
>  static void __meminit init_trampoline_pud(void)
>  {
> -	unsigned long paddr, paddr_next;
> +	unsigned long paddr, vaddr;
>  	pgd_t *pgd;
> -	pud_t *pud_page, *pud_page_tramp;
> -	int i;
> +

Unneeded empty line.

> +	pud_t *pud_page, *pud_page_tramp, *pud, *pud_tramp;
>  
>  	pud_page_tramp = alloc_low_page();
>  
>  	paddr = 0;
> +	vaddr = (unsigned long)__va(paddr);

Maybe just

	vaddr = PAGE_OFFSET;

?

>  	pgd = pgd_offset_k((unsigned long)__va(paddr));

We do have 'vaddr' already.

	pgd = pgd_offset_k(vaddr);

> -	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
> -
> -	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
> -		pud_t *pud, *pud_tramp;
> -		unsigned long vaddr = (unsigned long)__va(paddr);
>  
> -		pud_tramp = pud_page_tramp + pud_index(paddr);
> -		pud = pud_page + pud_index(vaddr);
> -		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
> -
> -		*pud_tramp = *pud;
> -	}
> +	if (pgtable_l5_enabled()) {
> +		p4d_t *p4d_page, *p4d_page_tramp, *p4d, *p4d_tramp;
> +		p4d_page_tramp = alloc_low_page();
>  
> -	set_pgd(&trampoline_pgd_entry,
> -		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> -}
> +		p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
> +		p4d = p4d_page + p4d_index(vaddr);
>  
> -static void __meminit init_trampoline_p4d(void)
> -{
> -	unsigned long paddr, paddr_next;
> -	pgd_t *pgd;
> -	p4d_t *p4d_page, *p4d_page_tramp;
> -	int i;
> +		pud_page = (pud_t *) p4d_page_vaddr(*p4d);
> +		pud = pud_page + pud_index(vaddr);
>  
> -	p4d_page_tramp = alloc_low_page();
> +		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> +		pud_tramp = pud_page_tramp + pud_index(paddr);

p?d_index() has to be called on the virtual address. It shouldn't break
anything, but it's wrong from conceptual point of view.

I don't think need paddr at all in the function.

BTW, any reason we cannot use p?d_offset() instead of playing with
p?d_index() directly?


-- 
 Kirill A. Shutemov
