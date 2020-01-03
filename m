Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A35C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E4F2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgACBTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:19:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgACBTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:19:46 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FF318C4CA7F7CD8310F;
        Fri,  3 Jan 2020 09:19:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 Jan 2020
 09:19:43 +0800
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fe34ebf1-5cfa-37bd-d290-0335c8ca3e27@huawei.com>
Date:   Fri, 3 Jan 2020 09:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/3 2:18, Jaegeuk Kim wrote:
> On 12/31, Chao Yu wrote:
>> On 2019/12/31 8:46, Jaegeuk Kim wrote:
>>> On 12/23, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> Sorry for the delay.
>>>>
>>>> On 2019/12/19 5:46, Jaegeuk Kim wrote:
>>>>> Hi Chao,
>>>>>
>>>>> I still see some diffs from my latest testing version, so please check anything
>>>>> that you made additionally from here.
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=25d18e19a91e60837d36368ee939db13fd16dc64
>>>>
>>>> I've checked the diff and picked up valid parts, could you please check and
>>>> comment on it?
>>>>
>>>> ---
>>>>  fs/f2fs/compress.c |  8 ++++----
>>>>  fs/f2fs/data.c     | 18 +++++++++++++++---
>>>>  fs/f2fs/f2fs.h     |  3 +++
>>>>  fs/f2fs/file.c     |  1 -
>>>>  4 files changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>>> index af23ed6deffd..1bc86a54ad71 100644
>>>> --- a/fs/f2fs/compress.c
>>>> +++ b/fs/f2fs/compress.c
>>>> @@ -593,7 +593,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>>>  							fgp_flag, GFP_NOFS);
>>>>  		if (!page) {
>>>>  			ret = -ENOMEM;
>>>> -			goto unlock_pages;
>>>> +			goto release_pages;
>>>>  		}
>>>>
>>>>  		if (PageUptodate(page))
>>>> @@ -608,13 +608,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>>>  		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>>>>  						&last_block_in_bio, false);
>>>>  		if (ret)
>>>> -			goto release_pages;
>>>> +			goto unlock_pages;
>>>>  		if (bio)
>>>>  			f2fs_submit_bio(sbi, bio, DATA);
>>>>
>>>>  		ret = f2fs_init_compress_ctx(cc);
>>>>  		if (ret)
>>>> -			goto release_pages;
>>>> +			goto unlock_pages;
>>>>  	}
>>>>
>>>>  	for (i = 0; i < cc->cluster_size; i++) {
>>>> @@ -762,7 +762,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>>>>  	if (err)
>>>>  		goto out_unlock_op;
>>>>
>>>> -	psize = (cc->rpages[last_index]->index + 1) << PAGE_SHIFT;
>>>> +	psize = (loff_t)(cc->rpages[last_index]->index + 1) << PAGE_SHIFT;
>>>>
>>>>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>>>>  	if (err)
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 19cd03450066..f1f5c701228d 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -184,13 +184,18 @@ static void f2fs_decompress_work(struct bio_post_read_ctx *ctx)
>>>>  }
>>>>
>>>>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>>>> +void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
>>>> +{
>>>> +	f2fs_decompress_end_io(rpages, cluster_size, false, true);
>>>> +}
>>>> +
>>>>  static void f2fs_verify_bio(struct bio *bio)
>>>>  {
>>>>  	struct page *page = bio_first_page_all(bio);
>>>>  	struct decompress_io_ctx *dic =
>>>>  			(struct decompress_io_ctx *)page_private(page);
>>>>
>>>> -	f2fs_decompress_end_io(dic->rpages, dic->cluster_size, false, true);
>>>> +	f2fs_verify_pages(dic->rpages, dic->cluster_size);
>>>>  	f2fs_free_dic(dic);
>>>>  }
>>>>  #endif
>>>> @@ -507,10 +512,16 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
>>>>  	bio_for_each_segment_all(bvec, bio, iter_all) {
>>>>  		struct page *target = bvec->bv_page;
>>>>
>>>> -		if (fscrypt_is_bounce_page(target))
>>>> +		if (fscrypt_is_bounce_page(target)) {
>>>>  			target = fscrypt_pagecache_page(target);
>>>> -		if (f2fs_is_compressed_page(target))
>>>> +			if (IS_ERR(target))
>>>> +				continue;
>>>> +		}
>>>> +		if (f2fs_is_compressed_page(target)) {
>>>>  			target = f2fs_compress_control_page(target);
>>>> +			if (IS_ERR(target))
>>>> +				continue;
>>>> +		}
>>>>
>>>>  		if (inode && inode == target->mapping->host)
>>>>  			return true;
>>>> @@ -2039,6 +2050,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>>>>  	if (ret)
>>>>  		goto out;
>>>>
>>>> +	/* cluster was overwritten as normal cluster */
>>>>  	if (dn.data_blkaddr != COMPRESS_ADDR)
>>>>  		goto out;
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 5d55cef66410..17d2af4eeafb 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -2719,6 +2719,7 @@ static inline void set_compress_context(struct inode *inode)
>>>>  			1 << F2FS_I(inode)->i_log_cluster_size;
>>>>  	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
>>>>  	set_inode_flag(inode, FI_COMPRESSED_FILE);
>>>> +	stat_inc_compr_inode(inode);
>>>>  }
>>>>
>>>>  static inline unsigned int addrs_per_inode(struct inode *inode)
>>>> @@ -3961,6 +3962,8 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>>>>  		return true;
>>>>  	if (f2fs_is_multi_device(sbi))
>>>>  		return true;
>>>> +	if (f2fs_compressed_file(inode))
>>>> +		return true;
>>>>  	/*
>>>>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>>>>  	 * all IOs can be serialized by log-structured write.
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index bde5612f37f5..9aeadf14413c 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -1828,7 +1828,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>>>  				return -EINVAL;
>>>>
>>>>  			set_compress_context(inode);
>>>> -			stat_inc_compr_inode(inode);
>>>
>>> As this breaks the count, I'll keep as is.
>>
>> @@ -2719,6 +2719,7 @@ static inline void set_compress_context(struct inode *inode)
>>  			1 << F2FS_I(inode)->i_log_cluster_size;
>>  	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
>>  	set_inode_flag(inode, FI_COMPRESSED_FILE);
>> +	stat_inc_compr_inode(inode);
>>
>> If I'm not missing anything, stat_inc_compr_inode() should be called inside
>> set_compress_context() in where we convert normal inode to compress one,
>> right?
> 
> I don't care much whether that's right or not. If we want to do that, I found
> another line to remove in f2fs_create(). Let me give it a try.

Correct, I forgot to remove that line.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>  		}
>>>>  	}
>>>>  	if ((iflags ^ fi->i_flags) & F2FS_NOCOMP_FL) {
>>>> -- 
>>>> 2.18.0.rc1
>>>>
>>>> Thanks,
>>> .
>>>
> .
> 
