Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90186C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BACF21852
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563991142;
	bh=St5GQXxw6i5OMdmiJQBNltNiWb6VR2PCKHSb/RJHrA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WcdhGHnueIAzWd6HvvK0K2ixuET2CQXapN57K98+JmSr1oOFypKu9yaRHpZG6qLMF
	 xMH/B0oQcZzLsHx9tw6AtjcLlcJ15jkZMxPq9t8yc1tRqVrFytVCp/pXrZiiG/USLa
	 J4h7QxiuybdRhcGqPz3vo2BlprWnmjIEW1WTBz6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfGXR7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:59:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:33240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfGXR7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:59:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FF3CABD9;
        Wed, 24 Jul 2019 17:58:59 +0000 (UTC)
Date:   Wed, 24 Jul 2019 19:58:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724175858.GC6410@dhcp22.suse.cz>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
 <20190724152858.GB28493@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724152858.GB28493@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-07-19 12:28:58, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 09:05:53AM +0200, Christoph Hellwig wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > One comment on a related cleanup:
> > 
> > >  	list_for_each_entry(mirror, &hmm->mirrors, list) {
> > >  		int rc;
> > >  
> > > -		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> > > +		rc = mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
> > >  		if (rc) {
> > > -			if (WARN_ON(update.blockable || rc != -EAGAIN))
> > > +			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
> > > +			    rc != -EAGAIN))
> > >  				continue;
> > >  			ret = -EAGAIN;
> > >  			break;
> > 
> > This magic handling of error seems odd.  I think we should merge rc and
> > ret into one variable and just break out if any error happens instead
> > or claiming in the comments -EAGAIN is the only valid error and then
> > ignoring all others here.
> 
> The WARN_ON is enforcing the rules already commented near
> mmuu_notifier_ops.invalidate_start - we could break or continue, it
> doesn't much matter how to recover from a broken driver, but since we
> did the WARN_ON this should sanitize the ret to EAGAIN or 0
> 
> Humm. Actually having looked this some more, I wonder if this is a
> problem:
> 
> I see in __oom_reap_task_mm():
> 
> 			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> 				tlb_finish_mmu(&tlb, range.start, range.end);
> 				ret = false;
> 				continue;
> 			}
> 			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> 			mmu_notifier_invalidate_range_end(&range);
> 
> Which looks like it creates an unbalanced start/end pairing if any
> start returns EAGAIN?
> 
> This does not seem OK.. Many users require start/end to be paired to
> keep track of their internal locking. Ie for instance hmm breaks
> because the hmm->notifiers counter becomes unable to get to 0.
> 
> Below is the best idea I've had so far..
> 
> Michal, what do you think?

IIRC we have discussed this with Jerome back then when I've introduced
this code and unless I misremember he said the current code was OK.
Maybe new users have started relying on a new semantic in the meantime,
back then, none of the notifier has even started any action in blocking
mode on a EAGAIN bailout. Most of them simply did trylock early in the
process and bailed out so there was nothing to do for the range_end
callback.

Has this changed?
-- 
Michal Hocko
SUSE Labs
