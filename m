Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314CBC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2B22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHSL5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:57:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:20098 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfHSL5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:57:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 04:57:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="377409646"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2019 04:57:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9AD77128; Mon, 19 Aug 2019 14:57:51 +0300 (EEST)
Date:   Mon, 19 Aug 2019 14:57:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm, page_owner: record page owner for each subpage
Message-ID: <20190819115751.bost7nrac4at7pq3@black.fi.intel.com>
References: <20190816101401.32382-1-vbabka@suse.cz>
 <20190816101401.32382-2-vbabka@suse.cz>
 <20190816140430.aoya6k7qxxrls72h@box>
 <a9344bd6-cdb9-3ad6-5bb1-8eb81650c398@suse.cz>
 <20190819115551.xkgnpr7zmaqpuebi@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819115551.xkgnpr7zmaqpuebi@black.fi.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:55:51AM +0000, Kirill A. Shutemov wrote:
> > @@ -2533,6 +2534,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >  
> >  	remap_page(head);
> >  
> > +	split_page_owner(head, HPAGE_PMD_ORDER);
> > +
> 
> I think it has to be before remap_page(). This way nobody would be able to
> mess with the page until it has valid page_owner.

Or rather next to ClearPageCompound().

-- 
 Kirill A. Shutemov
