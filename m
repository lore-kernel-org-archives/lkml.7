Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F9AC4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5A21473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFCG+qkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfD1ILS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:11:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfD1ILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 04:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9cfzCZHsC8Z1URVhGFCxQrxINgq5TQBCpge+7Hexgeo=; b=TFCG+qkPsR1tZhgIZ7nDdAu0U
        41Nj91cp2ngQL//A/7D/Qd/9wiELv5/cmOFeNyPyksBVKb+qMzDrmLMV4ybT5jMS9H+MF5ZsLts1l
        lfKLPgcZ0ZX3lBjNfifZXvn/oylF71G4vYc2rkGFLX8tAm9OrHVcOVcOGG0fnOkbaFDAL4OM0KDPp
        T8SYAMoCCLFGrrD8yxjawK2PBNYA0Xix+L43FIhjbTddeH2nGIBjguRfnkqeOg3LL21Kp+PkuxAh/
        4bERD+PCrlUYLJtsUSZQ5FXKeu2DsZb8IsCRYAqtv3geoy0wDTwEDGjksVmGvGbPjksJtmYTcqLcr
        1c0xSPqAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKetv-00011K-CV; Sun, 28 Apr 2019 08:11:07 +0000
Date:   Sun, 28 Apr 2019 01:11:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190428081107.GA30901@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
 <20190424113352.GA6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424113352.GA6278@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:33:53PM +0300, Mike Rapoport wrote:
> On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> > On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > > between 2004 and 2007. If someone is running a 64-bit capable system in
> > > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> > 
> > Can we mark it as BROKEN to see if someone shouts and then remove it
> > a year or two down the road?  Or just kill it off now..
> 
> How about making SPARSEMEM default for x86-32?

Sounds good.

Another question:  I always found the option to even select the memory
models like a bad tradeoff.  Can we really expect a user to make a sane
choice?  I'd rather stick to a relativelty optimal choice based on arch
and maybe a few other parameters (NUMA or not for example) and stick to
it, reducing the testing matrix.
