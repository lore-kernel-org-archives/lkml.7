Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B8C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C573221848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfKFOfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:35:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:53090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbfKFOfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:35:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95AB7B332;
        Wed,  6 Nov 2019 14:35:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E5811E4353; Wed,  6 Nov 2019 15:35:37 +0100 (CET)
Date:   Wed, 6 Nov 2019 15:35:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     snazy@snazy.de
Cc:     Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106143537.GI16085@quack2.suse.cz>
References: <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
 <20191106120315.GF16085@quack2.suse.cz>
 <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 14:45:43, Robert Stupp wrote:
> On Wed, 2019-11-06 at 13:03 +0100, Jan Kara wrote:
> > On Tue 05-11-19 13:22:11, Johannes Weiner wrote:
> > > What I don't quite understand yet is why the fault path doesn't
> > > make
> > > progress eventually. We must drop the mmap_sem without changing the
> > > state in any way. How can we keep looping on the same page?
> >
> > That may be a slight suboptimality with Josef's patches. If the page
> > is marked as PageReadahead, we always drop mmap_sem if we can and
> > start
> > readahead without checking whether that makes sense or not in
> > do_async_mmap_readahead(). OTOH page_cache_async_readahead() then
> > clears
> > PageReadahead so the only way how I can see we could loop like this
> > is when
> > file->ra->ra_pages is 0. Not sure if that's what's happening through.
> > We'd
> > need to find which of the paths in filemap_fault() calls
> > maybe_unlock_mmap_for_io() to tell more.
> 
> Yes, ra_pages==0

OK, thanks for confirmation!

> 5637e22a2000-5637e22a3000 r--p 00000000 103:02 49172550                  /home/snazy/devel/misc/zzz/test

What kind of device & fs does your /home stay on? I don't recognize the major
number...

							Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
