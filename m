Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D8B2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLMXMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:12:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:64745 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMXMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:12:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 15:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="211583507"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2019 15:12:34 -0800
Date:   Fri, 13 Dec 2019 15:12:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu, jhubbard@nvidia.com
Subject: Re: [PATCH v2] mm/gup: Fix memory leak in __gup_benchmark_ioctl
Message-ID: <20191213231234.GB8347@iweiny-DESK2.sc.intel.com>
References: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
 <20191213223751.4089-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213223751.4089-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 04:37:41PM -0600, Navid Emamdoost wrote:
> In the implementation of __gup_benchmark_ioctl() the allocated pages
> should be released before returning in case of an invalid cmd. Release
> pages via kvfree() by goto done.
> 
> Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changes in v2:
> 	-- added goto and ret value instead of return -1.
> ---
>  mm/gup_benchmark.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
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
> -- 
> 2.17.1
> 
> 
