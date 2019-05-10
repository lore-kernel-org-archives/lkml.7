Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F3EC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD7120896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfEJWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:54:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:36053 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfEJWyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:54:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 15:54:20 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2019 15:54:20 -0700
Date:   Fri, 10 May 2019 15:54:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
Message-ID: <20190510225456.GA13529@iweiny-DESK2.sc.intel.com>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <20190510163612.GA23417@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510163612.GA23417@bombadil.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 09:36:12AM -0700, Matthew Wilcox wrote:
> On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
> > > +		nr_reclaimed += (1 << compound_order(page));
> > 
> > How about to change this to
> > 
> > 
> >         nr_reclaimed += hpage_nr_pages(page);
> 
> Please don't.  That embeds the knowledge that we can only swap out either 
> normal pages or THP sized pages.  I'm trying to make the VM capable of 
> supporting arbitrary-order pages, and this would be just one more place
> to fix.
> 
> I'm sympathetic to the "self documenting" argument.  My current tree has
> a patch in it:
> 
>     mm: Introduce compound_nr
>     
>     Replace 1 << compound_order(page) with compound_nr(page).  Minor
>     improvements in readability.
> 
> It goes along with this patch:
> 
>     mm: Introduce page_size()
> 
>     It's unnecessarily hard to find out the size of a potentially huge page.
>     Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).
> 
> Better suggestions on naming gratefully received.  I'm more happy with 
> page_size() than I am with compound_nr().  page_nr() gives the wrong
> impression; page_count() isn't great either.

Stupid question : what does 'nr' stand for?

Ira

