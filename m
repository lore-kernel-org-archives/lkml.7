Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC1CC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3BF2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 13:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgDwe3K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfDUN0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 09:26:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 09:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rc67H1HDEjDy3HjQxasxWDB9M7vQy15mNKQuX9FUK1U=; b=RgDwe3K3Ke2irRAMVA4Yuayg5
        BR+M5mJK9AmCzzfU5OcbUqI2BjZcqfev7ed/9vrArbV/YOAew5l297EsE2X6yaD3jvvUrPcrq1UbD
        0P5HUDSp+DlQo5Oh5ZIIHk3WkRqA0AovrVcIWw/wslFt9rRqrxSRYh+WCla/VeosnH+2t5io5FTUD
        g4XnitQYKo7V32SMmUH8yOQJiJA0+r/AIo51eUqqIKzTxr49vPVShhvM/R4RhlrvWT2HXJk+wob6O
        2dhMD6nMhbYh9Db8OAsuM1uuqEPVhzBTbbjV/tsTleBfK+Hv567D52zbX6MzjoUBaVHDk/9M3AtgV
        zaBGfz//w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hICTv-0003S4-86; Sun, 21 Apr 2019 13:26:07 +0000
Date:   Sun, 21 Apr 2019 06:26:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190421132606.GJ7751@bombadil.infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421063859.GA19926@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 09:38:59AM +0300, Mike Rapoport wrote:
> On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> > On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > > DISCONTIG is essentially deprecated and even parisc plans to move to
> > > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > > watermark boosting by default on DISCONTIGMEM.
> > 
> > I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> > scenarios.  Grepping the arch/ directories shows:
> > 
> > alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> > arc (for supporting more than 1GB of memory)
> > ia64 (looks complicated ...)
> > m68k (for multiple chunks of memory)
> > mips (does support NUMA but also non-NUMA)
> > parisc (both NUMA and non-NUMA)
> 
> i386 NUMA as well

I clearly over-trimmed.  The original assumption that Mel had was that
DISCONTIGMEM => NUMA, and that's not true on the above six architectures.
It is true on i386 ;-)
