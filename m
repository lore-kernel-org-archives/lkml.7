Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF3120882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfDBOks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:40:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbfDBOks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:40:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34937C04FFEF;
        Tue,  2 Apr 2019 14:40:48 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7563F8491A;
        Tue,  2 Apr 2019 14:40:41 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:40:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH] vfio/type1: Limit DMA mappings per container
Message-ID: <20190402084040.72c3ceb5@x1.home>
In-Reply-To: <20190402051802.GB11008@xz-x1>
References: <155414977872.12780.13728555131525362206.stgit@gimli.home>
        <20190402024115.GA11008@xz-x1>
        <20190401223413.3783af5f@x1.home>
        <20190402051802.GB11008@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 02 Apr 2019 14:40:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 13:18:02 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Apr 01, 2019 at 10:34:13PM -0600, Alex Williamson wrote:
> > On Tue, 2 Apr 2019 10:41:15 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > On Mon, Apr 01, 2019 at 02:16:52PM -0600, Alex Williamson wrote:
> > > 
> > > [...]
> > >   
> > > > @@ -1081,8 +1088,14 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
> > > >  		goto out_unlock;
> > > >  	}
> > > >  
> > > > +	if (!atomic_add_unless(&iommu->dma_avail, -1, 0)) {
> > > > +		ret = -ENOSPC;
> > > > +		goto out_unlock;
> > > > +	}
> > > > +
> > > >  	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
> > > >  	if (!dma) {
> > > > +		atomic_inc(&iommu->dma_avail);    
> > > 
> > > This should be the only special path to revert the change.  Not sure
> > > whether this can be avoided by simply using atomic_read() or even
> > > READ_ONCE() (I feel like we don't need atomic ops with dma_avail
> > > because we've had the mutex but it of course it doesn't hurt...) to
> > > replace atomic_add_unless() above to check against zero then we do
> > > +1/-1 in vfio_[un]link_dma() only.  But AFAICT this patch is correct.  
> > 
> > Thanks for the review, you're right, we're only twiddling this atomic
> > while holding the iommu->lock mutex, so it appears unnecessary.  Since
> > we're within the mutex, I think we don't even need a READ_ONCE.  We can
> > simple test it before alloc and decrement after.  Am I missing something
> > that would specifically require READ_ONCE within our mutex critical
> > section?  Thanks,  
> 
> I don't know very clear on this and I'd be glad to learn about that.
> My understanding is that [READ|WRITE]_ONCE() is the same as volatile
> mem operation and will make sure we don't keep variables in the
> registers.  So if the mutex semantics can support that (say, a "*addr
> = val" following with a mutex_unlock will make sure "val" will
> definitely land into memory of "&addr") then I do think it's fine even
> without it (which corresponds to WRITE_ONCE(&addr, val) in this case).

The READ/WRITE_ONCE macros add memory barriers, but we have the mutex
for protecting concurrent access to the data.  I don't see that there's
anything special about a counter on the iommu object that needs special
attention vs any other elements that might get modified in these
sections.  Thanks,

Alex
