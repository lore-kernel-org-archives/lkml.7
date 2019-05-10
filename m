Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE43C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB42216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRHCCiJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfEJQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:52:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfEJQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hkMgP0pxOFd4HXfh4zG7QpG6/qI5aXSYBZKtEO3EEOI=; b=MRHCCiJ+3KeZif+1OowuNRo8gx
        rw7Pi279ZHHTn8y+BPlMF+KGvPAKwTr37z9Le5nCCU1xz0k7mZTBVhCYs+rrX1T4qSXTySjZOVkgi
        FBkfp8faCE6Yp6LnvgcG3RoGA3/Q4LrApYMwdTfaWfeoBJIh3f9bdUwV4LpCNcqccpSO9e5SzeC55
        bwjPm+PaV0By4jwPQ29iFDXr0OACaYxAJJILFO4Gni3WsTwj68bWAnoSyx3FpWLgXcaFSd6ZirxlU
        0IGUnh+W3pbx1E1b1A5SgRfD666iyufVPJKb++1gBE6nHF68XkZ6DP/SWIcLissANZMhMeybeCplc
        PoVJlybA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP8kh-00045a-F2; Fri, 10 May 2019 16:52:07 +0000
Date:   Fri, 10 May 2019 09:52:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190510165207.GB3162@bombadil.infradead.org>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <20190510163612.GA23417@bombadil.infradead.org>
 <3a919cba-fefe-d78e-313a-8f0d81a4a75d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a919cba-fefe-d78e-313a-8f0d81a4a75d@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 09:50:04AM -0700, Yang Shi wrote:
> On 5/10/19 9:36 AM, Matthew Wilcox wrote:
> > On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
> > > > +		nr_reclaimed += (1 << compound_order(page));
> > > How about to change this to
> > > 
> > >          nr_reclaimed += hpage_nr_pages(page);
> > Please don't.  That embeds the knowledge that we can only swap out either
> > normal pages or THP sized pages.  I'm trying to make the VM capable of
> > supporting arbitrary-order pages, and this would be just one more place
> > to fix.
> > 
> > I'm sympathetic to the "self documenting" argument.  My current tree has
> > a patch in it:
> > 
> >      mm: Introduce compound_nr
> >      Replace 1 << compound_order(page) with compound_nr(page).  Minor
> >      improvements in readability.
> > 
> > It goes along with this patch:
> > 
> >      mm: Introduce page_size()
> > 
> >      It's unnecessarily hard to find out the size of a potentially huge page.
> >      Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).
> 
> So you prefer keeping using  "1 << compound_order" as v1 did? Then you will
> convert all "1 << compound_order" to compound_nr?

Yes.  Please, let's merge v1 and ignore v2.
