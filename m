Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C9C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B7E20866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enB8NIwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCIEB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:01:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52879 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfCIEB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:01:58 -0500
Received: by mail-it1-f196.google.com with SMTP id g17so23977029ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pH8sAGGnXCkPUbMJRChks7/3dKNz3dpZwqyj91moOWQ=;
        b=enB8NIwmaJi4OQIxi6Q/xvZ0q+BraSiTqy2d+wEIOPrVqPSROmqMNQgomRAX4Fy7FD
         aU78a/tdjiDj1/km2nvCbgYpYF9620eRVkuVKCsDdfCUQUAsyg8tR2d/2/z+p9F8ciy0
         jp8jVPyYgGRg0vxFP2Z+iW/sp6FGoTiBKNf3gWO8vlKBn/8fLJo4Sp37mSN0IIgTQajl
         PtSqL/rRPvsI6d3mF0YCccXv69WCZWvqLWFV2M3Wz4F+VaUtRs2GXmeDFv9jOuWXSSb1
         cRPA6JKp79uuMAhwfOnwo60sTRoe1HWGlcGwVh4jlOA2wSZsKXqv3SbwFfbJrR5OvO7i
         6Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pH8sAGGnXCkPUbMJRChks7/3dKNz3dpZwqyj91moOWQ=;
        b=ZqscXSA+5vl+BOUwwAZFe7b5hMJRQPkP4QZLLhrdCXVUA7C5bbMxDa8IrzbsR2ks6L
         d2TcBv5H+UznNBz5LcypMqeo5/3dGR6xSIetrVIwtrlItTXWIu96m3Co7ojx4kA8lZ55
         CqQIt+nsAWyvkjHCUY4NH1Xb/ED2XIww6IGLXDUjO54GBwnKMl5mjRd405zNZ4Dmc5/h
         bCTDVlxGTPsGNn2udV4F4TBJHuiS/FyBJIUUtyHGb+UiX5Gdz+EXTE9kB5YiPbszKqHl
         FA22UH52cjgRaxOjS2jn6cPrDk9UcrpQm1dkSlL3G4MBb4JgrErPCSft2fddykdQdqiI
         liQQ==
X-Gm-Message-State: APjAAAX5C6liQ6+gvZrXDzSevIYpc4CM61Dh3xpeaGXlA0wCWBKkzzSz
        t7x/9fNleuaeRDKE/Zu7w45s5Q==
X-Google-Smtp-Source: APXvYqxw7MTdz7bi6mEtWop3jiCjYq5/KwPLeoWLGPADNTbYqSyrAqSKBzbVkN9Z2kxcgJUuJ4Uj3g==
X-Received: by 2002:a24:7690:: with SMTP id z138mr10329033itb.119.1552104117606;
        Fri, 08 Mar 2019 20:01:57 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id u82sm4882605itb.18.2019.03.08.20.01.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Mar 2019 20:01:57 -0800 (PST)
Date:   Fri, 8 Mar 2019 21:01:53 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190309040153.GB214016@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <20190226151230.GA20230@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226151230.GA20230@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:12:31PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 18, 2019 at 04:13:17PM -0700, Yu Zhao wrote:
> > For pte page, use pgtable_page_ctor(); for pmd page, use
> > pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> > p4d and pgd), don't use any.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> [...]
> 
> > -static phys_addr_t pgd_pgtable_alloc(void)
> > +static phys_addr_t pgd_pgtable_alloc(int shift)
> >  {
> >  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> > -		BUG();
> > +	BUG_ON(!ptr);
> > +
> > +	/*
> > +	 * Initialize page table locks in case later we need to
> > +	 * call core mm functions like apply_to_page_range() on
> > +	 * this pre-allocated page table.
> > +	 */
> > +	if (shift == PAGE_SHIFT)
> > +		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
> > +	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
> > +		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
> 
> IIUC, this is for nopmd kernels, where we only have real PGD and PTE
> levels of table. From my PoV, that would be clearer if we did:
> 
> 	else if (shift == PMD_SHIFT && !is_defined(__PAGETABLE_PMD_FOLDED))
> 
> ... though IMO it would be a bit nicer if the generic
> pgtable_pmd_page_ctor() were nop'd out for __PAGETABLE_PMD_FOLDED
> builds, so that callers don't have to be aware of folding.

Agreed. Will make pgtable_pmd_page_ctor() nop when pmd is folded.

> I couldn't think of a nicer way of distinguishing levels of table, and
> having separate function pointers for each level seems over-the-top, so
> otehr than that this looks good to me.
> 
> Assuming you're happy with the above change:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
