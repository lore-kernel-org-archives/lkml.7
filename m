Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D842171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IcH1Vq4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDLSwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:52:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2885 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:52:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb0de600000>; Fri, 12 Apr 2019 11:52:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 11:52:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Apr 2019 11:52:19 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 18:52:18 +0000
Subject: Re: [PATCH 1/9] mm: Allow the [page|pfn]_mkwrite callbacks to drop
 the mmap_sem
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20190412160338.64994-1-thellstrom@vmware.com>
 <20190412160338.64994-2-thellstrom@vmware.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <cba8a123-8d8d-c22b-e670-d87ae3ec46a2@nvidia.com>
Date:   Fri, 12 Apr 2019 11:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190412160338.64994-2-thellstrom@vmware.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555095136; bh=o7pYXYebwcZB9VG+SfqHk39wa19WyWkdp0pR+i/f4wo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IcH1Vq4J4rSeqgJQnoLEJb9hwun7XOw2WYaxyxKQCbrYuDvOmT3ZgXFheM2V416Rh
         WP7IdahP6zQOcF8JdvhBxSGWZarcrCtB7aaD2wGupWDCn/X0E2w+wleEJqI/H5e/fQ
         KO9gQ8wsvS/LxO8nIYgGV6SCU2oVfApi6rX20zQ1LvM4+h32eoA4D080vrE3YldHHA
         sVbXiYHGuzjA9VzRFIveZQ2RbpRqVOl0qtqoezcP+6qCvCeNctnNNJKNzw7nq0Sxok
         28HP4HmU45/XGzLeg5wSrw9fl4PCItC/vDgrHuXyEGek48BFv418PbWAbFTCicny+7
         9/EtLR0lLHaSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/19 9:04 AM, Thomas Hellstrom wrote:
> Driver fault callbacks are allowed to drop the mmap_sem when expecting
> long hardware waits to avoid blocking other mm users. Allow the mkwrite
> callbacks to do the same by returning early on VM_FAULT_RETRY.
>=20
> In particular we want to be able to drop the mmap_sem when waiting for
> a reservation object lock on a GPU buffer object. These locks may be
> held while waiting for the GPU.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/memory.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9dd823f..a95b4a3b1ae2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2144,7 +2144,7 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *=
vmf)
>   	ret =3D vmf->vma->vm_ops->page_mkwrite(vmf);
>   	/* Restore original flags so that caller is not surprised */
>   	vmf->flags =3D old_flags;
> -	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
> +	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NOPAGE))=
)

A very minor nit, for consistency elsewhere in mm/memory.c,
could you make this be:
	(VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)

>   		return ret;
>   	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
>   		lock_page(page);
> @@ -2419,7 +2419,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vm=
f)
>   		pte_unmap_unlock(vmf->pte, vmf->ptl);
>   		vmf->flags |=3D FAULT_FLAG_MKWRITE;
>   		ret =3D vma->vm_ops->pfn_mkwrite(vmf);
> -		if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
> +		if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY | VM_FAULT_NOPAGE))
>   			return ret;
>   		return finish_mkwrite_fault(vmf);
>   	}
> @@ -2440,7 +2440,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *v=
mf)
>   		pte_unmap_unlock(vmf->pte, vmf->ptl);
>   		tmp =3D do_page_mkwrite(vmf);
>   		if (unlikely(!tmp || (tmp &
> -				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> +				      (VM_FAULT_ERROR | VM_FAULT_RETRY |
> +				       VM_FAULT_NOPAGE)))) {
>   			put_page(vmf->page);
>   			return tmp;
>   		}
> @@ -3494,7 +3495,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *=
vmf)
>   		unlock_page(vmf->page);
>   		tmp =3D do_page_mkwrite(vmf);
>   		if (unlikely(!tmp ||
> -				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> +				(tmp & (VM_FAULT_ERROR | VM_FAULT_RETRY |
> +					VM_FAULT_NOPAGE)))) {
>   			put_page(vmf->page);
>   			return tmp;
>   		}
>=20
