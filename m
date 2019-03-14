Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC55C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218182184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCNKm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:42:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45156 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCNKmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:42:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so5397269qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKfElOakWQ9jAytxopIGDRsc9fgHNgyH9+OuJWYXtqQ=;
        b=kHPbjXP/RDewkI+lyZM/id6SPiWsX6NIXB0Ad9gSBhXWDuJcnuVFor5f5ZCyvmJmEP
         gUx/tRwBt5pg1Wkel1ZV9FuO6vi5fcDjDOi5ikt/9V88dL0w7juQn17tdbZDashRC9wz
         C2W3W/BxOYqIlxk/1aGFJiVnzAAbWZWvyDIFTP9w+yi/3ZeQL0qend8P/elMI12r6KDV
         b2tPqIWqzq64jvMqNb/Huws8Wa1ydGm0iup7KCLGB23d4o84AZTbK83j46GMBem2s4Pe
         QUrKsumg0GxIvIErOpu6ljqd3wjcHLzB6jEeL1Wk1QHwWLRSZ8nVrMCKsTpJ96Cjmrxk
         XIng==
X-Gm-Message-State: APjAAAXj5O0bazGLwZ1PQmsc8MBrzMH2FaKz2otHDrrKk0p84/vVAwC+
        Wv03R6gU5D27LV+3mDEltmlZRw==
X-Google-Smtp-Source: APXvYqzuTvhcTxdCy53aCMd03OXLipoCFuWa4Hom4hJY3Wk5ndn5Kuk15zvRYVXjblKQ47jdYUY9BA==
X-Received: by 2002:ad4:4304:: with SMTP id c4mr3312316qvs.41.1552560144409;
        Thu, 14 Mar 2019 03:42:24 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id i8sm4095314qtr.19.2019.03.14.03.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 03:42:23 -0700 (PDT)
Date:   Thu, 14 Mar 2019 06:42:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190314064004-mutt-send-email-mst@kernel.org>
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
 <20190312200450.GA25147@redhat.com>
 <1552424017.14432.11.camel@HansenPartnership.com>
 <20190313160529.GB15134@infradead.org>
 <1552495028.3022.37.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552495028.3022.37.camel@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:37:08AM -0700, James Bottomley wrote:
> On Wed, 2019-03-13 at 09:05 -0700, Christoph Hellwig wrote:
> > On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> > > I've got to say: optimize what?  What code do we ever have in the
> > > kernel that kmap's a page and then doesn't do anything with it? You
> > > can
> > > guarantee that on kunmap the page is either referenced (needs
> > > invalidating) or updated (needs flushing). The in-kernel use of
> > > kmap is
> > > always
> > > 
> > > kmap
> > > do something with the mapped page
> > > kunmap
> > > 
> > > In a very short interval.  It seems just a simplification to make
> > > kunmap do the flush if needed rather than try to have the users
> > > remember.  The thing which makes this really simple is that on most
> > > architectures flush and invalidate is the same operation.  If you
> > > really want to optimize you can use the referenced and dirty bits
> > > on the kmapped pte to tell you what operation to do, but if your
> > > flush is your invalidate, you simply assume the data needs flushing
> > > on kunmap without checking anything.
> > 
> > I agree that this would be a good way to simplify the API.   Now
> > we'd just need volunteers to implement this for all architectures
> > that need cache flushing and then remove the explicit flushing in
> > the callers..
> 
> Well, it's already done on parisc ...  I can help with this if we agree
> it's the best way forward.  It's really only architectures that
> implement flush_dcache_page that would need modifying.
> 
> It may also improve performance because some kmap/use/flush/kunmap
> sequences have flush_dcache_page() instead of
> flush_kernel_dcache_page() and the former is hugely expensive and
> usually unnecessary because GUP already flushed all the user aliases.
> 
> In the interests of full disclosure the reason we do it for parisc is
> because our later machines have problems even with clean aliases.  So
> on most VIPT systems, doing kmap/read/kunmap creates a fairly harmless
> clean alias.  Technically it should be invalidated, because if you
> remap the same page to the same colour you get cached stale data, but
> in practice the data is expired from the cache long before that
> happens, so the problem is almost never seen if the flush is forgotten.
>  Our problem is on the P9xxx processor: they have a L1/L2 VIPT L3 PIPT
> cache.  As the L1/L2 caches expire clean data, they place the expiring
> contents into L3, but because L3 is PIPT, the stale alias suddenly
> becomes the default for any read of they physical page because any
> update which dirtied the cache line often gets written to main memory
> and placed into the L3 as clean *before* the clean alias in L1/L2 gets
> expired, so the older clean alias replaces it.
> 
> Our only recourse is to kill all aliases with prejudice before the
> kernel loses ownership.
> 
> > > > Which means after we fix vhost to add the flush_dcache_page after
> > > > kunmap, Parisc will get a double hit (but it also means Parisc
> > > > was the only one of those archs needed explicit cache flushes,
> > > > where vhost worked correctly so far.. so it kinds of proofs your
> > > > point of giving up being the safe choice).
> > > 
> > > What double hit?  If there's no cache to flush then cache flush is
> > > a no-op.  It's also a highly piplineable no-op because the CPU has
> > > the L1 cache within easy reach.  The only event when flush takes a
> > > large amount time is if we actually have dirty data to write back
> > > to main memory.
> > 
> > I've heard people complaining that on some microarchitectures even
> > no-op cache flushes are relatively expensive.  Don't ask me why,
> > but if we can easily avoid double flushes we should do that.
> 
> It's still not entirely free for us.  Our internal cache line is around
> 32 bytes (some have 16 and some have 64) but that means we need 128
> flushes for a page ... we definitely can't pipeline them all.  So I
> agree duplicate flush elimination would be a small improvement.
> 
> James

I suspect we'll keep the copyXuser path around for 32 bit anyway -
right Jason?
So we can also keep using that on parisc...

-- 
MST
