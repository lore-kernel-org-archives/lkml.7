Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C72C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9855121537
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfFMV0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:26:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:43502 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMV0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:26:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 14:26:39 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2019 14:26:38 -0700
Date:   Thu, 13 Jun 2019 14:28:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/3] mm/gup: rename nr as nr_pinned in
 get_user_pages_fast()
Message-ID: <20190613212800.GD32404@iweiny-DESK2.sc.intel.com>
References: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
 <1560422702-11403-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560422702-11403-2-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:45:00PM +0800, Pingfan Liu wrote:
> To better reflect the held state of pages and make code self-explaining,
> rename nr as nr_pinned.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f173fcb..766ae54 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2216,7 +2216,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
>  {
>  	unsigned long addr, len, end;
> -	int nr = 0, ret = 0;
> +	int nr_pinned = 0, ret = 0;
>  
>  	start &= PAGE_MASK;
>  	addr = start;
> @@ -2231,25 +2231,25 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  
>  	if (gup_fast_permitted(start, nr_pages)) {
>  		local_irq_disable();
> -		gup_pgd_range(addr, end, gup_flags, pages, &nr);
> +		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
>  		local_irq_enable();
> -		ret = nr;
> +		ret = nr_pinned;
>  	}
>  
> -	if (nr < nr_pages) {
> +	if (nr_pinned < nr_pages) {
>  		/* Try to get the remaining pages with get_user_pages */
> -		start += nr << PAGE_SHIFT;
> -		pages += nr;
> +		start += nr_pinned << PAGE_SHIFT;
> +		pages += nr_pinned;
>  
> -		ret = __gup_longterm_unlocked(start, nr_pages - nr,
> +		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
>  					      gup_flags, pages);
>  
>  		/* Have to be a bit careful with return values */
> -		if (nr > 0) {
> +		if (nr_pinned > 0) {
>  			if (ret < 0)
> -				ret = nr;
> +				ret = nr_pinned;
>  			else
> -				ret += nr;
> +				ret += nr_pinned;
>  		}
>  	}
>  
> -- 
> 2.7.5
> 
