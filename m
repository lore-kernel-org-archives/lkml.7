Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF7C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC2520684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559771354;
	bh=o9XCwaZGzE63JH3BlHeLxlRN4g5v0bjuEKLTtVdRVy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BjbtyznRDAlPcxoshI2uiYrMY20g5rFbrZXcDgp9Wv0Xi58AhNdlCZ9bbBDAvGXaa
	 gtE6MTUnzrdtKz5R/VLIr93V8U7ZTkZCYEOd9Ck77r1CI6MTKu2/RE3ql7eutaEmVi
	 561PTR3y/P7pWJesQWVPb+2lrucmxz0EUUqK2X4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFEVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:49:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F662067C;
        Wed,  5 Jun 2019 21:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559771352;
        bh=o9XCwaZGzE63JH3BlHeLxlRN4g5v0bjuEKLTtVdRVy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=voYT0mE2QFPaaXfMNidp8XKZzbdetXlW2uiRL+mWOB7xc4nLzric/yQRfNuPzD+hG
         ltqSZsu4WPGkKl00DUSjIT3Z/2NtvKQLAI0yliqubD6O1B2ARXWZ6grl4zUSxZlkhl
         ngSgZ0UkH+RQp0JVpDU8lm3O3ftfuUyH8Tk5OVyM=
Date:   Wed, 5 Jun 2019 14:49:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-Id: <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
In-Reply-To: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jun 2019 17:10:19 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:

> As for FOLL_LONGTERM, it is checked in the slow path
> __gup_longterm_unlocked(). But it is not checked in the fast path, which
> means a possible leak of CMA page to longterm pinned requirement through
> this crack.
> 
> Place a check in the fast path.

I'm not actually seeing a description (in either the existing code or
this changelog or patch) an explanation of *why* we wish to exclude CMA
pages from longterm pinning.

> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_CMA
> +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pinned; i++)
> +		if (is_migrate_cma_page(pages[i])) {
> +			put_user_pages(pages + i, nr_pinned - i);
> +			return i;
> +		}
> +
> +	return nr_pinned;
> +}

There's no point in inlining this.

The code seems inefficient.  If it encounters a single CMA page it can
end up discarding a possibly significant number of non-CMA pages.  I
guess that doesn't matter much, as get_user_pages(FOLL_LONGTERM) is
rare.  But could we avoid this (and the second pass across pages[]) by
checking for a CMA page within gup_pte_range()?

> +#else
> +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> +{
> +	return nr_pinned;
> +}
> +#endif
> +
>  /**
>   * get_user_pages_fast() - pin user pages in memory
>   * @start:	starting user address
> @@ -2236,6 +2256,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  		ret = nr;
>  	}
>  
> +	if (unlikely(gup_flags & FOLL_LONGTERM) && nr)
> +		nr = reject_cma_pages(nr, pages);
> +

This would be a suitable place to add a comment explaining why we're
doing this...

