Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2465EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB063206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCLUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCLUEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C82453086203;
        Tue, 12 Mar 2019 20:04:53 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E951001DFA;
        Tue, 12 Mar 2019 20:04:51 +0000 (UTC)
Date:   Tue, 12 Mar 2019 16:04:50 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190312200450.GA25147@redhat.com>
References: <20190308141220.GA21082@infradead.org>
 <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
 <20190311095405-mutt-send-email-mst@kernel.org>
 <20190311.111413.1140896328197448401.davem@davemloft.net>
 <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
 <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552405610.3083.17.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 12 Mar 2019 20:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 08:46:50AM -0700, James Bottomley wrote:
> On Tue, 2019-03-12 at 07:54 -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 12, 2019 at 03:17:00PM +0800, Jason Wang wrote:
> > > 
> > > On 2019/3/12 上午11:52, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 12, 2019 at 10:59:09AM +0800, Jason Wang wrote:
> [...]
> > > At least for -stable, we need the flush?
> > > 
> > > 
> > > > Three atomic ops per bit is way to expensive.
> > > 
> > > 
> > > Yes.
> > > 
> > > Thanks
> > 
> > See James's reply - I stand corrected we do kunmap so no need to
> > flush.
> 
> Well, I said that's what we do on Parisc.  The cachetlb document
> definitely says if you alter the data between kmap and kunmap you are
> responsible for the flush.  It's just that flush_dcache_page() is a no-
> op on x86 so they never remember to add it and since it will crash
> parisc if you get it wrong we finally gave up trying to make them.
> 
> But that's the point: it is a no-op on your favourite architecture so
> it costs you nothing to add it.

Yes, the fact Parisc gave up and is doing it on kunmap is reasonable
approach for Parisc, but it doesn't move the needle as far as vhost
common code is concerned, because other archs don't flush any cache on
kunmap.

So either all other archs give up trying to optimize, or vhost still
has to call flush_dcache_page() after kunmap.

Which means after we fix vhost to add the flush_dcache_page after
kunmap, Parisc will get a double hit (but it also means Parisc was the
only one of those archs needed explicit cache flushes, where vhost
worked correctly so far.. so it kinds of proofs your point of giving
up being the safe choice).

Thanks,
Andrea
