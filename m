Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E1CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05236208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QElejmcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfITThH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:37:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4259 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfITThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:37:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d852a680000>; Fri, 20 Sep 2019 12:37:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Sep 2019 12:37:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Sep 2019 12:37:05 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Sep
 2019 19:37:05 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Sep
 2019 19:37:05 +0000
Subject: Re: [PATCH 3/3] mm:fix gup_pud_range
To:     Qiujun Huang <hqjagain@gmail.com>, <akpm@linux-foundation.org>
CC:     <ira.weiny@intel.com>, <jgg@ziepe.ca>, <dan.j.williams@intel.com>,
        <rppt@linux.ibm.com>, <aneesh.kumar@linux.ibm.com>,
        <keith.busch@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1a162778-41b9-4428-1058-82aaf82314b1@nvidia.com>
Date:   Fri, 20 Sep 2019 12:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569008232; bh=oi8jWpJWJ0tRPrMbAPcI1iFMVvLOMUJvV8DWHfUvSaE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QElejmcMr9EsbOUeMc+uMXZK01PdO09YtEhxknTTGQk13YHlLgueX6WAVX0noutEV
         kI6ePAfKuvItB3Hq1H94VyL8N7eQtu9dknI+rmjK7wD0yZ+AyvcdsA9hH8+QOLg9Xv
         OwbI4K7UdQN4vojkXzzkhQcTKz9V9wKCOxseBaEzHt8w5kUGbiRT4sACx007iZAe+N
         wWwfXZkO1uY6BSyqMQASd74utVhPV5FdERtxU2b+acs+msthllgvLLpZK/WYpHvTrg
         d1wgas5GrReesu4+2KIPZPiOErJpFXuIn0YH0eV5+eZWRv6DbsaRnZQU24bQD1YEIZ
         OWauQJ4Gcxf3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/19 8:51 AM, Qiujun Huang wrote:
> __get_user_pages_fast try to walk the page table but the
> hugepage pte is replace by hwpoison swap entry by mca path.

I expect you mean MCE (machine check exception), rather than mca?

> ...
> [15798.177437] mce: Uncorrected hardware memory error in
> 				user-access at 224f1761c0
> [15798.180171] MCE 0x224f176: Killing pal_main:6784 due to
> 				hardware memory corruption
> [15798.180176] MCE 0x224f176: Killing qemu-system-x86:167336
> 				due to hardware memory corruption
> ...
> [15798.180206] BUG: unable to handle kernel
> [15798.180226] paging request at ffff891200003000
> [15798.180236] IP: [<ffffffff8106edae>] gup_pud_range+
> 				0x13e/0x1e0
> ...
> 
> We need to skip the hwpoison entry in gup_pud_range.

It would be nice if this spelled out a little more clearly what's
wrong. I think you and Aneesh are saying that the entry is really
a swap entry, created by the MCE response to a bad page?

> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  mm/gup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98f13ab..6157ed9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>  		next = pud_addr_end(addr, end);
>  		if (pud_none(pud))
>  			return 0;
> +		if (unlikely(!pud_present(pud)))
> +			return 0;

If the MCE hwpoison behavior puts in swap entries, then it seems like all
page table walkers would need to check for p*d_present(), and maybe at all
levels too, right?  

thanks,
-- 
John Hubbard
NVIDIA


>  		if (unlikely(pud_huge(pud))) {
>  			if (!gup_huge_pud(pud, pudp, addr, next, flags,
>  					  pages, nr))
> 
