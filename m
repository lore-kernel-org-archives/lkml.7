Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F634C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="L7Iol6H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFUKyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:54:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39598 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:54:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so9475281edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPD52pM1kbPHr2ipfT8N63+uTqa+PsMEsWCmw0RUGSI=;
        b=L7Iol6H7AogoeG0yPLiTrrfEdF23c21L+vMOei7g9y1nbXLwTgDIiHpWmdqMbJkbP9
         jc/UzmqzfSYkvsCZCtixVuNpB4bJ4T9QH0H1texmzPO2wGRY4BkKdWNHpyLH20JfWZOH
         wSyz8VtYg6/J48O21Y1P2AEYNCzZm84JbwoAas199B6c5wNGkhza06sitt7gv2DjMB83
         Oa7cTdJ85bWxi3bqOUIdIS8o3OOJ2krvE5ftjCk0IteOI5pkpmzHWxzZ1bWJu5m/+tq8
         Kk6Tb8Q6oNb6BlO4GQZCTQeWrRVXy31ujF2Xig1Iv9T7KJK2SG+dCwsfRjT8Mky6mrsP
         Hl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPD52pM1kbPHr2ipfT8N63+uTqa+PsMEsWCmw0RUGSI=;
        b=Znj27Y8nID+n90MBU2N7+gctt5WhT62E+/GBVzqFJ05j4zIzZ2D6+OxZx0qrSDmOfi
         K7N/y04WCd3k3m37fwebmwREj/e6K+qObCb+pcHH27fJNNlvPzN3ncFyZunp1+ElROPc
         CrneBvo3KWHCSB00sbk+P98e/ppfgygcZzSrF/NnpEng11wqUmVyZCbKtRZP3cM9Mru8
         rtNfcbNt91+DRaALZAmrShvwVg5JLi9XqgQxLOTg/kgXWPzfv3bl19lM9/K6BW6Uv/zF
         5VbFU0HoN/A8gFS/UV2iKzvejbn4ZpsLT/ZTNDsKiNf8a72ZdQVb/QuKtUglzjseeKYt
         Mvhw==
X-Gm-Message-State: APjAAAXYHWqy+hvHN6uBBs6qSXugatK+wYB8bLSTcjvLLoiNWpspy/pz
        DgFRg0dhRnrMr5T6hDcpj6Qp2w==
X-Google-Smtp-Source: APXvYqyAUqCMTjnx1xRJKFu/gnhcKKwNaIOJkM5SvS6HjEEGweaIGWoFJWuvbJShFTuQGvjBgGW/VQ==
X-Received: by 2002:a17:906:7e4b:: with SMTP id z11mr60705768ejr.214.1561114488816;
        Fri, 21 Jun 2019 03:54:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x10sm723485edd.73.2019.06.21.03.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 03:54:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F202310289C; Fri, 21 Jun 2019 13:54:49 +0300 (+03)
Date:   Fri, 21 Jun 2019 13:54:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <20190621105449.fp7h7tsmpitvplyr@box>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
 <20190621090249.GL24419@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621090249.GL24419@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 05:02:49PM +0800, Baoquan He wrote:
> Hi Kirill,
> 
> On 06/20/19 at 02:22pm, Kirill A. Shutemov wrote:
> > Kyle has reported that kernel crashes sometimes when it boots in
> > 5-level paging mode with KASLR enabled:
> 
> This is a great finding, thanks for the fix. I ever have modified codes
> to make them accommodate PMD level of randomization, this
> phys_p4d_init() part is included. Not sure why I missed it when later
> took PUD level randomization for 5-level.
> 
> https://github.com/baoquan-he/linux/commit/dc91f5292bf1f55666c9139b6621d830b5b38aa5
> 
> Have some concerns, please check.
> 
> > [    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/init_64.c:87 phys_p4d_init+0x1d4/0x1ea
> ...... 
> > Kyle bisected the issue to commmit b569c1843498 ("x86/mm/KASLR: Reduce
> > randomization granularity for 5-level paging to 1GB")
> > 
> > The commit relaxes KASLR alignment requirements and it can lead to
> > mismatch bentween 'i' and 'p4d_index(vaddr)' inside the loop in
>            ^ between
> > phys_p4d_init(). The mismatch in its turn leads to clearing wrong p4d
> > entry and eventually to the oops.
> > 
> > The fix is to make phys_p4d_init() walk virtual address space, not
> > physical one.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reported-and-tested-by: Kyle Pelton <kyle.d.pelton@intel.com>
> > Fixes: b569c1843498 ("x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB")
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/init_64.c | 39 ++++++++++++++++-----------------------
> >  1 file changed, 16 insertions(+), 23 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 693aaf28d5fe..4628ac9105a2 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -671,41 +671,34 @@ static unsigned long __meminit
> >  phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
> >  	      unsigned long page_size_mask, bool init)
> >  {
> > -	unsigned long paddr_next, paddr_last = paddr_end;
> > -	unsigned long vaddr = (unsigned long)__va(paddr);
> > -	int i = p4d_index(vaddr);
> > +	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
> > +
> > +	paddr_last = paddr_end;
> > +	vaddr = (unsigned long)__va(paddr);
> > +	vaddr_end = (unsigned long)__va(paddr_end);
> > +	vaddr_start = vaddr;
> 
> Variable vaddr_start is not used in this patch, redundent?

Yep. I'll drop it in v2.

> >  	if (!pgtable_l5_enabled())
> >  
> >  		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
> >  				     page_size_mask, init);
> >  
> > -	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
> > -		p4d_t *p4d;
> > +	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> > +		p4d_t *p4d = p4d_page + p4d_index(vaddr);
> >  		pud_t *pud;
> >  
> > -		vaddr = (unsigned long)__va(paddr);
> > -		p4d = p4d_page + p4d_index(vaddr);
> > -		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
> > +		vaddr_next = (vaddr & P4D_MASK) + P4D_SIZE;
> >  
> 
> The code block as below is to zero p4d entries which are not coverred by
> the current memory range, and if haven't been mapped already. It's
> clearred away in this patch, could you also mention it in log, and tell
> why it doesn't matter now?
> 
> If it doesn't matter, should we clear away the simillar code in
> phys_pud_init/phys_pmd_init/phys_pte_init? Maybe a prep patch to do the
> clean up?

It only matters for the levels that contains page table entries that can
point to pages, not page tables. There's no p4d or pgd huge pages on x86.
Otherwise we only leak page tables without any benefit.

We might have this on all leveles under p?d_large() condition and don't
touch page tables at all.

BTW, it all becomes rather risky for this late in the release cycle. Maybe
we should revert the original patch and try again later with more
comprehansive solution?

-- 
 Kirill A. Shutemov
