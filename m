Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD4ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29492089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="RZ+GE5VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfJOKG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:06:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfJOKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:06:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so19618499lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RjVMtrJp1iFHo56unmu4gsv1JhH5b/RYaTBUd0ibDk8=;
        b=RZ+GE5VFUSnnTf/4sDkmoYv6MUSD4lyg2kYsLPOvYHjd6dE04HZw4ZcjF1x3FUMZvd
         W+6rr3QIHHJR8GkzYRfypHK7GaN9noxAC/nLkKLrkM+woppzwrLa3ru6EihxyiJV9dL4
         /24kmrtpNGcwWo0nWLjfo1DlwP1yw8Srj8tUKfRBtTtMbFl0y+oECZMwq26ZIS4gOwGs
         5tucrdKs65ohI9oQ14tCuEUC1kInwNruNxC/dkYGuHU+5aMdGivFrBS0tzRDmJ17Xfng
         vbsSLRwVGLooOgeUFk2X+Foynp1gDHtfmDpC+TQ7xAQ0HMn/O0ByZg1L1cvjNBdbHjjV
         6lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RjVMtrJp1iFHo56unmu4gsv1JhH5b/RYaTBUd0ibDk8=;
        b=JPd5WKOHoCSKCG8dxIAGljLrogONCfe3ygoGwDZU1e+S/1DT0VHRd8Y3/KH/rv3kSp
         +VphK8LEbbLhHCHIjnjECnjf/Ww6+2EKm39Mt7FaWU5nxCoq8yx8KizRKi820F4UGsbc
         2Dtlb+Wml61swnMis5GaU7BXDiJ6/H17o6D2XIJ+p9q4kK+uDLNK0S45uMeD89L6mOX3
         anf8xlSc1uojKRoN5r2Oa21zw8LrYIlho81USVchXMHubNMFsXHxWAIQ8psLwsjxVXGw
         ksVOrlkPaHN6/EsutEvpXKzQRzh2rEWvbJPa5PE+qxorN8EsBO96fwuCryttIJNrPTyk
         c7OQ==
X-Gm-Message-State: APjAAAXuSxCbVfYKQDN4tfDY1XuBqK0JtSQO3hWZ491b+6RJEUeIan85
        dQr3D7fll4y3Fx9Dyj7sI5LAJoVc6Pw=
X-Google-Smtp-Source: APXvYqzrUStCoSSrPUP/5nERGNNorZD3MawK+VZNiHzjzhWHkDwiDSY0QhCmMEg14m1WlC6XsH9p0Q==
X-Received: by 2002:a2e:8684:: with SMTP id l4mr22684903lji.87.1571134014417;
        Tue, 15 Oct 2019 03:06:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d8sm4527376lfb.88.2019.10.15.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 03:06:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8F9DC100D4C; Tue, 15 Oct 2019 13:06:53 +0300 (+03)
Date:   Tue, 15 Oct 2019 13:06:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [RFC PATCH] mm: Fix a huge pud insertion race during faulting
Message-ID: <20191015100653.ittq4b2mx7pszky5@box>
References: <20191008093711.3410-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008093711.3410-1-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:37:11AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> A huge pud page can theoretically be faulted in racing with pmd_alloc()
> in __handle_mm_fault(). That will lead to pmd_alloc() returning an
> invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
> similar to pmd_trans_unstable() and check whether the pud is really stable
> before using the pmd pointer.
> 
> Race:
> Thread 1:             Thread 2:                 Comment
> create_huge_pud()                               Fallback - not taken.
> 		      create_huge_pud()         Taken.
> pmd_alloc()                                     Returns an invalid pointer.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
> RFC: We include pud_devmap() as an unstable PUD flag. Is this correct?
>      Do the same for pmds?

I *think* it is correct and we should do the same for PMD, but I may be
wrong.

Dan, Matthew, could you comment on this?

> ---
>  include/asm-generic/pgtable.h | 25 +++++++++++++++++++++++++
>  mm/memory.c                   |  6 ++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 818691846c90..70c2058230ba 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -912,6 +912,31 @@ static inline int pud_trans_huge(pud_t pud)
>  }
>  #endif
>  
> +/* See pmd_none_or_trans_huge_or_clear_bad for discussion. */
> +static inline int pud_none_or_trans_huge_or_dev_or_clear_bad(pud_t *pud)
> +{
> +	pud_t pudval = READ_ONCE(*pud);
> +
> +	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
> +		return 1;
> +	if (unlikely(pud_bad(pudval))) {
> +		pud_clear_bad(pud);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +/* See pmd_trans_unstable for discussion. */
> +static inline int pud_trans_unstable(pud_t *pud)
> +{
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
> +	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> +	return pud_none_or_trans_huge_or_dev_or_clear_bad(pud);
> +#else
> +	return 0;
> +#endif
> +}
> +
>  #ifndef pmd_read_atomic
>  static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index b1ca51a079f2..43ff372f4f07 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3914,6 +3914,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  	vmf.pud = pud_alloc(mm, p4d, address);
>  	if (!vmf.pud)
>  		return VM_FAULT_OOM;
> +retry_pud:
>  	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
>  		ret = create_huge_pud(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
> @@ -3940,6 +3941,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
>  	if (!vmf.pmd)
>  		return VM_FAULT_OOM;
> +
> +	/* Huge pud page fault raced with pmd_alloc? */
> +	if (pud_trans_unstable(vmf.pud))
> +		goto retry_pud;
> +
>  	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
>  		ret = create_huge_pmd(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
> -- 
> 2.20.1
> 

-- 
 Kirill A. Shutemov
