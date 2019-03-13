Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A94C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D872146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kwt0ySHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCMQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:37:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37006 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfCMQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:37:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38F0B8EE20E;
        Wed, 13 Mar 2019 09:37:11 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uz8YNwgwnDV9; Wed, 13 Mar 2019 09:37:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 628BF8EE0D2;
        Wed, 13 Mar 2019 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552495030;
        bh=QTfACBd9QjgfxcwC257J3GFwzCkZGeBpWcBbXcF8jxE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kwt0ySHHA7v7acL0GpRQf35TN0COVmRGmz+t4naxEZ2nz/5mPZA3ublVzp3yMbnFx
         u93RsapIu5mY622mutvvsmo6tBNrms0ldJkuY8ZPD8kOf5xqikWEjK9mj5+KwQdgbK
         FewAlooiKHyMX+iD44fBZlQtAVn8BT23uhiwamto=
Message-ID: <1552495028.3022.37.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Date:   Wed, 13 Mar 2019 09:37:08 -0700
In-Reply-To: <20190313160529.GB15134@infradead.org>
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
         <20190313160529.GB15134@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 09:05 -0700, Christoph Hellwig wrote:
> On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> > I've got to say: optimize what?  What code do we ever have in the
> > kernel that kmap's a page and then doesn't do anything with it? You
> > can
> > guarantee that on kunmap the page is either referenced (needs
> > invalidating) or updated (needs flushing). The in-kernel use of
> > kmap is
> > always
> > 
> > kmap
> > do something with the mapped page
> > kunmap
> > 
> > In a very short interval.  It seems just a simplification to make
> > kunmap do the flush if needed rather than try to have the users
> > remember.  The thing which makes this really simple is that on most
> > architectures flush and invalidate is the same operation.  If you
> > really want to optimize you can use the referenced and dirty bits
> > on the kmapped pte to tell you what operation to do, but if your
> > flush is your invalidate, you simply assume the data needs flushing
> > on kunmap without checking anything.
> 
> I agree that this would be a good way to simplify the API.   Now
> we'd just need volunteers to implement this for all architectures
> that need cache flushing and then remove the explicit flushing in
> the callers..

Well, it's already done on parisc ...  I can help with this if we agree
it's the best way forward.  It's really only architectures that
implement flush_dcache_page that would need modifying.

It may also improve performance because some kmap/use/flush/kunmap
sequences have flush_dcache_page() instead of
flush_kernel_dcache_page() and the former is hugely expensive and
usually unnecessary because GUP already flushed all the user aliases.

In the interests of full disclosure the reason we do it for parisc is
because our later machines have problems even with clean aliases.  So
on most VIPT systems, doing kmap/read/kunmap creates a fairly harmless
clean alias.  Technically it should be invalidated, because if you
remap the same page to the same colour you get cached stale data, but
in practice the data is expired from the cache long before that
happens, so the problem is almost never seen if the flush is forgotten.
 Our problem is on the P9xxx processor: they have a L1/L2 VIPT L3 PIPT
cache.  As the L1/L2 caches expire clean data, they place the expiring
contents into L3, but because L3 is PIPT, the stale alias suddenly
becomes the default for any read of they physical page because any
update which dirtied the cache line often gets written to main memory
and placed into the L3 as clean *before* the clean alias in L1/L2 gets
expired, so the older clean alias replaces it.

Our only recourse is to kill all aliases with prejudice before the
kernel loses ownership.

> > > Which means after we fix vhost to add the flush_dcache_page after
> > > kunmap, Parisc will get a double hit (but it also means Parisc
> > > was the only one of those archs needed explicit cache flushes,
> > > where vhost worked correctly so far.. so it kinds of proofs your
> > > point of giving up being the safe choice).
> > 
> > What double hit?  If there's no cache to flush then cache flush is
> > a no-op.  It's also a highly piplineable no-op because the CPU has
> > the L1 cache within easy reach.  The only event when flush takes a
> > large amount time is if we actually have dirty data to write back
> > to main memory.
> 
> I've heard people complaining that on some microarchitectures even
> no-op cache flushes are relatively expensive.  Don't ask me why,
> but if we can easily avoid double flushes we should do that.

It's still not entirely free for us.  Our internal cache line is around
32 bytes (some have 16 and some have 64) but that means we need 128
flushes for a page ... we definitely can't pipeline them all.  So I
agree duplicate flush elimination would be a small improvement.

James

