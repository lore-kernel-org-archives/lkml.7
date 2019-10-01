Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57421D81
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Efj+B4nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJALwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:52:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42787 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJALwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:52:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id y91so11584649ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcFbftEjpta2y13GA3RqR5AgEFWor73R7GJxlkXb1DY=;
        b=Efj+B4nT92PjxgLdwaAbikzCcl7RsoyXjmBuG3TdB5B+wVU1va5i6kHvlgx3TYSiq5
         P7Oehmi5qiapBr6TjX1oe+MXono1XYg96rgVu6HmWVBbiWucafeqkQRpbEEnLxBopMff
         pJMUxzc11m0vOZ2GOVy4XXg0GYeqeV43xGTWt+3/mqaiQSTXRqH+WdiTCc6YkFL1q/mv
         bo5RKnIp3WAEPuh0dSKZc5Ep/5saVyKEnJzInVAMIlBlZFFAlHmu3G7RHUO8e6AcBk2g
         HlXneZzHgrH4ZeIJKOaiHIM+emYZH3LxW7dgQ32wRpjgqItJjCS2N6qG4xv/e7S+S0km
         QGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcFbftEjpta2y13GA3RqR5AgEFWor73R7GJxlkXb1DY=;
        b=AYJYMXaaHCk3DzPAExV5Nh5mXtU5kIWq5HXPtyn5js/B2QS0gXHqz9k9rKAdPSKJ5M
         75tbSI3evfgz6RhsNiFmdRBJEiDuMMH0mFx/wrxgXjctmyBjClFtRuu4AXNurt/HISkW
         Bg6rPsqzFha+QluuYN+CWjp2pzJ20ItYBpUdV0MMg1LaEqGFCN5usbrK6uXBE7kUsXzr
         5paHUIBQ3C2C/yi9iNzW61s67MzyNc24KVLQrX0aifcNMKbgvJyIE3TFErDty6IAAfxW
         XC3Xpx5CrScaGDFz6okcUd3IaEDHP1aaxpBPW47k6Vj9Th2v1NZpR+TX4A3BEGs5bmPF
         iiuQ==
X-Gm-Message-State: APjAAAUbbaI0n6eGikWLXyWMMurh6LnrqTdsVHYAAq1TaUFRIbWaw2zd
        3RTHgn8i3ygUyXXGLuTjJlaSwA==
X-Google-Smtp-Source: APXvYqw/w4WE63OqtmSARVsxFLPOqJjSYs9OcZT2cvZ9KcJU5kG1OZtYa8IosMjoi8SZuiyc5ZXX/w==
X-Received: by 2002:aa7:d995:: with SMTP id u21mr25117039eds.271.1569930759583;
        Tue, 01 Oct 2019 04:52:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f36sm3091085ede.28.2019.10.01.04.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:52:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 925F2102FB8; Tue,  1 Oct 2019 14:52:39 +0300 (+03)
Date:   Tue, 1 Oct 2019 14:52:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/thp: make set_huge_zero_page() return void
Message-ID: <20191001115239.dqodyji3r32zjkea@box>
References: <20190930195528.32553-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930195528.32553-1-rcampbell@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:55:28PM -0700, Ralph Campbell wrote:
> The return value from set_huge_zero_page() is never checked so simplify
> the code by making it return void.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  mm/huge_memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c5cb6dcd6c69..6cf0ee65538d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -686,20 +686,18 @@ static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
>  }
>  
>  /* Caller must hold page table lock. */
> -static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
> +static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>  		struct vm_area_struct *vma, unsigned long haddr, pmd_t *pmd,
>  		struct page *zero_page)
>  {
>  	pmd_t entry;
> -	if (!pmd_none(*pmd))
> -		return false;
> +

Wat? So you just bindly overwrite whatever is there?

NAK.

>  	entry = mk_pmd(zero_page, vma->vm_page_prot);
>  	entry = pmd_mkhuge(entry);
>  	if (pgtable)
>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  	set_pmd_at(mm, haddr, pmd, entry);
>  	mm_inc_nr_ptes(mm);
> -	return true;
>  }
>  
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> -- 
> 2.20.1
> 
> 

-- 
 Kirill A. Shutemov
