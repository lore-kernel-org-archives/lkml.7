Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC98C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D873D216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cgQf4I1Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NPa/oepq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392421AbfIQFdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:33:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbfIQFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:33:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6646060A97; Tue, 17 Sep 2019 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568698413;
        bh=wmKvgeQfdA6y0rsnNrQ+YHg50taAeluEhrZCwU6uuq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgQf4I1Yu4gsUEk7jkcdLw3Y7F83qogTEwRWrGmRtjohvm7MkiuZO1J7T+srtvsiM
         mLo8etrQnkBc8DB/Sum/C+f3ppU1FpAUpYdTXy9ojP66QmN3pot1Mk1rkeNR+MpKJy
         +s3sUEPBHowcSkP+EMPCdEOsuFfYJfmLwmgMiRac=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1021B60A97;
        Tue, 17 Sep 2019 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568698402;
        bh=wmKvgeQfdA6y0rsnNrQ+YHg50taAeluEhrZCwU6uuq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPa/oepq93w0zze8TUp1+Bom/dNMjeVk2JszON2J+nPZbYRBuMzGPwObH/uBDDoQT
         2VQ+9cPetcjvbpk2kfSnEZrtKiVWcTbCnkbMX4kf5z2JJBAVUo+LeSZSUn7mc/drrl
         Yx5HQSrSFHzN/iy/+s75hBo4DOi1m6i8a4kT5B3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1021B60A97
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 17 Sep 2019 11:03:16 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: Fix indefinite loop in f2fs_gc()
Message-ID: <20190917053316.GB12730@codeaurora.org>
References: <1565185232-11506-1-git-send-email-stummala@codeaurora.org>
 <2b8f7a88-5204-a4ea-9f80-1056abb30d98@kernel.org>
 <355d24c1-b07c-f8ff-1ab9-3f85653ced60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355d24c1-b07c-f8ff-1ab9-3f85653ced60@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Sep 06, 2019 at 07:00:32PM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> Luckily, I can reproduce this issue with generic/269, and have sent another
> patch for the issue, could you please check that one?
> 

Thanks for the fix. The issue could not get reproduced yet, so could not make
much progress on the customer case.

thanks,

