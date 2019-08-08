Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3538AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D82171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l5IhY/V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfHHXVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:21:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16780 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbfHHXVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:21:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cae8b0000>; Thu, 08 Aug 2019 16:21:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:21:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 16:21:45 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:21:45 +0000
Subject: Re: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup
 functions
To:     Bharath Vedartham <linux.bhar@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <sivanich@sgi.com>
CC:     <ira.weiny@intel.com>, <jglisse@redhat.com>,
        <william.kucharski@oracle.com>, <hch@lst.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
 <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
Date:   Thu, 8 Aug 2019 16:21:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565306507; bh=+5ClyXF4/+matB7j6ropEiCrm63pptXnzihc56YYTPY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l5IhY/V8wKpl1V8ijQzYcYptStoxXGnVHOhdeyz+62DluKzAguhVGZiCGRezc95/U
         U8C6lT2MUtBedJD6kwr7Jr7y0OfIyp3vjjn8DI1jErn0J4NJeZs9lx6UF3OsV+59PF
         l9qKdPDJk9lnGXFf/ud/g8F09AgJn0qSM+zmSFnnYPTfYywdwSxcSAhkZRvLOWY1fO
         GdRjyB+IPWpS5D+ip+y8DKkG89yqpP1f/za6Lv89SZGgGtFsR+oiXNE6uljc1cMMJ1
         vMRXg4Fs1Odywn1ugGiScfNOrclLqL0LzNz6i4WqKlB6fPKlo6RISUsFSt4Ex1WFaP
         DGa3Uuu+Ljl7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 11:55 AM, Bharath Vedartham wrote:
...
>  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
>  		    int write, int atomic, unsigned long *gpa, int *pageshift)
>  {
>  	struct mm_struct *mm = gts->ts_mm;
>  	struct vm_area_struct *vma;
>  	unsigned long paddr;
> -	int ret, ps;
> +	int ret;
> +	struct page *page;
>  
>  	vma = find_vma(mm, vaddr);
>  	if (!vma)
> @@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
>  
>  	/*
>  	 * Atomic lookup is faster & usually works even if called in non-atomic
> -	 * context.
> +	 * context. get_user_pages_fast does atomic lookup before falling back to
> +	 * slow gup.
>  	 */
>  	rmb();	/* Must/check ms_range_active before loading PTEs */
> -	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
> -	if (ret) {
> -		if (atomic)
> +	if (atomic) {
> +		ret = __get_user_pages_fast(vaddr, 1, write, &page);
> +		if (!ret)
>  			goto upm;
> -		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
> +	} else {
> +		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
> +		if (!ret)
>  			goto inval;
>  	}
> +
> +	paddr = page_to_phys(page);
> +	put_user_page(page);
> +
> +	if (unlikely(is_vm_hugetlb_page(vma)))
> +		*pageshift = HPAGE_SHIFT;
> +	else
> +		*pageshift = PAGE_SHIFT;
> +
>  	if (is_gru_paddr(paddr))
>  		goto inval;
> -	paddr = paddr & ~((1UL << ps) - 1);
> +	paddr = paddr & ~((1UL << *pageshift) - 1);
>  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> -	*pageshift = ps;

Why are you no longer setting *pageshift? There are a couple of callers
that both use this variable.


thanks,
-- 
John Hubbard
NVIDIA
