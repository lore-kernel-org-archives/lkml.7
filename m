Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BDC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85937216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556592849;
	bh=p/SnhW3xeF2JQZ6fSOsDt/Ecd/keaGeVyzAKAxontBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JSIP71s5j+offNk9CGKw+c2iGClxmG+h8TrPC6eAtYp7veRuaOoHlv6I13+uvciS0
	 XyvgMsdpoRPqkhWp24qzm24s870q5/5qRCdRP4I07eeSNYlZYyYYFtlDo8WPFj+flD
	 lQH9BI4gPl/6J1I9Bj0tHyEeAxFfvyi9Nu32vgWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfD3CyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfD3CyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:54:08 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4850F20578;
        Tue, 30 Apr 2019 02:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556592847;
        bh=p/SnhW3xeF2JQZ6fSOsDt/Ecd/keaGeVyzAKAxontBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMcwrkwvtTThEtCR6LL4hG89y/2GZaJ33apYPleVwHMxMT6INeCT46tbkrbUawTXe
         tJAGnjL3VPFMLKmdNJck9WYBl7ZaIOwizaK3mYiLZV0eMzrzqHUdJ6Zdl5KgVoeA0a
         dFFccJCZxz48eMPeo95KoPVcgmFOwQ7GnMhVwmtE=
Date:   Mon, 29 Apr 2019 19:54:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, drosen@google.com
Subject: Re: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
Message-ID: <20190430025406.GA17299@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190426095754.85784-1-yuchao0@huawei.com>
 <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
 <f8b890b8-22a3-bead-7df5-6ab87deb56e9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b890b8-22a3-bead-7df5-6ab87deb56e9@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29, Chao Yu wrote:
> On 2019-4-28 21:47, Jaegeuk Kim wrote:
> > On 04/26, Chao Yu wrote:
> >> When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
> >> can be increased after the judgment condition, result in overflow of
> >> .f_bfree in later calculation. This patch fixes to use a temporary signed
> >> variable to save the calculation result of .f_bfree.
> >>
> >> 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
> >>  		buf->f_bfree = 0;
> >>  	else
> >> 		buf->f_bfree -= sbi->unusable_block_count;
> > 
> > Do we just need stat_lock for this?
> 
> Like we access other stat value in statfs(), we just need the instantaneous
> value of .unusable_block_count, so we don't need additional stat_lock, right?

What I've concerend is whether or not this fixes all the inconsistent values.
The original intention was providing stats in best effort, so we wouldn't use
any lock.

> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/super.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 2376bb01b5c4..fcc9793dbc2c 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
> >>  	block_t total_count, user_block_count, start_count;
> >>  	u64 avail_node_count;
> >> +	long long bfree;
> >>  
> >>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
> >>  	user_block_count = sbi->user_block_count;
> >> @@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>  	buf->f_blocks = total_count - start_count;
> >>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
> >>  						sbi->current_reserved_blocks;
> >> -	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
> >> +
> >> +	bfree = buf->f_bfree - sbi->unusable_block_count;
> >> +	if (unlikely(bfree < 0))
> >>  		buf->f_bfree = 0;
> >>  	else
> >> -		buf->f_bfree -= sbi->unusable_block_count;
> >> +		buf->f_bfree = bfree;
> >>  
> >>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
> >>  		buf->f_bavail = buf->f_bfree -
> >> -- 
> >> 2.18.0.rc1
