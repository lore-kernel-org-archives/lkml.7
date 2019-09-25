Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B5C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52162205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfIYWYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:24:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44848 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfIYWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:24:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDFhg-0004J8-OU; Wed, 25 Sep 2019 22:24:08 +0000
Date:   Wed, 25 Sep 2019 23:24:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: prevent memory leak in udf_new_inode
Message-ID: <20190925222408.GN26530@ZenIV.linux.org.uk>
References: <20190925213904.12128-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925213904.12128-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:39:03PM -0500, Navid Emamdoost wrote:
> In udf_new_inode if either udf_new_block or insert_inode_locked fials
> the allocated memory for iinfo->i_ext.i_data should be released.

"... because of such-and-such reasons" part appears to be missing.
Why should it be released there?

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  fs/udf/ialloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
> index 0adb40718a5d..b8ab3acab6b6 100644
> --- a/fs/udf/ialloc.c
> +++ b/fs/udf/ialloc.c
> @@ -86,6 +86,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
>  			      dinfo->i_location.partitionReferenceNum,
>  			      start, &err);
>  	if (err) {
> +		kfree(iinfo->i_ext.i_data);
>  		iput(inode);
>  		return ERR_PTR(err);
>  	}

Have you tested that?  Because it has all earmarks of double-free;
normal eviction pathway ought to free the damn thing.  <greps around
a bit>

Mind explaining what's to stop ->evict_inode (== udf_evict_inode) from
hitting
        kfree(iinfo->i_ext.i_data);
considering that this call of kfree() appears to be unconditional there?

> @@ -130,6 +131,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
>  	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>  	iinfo->i_crtime = inode->i_mtime;
>  	if (unlikely(insert_inode_locked(inode) < 0)) {
> +		kfree(iinfo->i_ext.i_data);
>  		make_bad_inode(inode);
>  		iput(inode);
>  		return ERR_PTR(-EIO);

And the same here.
