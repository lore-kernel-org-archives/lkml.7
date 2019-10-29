Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F503CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716A5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfJ2Idn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:33:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729255AbfJ2Idm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:33:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91BC5391D03CB94728A5;
        Tue, 29 Oct 2019 16:33:38 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 29 Oct
 2019 16:33:37 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support data compression
To:     Eric Biggers <ebiggers@kernel.org>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
Date:   Tue, 29 Oct 2019 16:33:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191027225006.GA321938@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/28 6:50, Eric Biggers wrote:
>> +bool f2fs_is_compressed_page(struct page *page)
>> +{
>> +	if (!page_private(page))
>> +		return false;
>> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
>> +		return false;
>> +	return *((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC;
>> +}
> 
> This code implies that there can be multiple page private structures each of
> which has a different magic number.  But I only see F2FS_COMPRESSED_PAGE_MAGIC.
> Where in the code is the other one(s)?

I'm not sure I understood you correctly, did you mean it needs to introduce
f2fs_is_atomic_written_page() and f2fs_is_dummy_written_page() like
f2fs_is_compressed_page()?

> 
>> +
>> +static void f2fs_set_compressed_page(struct page *page,
>> +		struct inode *inode, pgoff_t index, void *data, refcount_t *r)
>> +{
>> +	SetPagePrivate(page);
>> +	set_page_private(page, (unsigned long)data);
>> +
>> +	/* i_crypto_info and iv index */
>> +	page->index = index;
>> +	page->mapping = inode->i_mapping;
>> +	if (r)
>> +		refcount_inc(r);
>> +}
> 
> It isn't really appropriate to create fake pagecache pages like this.  Did you
> consider changing f2fs to use fscrypt_decrypt_block_inplace() instead?

We need to store i_crypto_info and iv index somewhere, in order to pass them to
fscrypt_decrypt_block_inplace(), where did you suggest to store them?

>> +
>> +void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
>> +{
>> +	kvfree(cc->rpages);
>> +}
> 
> The memory is allocated with kzalloc(), so why is it freed with kvfree() and not
> just kfree()?

It was allocated by f2fs_*alloc() which will fallback to kvmalloc() once
kmalloc() failed.

>> +static int lzo_compress_pages(struct compress_ctx *cc)
>> +{
>> +	int ret;
>> +
>> +	ret = lzo1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
>> +					&cc->clen, cc->private);
>> +	if (ret != LZO_E_OK) {
>> +		printk_ratelimited("%sF2FS-fs: lzo compress failed, ret:%d\n",
>> +								KERN_ERR, ret);
>> +		return -EIO;
>> +	}
>> +	return 0;
>> +}
> 
> Why not using f2fs_err()?  Same in lots of other places.

We use printk_ratelimited at some points where we can afford to lose logs,
otherwise we use f2fs_{err,warn...} to record info as much as possible for
troubleshoot.

>> +
>> +	ret = cops->compress_pages(cc);
>> +	if (ret)
>> +		goto out_vunmap_cbuf;
>> +
>> +	max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
>> +
>> +	if (cc->clen > max_len) {
>> +		ret = -EAGAIN;
>> +		goto out_vunmap_cbuf;
>> +	}
> 
> Since we already know the max length we're willing to compress to (the max
> length for any space to be saved), why is more space than that being allocated?
> LZ4_compress_default() will return an error if there isn't enough space, so that
> error could just be used as the indication to store the data uncompressed.

AFAIK, there is no such common error code returned from all compression
algorithms indicating there is no room for limited target size, however we need
that information to fallback to write raw pages. Any better idea?

> 
>> +
>> +	cc->cbuf->clen = cpu_to_le32(cc->clen);
>> +	cc->cbuf->chksum = 0;
> 
> What is the point of the chksum field?  It's always set to 0 and never checked.

When I written initial codes, I doubt that I may lose to check some SPO corner
cases, in where we missed to write whole cluster, so I added that to help to
recall that case, however I didn't have time to cover those cases, resulting
leaving unfinished code there... :(, I'm okay to delete it in a formal version.

BTW, for data checksum feature, I guess we need to reconstruct dnode layout to
cover both compressed/non-compressed data.

> 
>> +
>> +static bool __cluster_may_compress(struct compress_ctx *cc)
>> +{
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>> +	loff_t i_size = i_size_read(cc->inode);
>> +	const pgoff_t end_index = ((unsigned long long)i_size)
>> +					>> PAGE_SHIFT;
>> +	unsigned offset;
>> +	int i;
>> +
>> +	for (i = 0; i < cc->cluster_size; i++) {
>> +		struct page *page = cc->rpages[i];
>> +
>> +		f2fs_bug_on(sbi, !page);
>> +
>> +		if (unlikely(f2fs_cp_error(sbi)))
>> +			return false;
>> +		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> +			return false;
>> +		if (f2fs_is_drop_cache(cc->inode))
>> +			return false;
>> +		if (f2fs_is_volatile_file(cc->inode))
>> +			return false;
>> +
>> +		offset = i_size & (PAGE_SIZE - 1);
>> +		if ((page->index > end_index) ||
>> +			(page->index == end_index && !offset))
>> +			return false;
> 
> No need to have a special case for when i_size is a multiple of the page size.
> Just replace end_index with 'nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE)' and
> check for page->index >= nr_pages.

That is copied from f2fs_write_data_page(), let's clean up in a separated patch.

> 
>> +out_fail:
>> +	/* TODO: revoke partially updated block addresses */
>> +	for (i += 1; i < cc->cluster_size; i++) {
>> +		if (!cc->rpages[i])
>> +			continue;
>> +		redirty_page_for_writepage(wbc, cc->rpages[i]);
>> +		unlock_page(cc->rpages[i]);
>> +	}
>> +	return err;
> 
> Un-addressed TODO.

Will fix a little later.

>>  static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
>>  {
>> -	/*
>> -	 * We use different work queues for decryption and for verity because
>> -	 * verity may require reading metadata pages that need decryption, and
>> -	 * we shouldn't recurse to the same workqueue.
>> -	 */
> 
> Why is it okay (i.e., no deadlocks) to no longer use different work queues for
> decryption and for verity?  See the comment above which is being deleted.

Could you explain more about how deadlock happen? or share me a link address if
you have described that case somewhere?

> 
>> +	/* TODO: cluster can be compressed due to race with .writepage */
>> +
> 
> Another un-addressed TODO.

Will fix a little later.

> 
>> +int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi)
>> +{
>> +	if (!f2fs_sb_has_encrypt(sbi) &&
>> +		!f2fs_sb_has_compression(sbi))
>> +		return 0;
>> +
>> +	sbi->post_read_wq = alloc_workqueue("f2fs_post_read_wq",
>> +						 WQ_UNBOUND | WQ_HIGHPRI,
>> +						 num_online_cpus());
> 
> post_read_wq is also needed if verity is enabled.

Yes, we missed this as verity was not merged when implementing this....

Thanks,
