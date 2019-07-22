Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25EC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE58921901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1SlHMSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfGVRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:50:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35416 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:50:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so17746188pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/LORfxhH4cPCyhMYt6N2Wj9cKNe2qt9hnR1X3sMowdQ=;
        b=n1SlHMSojQt0P7r4oOYQHnxtZpqyOPYp6kEQKFu9QtR2xjN41TFnIsvdRCN+aCtxPl
         4k3OiuK9FPft3Q4bXlV4mmO1yp2bxWNtUE1rsSa4pnvA9Bs7PR2Xr6ODcmZR6dvZnF7W
         tbm6cXf5r+0tUaqTxfRb7v8NZgjzLCiDBMWZFhhYTf7yPXHdIVEoVrJmzknZF4BL/M19
         iDyHcbXXPQjpRFq74i/6P8XHmdaBtL2B0x5StS3f+oxCxdIOUQwRKblPX4SXmXRlUO9z
         ta+dSgEQrvq1LWUSPv600HB+SGa25QRnyYIYPcLSw9vXg8nvthD5S/omzUjpaEJSmOqU
         nesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/LORfxhH4cPCyhMYt6N2Wj9cKNe2qt9hnR1X3sMowdQ=;
        b=SsJcJCh+ngLjbvY7V7TkkDsMEk+hZi0saChTpINUzYwGIZ38HLfvciRAOZISh4ekmY
         DsnXt0QrRm7u+alvYNaX3QeNJhal+XBlsIB/EGLF6yOPGMqEUo1Mm/PE7h5DqGt7F/IR
         saeKEb0uiIFp+SsVLa8XzA256Ea6lIm3eWnXVS8y2hfUTDpFI11L2NIq6pw7O2c7+rYs
         N4Jamv+WirgfoMGEKhYw8YNt5JjE3pP7pey0STe9yfX5wR7s23wotmQl4L7K0rTVz605
         VxyL7zMux1WmqI3prdzi7X88H+fAtrd55Yhe5LHGZReROEVOaBeRIk6eVNdUbUH+DxlQ
         LvtA==
X-Gm-Message-State: APjAAAU2Fjak3J0iJZrQ6IT///5HK3EbPrTjMZkhIeGTn+2U+ENQ9Cp7
        Q9WrX7iCUDVir9DNHxANDd0=
X-Google-Smtp-Source: APXvYqz1ZJ0Sw8KehKmYgjC5235A6lpjGgfo2wFuW+DCqMntVVX0am9/kqG+nW9cfKzlFJdJFG+tNg==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr1343927pfh.56.1563817829565;
        Mon, 22 Jul 2019 10:50:29 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id t2sm35502130pgo.61.2019.07.22.10.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:50:29 -0700 (PDT)
Date:   Mon, 22 Jul 2019 23:20:22 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] sgi-gru: Remove CONFIG_HUGETLB_PAGE ifdef
Message-ID: <20190722175022.GB12278@bharath12345-Inspiron-5559>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-3-git-send-email-linux.bhar@gmail.com>
 <1BA84A99-4EB5-4520-BFBD-CD60D5B7AED9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1BA84A99-4EB5-4520-BFBD-CD60D5B7AED9@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 09:20:38PM -0600, William Kucharski wrote:
> I suspect I'm being massively pedantic here, but the comments for atomic_pte_lookup() note:
> 
>  * Only supports Intel large pages (2MB only) on x86_64.
>  *	ZZZ - hugepage support is incomplete
> 
> That makes me wonder how many systems using this hardware are actually configured with CONFIG_HUGETLB_PAGE.
> 
> I ask as in the most common case, this is likely introducing a few extra instructions and possibly an additional branch to a routine that is called per-fault.
> 
> So the nit-picky questions are:
> 
> 1) Does the code really need to be cleaned up in this way?
> 
> 2) If it does, does it make more sense (given the way pmd_large() is handled now in atomic_pte_lookup()) for this to be coded as:
> 
> if (unlikely(is_vm_hugetlb_page(vma)))
> 	*pageshift = HPAGE_SHIFT;
> else
> 	*pageshift = PAGE_SHIFT;
> 
> In all likelihood, these questions are no-ops, and the optimizer may even make my questions completely moot, but I thought I might as well ask anyway.
> 
That sounds reasonable. I am not really sure as to how much of 
an improvement it would be, the condition will be evaluated eitherways
AFAIK? Eitherways, the ternary operator does not look good. I ll make a
version 2 of this.
> > On Jul 21, 2019, at 9:58 AM, Bharath Vedartham <linux.bhar@gmail.com> wrote:
> > 
> > is_vm_hugetlb_page has checks for whether CONFIG_HUGETLB_PAGE is defined
> > or not. If CONFIG_HUGETLB_PAGE is not defined is_vm_hugetlb_page will
> > always return false. There is no need to have an uneccessary
> > CONFIG_HUGETLB_PAGE check in the code.
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dimitri Sivanich <sivanich@sgi.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> > drivers/misc/sgi-gru/grufault.c | 11 +++--------
> > 1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 61b3447..75108d2 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -180,11 +180,8 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> > {
> > 	struct page *page;
> > 
> > -#ifdef CONFIG_HUGETLB_PAGE
> > 	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > +
> > 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> > 		return -EFAULT;
> > 	*paddr = page_to_phys(page);
> > @@ -238,11 +235,9 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
> > 		return 1;
> > 
> > 	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> > -#ifdef CONFIG_HUGETLB_PAGE
> > +
> > 	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > +
> > 	return 0;
> > 
> > err:
> > -- 
> > 2.7.4
> > 
> 
