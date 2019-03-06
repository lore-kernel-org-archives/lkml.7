Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BCE2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551844019;
	bh=PMVCxZ4ZPW97zmOWn4wfKhfj25tvj/GHUkxbc/r6p8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fXD6BlX+z4tObEIbyrnDqO/Udsh9Y/5nqFe64Sk1uzUn321U8LuIvVqqPXBd64Z83
	 pTV88MtnMZmR1CZ6/nBn1oEW+shd/eLHS/91BFiKVMY7L2PNN/M+QIR/KKz1yllw6q
	 NlQsg0E67T5NJ7HO3O61xl799Sdgks58nREdlNS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCFDq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfCFDq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:46:57 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9731820663;
        Wed,  6 Mar 2019 03:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551844015;
        bh=PMVCxZ4ZPW97zmOWn4wfKhfj25tvj/GHUkxbc/r6p8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7hZ2hmBIPgPpkCf3LInFZouqjZCHw2eJAB7o8hEo/WXEPmcJqNcaYVjxjSGNWWsh
         R/KDtlQEgwCjJU0Fx6FksP8XhPYRDxo3VKyJq3PzBww4J0Rmy/FKaD7pRDvmw2ZbXr
         1dqkNq73OnMilLmV0vTzXBpdZMWXB6UUam9EQIq8=
Date:   Tue, 5 Mar 2019 19:46:54 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: fix to add refcount once page is tagged
 PG_private
Message-ID: <20190306034654.GD78380@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190305095233.126601-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305095233.126601-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05, Chao Yu wrote:
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
>  fs/f2fs/checkpoint.c | 11 +++++++++--
>  fs/f2fs/data.c       | 32 ++++++++++++++++++++------------
>  fs/f2fs/dir.c        |  6 +++++-
>  fs/f2fs/node.c       |  6 +++++-
>  fs/f2fs/segment.c    | 23 +++++++++++++++++------
>  5 files changed, 56 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index c65a1e8e1e95..4e0e93af5ce0 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -406,7 +406,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
> -		SetPagePrivate(page);
> +
> +		if (!PagePrivate(page)) {
> +			get_page(page);
> +			SetPagePrivate(page);

Can we add generic functions?

f2fs_set_page_private(page)
{
	if (PagePrivate(page))
		return;

	SetPagePrivate(page);
	get_page(page);
}
 
f2fs_clear_page_private(page)
{
	if (!PagePrivate(page))
		return;

	set_page_private(page, 0);
	ClearPagePrivate(page);
	f2fs_put_page(page, 0);
}

>
> +		}
>  		f2fs_trace_pid(page);
>  		return 1;
>  	}
> @@ -957,7 +961,10 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
>  	inode_inc_dirty_pages(inode);
>  	spin_unlock(&sbi->inode_lock[type]);
>  
> -	SetPagePrivate(page);
> +	if (!PagePrivate(page)) {
> +		get_page(page);
> +		SetPagePrivate(page);
> +	}
>  	f2fs_trace_pid(page);
>  }
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3f3becd46362..46924d4f69d0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2715,8 +2715,11 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return f2fs_drop_inmem_page(inode, page);
>  
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +	if (PagePrivate(page)) {
> +		set_page_private(page, 0);
> +		ClearPagePrivate(page);
> +		f2fs_put_page(page, 0);
> +	}
>  }
>  
>  int f2fs_release_page(struct page *page, gfp_t wait)
> @@ -2730,8 +2733,11 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>  		return 0;
>  
>  	clear_cold_data(page);
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +	if (PagePrivate(page)) {
> +		set_page_private(page, 0);
> +		ClearPagePrivate(page);
> +		f2fs_put_page(page, 0);
> +	}
>  	return 1;
>  }
>  
> @@ -2799,12 +2805,8 @@ int f2fs_migrate_page(struct address_space *mapping,
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
> @@ -2825,9 +2827,15 @@ int f2fs_migrate_page(struct address_space *mapping,
>  		get_page(newpage);
>  	}
>  
> -	if (PagePrivate(page))
> +	if (PagePrivate(page)) {
> +		get_page(newpage);
>  		SetPagePrivate(newpage);
> -	set_page_private(newpage, page_private(page));
> +		set_page_private(newpage, page_private(page));
> +
> +		set_page_private(page, 0);
> +		ClearPagePrivate(page);
> +		f2fs_put_page(page, 0);
> +	}
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 103f3686a045..fbbafb04a431 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -728,7 +728,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>  		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
>  		f2fs_clear_page_cache_dirty_tag(page);
>  		clear_page_dirty_for_io(page);
> -		ClearPagePrivate(page);
> +		if (PagePrivate(page)) {
> +			set_page_private(page, 0);
> +			ClearPagePrivate(page);
> +			f2fs_put_page(page, 0);
> +		}
>  		ClearPageUptodate(page);
>  		clear_cold_data(page);
>  		inode_dec_dirty_pages(dir);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index f6ff84e29749..ce97a9885105 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1961,7 +1961,11 @@ static int f2fs_set_node_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
> -		SetPagePrivate(page);
> +
> +		if (!PagePrivate(page)) {
> +			get_page(page);
> +			SetPagePrivate(page);
> +		}
>  		f2fs_trace_pid(page);
>  		return 1;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e730c334abba..2d77dd133a4e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -191,8 +191,11 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
>  
>  	f2fs_trace_pid(page);
>  
> -	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
> -	SetPagePrivate(page);
> +	if (!PagePrivate(page)) {
> +		get_page(page);
> +		SetPagePrivate(page);
> +		set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
> +	}
>  
>  	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
>  
> @@ -280,8 +283,11 @@ static int __revoke_inmem_pages(struct inode *inode,
>  			ClearPageUptodate(page);
>  			clear_cold_data(page);
>  		}
> -		set_page_private(page, 0);
> -		ClearPagePrivate(page);
> +		if (PagePrivate(page)) {
> +			set_page_private(page, 0);
> +			ClearPagePrivate(page);
> +			f2fs_put_page(page, 0);
> +		}
>  		f2fs_put_page(page, 1);
>  
>  		list_del(&cur->list);
> @@ -370,8 +376,13 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
>  	kmem_cache_free(inmem_entry_slab, cur);
>  
>  	ClearPageUptodate(page);
> -	set_page_private(page, 0);
> -	ClearPagePrivate(page);
> +
> +	if (PagePrivate(page)) {
> +		set_page_private(page, 0);
> +		ClearPagePrivate(page);
> +		f2fs_put_page(page, 0);
> +	}
> +
>  	f2fs_put_page(page, 0);
>  
>  	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
> -- 
> 2.18.0.rc1
