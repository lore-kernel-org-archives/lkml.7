Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCCC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138CD217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZFJIkHf3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WfvX2j5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfHGDZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:25:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHGDZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:25:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3589E6074F; Wed,  7 Aug 2019 03:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565148305;
        bh=J/dns2iOH5Y3mj0RvjacseSPwgmnz4gU4UX2DLstYkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFJIkHf3qgVYzF5DW2WWVvAsAVqoPlAHIvw3Ohp3aDu/6zL0e2eX8cX22RiHRTzJi
         29bgxUK/hzEC9yZbStIAuRYgAimIR/y0aQFpfSH8MUy/I+CIpbFhliRJtmVz+LjDVn
         +fU3TDC3O10857bl2pHgUXUpSryImatUwG18vzhE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 681D16074F;
        Wed,  7 Aug 2019 03:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565148304;
        bh=J/dns2iOH5Y3mj0RvjacseSPwgmnz4gU4UX2DLstYkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfvX2j5gCIfiin5e+wskAAvME6/QqKhdg7Fi+FSfE4kpj5XHQ9z+TaY5qHwAO0/OD
         51AAMEg42Puuaje36Bs2c/aSrb8xBqs/KSW18m7TSuWDfVUvvf6ARzNIXhMfz/QMoQ
         REB2l8PWgtUuB91YEFyLr/RUhBGQWmk49llVu2Vs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 681D16074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 7 Aug 2019 08:54:58 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH v2] f2fs: Fix indefinite loop in f2fs_gc()
Message-ID: <20190807032458.GI8289@codeaurora.org>
References: <1565090396-7263-1-git-send-email-stummala@codeaurora.org>
 <8766875c-1e35-22dc-48d2-45b6776e4f38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8766875c-1e35-22dc-48d2-45b6776e4f38@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Aug 07, 2019 at 10:04:16AM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/8/6 19:19, Sahitya Tummala wrote:
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
> > GC loop under such error scenarios.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > v2: fix as per Chao's suggestion to handle this error case
> > 
> >  fs/f2fs/gc.c      | 15 ++++++++++++++-
> >  fs/f2fs/segment.c |  5 +++++
> >  fs/f2fs/segment.h |  3 +++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 8974672..321a78a 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -382,6 +382,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  			nsearched++;
> >  		}
> >  
> > +		/*
> > +		 * skip selecting the invalid segno (that is failed due to block
> > +		 * validity check failed during GC) to avoid endless GC loop in
> > +		 * such cases.
> > +		 */
> > +		if (test_bit(segno, sm->invalid_segmap))
> > +			goto next;
> > +
> >  		secno = GET_SEC_FROM_SEG(sbi, segno);
> >  
> >  		if (sec_usage_check(sbi, secno))
> > @@ -975,6 +983,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  	int off;
> >  	int phase = 0;
> >  	int submitted = 0;
> > +	struct sit_info *sit_i = SIT_I(sbi);
> >  
> >  	start_addr = START_BLOCK(sbi, segno);
> >  
> > @@ -1008,8 +1017,12 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  		}
> >  
> >  		/* Get an inode by ino with checking validity */
> > -		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs))
> > +		if (!is_alive(sbi, entry, &dni, start_addr + off, &nofs)) {
> > +			if (!test_and_set_bit(segno, sit_i->invalid_segmap))
> > +				f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
> > +						start_addr + off, segno);
> 
> Oh, there is some normal cases in is_alive(), such as f2fs_get_node_page() or
> f2fs_get_node_info() failure due to no memory, we should bypass such cases. I

Oh, yes, I have missed this point.

> guess something like this:
> 
> if (source_blkaddr != blkaddr) {
> 	if (unlikely(check_valid_map(sbi, segno, off))) {

check_valid_map() is validated before is_alive(). So I think this check again
may not be needed. What do you think?

> 		if (!test_and_set_bit(segno, sit_i->invalid_segmap)) {
> 			f2fs_err(sbi, "invalid blkaddr %u in seg %u is found\n",
> 				start_addr + off, segno);
> 			set_sbi_flag(sbi, SBI_NEED_FSCK);
> 		}
> 	}
> 	return false;
> }
> 
> I think this will be safe to call check_valid_map(), because there should be no
> race in between is_alive() and update_sit_entry() from all paths due to node
> page lock dependence.
> 
> One more concern is should we use this under CONFIG_F2FS_CHECK_FS? If there is
> actually such a bug can cause data inconsistency, we'd better find the root
> cause in debug version.
> 

Yes, I agree with you. I will include this under CONFIG_F2FS_CHECK_FS.

Thanks,

> Thanks,
> 
> >  			continue;
> > +		}
> >  
> >  		if (phase == 2) {
> >  			f2fs_ra_node_page(sbi, dni.ino);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a661ac3..d45a1d3 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -4017,6 +4017,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
> >  		return -ENOMEM;
> >  #endif
> >  
> > +	sit_i->invalid_segmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> > +	if (!sit_i->invalid_segmap)
> > +		return -ENOMEM;
> > +
> >  	/* init SIT information */
> >  	sit_i->s_ops = &default_salloc_ops;
> >  
> > @@ -4518,6 +4522,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
> >  #ifdef CONFIG_F2FS_CHECK_FS
> >  	kvfree(sit_i->sit_bitmap_mir);
> >  #endif
> > +	kvfree(sit_i->invalid_segmap);
> >  	kvfree(sit_i);
> >  }
> >  
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index b746028..bc5dbe8 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -246,6 +246,9 @@ struct sit_info {
> >  	unsigned long long min_mtime;		/* min. modification time */
> >  	unsigned long long max_mtime;		/* max. modification time */
> >  
> > +	/* list of segments to be ignored by GC in case of errors */
> > +	unsigned long *invalid_segmap;
> > +
> >  	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
> >  };
> >  
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
