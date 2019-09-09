Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CBC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C6218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568018250;
	bh=wD71LFsWJb5anHHZVkg5MlXupNPiZs49JdKTq4lnvI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjfwmS6OIh0uX+NZ+/Oo7bEzoqDJOIW5vQz/2QwLtB0VLBXmS6ov8tgsOdB/pmo5m
	 4TmA42fVwJ/04xY/YmUryKWbh2zWb/7ID/Lv3gxJQi0Vw6JKsU3BO4IArG4pD0YhfT
	 /b/f+g45QocuJ8YSRWpQqg9DeckuCaFYVo7SDlR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbfIIIha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfIIIh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:37:29 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D2B218AC;
        Mon,  9 Sep 2019 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568018248;
        bh=wD71LFsWJb5anHHZVkg5MlXupNPiZs49JdKTq4lnvI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I69s85ADkGDxWPpQCOdyxbAuZNX7xCZLsxVKSdEjkUvBPyoaN7OVOtmx7tTp+2dS2
         B0vxQPJbMP2hzJhJ7C+Ag4KRvh92rK6sSFwuYpfC+BoszH+4ob23B+3olyEx2kitAL
         GZnG1puVl47FhDkb+TWrDhUHIXTl8ViIGP/w04lA=
Date:   Mon, 9 Sep 2019 09:37:25 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of
 inode page in is_alive()
Message-ID: <20190909083725.GB25724@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
 <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
 <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
 <79228eaa-776f-da89-89f8-a9b5a90034b6@huawei.com>
 <873f4c07-5694-6554-5266-81812a6bd617@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873f4c07-5694-6554-5266-81812a6bd617@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Chao Yu wrote:
> On 2019/9/9 15:58, Chao Yu wrote:
> > On 2019/9/9 15:44, Jaegeuk Kim wrote:
> >> On 09/07, Chao Yu wrote:
> >>> On 2019-9-7 7:48, Jaegeuk Kim wrote:
> >>>> On 09/06, Chao Yu wrote:
> >>>>> If inode is newly created, inode page may not synchronize with inode cache,
> >>>>> so fields like .i_inline or .i_extra_isize could be wrong, in below call
> >>>>> path, we may access such wrong fields, result in failing to migrate valid
> >>>>> target block.
> >>>>
> >>>> If data is valid, how can we get new inode page?
> >>
> >> Let me rephrase the question. If inode is newly created, is this data block
> >> really valid to move in GC?
> > 
> > I guess it's valid, let double check that.
> 
> We can see inode page:
> 
> - f2fs_create
>  - f2fs_add_link
>   - f2fs_add_dentry
>    - f2fs_init_inode_metadata
>     - f2fs_add_inline_entry
>      - ipage = f2fs_new_inode_page
>      - f2fs_put_page(ipage)   <---- after this

Can you print out how many block was assigned to this inode?

> 
> > 
> >>
> >>>
> >>> is_alive()
> >>> {
> >>> ...
> >>> 	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page
> >>
> >> Aren't we seeing the below version warnings?
> >>
> >> if (sum->version != dni->version) {
> >> 	f2fs_warn(sbi, "%s: valid data with mismatched node version.",
> >>                            __func__);
> >>         set_sbi_flag(sbi, SBI_NEED_FSCK);
> >> }
> 
> The version of summary and dni are all zero.

Then, this node was allocated and removed without being flushed.

> 
> summary nid: 613, ofs: 111, ver: 0
> blkaddr 2436 (blkaddr in node 0)
> expect: seg 10, ofs_in_seg: 54
> real: seg 4294967295, ofs_in_seg: 0
> ofs: 54, 0
> node info ino:613, nid:613, nofs:0
> ofs_in_addr: 0
> 
> Thanks,
> 
> >>
> >>>
> >>> 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
> >>
> >> So, we're getting this? Does this incur infinite loop in GC?
> >>
> >> if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
> >> 	f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
> >> 	f2fs_bug_on(sbi, 1);
> >> }
> > 
> > Yes, I only get this with generic/269, rather than "valid data with mismatched
> > node version.".

Was this block moved as valid? In either way, is_alive() returns false, no?
How about checking i_blocks to detect the page is initialized in is_alive()?

> > 
> > With this patch, generic/269 won't panic again.
> > 
> > Thanks,
> > 
> >>
> >>> ...
> >>> }
> >>>
> >>> datablock_addr()
> >>> {
> >>> ...
> >>> 	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
> >>> accessing uninitialized .i_inline of raw_node->i.
> >>> ...
> >>> }
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>>>
> >>>>> - gc_data_segment
> >>>>>  - is_alive
> >>>>>   - datablock_addr
> >>>>>    - offset_in_addr
> >>>>>
> >>>>> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
> >>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>>> ---
> >>>>>  fs/f2fs/dir.c | 3 +++
> >>>>>  1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >>>>> index 765f13354d3f..b1840852967e 100644
> >>>>> --- a/fs/f2fs/dir.c
> >>>>> +++ b/fs/f2fs/dir.c
> >>>>> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
> >>>>>  		if (IS_ERR(page))
> >>>>>  			return page;
> >>>>>  
> >>>>> +		/* synchronize inode page's data from inode cache */
> >>>>> +		f2fs_update_inode(inode, page);
> >>>>> +
> >>>>>  		if (S_ISDIR(inode->i_mode)) {
> >>>>>  			/* in order to handle error case */
> >>>>>  			get_page(page);
> >>>>> -- 
> >>>>> 2.18.0.rc1
> >> .
> >>
