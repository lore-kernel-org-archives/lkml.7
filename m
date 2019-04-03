Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6830C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F3420830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDCIHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:07:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfDCIHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:07:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCD79AE3E;
        Wed,  3 Apr 2019 08:07:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 09E891E3FFD; Wed,  3 Apr 2019 10:07:01 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:07:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Possible UDF locking error?
Message-ID: <20190403080701.GB8836@quack2.suse.cz>
References: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
 <20190325164211.GF8308@quack2.suse.cz>
 <16a6ed55-e8c9-cc56-b675-e9a9de57ab66@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a6ed55-e8c9-cc56-b675-e9a9de57ab66@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat 30-03-19 14:49:46, Steve Magnani wrote:
> On 3/25/19 11:42 AM, Jan Kara wrote:
> > Hi!
> > 
> > On Sat 23-03-19 15:14:05, Steve Magnani wrote:
> > > I have been hunting a UDF bug that occasionally results in generation
> > > of an Allocation Extent Descriptor with an incorrect tagLocation. So
> > > far I haven't been able to see a path through the code that could
> > > cause that. But, I noticed some inconsistency in locking during
> > > AED generation and wonder if it could result in random corruption.
> > > 
> > > The function udf_update_inode() has this general pattern:
> > > 
> > >    bh = udf_tgetblk(...);   // calls sb_getblk()
> > >    lock_buffer(bh);
> > >    memset(bh->b_data, 0, inode->i_sb->s_blocksize);
> > >    // <snip>other code to populate FE/EFE data in the block</snip>
> > >    set_buffer_uptodate(bh);
> > >    unlock_buffer(bh);
> > >    mark_buffer_dirty(bh);
> > > 
> > > This I can understand - the lock is held for as long as the buffer
> > > contents are being assembled.
> > > 
> > > In contrast, udf_setup_indirect_aext(), which constructs an AED,
> > > has this sequence:
> > > 
> > >    bh = udf_tgetblk(...);   // calls sb_getblk()
> > >    lock_buffer(bh);
> > >    memset(bh->b_data, 0, inode->i_sb->s_blocksize);
> > > 
> > >    set_buffer_uptodate(bh);
> > >    unlock_buffer(bh);
> > >    mark_buffer_dirty_inode(bh);
> > > 
> > >    // <snip>other code to populate AED data in the block</snip>
> > > 
> > > In this case the population of the block occurs without
> > > the protection of the lock.
> > > 
> > > Because the block has been marked dirty, does this mean that
> > > writeback could occur at any point during population?
> > Yes. Thanks for noticing this!
> > 
> > > There is one path through udf_setup_indirect_aext() where
> > > mark_buffer_dirty_inode() gets called again after population is
> > > complete, which I suppose could heal a partial writeout, but there is
> > > also another path in which the buffer does not get marked dirty again.
> > Generally, we add new extents to the created indirect extent which dirties
> > the buffer and that should fix the problem. But you are definitely right
> > that the code is suspicious and should be fixed. Will you send a patch?
> 
> I did a little archaeology to see how the code evolved to this point. It's
> been like this a long time.
> 
> I also did some research to understand why filesystems use lock_buffer()
> sometimes but not others. For example, the FAT driver never calls it. I ran
> across this thread from 2011:
> 
>        https://lkml.org/lkml/2011/5/16/402
> 
> ...from which I conclude that while it is correct in a strict sense to hold
> a lock on a buffer any time its contents are being modified, performance
> considerations make it preferable (or at least reasonable) to make some
> modifications without a lock provided it's known that a subsequent write-out
> will "fix" any potential partial write out before anyone else tries to read
> the block.

Understood but UDF (and neither FAT) are really that performance critical.
If you look for performance, you'd certainly pick a different filesystem.
UDF is mainly for data interchange so it should work reasonably for copy-in
copy-out style of workloads, the rest isn't that important. So there
correctness and simplicity is preferred over performance.

> I doubt that UDF sees common use with DIF/DIX block devices,
> which might make a decision in favor of performance a little easier. Since
> the FAT driver doesn't contain Darrick's proposed changes I assume a
> decision was made that performance was more important there.
> 
> Certainly the call to udf_setup_indirect_aext() from udf_add_aext() meets
> those criteria. But udf_table_free_blocks() may not dirty the AED block.
> 
> So if this looks reasonable I will resend as a formal patch:
> 
> --- a/fs/udf/inode.c	2019-03-30 11:28:38.637759458 -0500
> +++ b/fs/udf/inode.c	2019-03-30 11:33:00.357761250 -0500
> @@ -1873,9 +1873,6 @@ int udf_setup_indirect_aext(struct inode
>  		return -EIO;
>  	lock_buffer(bh);
>  	memset(bh->b_data, 0x00, sb->s_blocksize);
> -	set_buffer_uptodate(bh);
> -	unlock_buffer(bh);
> -	mark_buffer_dirty_inode(bh, inode);
>  	aed = (struct allocExtDesc *)(bh->b_data);
>  	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_STRICT)) {
> @@ -1890,6 +1887,9 @@ int udf_setup_indirect_aext(struct inode
>  	udf_new_tag(bh->b_data, TAG_IDENT_AED, ver, 1, block,
>  		    sizeof(struct tag));
> +	set_buffer_uptodate(bh);
> +	unlock_buffer(bh);
> +
>  	nepos.block = neloc;
>  	nepos.offset = sizeof(struct allocExtDesc);
>  	nepos.bh = bh;
> @@ -1913,6 +1913,8 @@ int udf_setup_indirect_aext(struct inode
>  	} else {
>  		__udf_add_aext(inode, epos, &nepos.block,
>  			       sb->s_blocksize | EXT_NEXT_EXTENT_ALLOCDECS, 0);
> +		/* Make sure completed AED gets written out */
> +		mark_buffer_dirty_inode(nepos.bh, inode);

Why do you mark the buffer as dirty only here? I'd just mark it dirty after
unlocking. If __udf_add_aext() or udf_write_aext() modify the buffer, they
will mark it as dirty as well... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
