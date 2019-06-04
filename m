Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EC12493C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhE+NmWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFDHIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:08:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFDHIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m/punIg9+myPZqcO5Fex4TzU8Z+bUAZ/ApxJa070rqw=; b=PhE+NmWcH3ODsjbf5DgAK0rDR
        wNbT88AC4wWX+ZvyP5MM1KqyooYM0+mAkuIdGtabHS44vr1bAfF+mOtJyPthTKg+/syEbcFJyBQ+D
        vdlie6qPJkRzG+Nif1tIPr8FKNxoIgKFarWD5+HgSCI8eL9EpEd1969URTGDodzK0Vg9YxN6Dg7QU
        I1kZVZJSe2kjVSjBZt5VvJQJa8z6/2JIw+0EauSETmT3ODTqSj1eOnowCy7paNrTgZbjGe15oASWA
        pDcGtfUIgJqflfZtG65779lHUaUM7n3J7aSzRx1j3fTyF7KFC5P99GbYE/BvDYP7gnYfAk+D0GuSR
        juu0GR9+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3YG-0000zz-I4; Tue, 04 Jun 2019 07:08:08 +0000
Date:   Tue, 4 Jun 2019 00:08:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <20190604070808.GA28858@infradead.org>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org>
 <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:56:10PM -0700, Ira Weiny wrote:
> On Mon, Jun 03, 2019 at 09:42:06AM -0700, Christoph Hellwig wrote:
> > > +#if defined(CONFIG_CMA)
> > 
> > You can just use #ifdef here.
> > 
> > > +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> > > +	struct page **pages)
> > 
> > Please use two instead of one tab to indent the continuing line of
> > a function declaration.
> > 
> > > +{
> > > +	if (unlikely(gup_flags & FOLL_LONGTERM)) {
> > 
> > IMHO it would be a little nicer if we could move this into the caller.
> 
> FWIW we already had this discussion and thought it better to put this here.
> 
> https://lkml.org/lkml/2019/5/30/1565

I don't see any discussion like this.  FYI, this is what I mean,
code might be easier than words:


diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e4..62d770b18e2c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2197,6 +2197,27 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
 	return ret;
 }
 
+#ifdef CONFIG_CMA
+static int reject_cma_pages(struct page **pages, int nr_pinned)
+{
+	int i = 0;
+
+	for (i = 0; i < nr_pinned; i++)
+		if (is_migrate_cma_page(pages[i])) {
+			put_user_pages(pages + i, nr_pinned - i);
+			return i;
+		}
+	}
+
+	return nr_pinned;
+}
+#else
+static inline int reject_cma_pages(struct page **pages, int nr_pinned)
+{
+	return nr_pinned;
+}
+#endif /* CONFIG_CMA */
+
 /**
  * get_user_pages_fast() - pin user pages in memory
  * @start:	starting user address
@@ -2237,6 +2258,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		ret = nr;
 	}
 
+	if (nr && unlikely(gup_flags & FOLL_LONGTERM))
+		nr = reject_cma_pages(pages, nr);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
