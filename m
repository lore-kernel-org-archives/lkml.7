Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA6BC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858E0217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfKFOjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:39:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbfKFOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:38:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C942DB167;
        Wed,  6 Nov 2019 14:38:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F90C1E4353; Wed,  6 Nov 2019 15:38:55 +0100 (CET)
Date:   Wed, 6 Nov 2019 15:38:55 +0100
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
Message-ID: <20191106143855.GJ16085@quack2.suse.cz>
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
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <4edf4dea97f6c1e3c7d4fed0e12c3dc6dff7575f.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

BTW, attached patch should workaround your problem as well. But that's just
a performance optimization that happens to paper over your problem. Real
fix is the proper handling of fault retry as you did it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--hQiwHBbRI9kgIhsi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-mm-Don-t-bother-dropping-mmap_sem-for-zero-size-read.patch"

From e12c861e687364ff5a891f0ae90283b384d74197 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 6 Nov 2019 15:30:26 +0100
Subject: [PATCH] mm: Don't bother dropping mmap_sem for zero size readahead

When handling a page fault, we drop mmap_sem to start async readahead so
that we don't block on IO submission with mmap_sem held.  However
there's no point to drop mmap_sem in case readahead is disabled. Handle
that case to avoid pointless dropping of mmap_sem and retrying the
fault.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1146fcfa3215..3d39c437b07e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2458,7 +2458,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ)
+	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-- 
2.16.4


--hQiwHBbRI9kgIhsi--
