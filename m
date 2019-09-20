Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BECA20717
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YZ3fLouj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406405AbfITSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:18:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41465 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404824AbfITSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:18:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so9701160qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYbWvzmmKAZuy52DsRiouQHPZ26YbiYdZTYVkZZ/igY=;
        b=YZ3fLoujpXw2Je0ErSV6UgQ31eXHAgTzXUgNx1xncQzpK7MRAX69MKqBBOjpyti5bC
         pz8IvRQnDD9EdMXgdbDYJZgtn5WK5IMSO6krTprg29MJvBhbTAMNSPbWgMn0ebd1R50U
         QpWj4NHCCAByAoQ6AuUKA0Z2B7XnW5VkTXZz89yucCudWG4kNv+5bfwL/DZ6DC9b17xZ
         1jGf9x0b2a7cpwgKbi/dar8YMoVb2Bup+WPuCQJ9eRovePTx+SvOErfvXZiIJHFX5YKw
         jLaddoHNIl7U/8Cpuy6URd639uC9mlTwYj5dr5WyRA3Tc1N/cH7CYBH8s99Y+1cpx4gZ
         xHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYbWvzmmKAZuy52DsRiouQHPZ26YbiYdZTYVkZZ/igY=;
        b=jS2GDkaDsqgEx1GyaoIGH5aGtzRZUZwKr1oqhNgW0gkWu3DPMMIrJ7iRlirurImqXu
         qk+cNtwX1NowWaw7nutq+CVoewR+h1AIUYt0sGTAtxz6c10Eqe7OafiJicqbnuDvHAcu
         FvfUDjXOF2xmC/UvzgkO9/QrRMKJHKa/hgWn6vyVtPXfnJ8tx7Z0G3xtp3qZQGuyMQh2
         tAMt5Vvt1cgqAg97q4JWg/msoSP1fYjKkNmXASrsBmnvNRCR3mO7SPgNawN7uDBfvKN3
         Uj7YAQFjG16fandsc/mT6fT+makBwHHKuvOv4Yy25W0lPq+D8UiHsA8wQ8SvZfc6TD/0
         7z5g==
X-Gm-Message-State: APjAAAUtcPurAAyteywIqflZGfBn/odfkbDx81FzahSNGpaZEw1WN+NX
        u6t4tfHNI+nMyIF95Oimrc9Jsg==
X-Google-Smtp-Source: APXvYqwp9/fq/xscoRUtHvBetayixp1jIgu/24Pt8YF+ZNrY+yQ59g7DqU133QajvMMEu2PwokB9qQ==
X-Received: by 2002:ac8:428e:: with SMTP id o14mr4928399qtl.186.1569003480901;
        Fri, 20 Sep 2019 11:18:00 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v12sm1640151qtb.5.2019.09.20.11.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:18:00 -0700 (PDT)
Message-ID: <1569003478.5576.202.camel@lca.pw>
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
From:   Qian Cai <cai@lca.pw>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Sep 2019 14:17:58 -0400
In-Reply-To: <87r24bhwng.fsf@linux.ibm.com>
References: <1568988209.5576.199.camel@lca.pw>
         <87r24bhwng.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
> Qian Cai <cai@lca.pw> writes:
> 
> > The linux-next commit "libnvdimm/dax: Pick the right alignment default when
> > creating dax devices" causes powerpc failed to build with this config. Reverted
> > it fixed the issue.
> > 
> > ERROR: "hash__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
> > ERROR: "radix__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko]
> > undefined!
> > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
> > make: *** [Makefile:1305: modules] Error 2
> > 
> > [1] https://patchwork.kernel.org/patch/11133445/
> > [2] https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> Sorry for breaking the build. How about?

It works fine.

> 
> commit ea15fd8b5489e2c8e9f1b96d67248a7428ffb74a
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Fri Sep 20 19:47:56 2019 +0530
> 
>     powerpc/book3s/nvdimm: Fix build error with nvdimm kernel module
>     
>     Fix the below comiple error.
>     
>     ERROR: "hash__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
>     ERROR: "radix__has_transparent_hugepage" [drivers/nvdimm/libnvdimm.ko] undefined!
>     
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index e04a839cb5b9..65a6966f1de4 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -254,7 +254,13 @@ extern void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>  extern pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
>  extern pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
>  				      unsigned long addr, pmd_t *pmdp);
> -extern int radix__has_transparent_hugepage(void);
> +static inline int radix__has_transparent_hugepage(void)
> +{
> +	/* For radix 2M at PMD level means thp */
> +	if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
> +		return 1;
> +	return 0;
> +}
>  #endif
>  
>  extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
> diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> index d1f390ac9cdb..64733b9cb20a 100644
> --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> @@ -406,6 +406,8 @@ int hash__has_transparent_hugepage(void)
>  
>  	return 1;
>  }
> +EXPORT_SYMBOL_GPL(hash__has_transparent_hugepage);
> +
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index b4ca9e95e678..dc7a38f0a45b 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1057,13 +1057,6 @@ pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
>  	return old_pmd;
>  }
>  
> -int radix__has_transparent_hugepage(void)
> -{
> -	/* For radix 2M at PMD level means thp */
> -	if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
> -		return 1;
> -	return 0;
> -}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
