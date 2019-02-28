Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D788020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367538;
	bh=pXG5bNB4AYLVDdy+62JYw82ry4PlCNYd1LE6NbcVrcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mxs9DkF5J0v8hSlu3bBi8GA0OP3GDb2McMmPcoz8ylrSv7f4haOjSRVVOWgdKUfQI
	 mVLRTIUZpVZho7t6S5YqmsbNK2FwB2OzB8KLT0wG95w9CmU+dcKA9c0idA/LTOY4yS
	 zbHjB3g7seKE/dbBK5zQdrcvSDoO9zLvLiEvlVXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbfB1PZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731208AbfB1PZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:25:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB9F20C01;
        Thu, 28 Feb 2019 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367533;
        bh=pXG5bNB4AYLVDdy+62JYw82ry4PlCNYd1LE6NbcVrcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiuPTtr8dmh+tcqHtITE3u+ogxpVxpqAqABXpNn+kWuuVMugYC7yReKo0gYf3LcBT
         JXOyCe5BWYXgxaj10KNhbqxCI59nF0hEMh11fBwQ6yPeK5yuVKE7/19Z923QjAMIRu
         4VsyEUQJj+oQyLFjkGf0EyR3DeLYucovYxjUufaE=
Date:   Thu, 28 Feb 2019 16:25:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH AUTOSEL 4.20 35/81] debugfs: debugfs_lookup() should
 return NULL if not found
Message-ID: <20190228152530.GD8481@kroah.com>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-35-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228150813.10256-35-sashal@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:07:27AM -0500, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit 37ea7b630ae5cdea4e8ff381d9d23abfef5939e6 ]
> 
> Lots of callers of debugfs_lookup() were just checking NULL to see if
> the file/directory was found or not.  By changing this in ff9fb72bc077
> ("debugfs: return error values, not NULL") we caused some subsystems to
> easily crash.
> 
> Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
> Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Jens Axboe <axboe@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/debugfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b16f8035b1af7..29c68c5d44d5f 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
>   * @parent: a pointer to the parent dentry of the file.
>   *
>   * This function will return a pointer to a dentry if it succeeds.  If the file
> - * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
> - * returned dentry must be passed to dput() when it is no longer needed.
> + * doesn't exist or an error occurs, %NULL will be returned.  The returned
> + * dentry must be passed to dput() when it is no longer needed.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
>  	struct dentry *dentry;
>  
>  	if (IS_ERR(parent))
> -		return parent;
> +		return NULL;
>  
>  	if (!parent)
>  		parent = debugfs_mount->mnt_root;
>  
>  	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
>  	if (IS_ERR(dentry))
> -		return dentry;
> +		return NULL;
>  	if (!d_really_is_positive(dentry)) {
>  		dput(dentry);
> -		return ERR_PTR(-EINVAL);
> +		return NULL;
>  	}
>  	return dentry;

As the "Fixes:" commit should not be backported, no need for this one
either.  Please drop from all queues.

thanks,

greg k-h
