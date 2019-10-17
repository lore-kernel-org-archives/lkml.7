Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A26CFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pPFZz0wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440464AbfJQQMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:12:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbfJQQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/ASj5BAjjmZ0b4T5e4J6N07bBbYhOsugrzCLbymRK5I=; b=pPFZz0waJ/OX/rwoWc6LMzRoQ
        qcoGMAdH6vGR15HWdCfUe5RsnqsjB7A3bZdUdCXllT5q/HQmJlIf39K70K+prBRGL/IBdPUMCMKeT
        MU3VqOfzZVIB4kVc1+YLhVAdmZczn6SfvsY4j81bCpgraiWbov2iGz3HmiVKAnOL3IWpYT1ZUjYN+
        SPAow4cD6j6Sn8DaW55HYVPQO2Q+QyfdUb9Tfo8MUXGXnXjYl84voelmPX4ni3AHGYge1ts8wh8NR
        6d3y+B/Cv8uw7JhhOGyVPPrVLsjCG/jJYQVeMSdCxANYDgnRJHA8wGFAeU4LSn4G4wqG+5muHEa2X
        I6P31uoxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL8ON-0001hl-Da; Thu, 17 Oct 2019 16:12:47 +0000
Date:   Thu, 17 Oct 2019 09:12:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/4] mm/thp: allow drop THP from page cache
Message-ID: <20191017161247.GK32665@bombadil.infradead.org>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073731.4076725-4-songliubraving@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:37:30AM -0700, Song Liu wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Once a THP is added to the page cache, it cannot be dropped via
> /proc/sys/vm/drop_caches. Fix this issue with proper handling in
> invalidate_mapping_pages() and __remove_mapping().
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/truncate.c | 12 ++++++++++++
>  mm/vmscan.c   |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6659bb758a4..1d80a188ad4a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -932,7 +932,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  	 * Note that if SetPageDirty is always performed via set_page_dirty,
>  	 * and thus under the i_pages lock, then this ordering is not required.
>  	 */
> -	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
> +	if (unlikely(PageTransHuge(page)) &&
> +			(PageSwapCache(page) || !PageSwapBacked(page)))
>  		refcount = 1 + HPAGE_PMD_NR;
>  	else
>  		refcount = 2;

Kirill suggests that this patch would be better (for this part of the patch;
the part in truncate.c should remain as it is)

commit ddcee327f96d57cb9d5310486d21e43892b7a368
Author: William Kucharski <william.kucharski@oracle.com>
Date:   Fri Sep 20 16:14:51 2019 -0400

    mm: Support removing arbitrary sized pages from mapping
    
    __remove_mapping() assumes that pages can only be either base pages
    or HPAGE_PMD_SIZE.  Further, it assumes that large pages are
    swap-backed.  Support all kinds of pages by unconditionally asking how
    many pages this page references.
    
    Signed-off-by: William Kucharski <william.kucharski@oracle.com>
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6659bb758a4..f870da1f4bb7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	 * Note that if SetPageDirty is always performed via set_page_dirty,
 	 * and thus under the i_pages lock, then this ordering is not required.
 	 */
-	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
-		refcount = 1 + HPAGE_PMD_NR;
-	else
-		refcount = 2;
+	refcount = 1 + compound_nr(page);
 	if (!page_ref_freeze(page, refcount))
 		goto cannot_free;
 	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
