Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF7AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BE257E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lpkY7WCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE3LKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:10:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35980 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3LKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:10:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so8599508edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSkSGsERCoxbVMjuBLGVoXhettT+4ucAo/Muobuws1w=;
        b=lpkY7WCIeRrNPvejtIJrZOSMqBOD2vDAEol+ZNroa6YsXWMIJbffjnG++O0mHhs/s2
         i1cbel557QTceaU6PiiqPPXPIEn4ltxuN9kVRbGA3cvMEx55Td2NymONssG41sIWudKS
         aG3LojlM+mL9pGk8pgG8SNcX7gtiEbRMRLhB4IJS1wbypMnIO+Uaz2fqjQeGZVb3WMtM
         p6QY7EGsDqLuwY+6AMB5xpWilqj9hXwD/uRZuMBer9TjERT+BqLFHdsUXDX1y9tHCF8z
         dSOHLSOq+f+GpDbUXTkBSycGjbDinpnrR2PCZwaoYO3kXZaNREuCBs8SlhNKrfX0UJ7x
         bkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSkSGsERCoxbVMjuBLGVoXhettT+4ucAo/Muobuws1w=;
        b=EWdgvfZVJVIsBo5Jc5zgFFRhwRD47/u2AZ8oZDTitIO1Q46e266oJ59t6be/kI9pNQ
         FT3xHCoPUDKqv70iU7inukmdN4w0p/ghnUZJ9vifEujxtBYRYnQYHthnjxQZPwIg6zFl
         d3W8IMqjy/1Ty9rI+RFk4ozRRURKP9MyfqN/yFaYluOZM2s610Re8Bq8wFmTLQDtN6p6
         sW2Y6qiGhCeqCD7SC6PmeWrBZ+NnnKcgkAGx2xQEdn2b2EQc+33yx68B6TOEKliw4gD4
         l5KWtt0J75C39t4byX3AhfuIps6GmCIEJwqsiuRv4IRWDDiVS7Kq0/b9KPJfCP9luIL7
         v0zg==
X-Gm-Message-State: APjAAAWApco7eL2A6SH8ryfKxR5n80JlljoylRnrrOanD0pccB0JYLcm
        RFMaf0XFBwUaLvwXkyP9E+9RlQ==
X-Google-Smtp-Source: APXvYqyW4R+ymHjIY8r1F5s9hVOwh6JcUfNtfsYZlmiMn7r4TUnwNLPTQqYnMzNAsKVlV7WZfDDmBA==
X-Received: by 2002:a50:ba13:: with SMTP id g19mr3698011edc.236.1559214617675;
        Thu, 30 May 2019 04:10:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v15sm378833ejj.23.2019.05.30.04.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:10:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 424FB1041ED; Thu, 30 May 2019 14:10:15 +0300 (+03)
Date:   Thu, 30 May 2019 14:10:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, namit@vmware.com,
        peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, chad.mynhier@oracle.com,
        mike.kravetz@oracle.com
Subject: Re: [PATCH uprobe, thp 1/4] mm, thp: allow preallocate pgtable for
 split_huge_pmd_address()
Message-ID: <20190530111015.bz2om5aelsmwphwa@box>
References: <20190529212049.2413886-1-songliubraving@fb.com>
 <20190529212049.2413886-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529212049.2413886-2-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:20:46PM -0700, Song Liu wrote:
> @@ -2133,10 +2133,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>  	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>  				&& !pmd_devmap(*pmd));
> +	/* only file backed vma need preallocate pgtable*/
> +	VM_BUG_ON(vma_is_anonymous(vma) && prealloc_pgtable);
>  
>  	count_vm_event(THP_SPLIT_PMD);
>  
> -	if (!vma_is_anonymous(vma)) {
> +	if (prealloc_pgtable) {
> +		pgtable_trans_huge_deposit(mm, pmd, prealloc_pgtable);
> +		mm_inc_nr_pmds(mm);
> +	} else if (!vma_is_anonymous(vma)) {
>  		_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
>  		/*
>  		 * We are going to unmap this huge page. So

Nope. This going to leak a page table for architectures where
arch_needs_pgtable_deposit() is true.

-- 
 Kirill A. Shutemov
