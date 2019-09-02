Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46662C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FD221897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567465492;
	bh=6GZgqxv9ZdrRWETuEeOhYJh9DzHgCwcEevQnOpLNpuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n2qarMVLjUUZlfojctPBdbba8Tnus/Yu1GrSMADomZd5KZyAswYb0G+5Dyye00ZL5
	 muFxc3ypOZqzxrHbktiJRwf18cyIGuxOdFwbn449xVKbEeEAXfuuJ4gRzbwPx9JEO2
	 +VGXP924qCo/1BBi1LO8cROPBy1jU42rIZpXCTR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfIBXEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfIBXEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:04:50 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79AE216C8;
        Mon,  2 Sep 2019 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567465490;
        bh=6GZgqxv9ZdrRWETuEeOhYJh9DzHgCwcEevQnOpLNpuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlm3LQgQIxvu15+W1OTSs6m66X3i6ZSfdSx6wtgurwla+fwVinjVY1QaX0CcS3sEZ
         RROaSBjf5zbRVXp6WQhIx9H33bNQRkTKuub7PjGClfnOLsx5z+BhdAz8bsQkTOzJ4e
         n+DdGNL8H3QccEqOUnLPiGVp3SmpHhvxZ6S/fB/8=
Date:   Mon, 2 Sep 2019 16:04:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v4] f2fs: add bio cache for IPU
Message-ID: <20190902230449.GD71929@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190219081529.5106-1-yuchao0@huawei.com>
 <d2b3c101-0399-4e85-5765-7b6504aaca74@huawei.com>
 <20190901071757.GA49907@jaegeuk-macbookpro.roam.corp.google.com>
 <024fe351-8e25-35cd-47a7-9755498c73f4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024fe351-8e25-35cd-47a7-9755498c73f4@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02, Chao Yu wrote:
> On 2019/9/1 15:17, Jaegeuk Kim wrote:
> > On 08/31, Chao Yu wrote:
> >> On 2019/2/19 16:15, Chao Yu wrote:
> >>> @@ -1976,10 +2035,13 @@ static int __write_data_page(struct page *page, bool *submitted,
> >>>  	}
> >>>  
> >>>  	unlock_page(page);
> >>> -	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
> >>> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
> >>> +		f2fs_submit_ipu_bio(sbi, bio, page);
> >>>  		f2fs_balance_fs(sbi, need_balance_fs);
> >>> +	}
> >>
> >> Above bio submission was added to avoid below deadlock:
> >>
> >> - __write_data_page
> >>  - f2fs_do_write_data_page
> >>   - set_page_writeback        ---- set writeback flag
> >>   - f2fs_inplace_write_data
> >>  - f2fs_balance_fs
> >>   - f2fs_gc
> >>    - do_garbage_collect
> >>     - gc_data_segment
> >>      - move_data_page
> >>       - f2fs_wait_on_page_writeback
> >>        - wait_on_page_writeback  --- wait writeback
> >>
> >> However, it breaks the merge of IPU IOs, to solve this issue, it looks we need
> >> to add global bio cache for such IPU merge case, then later
> >> f2fs_wait_on_page_writeback can check whether writebacked page is cached or not,
> >> and do the submission if necessary.
> >>
> >> Jaegeuk, any thoughts?
> > 
> > How about calling f2fs_submit_ipu_bio() when we need to do GC in the same
> > context?
> 
> However it also could happen in race case:
> 
> Thread A				Thread B
> - __write_data_page (inode x, page y)
>  - f2fs_do_write_data_page
>   - set_page_writeback        ---- set writeback flag in page y
>   - f2fs_inplace_write_data
>  - f2fs_balance_fs
> 					 - lock gc_mutex
>  - lock gc_mutex
> 					  - f2fs_gc
> 					   - do_garbage_collect
> 					    - gc_data_segment
> 					     - move_data_page
> 					      - f2fs_wait_on_page_writeback
> 					       - wait_on_page_writeback  --- wait writeback of page y
> 
> So it needs a global bio cache for merged IPU pages, how about adding a list to
> link all ipu bios in struct f2fs_bio_info?

Hmm, I can't think of better solution than adding a list. In this case, blk_plug
doesn't work well?

> 
> struct f2fs_bio_info {
> 	....
> 	struct list_head ipu_bio_list;	/* track all ipu bio */
> 	spinlock_t ipu_bio_lock;	/* protect ipu bio list */
> }
> 
> > 
> >>
> >> Thanks,
> > .
> > 
