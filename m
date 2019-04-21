Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DAAC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D62147C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfDUVQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 17:16:08 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:37764 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfDUVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 17:16:08 -0400
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 5024C1C3636
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 22:16:06 +0100 (IST)
Received: (qmail 12317 invoked from network); 21 Apr 2019 21:16:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2019 21:16:06 -0000
Date:   Sun, 21 Apr 2019 22:16:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190421211604.GN18914@techsingularity.net>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190421132606.GJ7751@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 06:26:07AM -0700, Matthew Wilcox wrote:
> On Sun, Apr 21, 2019 at 09:38:59AM +0300, Mike Rapoport wrote:
> > On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> > > On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > > > DISCONTIG is essentially deprecated and even parisc plans to move to
> > > > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > > > watermark boosting by default on DISCONTIGMEM.
> > > 
> > > I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> > > scenarios.  Grepping the arch/ directories shows:
> > > 
> > > alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> > > arc (for supporting more than 1GB of memory)
> > > ia64 (looks complicated ...)
> > > m68k (for multiple chunks of memory)
> > > mips (does support NUMA but also non-NUMA)
> > > parisc (both NUMA and non-NUMA)
> > 
> > i386 NUMA as well
> 
> I clearly over-trimmed.  The original assumption that Mel had was that
> DISCONTIGMEM => NUMA, and that's not true on the above six architectures.
> It is true on i386 ;-)

32-bit NUMA systems should be non-existent in practice. The last NUMA
system I'm aware of that was both NUMA and 32-bit only died somewhere
between 2004 and 2007. If someone is running a 64-bit capable system in
32-bit mode with NUMA, they really are just punishing themselves for fun.

-- 
Mel Gorman
SUSE Labs
