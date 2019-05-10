Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D7DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1821479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ST5fCNq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfEJXGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 19:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfEJXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 19:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=teDBeReCOPgEIA4YvlNHjGWi0MjwIkQN8utbqMkM4JY=; b=ST5fCNq3P16ipcDSRBeOWzXml
        7FhiGG3myj/I9/8Od4g2FDJVl9ra/7I3wWkDFs6SeTRoh80jmS4DDdjyxLupc8Bl6jPM5l+/e6a5b
        uLpGRA0jwaOCHY/yAQzIcZJ8WBFx/3PHUFcPCWrHBPGzelKMROkf6g1BseGmVMIJBNINg8LEzDh4e
        +svUFpd86SF1IZxArY1qnaSa3EC/RVFtM8knp2iF2UHLHb1H1RtvjLJV0h8LdpFsDpFkxyrG1/FNI
        NAYuDoCSGtAaSmp55TEUHro31WNrR0UfaKk9Gny1/nkZ0GljaDyN7FpN80UAKr2DP26E7q+QHm/yk
        dEQFe4j6g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hPEaq-0005m7-7X; Fri, 10 May 2019 23:06:20 +0000
Date:   Fri, 10 May 2019 16:06:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190510230620.GA12158@bombadil.infradead.org>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <20190510163612.GA23417@bombadil.infradead.org>
 <20190510225456.GA13529@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510225456.GA13529@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 03:54:56PM -0700, Ira Weiny wrote:
> On Fri, May 10, 2019 at 09:36:12AM -0700, Matthew Wilcox wrote:
> > On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
> > > > +		nr_reclaimed += (1 << compound_order(page));
> > > 
> > > How about to change this to
> > > 
> > > 
> > >         nr_reclaimed += hpage_nr_pages(page);
> > 
> > Please don't.  That embeds the knowledge that we can only swap out either 
> > normal pages or THP sized pages.  I'm trying to make the VM capable of 
> > supporting arbitrary-order pages, and this would be just one more place
> > to fix.
> > 
> > I'm sympathetic to the "self documenting" argument.  My current tree has
> > a patch in it:
> > 
> >     mm: Introduce compound_nr
> >     
> >     Replace 1 << compound_order(page) with compound_nr(page).  Minor
> >     improvements in readability.
> > 
> > It goes along with this patch:
> > 
> >     mm: Introduce page_size()
> > 
> >     It's unnecessarily hard to find out the size of a potentially huge page.
> >     Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).
> > 
> > Better suggestions on naming gratefully received.  I'm more happy with 
> > page_size() than I am with compound_nr().  page_nr() gives the wrong
> > impression; page_count() isn't great either.
> 
> Stupid question : what does 'nr' stand for?

NumbeR.  It's relatively common argot in the Linux kernel (as you can
see from the earlier example ...

> > >         nr_reclaimed += hpage_nr_pages(page);

willy@bobo:~/kernel/xarray-2$ git grep -w nr mm |wc -l
388
willy@bobo:~/kernel/xarray-2$ git grep -w nr fs |wc -l
1067

