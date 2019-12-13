Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ECC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0E7206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oJ3bYl1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLMVkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:40:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9756 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLMVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:40:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df405380000>; Fri, 13 Dec 2019 13:40:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 13 Dec 2019 13:40:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 13 Dec 2019 13:40:16 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Dec
 2019 21:40:15 +0000
Subject: Re: [PATCH] mm/gup: Fix memory leak in __gup_benchmark_ioctl
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>
References: <20191211174653.4102-1-navid.emamdoost@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
Date:   Fri, 13 Dec 2019 13:40:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211174653.4102-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576273208; bh=kns9lRLNk7iBLl+oznMVtZYqw3+QAeHuGv8ec9B6yws=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oJ3bYl1Z5Gpmdvi7Y6NeGtebuuLGEPCWYNqk3tJzDS3MKEoKKqQUKczkvTc6g7KXL
         WyMondT5BBwHQvhYCCmEvUBq8ERzzLR+bydBWA3Fz+u0U0ZuSJzsh3R10KQOn2t+xS
         84trCd9TjfilpWf6ixPvaTLnkJC4zq3h7/8gLx5o16nSgn4w2QYy4cTqwy7ORXT1wf
         DAaliJCEMTzjHL70kcOVSVJ78IYGj4nnw1jw8eQb5oTzgBU/+1kRg24hFLa+bAu+BE
         vqokTJcSremr/xFOXkvqxSe9SRoCZZO4IySFSSZTytlku/65NSJDSbWuV2bzAdJ6hw
         8dScaKdl6pHtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:46 AM, Navid Emamdoost wrote:
> In the implementation of __gup_benchmark_ioctl() the allocated pages
> should be released before returning in case of an invalid cmd. Release
> pages via kvfree().
> 
> Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  mm/gup_benchmark.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 7dd602d7f8db..b160638f647e 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -63,6 +63,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  					    NULL);
>  			break;
>  		default:
> +			kvfree(pages);
>  			return -1;
>  		}
>  

Hi,

The patch is correct, but I would like to second Ira's request for a ret value,
and a "goto done" to use a single place to kvfree, if you don't mind. 

Either way, you can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
 
