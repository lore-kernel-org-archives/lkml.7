Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A16EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6BB23CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFDQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:54:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:50580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfFDQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:54:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:54:24 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2019 09:54:24 -0700
Date:   Tue, 4 Jun 2019 09:55:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190604165533.GA3980@iweiny-DESK2.sc.intel.com>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org>
 <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
 <20190604070808.GA28858@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604070808.GA28858@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:08:08AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 03, 2019 at 04:56:10PM -0700, Ira Weiny wrote:
> > On Mon, Jun 03, 2019 at 09:42:06AM -0700, Christoph Hellwig wrote:
> > > > +#if defined(CONFIG_CMA)
> > > 
> > > You can just use #ifdef here.
> > > 
> > > > +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> > > > +	struct page **pages)
> > > 
> > > Please use two instead of one tab to indent the continuing line of
> > > a function declaration.
> > > 
> > > > +{
> > > > +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
> > > 
> > > IMHO it would be a little nicer if we could move this into the caller.
> > 
> > FWIW we already had this discussion and thought it better to put this here.
> > 
> > https://lkml.org/lkml/2019/5/30/1565
> 
> I don't see any discussion like this.  FYI, this is what I mean,
> code might be easier than words:

Indeed that is more clear.  My apologies.

Ira

> 
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..62d770b18e2c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2197,6 +2197,27 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_CMA
> +static int reject_cma_pages(struct page **pages, int nr_pinned)
> +{
> +	int i = 0;
> +
> +	for (i = 0; i < nr_pinned; i++)
> +		if (is_migrate_cma_page(pages[i])) {
> +			put_user_pages(pages + i, nr_pinned - i);
> +			return i;
> +		}
> +	}
> +
> +	return nr_pinned;
> +}
> +#else
> +static inline int reject_cma_pages(struct page **pages, int nr_pinned)
> +{
> +	return nr_pinned;
> +}
> +#endif /* CONFIG_CMA */
> +
>  /**
>   * get_user_pages_fast() - pin user pages in memory
>   * @start:	starting user address
> @@ -2237,6 +2258,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  		ret = nr;
>  	}
>  
> +	if (nr && unlikely(gup_flags & FOLL_LONGTERM))
> +		nr = reject_cma_pages(pages, nr);
> +
>  	if (nr < nr_pages) {
>  		/* Try to get the remaining pages with get_user_pages */
>  		start += nr << PAGE_SHIFT;
> 
