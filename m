Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79ECC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB42081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578337691;
	bh=GTgBx/JA91ia0+OMvTgPUGoIEEqGYFmp61UBCTw+K+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KHYXu+jQynrP5CpmZEYLhf/OoUa4EjmCZZ6owtNDHVlAbH/YuM9QyU+5sitKzYghR
	 j0+OzlwNQNDnvK3WxJQIJ0vLkEnWeRCitqCY7KxlEAZqNH+0o0NxW9gCD+r30w8rnI
	 kXZbKz0Q8vbJ3g5tIQ4TSFrZHU/wC2rN59GPlbsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAFTIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:08:10 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2549E2072E;
        Mon,  6 Jan 2020 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578337690;
        bh=GTgBx/JA91ia0+OMvTgPUGoIEEqGYFmp61UBCTw+K+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbPI6gd17MVlhjV1JDDBmHnf2an7DD5VWxs6DCFS9mIDC+HU5PAxeOfNzDqIIcHAp
         Q7+mf9RkCC/aJ0DNn8E7UYnoHWpmjsLmcCGq3ikfuSC6y/emkVTDsdsIH23IbT6J7i
         DCj8ab6ajH+5jyRGuttqhaYaNQjDMMsTd+WOQqWQ=
Date:   Mon, 6 Jan 2020 11:08:09 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/4] f2fs: compress: fix error path in
 prepare_compress_overwrite()
Message-ID: <20200106190809.GE50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106080144.52363-3-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06, Chao Yu wrote:
> - fix to release cluster pages in retry flow
> - fix to call f2fs_put_dnode() & __do_map_lock() in error path
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index fc4510729654..3390351d2e39 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -626,20 +626,26 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  	}
>  
>  	for (i = 0; i < cc->cluster_size; i++) {
> +		f2fs_bug_on(sbi, cc->rpages[i]);
> +
>  		page = find_lock_page(mapping, start_idx + i);
>  		f2fs_bug_on(sbi, !page);
>  
>  		f2fs_wait_on_page_writeback(page, DATA, true, true);
>  
> -		cc->rpages[i] = page;
> +		f2fs_compress_ctx_add_page(cc, page);
>  		f2fs_put_page(page, 0);
>  
>  		if (!PageUptodate(page)) {
> -			for (idx = 0; idx < cc->cluster_size; idx++) {
> -				f2fs_put_page(cc->rpages[idx],
> -						(idx <= i) ? 1 : 0);
> +			for (idx = 0; idx <= i; idx++) {
> +				unlock_page(cc->rpages[idx]);
>  				cc->rpages[idx] = NULL;
>  			}
> +			for (idx = 0; idx < cc->cluster_size; idx++) {
> +				page = find_lock_page(mapping, start_idx + idx);

Why do we need to lock the pages again?

> +				f2fs_put_page(page, 1);
> +				f2fs_put_page(page, 0);
> +			}
>  			kvfree(cc->rpages);
>  			cc->nr_rpages = 0;
>  			goto retry;
> @@ -654,16 +660,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		for (i = cc->cluster_size - 1; i > 0; i--) {
>  			ret = f2fs_get_block(&dn, start_idx + i);
>  			if (ret) {
> -				/* TODO: release preallocate blocks */
>  				i = cc->cluster_size;
> -				goto unlock_pages;
> +				break;
>  			}
>  
>  			if (dn.data_blkaddr != NEW_ADDR)
>  				break;
>  		}
>  
> +		f2fs_put_dnode(&dn);

We don't neeed this, since f2fs_reserve_block() put the dnode.

> +
>  		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
> +
> +		if (ret)
> +			goto unlock_pages;
>  	}
>  
>  	*fsdata = cc->rpages;
> -- 
> 2.18.0.rc1
