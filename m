Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C3CC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E02821655
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 00:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NthJMitm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNAoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:44:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19066 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfLNAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 19:44:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df4306e0000>; Fri, 13 Dec 2019 16:44:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 13 Dec 2019 16:44:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 13 Dec 2019 16:44:37 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 14 Dec
 2019 00:44:37 +0000
Subject: Re: [PATCH v2] mm/gup: Fix memory leak in __gup_benchmark_ioctl
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>
References: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
 <20191213223751.4089-1-navid.emamdoost@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2690f981-7291-f3fd-2f28-5d16f697f320@nvidia.com>
Date:   Fri, 13 Dec 2019 16:44:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213223751.4089-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576284270; bh=MLaoq1HvWNuPndisp3PFCN1X+uEl1V/8kfciklEUVvo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NthJMitmyfjMWWnOwkaPgexAM26yp3PDLlBswnZOF/FRCLfiC5v4JV/rJYt9D0b6N
         trjEm2jVRc3c/anL8vW8YWLncJJP0TfVcJRASDReBnMGfdd4kUrgHcG2mtMt3WqSXn
         fvUKaz4CGy0yazLdEfcw3MpbOlvsajTar/oBNjVwrVUMXgH8m0eHxQv9Lf7mzfo5EC
         u8t18fJPT0luUO3iEM1LRaa7Y1XJHDYkLwQXEF+3yv+rgWqTTz/Y8nPPDJ4AzJ4Vqw
         Tkh5prl5KGrZkgVdYroJwicr5SXt3jNHUswUVjaSlXkrv43IzsO2dYmHL2F0H2wmL+
         e0Mu5QOnfi/9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 2:37 PM, Navid Emamdoost wrote:
> In the implementation of __gup_benchmark_ioctl() the allocated pages
> should be released before returning in case of an invalid cmd. Release
> pages via kvfree() by goto done.
> 
> Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	-- added goto and ret value instead of return -1.
> ---
>  mm/gup_benchmark.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index b160638f647e..b773b2568544 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -24,7 +24,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  {
>  	ktime_t start_time, end_time;
>  	unsigned long i, nr_pages, addr, next;
> -	int nr;
> +	int nr, ret = 0;
>  	struct page **pages;
>  
>  	if (gup->size > ULONG_MAX)
> @@ -63,8 +63,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  					    NULL);
>  			break;
>  		default:
> -			kvfree(pages);
> -			return -1;
> +			ret = -EINVAL;
> +			goto done;
>  		}
>  
>  		if (nr <= 0)
> @@ -85,8 +85,9 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  	end_time = ktime_get();
>  	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
>  
> +done:
>  	kvfree(pages);
> -	return 0;
> +	return ret;
>  }
>  
>  static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
> 
