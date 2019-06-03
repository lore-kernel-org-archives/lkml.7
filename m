Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC927B3C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfFCO7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:59:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:34041 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfFCO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 07:59:00 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2019 07:58:59 -0700
Date:   Mon, 3 Jun 2019 08:00:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190603150007.GA26623@iweiny-DESK2.sc.intel.com>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:34:12PM +0800, Pingfan Liu wrote:
> As for FOLL_LONGTERM, it is checked in the slow path
> __gup_longterm_unlocked(). But it is not checked in the fast path, which
> means a possible leak of CMA page to longterm pinned requirement through
> this crack.
> 
> Place a check in the fast path.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f173fcb..6fe2feb 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2196,6 +2196,29 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>  	return ret;
>  }
>  
> +#if defined(CONFIG_CMA)
> +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> +	struct page **pages)
> +{
> +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
> +		int i = 0;
> +
> +		for (i = 0; i < nr_pinned; i++)
> +			if (is_migrate_cma_page(pages[i])) {
> +				put_user_pages(pages + i, nr_pinned - i);
> +				return i;
> +			}
> +	}
> +	return nr_pinned;
> +}
> +#else
> +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> +	struct page **pages)
> +{
> +	return nr_pinned;
> +}
> +#endif
> +
>  /**
>   * get_user_pages_fast() - pin user pages in memory
>   * @start:	starting user address
> @@ -2236,6 +2259,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  		ret = nr;
>  	}
>  
> +	nr = reject_cma_pages(nr, gup_flags, pages);
>  	if (nr < nr_pages) {
>  		/* Try to get the remaining pages with get_user_pages */
>  		start += nr << PAGE_SHIFT;
> -- 
> 2.7.5
> 
