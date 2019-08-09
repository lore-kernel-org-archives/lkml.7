Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B4C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E032171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565365017;
	bh=xHy/aZIedO/E/iENvp78HifCYJNuF/LVZNi3PI8gW3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0oP/rgj5gSM9ru7a+o4l+dk0x94XHLhgONXROCNXY+ZAnB++WJXz+RLyVeqsZgJCD
	 JVh5emYZ6zmPfR+DMh166517ij7T+7hILl5Q8Kev47suO0f1Zc5rkT8lCfmD7XG1mQ
	 HhhETF4n8Aq9egNeja7+OUhfUv1fsbk8g9BqQiR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436695AbfHIPg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfHIPgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:36:55 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3E520C01;
        Fri,  9 Aug 2019 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565365014;
        bh=xHy/aZIedO/E/iENvp78HifCYJNuF/LVZNi3PI8gW3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btsz1PgUwaoFljerSh/Rd04xXFZLEubJgnRY1W+UpDA8gARX9Chz4/4QiFh3sLwWt
         R5q3KWt5s+XAl0uNWkt9gCS7ad1F2PQX99CnRyie21JijF9T+U5MzVItJ+Mn4aculd
         1UtQ5FB9uMpPuKND6MDzMrBP7kVc/vvwdAa7+aKo=
Date:   Fri, 9 Aug 2019 08:36:53 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: Fix indefinite loop in f2fs_gc()
Message-ID: <20190809153653.GD93481@jaegeuk-macbookpro.roam.corp.google.com>
References: <1565185232-11506-1-git-send-email-stummala@codeaurora.org>
 <2b8f7a88-5204-a4ea-9f80-1056abb30d98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8f7a88-5204-a4ea-9f80-1056abb30d98@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07, Chao Yu wrote:
> On 2019-8-7 21:40, Sahitya Tummala wrote:
> > Policy - Foreground GC, LFS and greedy GC mode.
> > 
> > Under this policy, f2fs_gc() loops forever to GC as it doesn't have
> > enough free segements to proceed and thus it keeps calling gc_more
> > for the same victim segment.  This can happen if the selected victim
> > segment could not be GC'd due to failed blkaddr validity check i.e.
> > is_alive() returns false for the blocks set in current validity map.
> > 
> > Fix this by keeping track of such invalid segments and skip those
> > segments for selection in get_victim_by_default() to avoid endless
> > GC loop under such error scenarios. Currently, add this logic under
> > CONFIG_F2FS_CHECK_FS to be able to root cause the issue in debug
> > version.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > v4: Cover all logic with CONFIG_F2FS_CHECK_FS
> > 
> >  fs/f2fs/gc.c      | 31 +++++++++++++++++++++++++++++--
> >  fs/f2fs/segment.c | 14 +++++++++++++-
> >  fs/f2fs/segment.h |  3 +++
> >  3 files changed, 45 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 8974672..cbcacbd 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -382,6 +382,16 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  			nsearched++;
> >  		}
> >  
> > +#ifdef CONFIG_F2FS_CHECK_FS
> > +		/*
> > +		 * skip selecting the invalid segno (that is failed due to block
> > +		 * validity check failure during GC) to avoid endless GC loop in
> > +		 * such cases.
> > +		 */
> > +		if (test_bit(segno, sm->invalid_segmap))
> > +			goto next;
> > +#endif
> > +
> >  		secno = GET_SEC_FROM_SEG(sbi, segno);
> >  
> >  		if (sec_usage_check(sbi, secno))
> > @@ -602,8 +612,15 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  {
> >  	struct page *node_page;
> >  	nid_t nid;
> > -	unsigned int ofs_in_node;
> > +	unsigned int ofs_in_node, segno;
> >  	block_t source_blkaddr;
> > +	unsigned long offset;
> > +#ifdef CONFIG_F2FS_CHECK_FS
> > +	struct sit_info *sit_i = SIT_I(sbi);
> > +#endif
> > +
> > +	segno = GET_SEGNO(sbi, blkaddr);
> > +	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> >  
> >  	nid = le32_to_cpu(sum->nid);
> >  	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
> > @@ -627,8 +644,18 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
> >  	f2fs_put_page(node_page, 1);
> >  
> > -	if (source_blkaddr != blkaddr)
> > +	if (source_blkaddr != blkaddr) {
> > +#ifdef CONFIG_F2FS_CHECK_FS
> 
> 		unsigned int segno = GET_SEGNO(sbi, blkaddr);
> 		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> 
> Should be local, otherwise it looks good to me, I think Jaegeuk can help to fix
> this while merging.

Fixed a bit, and merged.
Thanks~

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > +		if (unlikely(check_valid_map(sbi, segno, offset))) {
> > +			if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
> > +				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
> > +						blkaddr, source_blkaddr, segno);
> > +				f2fs_bug_on(sbi, 1);
> > +			}
> > +		}
> > +#endif
> >  		return false;
> > +	}
> >  	return true;
> >  }
> >  
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a661ac3..ee795b1 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -806,6 +806,9 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> >  		enum dirty_type dirty_type)
> >  {
> >  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> > +#ifdef CONFIG_F2FS_CHECK_FS
> > +	struct sit_info *sit_i = SIT_I(sbi);
> > +#endif
> >  
> >  	if (test_and_clear_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> >  		dirty_i->nr_dirty[dirty_type]--;
> > @@ -817,9 +820,13 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> >  		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
> >  			dirty_i->nr_dirty[t]--;
> >  
> > -		if (get_valid_blocks(sbi, segno, true) == 0)
> > +		if (get_valid_blocks(sbi, segno, true) == 0) {
> >  			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
> >  						dirty_i->victim_secmap);
> > +#ifdef CONFIG_F2FS_CHECK_FS
> > +			clear_bit(segno, sit_i->invalid_segmap);
> > +#endif
> > +		}
> >  	}
> >  }
> >  
> > @@ -4015,6 +4022,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
> >  	sit_i->sit_bitmap_mir = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
> >  	if (!sit_i->sit_bitmap_mir)
> >  		return -ENOMEM;
> > +
> > +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> > +	if (!sit_i->invalid_segmap)
> > +		return -ENOMEM;
> >  #endif
> >  
> >  	/* init SIT information */
> > @@ -4517,6 +4528,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
> >  	kvfree(sit_i->sit_bitmap);
> >  #ifdef CONFIG_F2FS_CHECK_FS
> >  	kvfree(sit_i->sit_bitmap_mir);
> > +	kvfree(sit_i->invalid_segmap);
> >  #endif
> >  	kvfree(sit_i);
> >  }
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index b746028..9370d53 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -229,6 +229,9 @@ struct sit_info {
> >  	char *sit_bitmap;		/* SIT bitmap pointer */
> >  #ifdef CONFIG_F2FS_CHECK_FS
> >  	char *sit_bitmap_mir;		/* SIT bitmap mirror */
> > +
> > +	/* bitmap of segments to be ignored by GC in case of errors */
> > +	unsigned long *invalid_segmap;
> >  #endif
> >  	unsigned int bitmap_size;	/* SIT bitmap size */
> >  
> > 
