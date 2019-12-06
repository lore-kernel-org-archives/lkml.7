Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53DC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F6124659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575605306;
	bh=j7VIs/pP2Li7ttXFZelak/7oq+uT2fUP9Er5lq8WUk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W39/pQ94SuQ/A/hix1A2EdkYMcLHIXQ36murDRxTck0xtPp8jGS/Jn1PlgNWLU3JJ
	 e05Eom3fzkdzOaRT7LZlrXmZHJPINqW1RNn9YUlS1cR37KK50+Gk3OayHMfZLAuURb
	 cmXuGYD3jpwqw5FFYUbZAqGdNi9ng9yjllTGRgHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFEIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLFEIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:08:25 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F1621823;
        Fri,  6 Dec 2019 04:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575605304;
        bh=j7VIs/pP2Li7ttXFZelak/7oq+uT2fUP9Er5lq8WUk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGiMLRPFljplVbwHEJ4djhtj0Keydq/B2UZcK8qlSb7S0+JXXTO0pN4NsR/d+5xZO
         9u06KvCL6artBVKWPAvj9zPBC9PCtiXrNyTFStTagz1Rb3YhVkMvdmad3a1fQQmeBl
         L8dru2gtvpk005BznlEd0JOLFWqG6WmsdkMZDnqA=
Date:   Thu, 5 Dec 2019 20:08:23 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to relocate f2fs_balance_fs() in mkwrite()
Message-ID: <20191206040823.GA33758@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191206033100.36345-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206033100.36345-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

I was testing this.

https://github.com/jaegeuk/f2fs/commit/76be33b9f1fce70dd2d3f04f66d0f78b418fe3f5

On 12/06, Chao Yu wrote:
> As Dinosaur Huang reported, there is a potential deadlock in between
> GC and mkwrite():
> 
> Thread A			Thread B
> - do_page_mkwrite
>  - f2fs_vm_page_mkwrite
>   - lock_page
> 				- f2fs_balance_fs
>                                  - mutex_lock(gc_mutex)
> 				 - f2fs_gc
> 				  - do_garbage_collect
> 				   - ra_data_block
> 				    - grab_cache_page
>   - f2fs_balance_fs
>    - mutex_lock(gc_mutex)
> 
> In order to fix this, we just move f2fs_balance_fs() out of page lock's
> coverage in f2fs_vm_page_mkwrite().
> 
> Reported-by: Dinosaur Huang <dinosaur.huang@unisoc.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c0560d62dbee..ed3290225506 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -67,6 +67,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>  
> +	f2fs_balance_fs(sbi, true);
> +
>  	file_update_time(vmf->vma->vm_file);
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>  	lock_page(page);
> @@ -120,8 +122,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  out_sem:
>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>  
> -	f2fs_balance_fs(sbi, dn.node_changed);
> -
>  	sb_end_pagefault(inode->i_sb);
>  err:
>  	return block_page_mkwrite_return(err);
> -- 
> 2.18.0.rc1
