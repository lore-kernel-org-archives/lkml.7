Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC998C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17A0214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552394647;
	bh=iDmTigBJmIE8LZYaENOkngqjl0nhAtLQY+yB7sNcAxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nEZULuio4vaPCKlbOvA3ZtL3pJSk/UB1tMxtcPcYFeOpxSjk+Rm6evdI2wT1D1Afz
	 JCofgzHxzamROPXxttMTGSPkOAGSdINMDC/y2MLBNwX3N+Thy5y8DLSoR55GLxkzcF
	 HNnFljFqB/fn9B7rj7VPEaHEn2ze1m96wannV5ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCLMoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfCLMoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:44:06 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC67206BA;
        Tue, 12 Mar 2019 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552394644;
        bh=iDmTigBJmIE8LZYaENOkngqjl0nhAtLQY+yB7sNcAxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lm2Fm0WPeOv7qpbtCTa86JSDZU1fE84hBGp4iPwE7TSSAemJgX8Iis+XNm2U2qznC
         56BC4Wq4ElEZyJk2Xl0ngKw9ElUGTvjJnk64LihwYc+qrd+3q0tffEAX1FMpR6brl2
         Sls6tvSEwGdFufzrN8NXgnijWVd505Nmw3sejO6w=
Date:   Tue, 12 Mar 2019 05:44:04 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH RESEND for-5.0 2/2] staging: erofs: compressed_pages
 should not be accessed again after freed
Message-ID: <20190312124404.GE14713@kroah.com>
References: <20190311022932.13539-1-gaoxiang25@huawei.com>
 <20190311022932.13539-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311022932.13539-2-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:29:32AM +0800, Gao Xiang wrote:
