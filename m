Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19364C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43992086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568015071;
	bh=tV24GOjNAYTiVFG97hQg62EZuXRnUTpyN7sGlS4Bo40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQq01b5m0MCSs0WbY+qE0Kx/tuo6lYVH98xOPsYVTM0ysPCZxExOHYB8ZJnphdT/v
	 99eENHMqq/sYZK2WDdaYQZtTNbPhAfvyCrhXDtUWw/CdLB2F827I55OxVe2+UOpoXU
	 6db+qbe/K03dR5AZQJyBXWfBVBEu+sfWITn9lZYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbfIIHob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfIIHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:44:30 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F1E20828;
        Mon,  9 Sep 2019 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568015070;
        bh=tV24GOjNAYTiVFG97hQg62EZuXRnUTpyN7sGlS4Bo40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSKMB14HHy94yHAHJeWwQlxtq8Ja+zunbUz7s+CftQGOi42wdvZbRb682Q1hvFBym
         5jTYNBRHWG0ve3MFS92nykxMNmwwGA0ABKofpcAqyXyDCIcjjOx+7xPvJuK6t5vf9B
         vkHHwhh6Y/GWlW/l3ffOWSQSFgY1y6p7AAdRpA+w=
Date:   Mon, 9 Sep 2019 08:44:25 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of
 inode page in is_alive()
Message-ID: <20190909074425.GB21625@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
 <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07, Chao Yu wrote:
> On 2019-9-7 7:48, Jaegeuk Kim wrote:
> > On 09/06, Chao Yu wrote:
> >> If inode is newly created, inode page may not synchronize with inode cache,
> >> so fields like .i_inline or .i_extra_isize could be wrong, in below call
> >> path, we may access such wrong fields, result in failing to migrate valid
> >> target block.
> > 
> > If data is valid, how can we get new inode page?

Let me rephrase the question. If inode is newly created, is this data block
really valid to move in GC?

> 
> is_alive()
> {
> ...
> 	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page

Aren't we seeing the below version warnings?

if (sum->version != dni->version) {
	f2fs_warn(sbi, "%s: valid data with mismatched node version.",
                           __func__);
        set_sbi_flag(sbi, SBI_NEED_FSCK);
}

> 
> 	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);

So, we're getting this? Does this incur infinite loop in GC?

if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
	f2fs_err(sbi, "mismatched blkaddr %u (source_blkaddr %u) in seg %u\n",
	f2fs_bug_on(sbi, 1);
}

> ...
> }
> 
> datablock_addr()
> {
> ...
> 	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
> accessing uninitialized .i_inline of raw_node->i.
> ...
> }
> 
> Thanks,
> 
> > 
> >>
> >> - gc_data_segment
> >>  - is_alive
> >>   - datablock_addr
> >>    - offset_in_addr
> >>
> >> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/dir.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >> index 765f13354d3f..b1840852967e 100644
> >> --- a/fs/f2fs/dir.c
> >> +++ b/fs/f2fs/dir.c
> >> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
> >>  		if (IS_ERR(page))
> >>  			return page;
> >>  
> >> +		/* synchronize inode page's data from inode cache */
> >> +		f2fs_update_inode(inode, page);
> >> +
> >>  		if (S_ISDIR(inode->i_mode)) {
> >>  			/* in order to handle error case */
> >>  			get_page(page);
> >> -- 
> >> 2.18.0.rc1