> Thanks,
> 
> On 2019/8/7 22:06, Chao Yu wrote:
> > On 2019-8-7 21:40, Sahitya Tummala wrote:
> >> Policy - Foreground GC, LFS and greedy GC mode.
> >>
> >> Under this policy, f2fs_gc() loops forever to GC as it doesn't have
> >> enough free segements to proceed and thus it keeps calling gc_more
> >> for the same victim segment.  This can happen if the selected victim
> >> segment could not be GC'd due to failed blkaddr validity check i.e.
> >> is_alive() returns false for the blocks set in current validity map.
> >>
> >> Fix this by keeping track of such invalid segments and skip those
> >> segments for selection in get_victim_by_default() to avoid endless
> >> GC loop under such error scenarios. Currently, add this logic under
> >> CONFIG_F2FS_CHECK_FS to be able to root cause the issue in debug
> >> version.
> >>
> >> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >> ---
> >> v4: Cover all logic with CONFIG_F2FS_CHECK_FS
> >>
> >>  fs/f2fs/gc.c      | 31 +++++++++++++++++++++++++++++--
> >>  fs/f2fs/segment.c | 14 +++++++++++++-
> >>  fs/f2fs/segment.h |  3 +++
> >>  3 files changed, 45 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index 8974672..cbcacbd 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -382,6 +382,16 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >>  			nsearched++;
> >>  		}
> >>  
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> >> +		/*
> >> +		 * skip selecting the invalid segno (that is failed due to block
> >> +		 * validity check failure during GC) to avoid endless GC loop in
> >> +		 * such cases.
> >> +		 */
> >> +		if (test_bit(segno, sm->invalid_segmap))
> >> +			goto next;
> >> +#endif
> >> +
> >>  		secno = GET_SEC_FROM_SEG(sbi, segno);
> >>  
> >>  		if (sec_usage_check(sbi, secno))
> >> @@ -602,8 +612,15 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>  {
> >>  	struct page *node_page;
> >>  	nid_t nid;
> >> -	unsigned int ofs_in_node;
> >> +	unsigned int ofs_in_node, segno;
> >>  	block_t source_blkaddr;
> >> +	unsigned long offset;
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> >> +	struct sit_info *sit_i = SIT_I(sbi);
> >> +#endif
> >> +
> >> +	segno = GET_SEGNO(sbi, blkaddr);
> >> +	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> >>  
> >>  	nid = le32_to_cpu(sum->nid);
> >>  	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
> >> @@ -627,8 +644,18 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>  	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
> >>  	f2fs_put_page(node_page, 1);
> >>  
> >> -	if (source_blkaddr != blkaddr)
> >> +	if (source_blkaddr != blkaddr) {
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> > 
> > 		unsigned int segno = GET_SEGNO(sbi, blkaddr);
> > 		unsigned int offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> > 
> > Should be local, otherwise it looks good to me, I think Jaegeuk can help to fix
> > this while merging.
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > 
> > Thanks,
> > 
> >> +		if (unlikely(check_valid_map(sbi, segno, offset))) {
> >> +			if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
> >> +				f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
> >> +						blkaddr, source_blkaddr, segno);
> >> +				f2fs_bug_on(sbi, 1);
> >> +			}
> >> +		}
> >> +#endif
> >>  		return false;
> >> +	}
> >>  	return true;
> >>  }
> >>  
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index a661ac3..ee795b1 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -806,6 +806,9 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> >>  		enum dirty_type dirty_type)
> >>  {
> >>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> >> +	struct sit_info *sit_i = SIT_I(sbi);
> >> +#endif
> >>  
> >>  	if (test_and_clear_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> >>  		dirty_i->nr_dirty[dirty_type]--;
> >> @@ -817,9 +820,13 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> >>  		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
> >>  			dirty_i->nr_dirty[t]--;
> >>  
> >> -		if (get_valid_blocks(sbi, segno, true) == 0)
> >> +		if (get_valid_blocks(sbi, segno, true) == 0) {
> >>  			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
> >>  						dirty_i->victim_secmap);
> >> +#ifdef CONFIG_F2FS_CHECK_FS
> >> +			clear_bit(segno, sit_i->invalid_segmap);
> >> +#endif
> >> +		}
> >>  	}
> >>  }
> >>  
> >> @@ -4015,6 +4022,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
> >>  	sit_i->sit_bitmap_mir = kmemdup(src_bitmap, bitmap_size, GFP_KERNEL);
> >>  	if (!sit_i->sit_bitmap_mir)
> >>  		return -ENOMEM;
> >> +
> >> +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> >> +	if (!sit_i->invalid_segmap)
> >> +		return -ENOMEM;
> >>  #endif
> >>  
> >>  	/* init SIT information */
> >> @@ -4517,6 +4528,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
> >>  	kvfree(sit_i->sit_bitmap);
> >>  #ifdef CONFIG_F2FS_CHECK_FS
> >>  	kvfree(sit_i->sit_bitmap_mir);
> >> +	kvfree(sit_i->invalid_segmap);
> >>  #endif
> >>  	kvfree(sit_i);
> >>  }
> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >> index b746028..9370d53 100644
> >> --- a/fs/f2fs/segment.h
> >> +++ b/fs/f2fs/segment.h
> >> @@ -229,6 +229,9 @@ struct sit_info {
> >>  	char *sit_bitmap;		/* SIT bitmap pointer */
> >>  #ifdef CONFIG_F2FS_CHECK_FS
> >>  	char *sit_bitmap_mir;		/* SIT bitmap mirror */
> >> +
> >> +	/* bitmap of segments to be ignored by GC in case of errors */
> >> +	unsigned long *invalid_segmap;
> >>  #endif
> >>  	unsigned int bitmap_size;	/* SIT bitmap size */
> >>  
> >>
> > .
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
