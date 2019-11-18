Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC11C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D413B206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HkS3wVBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRDb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:31:59 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5303 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKRDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:31:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd210ac0000>; Sun, 17 Nov 2019 19:31:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 Nov 2019 19:31:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 Nov 2019 19:31:58 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 03:31:58 +0000
Subject: Re: [PATCH v2] mm: get rid of odd jump labels in
 find_mergeable_anon_vma()
To:     linmiaohe <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <richardw.yang@linux.intel.com>, <sfr@canb.auug.org.au>,
        <rppt@linux.ibm.com>, <jannh@google.com>, <steve.capper@arm.com>,
        <catalin.marinas@arm.com>, <aarcange@redhat.com>,
        <chenjianhong2@huawei.com>, <walken@google.com>,
        <dave.hansen@linux.intel.com>, <tiny.windzz@gmail.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1574047361-30862-1-git-send-email-linmiaohe@huawei.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8235edcf-21b9-7307-d8fb-2a2926cb5162@nvidia.com>
Date:   Sun, 17 Nov 2019 19:31:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574047361-30862-1-git-send-email-linmiaohe@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574047916; bh=lQYGUdIdHwF+Qkoo0zjbN6+sXs1+NGnF9j4plIW/CXs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HkS3wVBaCt3R/9VJr5sREh5h51tQH/mV090L2CHpBdLLVw5mqVjfzayuX1krXqT8/
         z6KgVwWWJbhFLycs2DhoyU9uoggnmFFK2AyZGpe9xW3H37hD1setPfOvDfASdrlMbC
         +H6kzSGBo0PKkUMX2OU1XXBG1NSMyAXf8KMe/Eaa6yht3ZUeowby/dJRAgyhn0dTgI
         PTqKtFmNP6Yv1I103BU+M7Ls8euYeUCftI1mEqnkpPp2kwipVXoD3+1RUgpC1Es4HP
         ap8gvCV/z1EEVKpuOpvZ1fDKadKcPk3XEpbMUliuPC8U5ZvqHcocCeMMra66bOBT2V
         OB8cDOBwSBmbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/19 7:22 PM, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> The jump labels try_prev and none are not really needed
> in find_mergeable_anon_vma(), eliminate them to improve
> readability.
> -v2:
> 	Fix commit descriptions and further simplify the code
> 	as suggested by David Hildenbrand and John Hubbard.

Admin point: the above three lines will end up in the commit log,
which is probably not what you intended. If, instead, you put them 
below the "---" line, then they will act as comments about
the patch, and won't show up in the commit log.


thanks,
-- 
John Hubbard
NVIDIA

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mmap.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4d4db76a07da..ff02c23fd375 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1276,26 +1276,25 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
>   */
>  struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>  {
> -	struct anon_vma *anon_vma;
> +	struct anon_vma *anon_vma = NULL;
>  	struct vm_area_struct *near;
>  
> +	/* Try next first. */
>  	near = vma->vm_next;
> -	if (!near)
> -		goto try_prev;
> +	if (near) {
> +		anon_vma = reusable_anon_vma(near, vma, near);
> +		if (anon_vma)
> +			return anon_vma;
> +	}
>  
> -	anon_vma = reusable_anon_vma(near, vma, near);
> -	if (anon_vma)
> -		return anon_vma;
> -try_prev:
> +	/* Try prev next. */
>  	near = vma->vm_prev;
> -	if (!near)
> -		goto none;
> +	if (near)
> +		anon_vma = reusable_anon_vma(near, near, vma);
>  
> -	anon_vma = reusable_anon_vma(near, near, vma);
> -	if (anon_vma)
> -		return anon_vma;
> -none:
>  	/*
> +	 * We might reach here with anon_vma == NULL if we can't find
> +	 * any reusable anon_vma.
>  	 * There's no absolute need to look only at touching neighbours:
>  	 * we could search further afield for "compatible" anon_vmas.
>  	 * But it would probably just be a waste of time searching,
> @@ -1303,7 +1302,7 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>  	 * We're trying to allow mprotect remerging later on,
>  	 * not trying to minimize memory used for anon_vmas.
>  	 */
> -	return NULL;
> +	return anon_vma;
>  }
>  
>  /*
> 
