Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0566C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813F52147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552417490;
	bh=566iRbhkG58LUX+noFzqfjU1O5aniRwMQtk68c3QXuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wF0QSrZocvbtQFzLz3pZrhXrNlxeiyGKGXlSO4tcEpLvZFajaDS4WO62Zm3G//jaL
	 vCy9/PaqfHArA9qWkTauXGmEQX0J/AvMmryqSzhEErv3vdYRgXah57sYKsO0lLFwqR
	 vnwZlnKkBMuj+QUodls0GVpUz0HbowhJfGmBUHr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCLTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbfCLTEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:04:48 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1E82087C;
        Tue, 12 Mar 2019 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552417487;
        bh=566iRbhkG58LUX+noFzqfjU1O5aniRwMQtk68c3QXuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go3KZzHcYxY8D+tWP113sAb96ReNcy3J9FJO3HDpt/XQcOQdSvC3wh1L6N7FBCO/8
         okPhy0kgGxVLrkPz3KDfaFJIdbywU+dct1JN9+6lw+sDZ+Yx5ayG9vzJSYFcr0MWFi
         GCzjIbUsAJJiKET6D866RRukuzV9kz/qCfDRsqeA=
Date:   Tue, 12 Mar 2019 12:04:46 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v3] f2fs: fix to add refcount once page is tagged
 PG_private
Message-ID: <20190312190446.GC45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190306093059.80014-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306093059.80014-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06, Chao Yu wrote:
> As Gao Xiang reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202749
> 
> f2fs may skip pageout() due to incorrect page reference count.
> 
> The problem here is that MM defined the rule [1] very clearly that
> once page was set with PG_private flag, we should increment the
> refcount in that page, also main flows like pageout(), migrate_page()
> will assume there is one additional page reference count if
> page_has_private() returns true.
> 
> But currently, f2fs won't add/del refcount when changing PG_private
> flag. Anyway, f2fs should follow MM's rule to make MM's related flows
> running as expected.
> 
> [1] https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com/
> 
> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v3:
> - wrap page->private assignment into f2fs_set_page_private() as suggested
> by Gao Xiang.
>  fs/f2fs/checkpoint.c |  4 ++--
>  fs/f2fs/data.c       | 21 ++++++++-------------
>  fs/f2fs/dir.c        |  2 +-
>  fs/f2fs/f2fs.h       | 21 +++++++++++++++++++++
>  fs/f2fs/node.c       |  2 +-
>  fs/f2fs/segment.c    |  9 +++------
>  6 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index c65a1e8e1e95..a98e1b02279e 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -406,7 +406,7 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
> -		SetPagePrivate(page);
> +		f2fs_set_page_private(page, 0);
>  		f2fs_trace_pid(page);
>  		return 1;
>  	}
> @@ -957,7 +957,7 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
>  	inode_inc_dirty_pages(inode);
>  	spin_unlock(&sbi->inode_lock[type]);
>  
> -	SetPagePrivate(page);
> +	f2fs_set_page_private(page, 0);
>  	f2fs_trace_pid(page);
>  }
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3f3becd46362..992045d1584e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2715,8 +2715,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return f2fs_drop_inmem_page(inode, page);
>  
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +	f2fs_clear_page_private(page);
>  }
>  
>  int f2fs_release_page(struct page *page, gfp_t wait)
> @@ -2730,8 +2729,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>  		return 0;
>  
>  	clear_cold_data(page);
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +	f2fs_clear_page_private(page);
>  	return 1;
>  }
>  
> @@ -2799,12 +2797,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>  			return -EAGAIN;
>  	}
>  
> -	/*
> -	 * A reference is expected if PagePrivate set when move mapping,
> -	 * however F2FS breaks this for maintaining dirty page counts when
> -	 * truncating pages. So here adjusting the 'extra_count' make it work.
> -	 */
> -	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
> +	/* one extra reference was held for atomic_write page */
> +	extra_count = atomic_written ? 1 : 0;
>  	rc = migrate_page_move_mapping(mapping, newpage,
>  				page, mode, extra_count);
>  	if (rc != MIGRATEPAGE_SUCCESS) {
> @@ -2825,9 +2819,10 @@ int f2fs_migrate_page(struct address_space *mapping,
>  		get_page(newpage);
>  	}
>  
> -	if (PagePrivate(page))
> -		SetPagePrivate(newpage);
> -	set_page_private(newpage, page_private(page));
> +	if (PagePrivate(page)) {
> +		f2fs_set_page_private(newpage, page_private(page));
> +		f2fs_clear_page_private(page);
> +	}
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 103f3686a045..fb647e58edb5 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -728,7 +728,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
>  		f2fs_clear_page_cache_dirty_tag(page);
>  		clear_page_dirty_for_io(page);
> -		ClearPagePrivate(page);
> +		f2fs_clear_page_private(page);
>  		ClearPageUptodate(page);
>  		clear_cold_data(page);
>  		inode_dec_dirty_pages(dir);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3007759dd2dd..1e9e780f3db7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2835,6 +2835,27 @@ static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
>  	return true;
>  }
>  
> +static inline void f2fs_set_page_private(struct page *page,
> +						unsigned long date)

I fixed to use "data".

> +{
> +	if (PagePrivate(page))
> +		return;
> +
> +	get_page(page);
> +	SetPagePrivate(page);
> +	set_page_private(page, date);
> +}
> +
> +static inline void f2fs_clear_page_private(struct page *page)
> +{
> +	if (!PagePrivate(page))
> +		return;
> +
> +	set_page_private(page, 0);
> +	ClearPagePrivate(page);
> +	f2fs_put_page(page, 0);
> +}
> +
>  /*
>   * file.c
>   */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index f6ff84e29749..3f99ab288695 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1961,7 +1961,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
> -		SetPagePrivate(page);
> +		f2fs_set_page_private(page, 0);
>  		f2fs_trace_pid(page);
>  		return 1;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e730c334abba..aa7fe79b62b2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -191,8 +191,7 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
>  
>  	f2fs_trace_pid(page);
>  
> -	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
> -	SetPagePrivate(page);
> +	f2fs_set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
>  
>  	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
>  
> @@ -280,8 +279,7 @@ static int __revoke_inmem_pages(struct inode *inode,
>  			ClearPageUptodate(page);
>  			clear_cold_data(page);
>  		}
> -		set_page_private(page, 0);
> -		ClearPagePrivate(page);
> +		f2fs_clear_page_private(page);
>  		f2fs_put_page(page, 1);
>  
>  		list_del(&cur->list);
> @@ -370,8 +368,7 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
>  	kmem_cache_free(inmem_entry_slab, cur);
>  
>  	ClearPageUptodate(page);
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +	f2fs_clear_page_private(page);
>  	f2fs_put_page(page, 0);
>  
>  	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
> -- 
> 2.18.0.rc1
