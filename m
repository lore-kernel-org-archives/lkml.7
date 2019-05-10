Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FABC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B902177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aa7n+JxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfEJQgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:36:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfEJQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b/JhnmzdXvcZzBwouxXoQxGy1LUWG9vrwQ6s+nGq3oI=; b=aa7n+JxOP4GJyt+6e9t186rvV
        ZLNOAx0QcDgAMax2GMB3YAFR2nvjovRMNFHsqMoqrw7bksP5Q8t57AlEyhctFD8PzdKtfIZxNHlhk
        BrX2diNGkIneThNr0j/li+YDar0K9CwzwSzMjRNI7W+Txv4AWT/oCeGKEGoBxCafblJbgmvzstPVA
        30TskXHyRLMWWBNBqfYi9PHfso3dkPLNR5XffHnIz7m43cbLaBTst9Kf/A9/zzwKrOG2FJqqc30DE
        YXtWqLHH6vgBfoqm12GBjjebNEbUh6DPDhKHlp48pY78sCZhOkd4aV3aHiXiSQcBrDo9Uyo4bZNRj
        uw3aSHlXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hP8VJ-0007RN-1p; Fri, 10 May 2019 16:36:13 +0000
Date:   Fri, 10 May 2019 09:36:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190510163612.GA23417@bombadil.infradead.org>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y33fjbvr.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
> > +		nr_reclaimed += (1 << compound_order(page));
> 
> How about to change this to
> 
> 
>         nr_reclaimed += hpage_nr_pages(page);

Please don't.  That embeds the knowledge that we can only swap out either 
normal pages or THP sized pages.  I'm trying to make the VM capable of 
supporting arbitrary-order pages, and this would be just one more place
to fix.

I'm sympathetic to the "self documenting" argument.  My current tree has
a patch in it:

    mm: Introduce compound_nr
    
    Replace 1 << compound_order(page) with compound_nr(page).  Minor
    improvements in readability.

It goes along with this patch:

    mm: Introduce page_size()

    It's unnecessarily hard to find out the size of a potentially huge page.
    Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).

Better suggestions on naming gratefully received.  I'm more happy with 
page_size() than I am with compound_nr().  page_nr() gives the wrong
impression; page_count() isn't great either.