> commit af692e117cb8cd9d3d844d413095775abc1217f9 upstream.
> 
> This patch resolves the following page use-after-free issue,
> z_erofs_vle_unzip:
>     ...
>     for (i = 0; i < nr_pages; ++i) {
>         ...
>         z_erofs_onlinepage_endio(page);  (1)
>     }
> 
>     for (i = 0; i < clusterpages; ++i) {
>         page = compressed_pages[i];
> 
>         if (page->mapping == mngda)      (2)
>             continue;
>         /* recycle all individual staging pages */
>         (void)z_erofs_gather_if_stagingpage(page_pool, page); (3)
>         WRITE_ONCE(compressed_pages[i], NULL);
>     }
>     ...
> 
> After (1) is executed, page is freed and could be then reused, if
> compressed_pages is scanned after that, it could fall info (2) or
> (3) by mistake and that could finally be in a mess.
> 
> This patch aims to solve the above issue only with little changes
> as much as possible in order to make the fix backport easier.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c     | 38 ++++++++++++++++++-----------------
>  drivers/staging/erofs/unzip_vle.h     |  3 +--
>  drivers/staging/erofs/unzip_vle_lz4.c | 19 ++++++++----------
>  3 files changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index ca2e8fd78959..ab30d14ded06 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -1017,11 +1017,10 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>  	if (llen > grp->llen)
>  		llen = grp->llen;
>  
> -	err = z_erofs_vle_unzip_fast_percpu(compressed_pages,
> -		clusterpages, pages, llen, work->pageofs,
> -		z_erofs_onlinepage_endio);
> +	err = z_erofs_vle_unzip_fast_percpu(compressed_pages, clusterpages,
> +					    pages, llen, work->pageofs);
>  	if (err != -ENOTSUPP)
> -		goto out_percpu;
> +		goto out;
>  
>  	if (sparsemem_pages >= nr_pages)
>  		goto skip_allocpage;
> @@ -1042,8 +1041,25 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>  	erofs_vunmap(vout, nr_pages);
>  
>  out:
> +	/* must handle all compressed pages before endding pages */
> +	for (i = 0; i < clusterpages; ++i) {
> +		page = compressed_pages[i];
> +
> +#ifdef EROFS_FS_HAS_MANAGED_CACHE
> +		if (page->mapping == MNGD_MAPPING(sbi))
> +			continue;
> +#endif
> +		/* recycle all individual staging pages */
> +		(void)z_erofs_gather_if_stagingpage(page_pool, page);
> +
> +		WRITE_ONCE(compressed_pages[i], NULL);
> +	}
> +
>  	for (i = 0; i < nr_pages; ++i) {
>  		page = pages[i];
> +		if (!page)
> +			continue;
> +
>  		DBG_BUGON(!page->mapping);
>  
>  		/* recycle all individual staging pages */
> @@ -1056,20 +1072,6 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>  		z_erofs_onlinepage_endio(page);
>  	}
>  
> -out_percpu:
> -	for (i = 0; i < clusterpages; ++i) {
> -		page = compressed_pages[i];
> -
> -#ifdef EROFS_FS_HAS_MANAGED_CACHE
> -		if (page->mapping == MNGD_MAPPING(sbi))
> -			continue;
> -#endif
> -		/* recycle all individual staging pages */
> -		(void)z_erofs_gather_if_stagingpage(page_pool, page);
> -
> -		WRITE_ONCE(compressed_pages[i], NULL);
> -	}
> -
>  	if (pages == z_pagemap_global)
>  		mutex_unlock(&z_pagemap_global_lock);
>  	else if (unlikely(pages != pages_onstack))
> diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
> index 5a4e1b62c0d1..c0dfd6906aa8 100644
> --- a/drivers/staging/erofs/unzip_vle.h
> +++ b/drivers/staging/erofs/unzip_vle.h
> @@ -218,8 +218,7 @@ extern int z_erofs_vle_plain_copy(struct page **compressed_pages,
>  
>  extern int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
>  	unsigned clusterpages, struct page **pages,
> -	unsigned outlen, unsigned short pageofs,
> -	void (*endio)(struct page *));
> +	unsigned int outlen, unsigned short pageofs);
>  
>  extern int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
>  	unsigned clusterpages, void *vaddr, unsigned llen,
> diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
> index 52797bd89da1..f471b894c848 100644
> --- a/drivers/staging/erofs/unzip_vle_lz4.c
> +++ b/drivers/staging/erofs/unzip_vle_lz4.c
> @@ -125,8 +125,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
>  				  unsigned int clusterpages,
>  				  struct page **pages,
>  				  unsigned int outlen,
> -				  unsigned short pageofs,
> -				  void (*endio)(struct page *))
> +				  unsigned short pageofs)
>  {
>  	void *vin, *vout;
>  	unsigned int nr_pages, i, j;
> @@ -148,19 +147,16 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
>  	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
>  				clusterpages * PAGE_SIZE, outlen);
>  
> -	if (ret >= 0) {
> -		outlen = ret;
> -		ret = 0;
> -	}
> +	if (ret < 0)
> +		goto out;
> +	ret = 0;
>  
>  	for (i = 0; i < nr_pages; ++i) {
>  		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
>  
>  		if (pages[i]) {
> -			if (ret < 0) {
> -				SetPageError(pages[i]);
> -			} else if (clusterpages == 1 &&
> -				   pages[i] == compressed_pages[0]) {
> +			if (clusterpages == 1 &&
> +			    pages[i] == compressed_pages[0]) {
>  				memcpy(vin + pageofs, vout + pageofs, j);
>  			} else {
>  				void *dst = kmap_atomic(pages[i]);
> @@ -168,12 +164,13 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
>  				memcpy(dst + pageofs, vout + pageofs, j);
>  				kunmap_atomic(dst);
>  			}
> -			endio(pages[i]);
>  		}
>  		vout += PAGE_SIZE;
>  		outlen -= j;
>  		pageofs = 0;
>  	}
> +
> +out:
>  	preempt_enable();
>  
>  	if (clusterpages == 1)
> -- 
> 2.14.5
>

Now applied, thanks.

greg k-h
