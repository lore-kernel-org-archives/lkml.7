Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D314213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xlq9MgHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCLUxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:53:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46982 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfCLUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:53:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 33B738EE1ED;
        Tue, 12 Mar 2019 13:53:39 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wLorcc8lOR75; Tue, 12 Mar 2019 13:53:39 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 688588EE0F5;
        Tue, 12 Mar 2019 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552424018;
        bh=xBXu18RoJWJ5B4KHNewRd2Rk9PRsAei+eBQI4KiIbeY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xlq9MgHsTme9IiV3l5DS1bhGe2e2yBGv5xMnFuAUo3FND/cNBSgTYhs2hLcTvBHBt
         YXaNutNhc7CQMLA18VtnBZRLFNVrMv8VFLcdGmoUhK+Sy6721n6yei9bvNTLp1k2xB
         VUr8feAFN96BKuJ90nrtw4xh7PaBspbU6h6RJU4k=
Message-ID: <1552424017.14432.11.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Date:   Tue, 12 Mar 2019 13:53:37 -0700
In-Reply-To: <20190312200450.GA25147@redhat.com>
References: <20190308141220.GA21082@infradead.org>
         <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
         <20190311095405-mutt-send-email-mst@kernel.org>
         <20190311.111413.1140896328197448401.davem@davemloft.net>
         <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
         <20190311235140-mutt-send-email-mst@kernel.org>
         <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
         <20190312075033-mutt-send-email-mst@kernel.org>
         <1552405610.3083.17.camel@HansenPartnership.com>
         <20190312200450.GA25147@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 16:04 -0400, Andrea Arcangeli wrote:
> On Tue, Mar 12, 2019 at 08:46:50AM -0700, James Bottomley wrote:
> > On Tue, 2019-03-12 at 07:54 -0400, Michael S. Tsirkin wrote:
> > > On Tue, Mar 12, 2019 at 03:17:00PM +0800, Jason Wang wrote:
> > > > 
> > > > On 2019/3/12 ä¸Šåˆ11:52, Michael S. Tsirkin wrote:
> > > > > On Tue, Mar 12, 2019 at 10:59:09AM +0800, Jason Wang wrote:
> > 
> > [...]
> > > > At least for -stable, we need the flush?
> > > > 
> > > > 
> > > > > Three atomic ops per bit is way to expensive.
> > > > 
> > > > 
> > > > Yes.
> > > > 
> > > > Thanks
> > > 
> > > See James's reply - I stand corrected we do kunmap so no need to
> > > flush.
> > 
> > Well, I said that's what we do on Parisc.  The cachetlb document
> > definitely says if you alter the data between kmap and kunmap you
> > are responsible for the flush.  It's just that flush_dcache_page()
> > is a no-op on x86 so they never remember to add it and since it
> > will crash parisc if you get it wrong we finally gave up trying to
> > make them.
> > 
> > But that's the point: it is a no-op on your favourite architecture
> > so it costs you nothing to add it.
> 
> Yes, the fact Parisc gave up and is doing it on kunmap is reasonable
> approach for Parisc, but it doesn't move the needle as far as vhost
> common code is concerned, because other archs don't flush any cache
> on kunmap.
> 
> So either all other archs give up trying to optimize, or vhost still
> has to call flush_dcache_page() after kunmap.

I've got to say: optimize what?  What code do we ever have in the
kernel that kmap's a page and then doesn't do anything with it? You can
guarantee that on kunmap the page is either referenced (needs
invalidating) or updated (needs flushing). The in-kernel use of kmap is
always

kmap
do something with the mapped page
kunmap

In a very short interval.  It seems just a simplification to make
kunmap do the flush if needed rather than try to have the users
remember.  The thing which makes this really simple is that on most
architectures flush and invalidate is the same operation.  If you
really want to optimize you can use the referenced and dirty bits on
the kmapped pte to tell you what operation to do, but if your flush is
your invalidate, you simply assume the data needs flushing on kunmap
without checking anything.

> Which means after we fix vhost to add the flush_dcache_page after
> kunmap, Parisc will get a double hit (but it also means Parisc was
> the only one of those archs needed explicit cache flushes, where
> vhost worked correctly so far.. so it kinds of proofs your point of
> giving up being the safe choice).

What double hit?  If there's no cache to flush then cache flush is a
no-op.  It's also a highly piplineable no-op because the CPU has the L1
cache within easy reach.  The only event when flush takes a large
amount time is if we actually have dirty data to write back to main
memory.

James

