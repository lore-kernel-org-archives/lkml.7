Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45B5C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4072148D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfDWRAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:00:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:30818 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfDWRAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:00:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="318293329"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2019 10:00:30 -0700
Date:   Tue, 23 Apr 2019 10:00:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc-fixes tree
Message-ID: <20190423170044.GA30084@iweiny-DESK2.sc.intel.com>
References: <20190423190606.0fefb856@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423190606.0fefb856@canb.auug.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:06:06PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in:
> 
>   arch/powerpc/mm/mmu_context_iommu.c
> 
> between commits:
> 
>   eb9d7a62c386 ("powerpc/mm_iommu: Fix potential deadlock")
>   7a3a4d763837 ("powerpc/mm_iommu: Allow pinning large regions")
> 
> from the powerpc-fixes tree and commit:
> 
>   02f506bad7af ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTERM")
> 
> from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

Thanks Stephen

Looks good for my changes.

Acked-by: Ira Weiny <ira.weiny@intel.com>

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/powerpc/mm/mmu_context_iommu.c
> index 8330f135294f,755fe7adc0d8..000000000000
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@@ -135,27 -144,18 +131,28 @@@ static long mm_iommu_do_alloc(struct mm
>   	}
>   
>   	down_read(&mm->mmap_sem);
>  -	ret = get_user_pages(ua, entries, FOLL_WRITE | FOLL_LONGTERM,
>  -			     mem->hpages, NULL);
>  +	chunk = (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
>  +			sizeof(struct vm_area_struct *);
>  +	chunk = min(chunk, entries);
>  +	for (entry = 0; entry < entries; entry += chunk) {
>  +		unsigned long n = min(entries - entry, chunk);
>  +
> - 		ret = get_user_pages_longterm(ua + (entry << PAGE_SHIFT), n,
> - 				FOLL_WRITE, mem->hpages + entry, NULL);
> ++		ret = get_user_pages(ua + (entry << PAGE_SHIFT), n,
> ++				     FOLL_WRITE | FOLL_LONGTERM,
> ++				     mem->hpages + entry, NULL);
>  +		if (ret == n) {
>  +			pinned += n;
>  +			continue;
>  +		}
>  +		if (ret > 0)
>  +			pinned += ret;
>  +		break;
>  +	}
>   	up_read(&mm->mmap_sem);
>  -	if (ret != entries) {
>  -		/* free the reference taken */
>  -		for (i = 0; i < ret; i++)
>  -			put_page(mem->hpages[i]);
>  -
>  -		vfree(mem->hpas);
>  -		kfree(mem);
>  -		ret = -EFAULT;
>  -		goto unlock_exit;
>  +	if (pinned != entries) {
>  +		if (!ret)
>  +			ret = -EFAULT;
>  +		goto free_exit;
>   	}
>   
>   	pageshift = PAGE_SHIFT;


