Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08F220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfCFGbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:31:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbfCFGbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:31:38 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2ECF52F0FCF37C7ACBE7;
        Wed,  6 Mar 2019 14:31:36 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 14:31:35 +0800
Subject: Re: [PATCH 1/2] f2fs: fix to add refcount once page is tagged
 PG_private
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190305095233.126601-1-yuchao0@huawei.com>
 <20190306034654.GD78380@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <328faef7-dad0-4dd9-5ecf-1c37ed5ebad6@huawei.com>
Date:   Wed, 6 Mar 2019 14:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190306034654.GD78380@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/6 11:46, Jaegeuk Kim wrote:
> On 03/05, Chao Yu wrote:
>> As Gao Xiang reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=202749
>>
>> f2fs may skip pageout() due to incorrect page reference count.
>>
>> The problem here is that MM defined the rule [1] very clearly that
>> once page was set with PG_private flag, we should increment the
>> refcount in that page, also main flows like pageout(), migrate_page()
>> will assume there is one additional page reference count if
>> page_has_private() returns true.
>>
>> But currently, f2fs won't add/del refcount when changing PG_private
>> flag. Anyway, f2fs should follow MM's rule to make MM's related flows
>> running as expected.
>>
>> [1] https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com/
>>
>> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/checkpoint.c | 11 +++++++++--
>>  fs/f2fs/data.c       | 32 ++++++++++++++++++++------------
>>  fs/f2fs/dir.c        |  6 +++++-
>>  fs/f2fs/node.c       |  6 +++++-
>>  fs/f2fs/segment.c    | 23 +++++++++++++++++------
>>  5 files changed, 56 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index c65a1e8e1e95..4e0e93af5ce0 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -406,7 +406,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>>  	if (!PageDirty(page)) {
>>  		__set_page_dirty_nobuffers(page);
>>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
>> -		SetPagePrivate(page);
>> +
>> +		if (!PagePrivate(page)) {
>> +			get_page(page);
>> +			SetPagePrivate(page);
> 
> Can we add generic functions?
> 
> f2fs_set_page_private(page)
> {
> 	if (PagePrivate(page))
> 		return;
> 
> 	SetPagePrivate(page);
> 	get_page(page);
> }
>  
> f2fs_clear_page_private(page)
> {
> 	if (!PagePrivate(page))
> 		return;
> 
> 	set_page_private(page, 0);
> 	ClearPagePrivate(page);
> 	f2fs_put_page(page, 0);
> }

Done. :)

Thanks,

> 
>>
>> +		}
>>  		f2fs_trace_pid(page);
>>  		return 1;
>>  	}
>> @@ -957,7 +961,10 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
>>  	inode_inc_dirty_pages(inode);
>>  	spin_unlock(&sbi->inode_lock[type]);
>>  
>> -	SetPagePrivate(page);
>> +	if (!PagePrivate(page)) {
>> +		get_page(page);
>> +		SetPagePrivate(page);
>> +	}
>>  	f2fs_trace_pid(page);
>>  }
>>  
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 3f3becd46362..46924d4f69d0 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2715,8 +2715,11 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>>  		return f2fs_drop_inmem_page(inode, page);
>>  
>> -	set_page_private(page, 0);
>> -	ClearPagePrivate(page);
>> +	if (PagePrivate(page)) {
>> +		set_page_private(page, 0);
>> +		ClearPagePrivate(page);
>> +		f2fs_put_page(page, 0);
>> +	}
>>  }
>>  
>>  int f2fs_release_page(struct page *page, gfp_t wait)
>> @@ -2730,8 +2733,11 @@ int f2fs_release_page(struct page *page, gfp_t wait)
>>  		return 0;
>>  
>>  	clear_cold_data(page);
>> -	set_page_private(page, 0);
>> -	ClearPagePrivate(page);
>> +	if (PagePrivate(page)) {
>> +		set_page_private(page, 0);
>> +		ClearPagePrivate(page);
>> +		f2fs_put_page(page, 0);
>> +	}
>>  	return 1;
>>  }
>>  
>> @@ -2799,12 +2805,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>>  			return -EAGAIN;
>>  	}
>>  
>> -	/*
>> -	 * A reference is expected if PagePrivate set when move mapping,
>> -	 * however F2FS breaks this for maintaining dirty page counts when
>> -	 * truncating pages. So here adjusting the 'extra_count' make it work.
>> -	 */
>> -	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
>> +	/* one extra reference was held for atomic_write page */
>> +	extra_count = atomic_written ? 1 : 0;
>>  	rc = migrate_page_move_mapping(mapping, newpage,
>>  				page, mode, extra_count);
>>  	if (rc != MIGRATEPAGE_SUCCESS) {
>> @@ -2825,9 +2827,15 @@ int f2fs_migrate_page(struct address_space *mapping,
>>  		get_page(newpage);
>>  	}
>>  
>> -	if (PagePrivate(page))
>> +	if (PagePrivate(page)) {
>> +		get_page(newpage);
>>  		SetPagePrivate(newpage);
>> -	set_page_private(newpage, page_private(page));
>> +		set_page_private(newpage, page_private(page));
>> +
>> +		set_page_private(page, 0);
>> +		ClearPagePrivate(page);
>> +		f2fs_put_page(page, 0);
>> +	}
>>  
>>  	if (mode != MIGRATE_SYNC_NO_COPY)
>>  		migrate_page_copy(newpage, page);
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 103f3686a045..fbbafb04a431 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -728,7 +728,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
>>  		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
>>  		f2fs_clear_page_cache_dirty_tag(page);
>>  		clear_page_dirty_for_io(page);
>> -		ClearPagePrivate(page);
>> +		if (PagePrivate(page)) {
>> +			set_page_private(page, 0);
>> +			ClearPagePrivate(page);
>> +			f2fs_put_page(page, 0);
>> +		}
>>  		ClearPageUptodate(page);
>>  		clear_cold_data(page);
>>  		inode_dec_dirty_pages(dir);
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index f6ff84e29749..ce97a9885105 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1961,7 +1961,11 @@ static int f2fs_set_node_page_dirty(struct page *page)
>>  	if (!PageDirty(page)) {
>>  		__set_page_dirty_nobuffers(page);
>>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
>> -		SetPagePrivate(page);
>> +
>> +		if (!PagePrivate(page)) {
>> +			get_page(page);
>> +			SetPagePrivate(page);
>> +		}
>>  		f2fs_trace_pid(page);
>>  		return 1;
>>  	}
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index e730c334abba..2d77dd133a4e 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -191,8 +191,11 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
>>  
>>  	f2fs_trace_pid(page);
>>  
>> -	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
>> -	SetPagePrivate(page);
>> +	if (!PagePrivate(page)) {
>> +		get_page(page);
>> +		SetPagePrivate(page);
>> +		set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
>> +	}
>>  
>>  	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
>>  
>> @@ -280,8 +283,11 @@ static int __revoke_inmem_pages(struct inode *inode,
>>  			ClearPageUptodate(page);
>>  			clear_cold_data(page);
>>  		}
>> -		set_page_private(page, 0);
>> -		ClearPagePrivate(page);
>> +		if (PagePrivate(page)) {
>> +			set_page_private(page, 0);
>> +			ClearPagePrivate(page);
>> +			f2fs_put_page(page, 0);
>> +		}
>>  		f2fs_put_page(page, 1);
>>  
>>  		list_del(&cur->list);
>> @@ -370,8 +376,13 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
>>  	kmem_cache_free(inmem_entry_slab, cur);
>>  
>>  	ClearPageUptodate(page);
>> -	set_page_private(page, 0);
>> -	ClearPagePrivate(page);
>> +
>> +	if (PagePrivate(page)) {
>> +		set_page_private(page, 0);
>> +		ClearPagePrivate(page);
>> +		f2fs_put_page(page, 0);
>> +	}
>> +
>>  	f2fs_put_page(page, 0);
>>  
>>  	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
>> -- 
>> 2.18.0.rc1
> 
> .
> 

