Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255C920578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3IoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:44:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:44:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15ADDE56AFBAB5BA9233;
        Wed, 30 Oct 2019 16:43:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 16:43:52 +0800
Subject: Re: [PATCH 2/2] f2fs: support data compression
To:     Eric Biggers <ebiggers@kernel.org>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
Date:   Wed, 30 Oct 2019 16:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030025512.GA4791@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/30 10:55, Eric Biggers wrote:
> On Tue, Oct 29, 2019 at 04:33:36PM +0800, Chao Yu wrote:
>> On 2019/10/28 6:50, Eric Biggers wrote:
>>>> +bool f2fs_is_compressed_page(struct page *page)
>>>> +{
>>>> +	if (!page_private(page))
>>>> +		return false;
>>>> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
>>>> +		return false;
>>>> +	return *((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC;
>>>> +}
>>>
>>> This code implies that there can be multiple page private structures each of
>>> which has a different magic number.  But I only see F2FS_COMPRESSED_PAGE_MAGIC.
>>> Where in the code is the other one(s)?
>>
>> I'm not sure I understood you correctly, did you mean it needs to introduce
>> f2fs_is_atomic_written_page() and f2fs_is_dummy_written_page() like
>> f2fs_is_compressed_page()?
>>
> 
> No, I'm asking what is the case where the line
> 
> 	*((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC
> 
> returns false?

Should be this?

if (!page_private(page))
	return false;
f2fs_bug_on(*((u32 *)page_private(page)) != F2FS_COMPRESSED_PAGE_MAGIC)
return true;

> 
>>>
>>>> +
>>>> +static void f2fs_set_compressed_page(struct page *page,
>>>> +		struct inode *inode, pgoff_t index, void *data, refcount_t *r)
>>>> +{
>>>> +	SetPagePrivate(page);
>>>> +	set_page_private(page, (unsigned long)data);
>>>> +
>>>> +	/* i_crypto_info and iv index */
>>>> +	page->index = index;
>>>> +	page->mapping = inode->i_mapping;
>>>> +	if (r)
>>>> +		refcount_inc(r);
>>>> +}
>>>
>>> It isn't really appropriate to create fake pagecache pages like this.  Did you
>>> consider changing f2fs to use fscrypt_decrypt_block_inplace() instead?
>>
>> We need to store i_crypto_info and iv index somewhere, in order to pass them to
>> fscrypt_decrypt_block_inplace(), where did you suggest to store them?
>>
> 
> The same place where the pages are stored.

Still we need allocate space for those fields, any strong reason to do so?

> 
>>>> +
>>>> +void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
>>>> +{
>>>> +	kvfree(cc->rpages);
>>>> +}
>>>
>>> The memory is allocated with kzalloc(), so why is it freed with kvfree() and not
>>> just kfree()?
>>
>> It was allocated by f2fs_*alloc() which will fallback to kvmalloc() once
>> kmalloc() failed.
> 
> This seems to be a bug in f2fs_kmalloc() -- it inappropriately falls back to
> kvmalloc().  As per its name, it should only use kmalloc().  f2fs_kvmalloc()
> already exists, so it can be used when the fallback is wanted.

We can introduce f2fs_memalloc() to wrap f2fs_kmalloc() and f2fs_kvmalloc() as
below:

f2fs_memalloc()
{
	mem = f2fs_kmalloc();
	if (mem)
		return mem;
	return f2fs_kvmalloc();
}

It can be used in specified place where we really need it, like the place
descirbied in 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed") in where
we introduced original logic.

> 
>>
>>>> +static int lzo_compress_pages(struct compress_ctx *cc)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = lzo1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
>>>> +					&cc->clen, cc->private);
>>>> +	if (ret != LZO_E_OK) {
>>>> +		printk_ratelimited("%sF2FS-fs: lzo compress failed, ret:%d\n",
>>>> +								KERN_ERR, ret);
>>>> +		return -EIO;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>
>>> Why not using f2fs_err()?  Same in lots of other places.
>>
>> We use printk_ratelimited at some points where we can afford to lose logs,
>> otherwise we use f2fs_{err,warn...} to record info as much as possible for
>> troubleshoot.
>>
> 
> It used to be the case that f2fs_msg() was ratelimited.  What stops it from
> spamming the logs now?

https://lore.kernel.org/patchwork/patch/973837/

> 
> The problem with a bare printk is that it doesn't show which filesystem instance
> the message is coming from.

We can add to print sbi->sb->s_id like f2fs_printk().

> 
>>>> +
>>>> +	ret = cops->compress_pages(cc);
>>>> +	if (ret)
>>>> +		goto out_vunmap_cbuf;
>>>> +
>>>> +	max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
>>>> +
>>>> +	if (cc->clen > max_len) {
>>>> +		ret = -EAGAIN;
>>>> +		goto out_vunmap_cbuf;
>>>> +	}
>>>
>>> Since we already know the max length we're willing to compress to (the max
>>> length for any space to be saved), why is more space than that being allocated?
>>> LZ4_compress_default() will return an error if there isn't enough space, so that
>>> error could just be used as the indication to store the data uncompressed.
>>
>> AFAIK, there is no such common error code returned from all compression
>> algorithms indicating there is no room for limited target size, however we need
>> that information to fallback to write raw pages. Any better idea?
>>
> 
> "Not enough room" is the only reasonable way for compression to fail, so all

At a glance, compression comments did say only fail due to out-of-space of
dst_buf, and it will fail due to other reasons as I checked few codes.
a) dst_buf is too small
b) src_buf is too large/small
c) wrong step
maybe missed other cases...

Yeah, we can get rid of condition b)/c) during implementation, however, what I'm
concern is the implementation is too tight to all error handling of all
compression algorithms, as we're not always aware of compression error handling
changes.

> that's needed is the ability for compression to report errors at all.  What
> specifically prevents this approach from working?
> 
>>>>  static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
>>>>  {
>>>> -	/*
>>>> -	 * We use different work queues for decryption and for verity because
>>>> -	 * verity may require reading metadata pages that need decryption, and
>>>> -	 * we shouldn't recurse to the same workqueue.
>>>> -	 */
>>>
>>> Why is it okay (i.e., no deadlocks) to no longer use different work queues for
>>> decryption and for verity?  See the comment above which is being deleted.
>>
>> Could you explain more about how deadlock happen? or share me a link address if
>> you have described that case somewhere?
>>
> 
> The verity work can read pages from the file which require decryption.  I'm
> concerned that it could deadlock if the work is scheduled on the same workqueue.

I assume you've tried one workqueue, and suffered deadlock..

> Granted, I'm not an expert in Linux workqueues, so if you've investigated this
> and determined that it's safe, can you explain why?

I'm not familiar with workqueue...  I guess it may not safe that if the work is
scheduled to the same cpu in where verity was waiting for data? if the work is
scheduled to other cpu, it may be safe.

I can check that before splitting the workqueue for verity and decrypt/decompress.

Thanks,

> 
> - Eric
> .
> 
