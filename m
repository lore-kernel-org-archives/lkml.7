Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6AC32757
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7AF2184E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565342178;
	bh=TV6APTnpfV3NfB2dQiDb6/LNtdcZ4qHbPaHm2cq8Boc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RpAFBdkHtUDn1xdQRDgamqncU+i8ME2a4eu7bKgYX6g5t9E0jJy7qJYLFzgBdiLCA
	 1B60UL28j7/UzIJe1AWMXuYBgcBpwiMLpBXhJgb10GkE8qngrlLSFNds4PMP2duk1X
	 y3XuzKteKXzoEnNhqPxKp0M/ElI2daAL5V2ISvT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406090AbfHIJQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:16:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405641AbfHIJQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:16:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAA78B011;
        Fri,  9 Aug 2019 09:16:14 +0000 (UTC)
Date:   Fri, 9 Aug 2019 11:16:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Message-ID: <20190809091614.GO18351@dhcp22.suse.cz>
References: <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
 <420a5039-a79c-3872-38ea-807cedca3b8a@suse.cz>
 <20190809082307.GL18351@dhcp22.suse.cz>
 <a83e4449-fc8d-7771-1b78-2fa645fa0772@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83e4449-fc8d-7771-1b78-2fa645fa0772@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 02:05:15, John Hubbard wrote:
> On 8/9/19 1:23 AM, Michal Hocko wrote:
> > On Fri 09-08-19 10:12:48, Vlastimil Babka wrote:
> > > On 8/9/19 12:59 AM, John Hubbard wrote:
> > > > > > That's true. However, I'm not sure munlocking is where the
> > > > > > put_user_page() machinery is intended to be used anyway? These are
> > > > > > short-term pins for struct page manipulation, not e.g. dirtying of page
> > > > > > contents. Reading commit fc1d8e7cca2d I don't think this case falls
> > > > > > within the reasoning there. Perhaps not all GUP users should be
> > > > > > converted to the planned separate GUP tracking, and instead we should
> > > > > > have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
> > > > > 
> > > > > Interesting. So far, the approach has been to get all the gup callers to
> > > > > release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
> > > > > wrapper, then maybe we could leave some sites unconverted.
> > > > > 
> > > > > However, in order to do so, we would have to change things so that we have
> > > > > one set of APIs (gup) that do *not* increment a pin count, and another set
> > > > > (vaddr_pin_pages) that do.
> > > > > 
> > > > > Is that where we want to go...?
> > > > > 
> > > 
> > > We already have a FOLL_LONGTERM flag, isn't that somehow related? And if
> > > it's not exactly the same thing, perhaps a new gup flag to distinguish
> > > which kind of pinning to use?
> > 
> > Agreed. This is a shiny example how forcing all existing gup users into
> > the new scheme is subotimal at best. Not the mention the overal
> > fragility mention elsewhere. I dislike the conversion even more now.
> > 
> > Sorry if this was already discussed already but why the new pinning is
> > not bound to FOLL_LONGTERM (ideally hidden by an interface so that users
> > do not have to care about the flag) only?
> > 
> 
> Oh, it's been discussed alright, but given how some of the discussions have gone,
> I certainly am not surprised that there are still questions and criticisms!
> Especially since I may have misunderstood some of the points, along the way.
> It's been quite a merry go round. :)

Yeah, I've tried to follow them but just gave up at some point.

> Anyway, what I'm hearing now is: for gup(FOLL_LONGTERM), apply the pinned tracking.
> And therefore only do put_user_page() on pages that were pinned with
> FOLL_LONGTERM. For short term pins, let the locking do what it will:
> things can briefly block and all will be well.
> 
> Also, that may or may not come with a wrapper function, courtesy of Jan
> and Ira.
> 
> Is that about right? It's late here, but I don't immediately recall any
> problems with doing it that way...

Yes that makes more sense to me. Whoever needs that tracking should
opt-in for it. Otherwise you just risk problems like the one discussed
in the mlock path (because we do a strange stuff in the name of
performance) and a never ending whack a mole where new users do not
follow the new API usage and that results in all sorts of weird issues.

Thanks!
-- 
Michal Hocko
SUSE Labs
