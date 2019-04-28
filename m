Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F53CC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAF320881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556459245;
	bh=wHRWVkog4zflnnw0t5JuuQTtmUoa5msQ3jIsMaiS1v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BO9cH0fyzD+AmneHtFwXsmRr3MsDQ2Od7S0vouKn0t5qoNcTUMklfFHVNP/Pc2Aky
	 GwF6E8a6T51TeHZyQm+LcsV+lS7TdJzv42FKLEQGR2E9tqP58Kb0Ud92oS+Pxu+Dlp
	 o25u7vRkAaMTG87vygnIuNtF0RfH+u4RHtKlx0Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfD1NrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 09:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfD1NrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 09:47:23 -0400
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF032075D;
        Sun, 28 Apr 2019 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556459243;
        bh=wHRWVkog4zflnnw0t5JuuQTtmUoa5msQ3jIsMaiS1v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUklfwF0o1dCpfy9Erdz6AYCdn3uTTfEXPVmo1vzuzpW+paq7AFZ7XS3xkTxSOJuK
         icWkfoXoY0Zq63Gk0JereoHnlsou9llJBOcw8tQPjVxYwyxfjO97apwRXuXYQVEb6q
         Eo4O/I8Du81RocdN5cXyWD0JjTRYpif+lOeBwEMs=
Date:   Sun, 28 Apr 2019 06:47:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org, drosen@google.com
Subject: Re: [PATCH 1/2] f2fs: fix to avoid potential negative .f_bfree
Message-ID: <20190428134722.GC37346@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190426095754.85784-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426095754.85784-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Chao Yu wrote:
> When calculating .f_bfree value in f2fs_statfs(), sbi->unusable_block_count
> can be increased after the judgment condition, result in overflow of
> .f_bfree in later calculation. This patch fixes to use a temporary signed
> variable to save the calculation result of .f_bfree.
> 
> 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
>  		buf->f_bfree = 0;
>  	else
> 		buf->f_bfree -= sbi->unusable_block_count;

Do we just need stat_lock for this?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2376bb01b5c4..fcc9793dbc2c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1216,6 +1216,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>  	block_t total_count, user_block_count, start_count;
>  	u64 avail_node_count;
> +	long long bfree;
>  
>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
>  	user_block_count = sbi->user_block_count;
> @@ -1226,10 +1227,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_blocks = total_count - start_count;
>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>  						sbi->current_reserved_blocks;
> -	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
> +
> +	bfree = buf->f_bfree - sbi->unusable_block_count;
> +	if (unlikely(bfree < 0))
>  		buf->f_bfree = 0;
>  	else
> -		buf->f_bfree -= sbi->unusable_block_count;
> +		buf->f_bfree = bfree;
>  
>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
>  		buf->f_bavail = buf->f_bfree -
> -- 
> 2.18.0.rc1
