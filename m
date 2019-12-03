Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0FC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F5206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Y949QJfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCJre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:47:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36325 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:47:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id f16so2399081lfm.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBlsPDMutrlKmGK6ispxJ+ONxNie6T+smNqG2/7IGRo=;
        b=Y949QJfuY8kPUH91G3q2lREJ5bLgeFdqRyUXx3+W2ujbmbNETadIbVHMxY+tPHnmMQ
         7YQCavJDwZ4bIWs/r08lFxw8+qMva/308JyQpjZG3Q6RGDxqHdJ6W5Tt0ZXyVakSwrmq
         BTmzZcSwvzWsEjXJQxpViirKa9sC7WpXQ3pIv+mxPyGd6uztqyI2HNV2hCmDGf34Js/2
         vW+gpPhdpLTXlXJBNM7WR2xhkMFzBMgRGNp03TK3QBhswPFl1jswE2daTtn0hKRukYhc
         8ke8mRLg2pNF5CjmCBXG2Pkj2coqWavGT0O6TM4koBFwe0HQEQAwIlZrL1Fk00AjPOqJ
         5XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBlsPDMutrlKmGK6ispxJ+ONxNie6T+smNqG2/7IGRo=;
        b=EL3xtuYkIPt2SYIjIp9RzlZgmuPzuKjcBTwIG8ePKvn+byI54TClw/6DDVwfBbUgva
         +6xOCYqNgIXPjWqPKJ4eUQ2EUuihig9GUC6Q9v5bPb3m5PW5CRKe8Am66zpsd3HVdKPa
         Umu5Eqz0ATdN5FGJd/Ips0xeZLMrzvCuxdbVbbls/HgB0A02GeZB+o2b7l2N/weVAZ/F
         zqCbAZrakdxIucJV+S9BTTMhGXf60pN3H0QgQWKPmKUSurqLjyBY6BKeGwK+ZHZx0pj+
         hffapMZsVARHhuzwjJYihQ3/AY0dgLiLFL60w4hyfNjk7fNOGzxjHv3UvKv2mxIQuj5Z
         lsNQ==
X-Gm-Message-State: APjAAAXoXWieqRRl5y9YpkfQ16reLcRJgu6b8PoHA42W9lABdXBk2fnt
        QYnGK1CW2wvab9I8//ewjMjiPQ==
X-Google-Smtp-Source: APXvYqzKRWDqiRYC85MOhaukLO9IBk6JgBuxKJ5+vxvt4puTqMMjzpNwCwUmN7LgJVCP0G/yEC3aHw==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr2257417lfa.70.1575366452524;
        Tue, 03 Dec 2019 01:47:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c193sm969116lfd.28.2019.12.03.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:47:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9D6C4100494; Tue,  3 Dec 2019 12:47:30 +0300 (+03)
Date:   Tue, 3 Dec 2019 12:47:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191203094730.7oh4j5juh3jsx5dk@box>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
 <20191128212226.sfrhfs5m3q7m6tly@master>
 <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
 <20191202222151.xx4g3ry7mrcselh5@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202222151.xx4g3ry7mrcselh5@master>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 10:21:51PM +0000, Wei Yang wrote:
> On Mon, Dec 02, 2019 at 11:03:15AM +0300, Kirill A. Shutemov wrote:
> >On Thu, Nov 28, 2019 at 09:22:26PM +0000, Wei Yang wrote:
> >> On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
> >> >On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
> >> >> At this point, we are sure page is PageTransHuge, which means
> >> >> hpage_nr_pages is HPAGE_PMD_NR.
> >> >> 
> >> >> This is safe to use PMD_SIZE instead of calculating it.
> >> >> 
> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> >> ---
> >> >>  mm/page_vma_mapped.c | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> 
> >> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >> >> index eff4b4520c8d..76e03650a3ab 100644
> >> >> --- a/mm/page_vma_mapped.c
> >> >> +++ b/mm/page_vma_mapped.c
> >> >> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >> >>  			if (pvmw->address >= pvmw->vma->vm_end ||
> >> >>  			    pvmw->address >=
> >> >>  					__vma_address(pvmw->page, pvmw->vma) +
> >> >> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
> >> >> +					PMD_SIZE)
> >> >>  				return not_found(pvmw);
> >> >>  			/* Did we cross page table boundary? */
> >> >>  			if (pvmw->address % PMD_SIZE == 0) {
> >> >
> >> >It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
> >> >break if we ever get PUD THP pages.
> >> >
> >> 
> >> Thanks for your comment.
> >> 
> >> I took a look into the code again and found I may miss something.
> >> 
> >> I found we support PUD THP pages, whilc hpage_nr_pages() just return
> >> HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?
> >
> >We only support PUD THP for DAX. Means, we don't have struct page for it.
> >
> 
> BTW, may I ask why you suggest to use page_size() if we are sure only PMD THP
> page is used here? To be more generic?

Yeah. I would rather not touch it at all.

-- 
 Kirill A. Shutemov
