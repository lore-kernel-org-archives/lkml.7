Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D24C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E193E20449
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCILmwMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfGVMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:01:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfGVMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9TwEeiv3tAVyHgkzTpEKGutIGiR1ezQhfTVqiOL+Sb0=; b=UCILmwMh4QosYLRTNnXrods3F
        4KxY+e4JGnpRThW5geoeGaInPL7r1BXuS44bNjBBemcEa9ZgxZaHOE2oJQmNVQyO2WhH/943vstsT
        w20+k6OAS4AjohS8FWHKG3aBodnj/zud/jY8BKK+ZsOGilYtq7YvghVnKnCIfiHm5VEhxTvaeebFP
        0PuKLNenX5rDBPcOmj5B95w47dd5BwlcWN+uAQCA7islpDVX4F2cG38rTkqdvx8vnhGBYz7dcui53
        7hEJbp2L3mZ2cJomjlLAH6VT6ZV2c9rQYdIjQBGDvlxrMIbVARj5DueGfxUtGnE9XEs1E8yyeD9JU
        lsrmDoM5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpX0U-0005w8-Q0; Mon, 22 Jul 2019 12:01:30 +0000
Date:   Mon, 22 Jul 2019 05:01:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>, john.hubbard@gmail.com,
        SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, liubo95@huawei.com,
        mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190722120130.GA17178@infradead.org>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
 <20190719105239.GA10627@amd>
 <20190719114853.GB15816@ziepe.ca>
 <20190719120043.GA15320@infradead.org>
 <20190719120432.GC11224@amd>
 <b5143eb4-f519-57bc-4058-4ed934596ee1@nvidia.com>
 <20190722115804.GB7607@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722115804.GB7607@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 08:58:04AM -0300, Jason Gunthorpe wrote:
> No one has given me a satisfactory answer about the restriction
> either.
> 
> The only thing this kconfig controls that could possibly be arch
> specific is the page walking code in hmm_range_snapshot and
> related. 
> 
> Maybe there is/was some arch entanglement there?

The page walking code is supposed to be platform independent.
I did push a branch to the buildbot a few days ago to catch issues,
and the only one found so far is an abuse of pte_index() that can be
trivially fixed.  The other thing I noticed is that the use of some
of the p??_none/protnone/present checks seems inconsistent, but I did
not have time to audit that yet.
