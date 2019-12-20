Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DE82467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576830245;
	bh=4VYjFp9lyonff3jT63qIn1hlsf0Szvp6sGFFfIVjSX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=thVQa5mmCsGUxshcxXM3pb4qBkjSMppWcVx17r+5TIC0B4NxVp3MscABwfNlXQdnO
	 92H4uBa77wk0eo3HpNBwm3UmBIaeQMtXLJQnT4D4mZ8xu21vOZfq9VX3RLZYjJ9uJR
	 t0lXU/R7LC3svaSdq71ZEMKAImZKpI9Fv1TZYtyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfLTIYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:24:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfLTIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:24:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so8487502wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=16kleYj3EzWpMaA9Rqqv7rsiyiD6OUag5CBmilPxVWQ=;
        b=cDzKILpGjB5sqcLTY8R78UnRhTpNaCMps3Njs9vHUMe650oKYddUtjEA/YstNOK6bp
         nROFjgNhegZFHZiK6sidFn6QerZMtCopFheDpyitOvcPzmEvmp2EO4M6G8YmlBl8OuZi
         0qg3LT8GlNFCF48n2GYS+Ofe60lGJ9KoKFWxeLsXxkpKdT+F3DthIcmy96WU002g6xGI
         spZ2Qhh5ozyYgK/A9Vq06dxK9RrpgeMWuq5rjN41qDcFdbl1GlrwDuvkrOyOEPwOLJJI
         K3Vg2VIIPSWbXrifKyzrIPb07OFzHizcqJaSroEXzmD9j6viBxXL+dGdlCZltcfevLHg
         5DRA==
X-Gm-Message-State: APjAAAXO6gOXZj+2agVwFkfAbZuF1IEPHOBb/KZ7ecFjJIlknJYtLqO7
        aakIwZ8vjhU06iaGI4df6BFzIbNd
X-Google-Smtp-Source: APXvYqwj2I+JPingsGXkMNL2ZaL9e1PCB9+FBAHMeSCLK9AHTTFkQAjwf7ZwwRriPeGiK/PwXbKoQw==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr14443874wrv.308.1576830241291;
        Fri, 20 Dec 2019 00:24:01 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v62sm8994041wmg.3.2019.12.20.00.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 00:24:00 -0800 (PST)
Date:   Fri, 20 Dec 2019 09:23:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 1/2] mm: Add a vmf_insert_mixed_prot() function
Message-ID: <20191220082359.GD20332@dhcp22.suse.cz>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
 <20191212084741.9251-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212084741.9251-2-thomas_os@shipmail.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-12-19 09:47:40, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The TTM module today uses a hack to be able to set a different page
> protection than struct vm_area_struct::vm_page_prot. To be able to do
> this properly, add the needed vm functionality as vmf_insert_mixed_prot().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Acked-by: Christian König <christian.koenig@amd.com>

I cannot say I am happy about this because it adds a discrepancy and
that is always tricky but I do agree that a formalized discrepancy is
better than ad-hoc hacks so

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for extending the documentation.

> ---
>  include/linux/mm.h       |  2 ++
>  include/linux/mm_types.h |  7 ++++++-
>  mm/memory.c              | 43 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc292273e6ba..29575d3c1e47 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>  			unsigned long pfn, pgprot_t pgprot);
>  vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>  			pfn_t pfn);
> +vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
> +			pfn_t pfn, pgprot_t pgprot);
>  vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>  		unsigned long addr, pfn_t pfn);
>  int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2222fa795284..ac96afdbb4bc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -307,7 +307,12 @@ struct vm_area_struct {
>  	/* Second cache line starts here. */
>  
>  	struct mm_struct *vm_mm;	/* The address space we belong to. */
> -	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
> +
> +	/*
> +	 * Access permissions of this VMA.
> +	 * See vmf_insert_mixed() for discussion.
> +	 */
> +	pgprot_t vm_page_prot;
>  	unsigned long vm_flags;		/* Flags, see mm.h. */
>  
>  	/*
> diff --git a/mm/memory.c b/mm/memory.c
> index b1ca51a079f2..269a8a871e83 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1646,6 +1646,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>   * vmf_insert_pfn_prot should only be used if using multiple VMAs is
>   * impractical.
>   *
> + * See vmf_insert_mixed_prot() for a discussion of the implication of using
> + * a value of @pgprot different from that of @vma->vm_page_prot.
> + *
>   * Context: Process context.  May allocate using %GFP_KERNEL.
>   * Return: vm_fault_t value.
>   */
> @@ -1719,9 +1722,9 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
>  }
>  
>  static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
> -		unsigned long addr, pfn_t pfn, bool mkwrite)
> +		unsigned long addr, pfn_t pfn, pgprot_t pgprot,
> +		bool mkwrite)
>  {
> -	pgprot_t pgprot = vma->vm_page_prot;
>  	int err;
>  
>  	BUG_ON(!vm_mixed_ok(vma, pfn));
> @@ -1764,10 +1767,42 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>  	return VM_FAULT_NOPAGE;
>  }
>  
> +/**
> + * vmf_insert_mixed_prot - insert single pfn into user vma with specified pgprot
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + * @pgprot: pgprot flags for the inserted page
> + *
> + * This is exactly like vmf_insert_mixed(), except that it allows drivers to
> + * to override pgprot on a per-page basis.
> + *
> + * Typically this function should be used by drivers to set caching- and
> + * encryption bits different than those of @vma->vm_page_prot, because
> + * the caching- or encryption mode may not be known at mmap() time.
> + * This is ok as long as @vma->vm_page_prot is not used by the core vm
> + * to set caching and encryption bits for those vmas (except for COW pages).
> + * This is ensured by core vm only modifying these page table entries using
> + * functions that don't touch caching- or encryption bits, using pte_modify()
> + * if needed. (See for example mprotect()).
> + * Also when new page-table entries are created, this is only done using the
> + * fault() callback, and never using the value of vma->vm_page_prot,
> + * except for page-table entries that point to anonymous pages as the result
> + * of COW.
> + *
> + * Context: Process context.  May allocate using %GFP_KERNEL.
> + * Return: vm_fault_t value.
> + */
> +vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
> +				 pfn_t pfn, pgprot_t pgprot)
> +{
> +	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
> +}
> +
>  vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>  		pfn_t pfn)
>  {
> -	return __vm_insert_mixed(vma, addr, pfn, false);
> +	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, false);
>  }
>  EXPORT_SYMBOL(vmf_insert_mixed);
>  
> @@ -1779,7 +1814,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
>  vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>  		unsigned long addr, pfn_t pfn)
>  {
> -	return __vm_insert_mixed(vma, addr, pfn, true);
> +	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, true);
>  }
>  EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
