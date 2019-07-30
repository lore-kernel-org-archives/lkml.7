Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A0208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfG3OO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfG3OO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:14:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B182FADDC;
        Tue, 30 Jul 2019 14:14:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0AE211E440D; Tue, 30 Jul 2019 16:14:57 +0200 (CEST)
Date:   Tue, 30 Jul 2019 16:14:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] mm/filemap: don't initiate writeback if mapping has
 no dirty pages
Message-ID: <20190730141457.GE28829@quack2.suse.cz>
References: <156378816804.1087.8607636317907921438.stgit@buzz>
 <20190722175230.d357d52c3e86dc87efbd4243@linux-foundation.org>
 <bdc6c53d-a7bb-dcc4-20ba-6c7fa5c57dbd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc6c53d-a7bb-dcc4-20ba-6c7fa5c57dbd@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-07-19 11:16:51, Konstantin Khlebnikov wrote:
> On 23.07.2019 3:52, Andrew Morton wrote:
> > 
> > (cc linux-fsdevel and Jan)

Thanks for CC Andrew.

> > On Mon, 22 Jul 2019 12:36:08 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> > 
> > > Functions like filemap_write_and_wait_range() should do nothing if inode
> > > has no dirty pages or pages currently under writeback. But they anyway
> > > construct struct writeback_control and this does some atomic operations
> > > if CONFIG_CGROUP_WRITEBACK=y - on fast path it locks inode->i_lock and
> > > updates state of writeback ownership, on slow path might be more work.
> > > Current this path is safely avoided only when inode mapping has no pages.
> > > 
> > > For example generic_file_read_iter() calls filemap_write_and_wait_range()
> > > at each O_DIRECT read - pretty hot path.

Yes, but in common case mapping_needs_writeback() is false for files you do
direct IO to (exactly the case with no pages in the mapping). So you
shouldn't see the overhead at all. So which case you really care about?

> > > This patch skips starting new writeback if mapping has no dirty tags set.
> > > If writeback is already in progress filemap_write_and_wait_range() will
> > > wait for it.
> > > 
> > > ...
> > > 
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -408,7 +408,8 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
> > >   		.range_end = end,
> > >   	};
> > > -	if (!mapping_cap_writeback_dirty(mapping))
> > > +	if (!mapping_cap_writeback_dirty(mapping) ||
> > > +	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > >   		return 0;
> > >   	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> > 
> > How does this play with tagged_writepages?  We assume that no tagging
> > has been performed by any __filemap_fdatawrite_range() caller?
> > 
> 
> Checking also PAGECACHE_TAG_TOWRITE is cheap but seems redundant.
> 
> To-write tags are supposed to be a subset of dirty tags:
> to-write is set only when dirty is set and cleared after starting writeback.
> 
> Special case set_page_writeback_keepwrite() which does not clear to-write
> should be for dirty page thus dirty tag is not going to be cleared either.
> Ext4 calls it after redirty_page_for_writepage()
> XFS even without clear_page_dirty_for_io()
> 
> Anyway to-write tag without dirty tag or at clear page is confusing.

Yeah, TOWRITE tag is intended to be internal to writepages logic so your
patch is fine in that regard. Overall the patch looks good to me so I'm
just wondering a bit about the motivation...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
