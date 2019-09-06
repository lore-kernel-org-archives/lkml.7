Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5BE208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567811430;
	bh=DWOUzOtNS02FNCJ7dP2lQJ0JmC8h3u5IYwib+4bFMaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D6my5ArQCnUF45nhw/XrqSeQKKLN8SKKVP8MGHIPrE+0Dbb4C7iOUBkhKspq1UIqN
	 cUbxs1uCq4qcsP0IwSyRPnYPp+zALGcHLZTc6jvNh883zWnaliU7n+6wDT10CeG+wh
	 CNc+kJ87861KOxvdk3oGAcn+iiW1Z6msTm/0NXBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbfIFXKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfIFXK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:10:29 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1873D207FC;
        Fri,  6 Sep 2019 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567811428;
        bh=DWOUzOtNS02FNCJ7dP2lQJ0JmC8h3u5IYwib+4bFMaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xsNcr0BYg/a3FJLdpndzLhE/qAjADYwt3EYa+zhXyJM2wPJSQ3GfbLZJ7fdPa9TRL
         Dkd4LUua+0K817a2PHJ3b48FMYI0KHhIJaGXlhIThlEeSSHAi6P3L917Yu2NElTsuP
         g+2y/UeX9CgU44Y5IqD7PfpVJh3L5SkzODiClCW0=
Date:   Fri, 6 Sep 2019 16:10:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] f2fs: introduce get_available_block_count() for
 cleanup
Message-ID: <20190906231027.GB71848@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190831095401.8142-1-yuchao0@huawei.com>
 <20190902225413.GC71929@jaegeuk-macbookpro.roam.corp.google.com>
 <6c5da795-4929-3bb6-fdbf-e103a2bcd431@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5da795-4929-3bb6-fdbf-e103a2bcd431@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03, Chao Yu wrote:
> On 2019-9-3 6:54, Jaegeuk Kim wrote:
> > On 08/31, Chao Yu wrote:
> >> There are very similar codes in inc_valid_block_count() and
> >> inc_valid_node_count() which is used for available user block
> >> count calculation.
> >>
> >> This patch introduces a new helper get_available_block_count()
> >> to include those common codes, and used it instead for cleanup.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2:
> >> - fix panic during recovery
> >>  fs/f2fs/f2fs.h | 47 +++++++++++++++++++++++++++--------------------
> >>  1 file changed, 27 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index a89ad8cab821..9c010e6cba5c 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -1756,6 +1756,27 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
> >>  	return false;
> >>  }
> >>  
> >> +static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
> >> +						struct inode *inode, bool cap)
> >> +{
> >> +	block_t avail_user_block_count;
> >> +
> >> +	avail_user_block_count = sbi->user_block_count -
> >> +					sbi->current_reserved_blocks;
> >> +
> >> +	if (!__allow_reserved_blocks(sbi, inode, cap))
> >> +		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> >> +
> >> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> >> +		if (avail_user_block_count > sbi->unusable_block_count)
> >> +			avail_user_block_count -= sbi->unusable_block_count;
> >> +		else
> >> +			avail_user_block_count = 0;
> >> +	}
> >> +
> >> +	return avail_user_block_count;
> >> +}
> >> +
> >>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
> >>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >>  				 struct inode *inode, blkcnt_t *count)
> >> @@ -1782,17 +1803,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >>  
> >>  	spin_lock(&sbi->stat_lock);
> >>  	sbi->total_valid_block_count += (block_t)(*count);
> >> -	avail_user_block_count = sbi->user_block_count -
> >> -					sbi->current_reserved_blocks;
> >> +	avail_user_block_count = get_available_block_count(sbi, inode, true);
> >>  
> >> -	if (!__allow_reserved_blocks(sbi, inode, true))
> >> -		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> >> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> >> -		if (avail_user_block_count > sbi->unusable_block_count)
> >> -			avail_user_block_count -= sbi->unusable_block_count;
> >> -		else
> >> -			avail_user_block_count = 0;
> >> -	}
> >>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
> >>  		diff = sbi->total_valid_block_count - avail_user_block_count;
> >>  		if (diff > *count)
> >> @@ -2005,7 +2017,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >>  					struct inode *inode, bool is_inode)
> >>  {
> >>  	block_t	valid_block_count;
> >> -	unsigned int valid_node_count, user_block_count;
> >> +	unsigned int valid_node_count;
> >> +	unsigned int avail_user_block_count;
> >>  	int err;
> >>  
> >>  	if (is_inode) {
> >> @@ -2027,16 +2040,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >>  
> >>  	spin_lock(&sbi->stat_lock);
> >>  
> >> -	valid_block_count = sbi->total_valid_block_count +
> >> -					sbi->current_reserved_blocks + 1;
> >> -
> >> -	if (!__allow_reserved_blocks(sbi, inode, false))
> >> -		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> >> -	user_block_count = sbi->user_block_count;
> >> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> >> -		user_block_count -= sbi->unusable_block_count;
> >> +	valid_block_count = sbi->total_valid_block_count + 1;
> >> +	avail_user_block_count = get_available_block_count(sbi, inode, false);
> > 
> > This doesn't look like same?
> 
> Actually, calculations of block count in inc_valid_node_count() and
> inc_valid_block_count() should be the same, I've no idea why we use different
> policy for reserved block for root user.

Hmm, for now, let's defer to discuss this.

> 
> Thanks,
> 
> > 
> >>  
> >> -	if (unlikely(valid_block_count > user_block_count)) {
> >> +	if (unlikely(valid_block_count > avail_user_block_count)) {
> >>  		spin_unlock(&sbi->stat_lock);
> >>  		goto enospc;
> >>  	}
> >> -- 
> >> 2.18.0.rc1
