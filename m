Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25276C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC94A20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578516596;
	bh=RoGyoxDjbmh57ZZyR6e3bepLtqCh5hqe8I/Oj1/AnkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=matkVkRC4YyMq5iSjNsOBxSlaFx+citDciW1EHnrGiP9vkJJgz82Z5aEpgRJVAmrj
	 XdxtCRiTdat5ypuZNHfAyoBpLg5RtHq2Xu6N9e5WLuJ568G3DMPfN/0TC/hEbwbxSn
	 uzWO1cRR/hh5oVIo0G699I6u07E/MUCRmynspsOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgAHUty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgAHUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:49:52 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B3F206DB;
        Wed,  8 Jan 2020 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578516591;
        bh=RoGyoxDjbmh57ZZyR6e3bepLtqCh5hqe8I/Oj1/AnkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEP25404Vj17mJBZ/HZTJvolNiedCiANYMD0o9tuLERpiN96XVn4eMyDNideENRJ1
         KlIfDTSu08HhqtmDiArry0dKlMZRLrj/se9q0JVg0brPkFb9u7OrkNWKH8j1Ij9lci
         GfN2cRGOCqgB5mX7h7iRl7rs6tRdnXwLuEcmd+ew=
Date:   Wed, 8 Jan 2020 12:49:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/4] f2fs: compress: fix error path in
 prepare_compress_overwrite()
Message-ID: <20200108204950.GD28331@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-3-yuchao0@huawei.com>
 <20200106190809.GE50058@jaegeuk-macbookpro.roam.corp.google.com>
 <e5c45ba2-6437-c84a-11b3-abe8c16a5c6c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c45ba2-6437-c84a-11b3-abe8c16a5c6c@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Chao Yu wrote:
> On 2020/1/7 3:08, Jaegeuk Kim wrote:
> > On 01/06, Chao Yu wrote:
> >> - fix to release cluster pages in retry flow
> >> - fix to call f2fs_put_dnode() & __do_map_lock() in error path
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/compress.c | 22 ++++++++++++++++------
> >>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >> index fc4510729654..3390351d2e39 100644
> >> --- a/fs/f2fs/compress.c
> >> +++ b/fs/f2fs/compress.c
> >> @@ -626,20 +626,26 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
> >>  	}
> >>  
> >>  	for (i = 0; i < cc->cluster_size; i++) {
> >> +		f2fs_bug_on(sbi, cc->rpages[i]);
> >> +
> >>  		page = find_lock_page(mapping, start_idx + i);
> >>  		f2fs_bug_on(sbi, !page);
> >>  
> >>  		f2fs_wait_on_page_writeback(page, DATA, true, true);
> >>  
> >> -		cc->rpages[i] = page;
> >> +		f2fs_compress_ctx_add_page(cc, page);
> >>  		f2fs_put_page(page, 0);
> >>  
> >>  		if (!PageUptodate(page)) {
> >> -			for (idx = 0; idx < cc->cluster_size; idx++) {
> >> -				f2fs_put_page(cc->rpages[idx],
> >> -						(idx <= i) ? 1 : 0);
> >> +			for (idx = 0; idx <= i; idx++) {
> >> +				unlock_page(cc->rpages[idx]);
> >>  				cc->rpages[idx] = NULL;
> >>  			}
> >> +			for (idx = 0; idx < cc->cluster_size; idx++) {
> >> +				page = find_lock_page(mapping, start_idx + idx);
> > 
> > Why do we need to lock the pages again?
> 
> Here, all pages in cluster has one extra reference count, we need to find all
> pages, and release those references on them.
> 
> cc->rpages may not record all pages' pointers, so we can not use
> 
> f2fs_put_page(cc->rpages[idx], (idx <= i) ? 1 : 0); to release all pages' references.
> 
> BTW, find_get_page() should be fine to instead find_lock_page().

Could you take a look at this?

https://github.com/jaegeuk/f2fs/commit/2e4ea726633dd2666f57ae88dfec5d97694d6495


Thanks,

> 
> > 
> >> +				f2fs_put_page(page, 1);
> >> +				f2fs_put_page(page, 0);
> >> +			}
> >>  			kvfree(cc->rpages);
> >>  			cc->nr_rpages = 0;
> >>  			goto retry;
> >> @@ -654,16 +660,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
> >>  		for (i = cc->cluster_size - 1; i > 0; i--) {
> >>  			ret = f2fs_get_block(&dn, start_idx + i);
> >>  			if (ret) {
> >> -				/* TODO: release preallocate blocks */
> >>  				i = cc->cluster_size;
> >> -				goto unlock_pages;
> >> +				break;
> >>  			}
> >>  
> >>  			if (dn.data_blkaddr != NEW_ADDR)
> >>  				break;
> >>  		}
> >>  
> >> +		f2fs_put_dnode(&dn);
> > 
> > We don't neeed this, since f2fs_reserve_block() put the dnode.
> 
> Correct.
> 
> Thanks,
> 
> > 
> >> +
> >>  		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
> >> +
> >> +		if (ret)
> >> +			goto unlock_pages;
> >>  	}
> >>  
> >>  	*fsdata = cc->rpages;
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
