Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41872C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7EE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBmrDOFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfCMQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:05:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbfCMQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Baj+lWDXGPt27lshCwJLP8POnzrLswu3QVB5Jfd4sTc=; b=WBmrDOFdeqXIspuqZdFAcMVYT
        YzewMY/wBRq50wT4qf5pW+61boYgJjwEtUWHYvuvAA+t/hQpnyd7+NFHdTQMl1UnvjZgUfrXVpzNS
        VrSoqYQZLfdfSVN/E1wKu4mZy/4WJkG47nre5T0lR2Bm5nsnv6H0D/R1O7247uk1zW/zRIEv9ysUv
        TlxDpIA1dtVJYOVQ9eR2vQmUEA0xhxpFLYhzYZYd1mlG/jrPspUZFkFWxtON496QO+uRSS//+lYbz
        gu5x6yBnZsyJnKKOOAuDSYTZmPmkd93XFQAjDD/yUixFfT7S6wWLCpD8KlcWUgBNqemS+Hubgfnzg
        lYhikX1Sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h46Nl-0005jS-AC; Wed, 13 Mar 2019 16:05:29 +0000
Date:   Wed, 13 Mar 2019 09:05:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190313160529.GB15134@infradead.org>
References: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
 <20190311095405-mutt-send-email-mst@kernel.org>
 <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
 <20190312200450.GA25147@redhat.com>
 <1552424017.14432.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552424017.14432.11.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> I've got to say: optimize what?  What code do we ever have in the
> kernel that kmap's a page and then doesn't do anything with it? You can
> guarantee that on kunmap the page is either referenced (needs
> invalidating) or updated (needs flushing). The in-kernel use of kmap is
> always
> 
> kmap
> do something with the mapped page
> kunmap
> 
> In a very short interval.  It seems just a simplification to make
> kunmap do the flush if needed rather than try to have the users
> remember.  The thing which makes this really simple is that on most
> architectures flush and invalidate is the same operation.  If you
> really want to optimize you can use the referenced and dirty bits on
> the kmapped pte to tell you what operation to do, but if your flush is
> your invalidate, you simply assume the data needs flushing on kunmap
> without checking anything.

I agree that this would be a good way to simplify the API.   Now
we'd just need volunteers to implement this for all architectures
that need cache flushing and then remove the explicit flushing in
the callers..

> > Which means after we fix vhost to add the flush_dcache_page after
> > kunmap, Parisc will get a double hit (but it also means Parisc was
> > the only one of those archs needed explicit cache flushes, where
> > vhost worked correctly so far.. so it kinds of proofs your point of
> > giving up being the safe choice).
> 
> What double hit?  If there's no cache to flush then cache flush is a
> no-op.  It's also a highly piplineable no-op because the CPU has the L1
> cache within easy reach.  The only event when flush takes a large
> amount time is if we actually have dirty data to write back to main
> memory.

I've heard people complaining that on some microarchitectures even
no-op cache flushes are relatively expensive.  Don't ask me why,
but if we can easily avoid double flushes we should do that.
