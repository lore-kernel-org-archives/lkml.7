Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C94FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AB7208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pu7FtOXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438166AbfFLLXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:23:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfFLLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KJAXvYM0DI4vnD/0tu+larrshBV1A0aACdJmWI9kxzw=; b=pu7FtOXG6wwPz8NJqGleP0ENqZ
        mWOWq7bfIS7I5pJndBO7Iorv4+OVLhztJH0MIESlmLmmGgHrX5hLbLEBOu5/+LynDGtoTdbcUkwHz
        m+0nmPp8W2Zntos4QTutZ9PdRPfjOaERnezAPGG3G6HwOydPr0nIyh6ofXteGyBhSrbeCM90amEhl
        OvRad6uKCL5pbwCDcWfUThMqxLI35Q+Iv2FUvjxoK6yPof3pP/uGWUbgh7SyFzGn2D06ZiXnMuLmo
        FR8QqLtcf0RpwhAoW7YZQpMmHjkcYzS44RCzNLkzUQGIM1bRdNtGmin0BBuQtePw75gHO3CRPmO21
        BHvzeyqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hb1M6-0005io-1P; Wed, 12 Jun 2019 11:23:50 +0000
Date:   Wed, 12 Jun 2019 04:23:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thellstrom@vmwopensource.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v5 3/9] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20190612112349.GA20226@infradead.org>
References: <20190612064243.55340-1-thellstrom@vmwopensource.org>
 <20190612064243.55340-4-thellstrom@vmwopensource.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612064243.55340-4-thellstrom@vmwopensource.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:42:37AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Add two utilities to a) write-protect and b) clean all ptes pointing into
> a range of an address space.
> The utilities are intended to aid in tracking dirty pages (either
> driver-allocated system memory or pci device memory).
> The write-protect utility should be used in conjunction with
> page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
> accesses. Typically one would want to use this on sparse accesses into
> large memory regions. The clean utility should be used to utilize
> hardware dirtying functionality and avoid the overhead of page-faults,
> typically on large accesses into small memory regions.

Please use EXPORT_SYMBOL_GPL, just like for apply_to_page_range and
friends.  Also in general new core functionality like this should go
along with the actual user, we don't need to repeat the hmm disaster.
