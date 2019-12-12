Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9A6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA5E21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfLLXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:14:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:15504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbfLLXO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:14:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 15:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="364129616"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2019 15:14:57 -0800
Date:   Thu, 12 Dec 2019 15:14:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu
Subject: Re: [PATCH] mm/gup: Fix memory leak in __gup_benchmark_ioctl
Message-ID: <20191212231456.GA31115@iweiny-DESK2.sc.intel.com>
References: <20191211174653.4102-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211174653.4102-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:46:51AM -0600, Navid Emamdoost wrote:
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

I wonder if adding a ret value and a goto where the free is done would be
better.  But may be overkill at this time.  So...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  			return -1;
>  		}
>  
> -- 
> 2.17.1
> 
