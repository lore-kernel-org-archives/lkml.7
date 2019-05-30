Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB58C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423AE26213
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfE3Vzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:55:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:2131 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfE3Vzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:55:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 14:46:34 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2019 14:46:33 -0700
Date:   Thu, 30 May 2019 14:47:26 -0700
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
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190530214726.GA14000@iweiny-DESK2.sc.intel.com>
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 06:54:04AM +0800, Pingfan Liu wrote:
> As for FOLL_LONGTERM, it is checked in the slow path
> __gup_longterm_unlocked(). But it is not checked in the fast path, which
> means a possible leak of CMA page to longterm pinned requirement through
> this crack.
> 
> Place a check in the fast path.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
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
>  mm/gup.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f173fcb..00feab3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2235,6 +2235,18 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  		local_irq_enable();
>  		ret = nr;
>  	}
> +#if defined(CONFIG_CMA)
> +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
> +		int i, j;
> +
> +		for (i = 0; i < nr; i++)
> +			if (is_migrate_cma_page(pages[i])) {
> +				for (j = i; j < nr; j++)
> +					put_page(pages[j]);

Should be put_user_page() now.  For now that just calls put_page() but it is
slated to change soon.

I also wonder if this would be more efficient as a check as we are walking the
page tables and bail early.

Perhaps the code complexity is not worth it?

> +				nr = i;

Why not just break from the loop here?

Or better yet just use 'i' in the inner loop...

Ira

> +			}
> +	}
> +#endif
>  
>  	if (nr < nr_pages) {
>  		/* Try to get the remaining pages with get_user_pages */
> -- 
> 2.7.5
> 
