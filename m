Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05093C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45BB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfCYQmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:45726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfCYQmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:42:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 002F1AFEF;
        Mon, 25 Mar 2019 16:42:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2C52F1E429A; Mon, 25 Mar 2019 17:42:11 +0100 (CET)
Date:   Mon, 25 Mar 2019 17:42:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Possible UDF locking error?
Message-ID: <20190325164211.GF8308@quack2.suse.cz>
References: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224e1613-b080-bd64-ef88-badcb755a233@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat 23-03-19 15:14:05, Steve Magnani wrote:
> I have been hunting a UDF bug that occasionally results in generation
> of an Allocation Extent Descriptor with an incorrect tagLocation. So
> far I haven't been able to see a path through the code that could
> cause that. But, I noticed some inconsistency in locking during
> AED generation and wonder if it could result in random corruption.
> 
> The function udf_update_inode() has this general pattern:
> 
>   bh = udf_tgetblk(...);   // calls sb_getblk()
>   lock_buffer(bh);
>   memset(bh->b_data, 0, inode->i_sb->s_blocksize);
>   // <snip>other code to populate FE/EFE data in the block</snip>
>   set_buffer_uptodate(bh);
>   unlock_buffer(bh);
>   mark_buffer_dirty(bh);
> 
> This I can understand - the lock is held for as long as the buffer
> contents are being assembled.
> 
> In contrast, udf_setup_indirect_aext(), which constructs an AED,
> has this sequence:
> 
>   bh = udf_tgetblk(...);   // calls sb_getblk()
>   lock_buffer(bh);
>   memset(bh->b_data, 0, inode->i_sb->s_blocksize);
> 
>   set_buffer_uptodate(bh);
>   unlock_buffer(bh);
>   mark_buffer_dirty_inode(bh);
> 
>   // <snip>other code to populate AED data in the block</snip>
> 
> In this case the population of the block occurs without
> the protection of the lock.
> 
> Because the block has been marked dirty, does this mean that
> writeback could occur at any point during population?

Yes. Thanks for noticing this!

> There is one path through udf_setup_indirect_aext() where
> mark_buffer_dirty_inode() gets called again after population is
> complete, which I suppose could heal a partial writeout, but there is
> also another path in which the buffer does not get marked dirty again.

Generally, we add new extents to the created indirect extent which dirties
the buffer and that should fix the problem. But you are definitely right
that the code is suspicious and should be fixed. Will you send a patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
