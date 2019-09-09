Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAFFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65FF222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568014217;
	bh=OVOy6nM7ZIjELdXJvNXwDvGFl65BdXk2V5DtDr3wcJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OZO5rPiKV1JYfN0QBV/OTqjj0xg7lOL7vF85Pz4jF5KIRnYt/r3axtzvRhslh6DWB
	 NynFzh2425RW6N5Gphj9ejdEYDffGE2jTY0ZS7QkIu79Jx/J3Lm5h0Su48dUIzvxem
	 qYGecskTAxNe+eq/yUAq3lBiH8lnXz1hSENtRnUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbfIIHaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfIIHaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:30:16 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91ED021D82;
        Mon,  9 Sep 2019 07:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568014215;
        bh=OVOy6nM7ZIjELdXJvNXwDvGFl65BdXk2V5DtDr3wcJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm66tvXVqT7XpZ+Yu96Dctrs7CqcuYUt2cqa04ui0xUvX44j4HXBD/a7R++nhS9g1
         BPe59ePozV5LnJLX1djfuyFadATI2UPy0I5em9Xf3F0obwV96NvIswP0oQJWs1uFtl
         60JUYssnWhDGSLWAImQeRvuiMm5aZ53m9bYMpMiw=
Date:   Mon, 9 Sep 2019 08:30:11 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
Message-ID: <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <20190909012532.20454-2-jaegeuk@kernel.org>
 <f446ff29-38a5-61fd-4056-b4067b01c630@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f446ff29-38a5-61fd-4056-b4067b01c630@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Chao Yu wrote:
> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> > If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
> > get commited pages but atomic_file being still set like:
> > 
> > - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
> > 
> > If GC selects this block, we can get an infinite loop like this:
> > 
> > f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > 
> > In that moment, we can observe:
> > 
> > [Before]
> > Try to move 5084219 blocks (BG: 384508)
> >   - data blocks : 4962373 (274483)
> >   - node blocks : 121846 (110025)
> > Skipped : atomic write 4534686 (10)
> > 
> > [After]
> > Try to move 5088973 blocks (BG: 384508)
> >   - data blocks : 4967127 (274483)
> >   - node blocks : 121846 (110025)
> > Skipped : atomic write 4539440 (10)
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 7ae2f3bd8c2f..68b6da734e5f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >  			goto err_out;
> >  
> >  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> > -		if (!ret) {
> > -			clear_inode_flag(inode, FI_ATOMIC_FILE);
> > -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> > -			stat_dec_atomic_write(inode);
> > -		}
> > +
> > +		/* doesn't need to check error */
> > +		clear_inode_flag(inode, FI_ATOMIC_FILE);
> > +		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> > +		stat_dec_atomic_write(inode);
> 
> If there are still valid atomic write pages linked in .inmem_pages, it may cause
> memory leak when we just clear FI_ATOMIC_FILE flag.

f2fs_commit_inmem_pages() should have flushed them.

> 
> So my question is why below logic didn't handle such condition well?
> 
> f2fs_gc()
> 
> 	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> 		if (skipped_round <= MAX_SKIP_GC_COUNT ||
> 					skipped_round * 2 < round) {
> 			segno = NULL_SEGNO;
> 			goto gc_more;
> 		}
> 
> 		if (first_skipped < last_skipped &&
> 				(last_skipped - first_skipped) >
> 						sbi->skipped_gc_rwsem) {
> 			f2fs_drop_inmem_pages_all(sbi, true);

This is doing nothing, since f2fs_commit_inmem_pages() removed the inode
from inmem list.

> 			segno = NULL_SEGNO;
> 			goto gc_more;
> 		}
> 		if (gc_type == FG_GC && !is_sbi_flag_set(sbi, SBI_CP_DISABLED))
> 			ret = f2fs_write_checkpoint(sbi, &cpc);
> 	}
> 
> >  	} else {
> >  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
> >  	}
> > 
