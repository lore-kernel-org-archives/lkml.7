Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E87CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572404117;
	bh=PauVWSxjmuThe1M0wDRef8hgagGVTm4RCXliKrxBA+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oiB7aSgxIcyxOIryLwMFYNjHkQoUKZf9qMWiN1xbOtyswS2qaOn7zx3E52s/RWngI
	 f8xlcF6D7S65dFTY2MplkALQ09IvaMCirOl/d4/uVVDTjWWMB35HWhX+EtNjUl6Isw
	 ohmVch0ywcSnCbWKl22ojXBAYgSsP7dshdXxQ//0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJ3CzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfJ3CzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:55:15 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A0120856;
        Wed, 30 Oct 2019 02:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572404114;
        bh=PauVWSxjmuThe1M0wDRef8hgagGVTm4RCXliKrxBA+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9FrYd1l8EhJDfZXDF661fQwvMXBCgKXBd913ct2ii9dMZbVRVdOJc9qy3bwAc9Cd
         JvClmw0vq8n8IQMbmh4BhO0mi4pKy8rOidLS2N6XqyIh03D9hHlfx6Bo0K2Nz5fAgM
         2RYWU5rkaUUg5tXvmkdm01Vuu4YiF4tlTjzNjlP0=
Date:   Tue, 29 Oct 2019 19:55:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs: support data compression
Message-ID: <20191030025512.GA4791@sol.localdomain>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 04:33:36PM +0800, Chao Yu wrote:
> On 2019/10/28 6:50, Eric Biggers wrote:
> >> +bool f2fs_is_compressed_page(struct page *page)
> >> +{
> >> +	if (!page_private(page))
> >> +		return false;
> >> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
> >> +		return false;
> >> +	return *((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC;
> >> +}
> > 
> > This code implies that there can be multiple page private structures each of
> > which has a different magic number.  But I only see F2FS_COMPRESSED_PAGE_MAGIC.
> > Where in the code is the other one(s)?
> 
> I'm not sure I understood you correctly, did you mean it needs to introduce
> f2fs_is_atomic_written_page() and f2fs_is_dummy_written_page() like
> f2fs_is_compressed_page()?
> 

No, I'm asking what is the case where the line

	*((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC

returns false?

> > 
> >> +
> >> +static void f2fs_set_compressed_page(struct page *page,
> >> +		struct inode *inode, pgoff_t index, void *data, refcount_t *r)
> >> +{
> >> +	SetPagePrivate(page);
> >> +	set_page_private(page, (unsigned long)data);
> >> +
> >> +	/* i_crypto_info and iv index */
> >> +	page->index = index;
> >> +	page->mapping = inode->i_mapping;
> >> +	if (r)
> >> +		refcount_inc(r);
> >> +}
> > 
> > It isn't really appropriate to create fake pagecache pages like this.  Did you
> > consider changing f2fs to use fscrypt_decrypt_block_inplace() instead?
> 
> We need to store i_crypto_info and iv index somewhere, in order to pass them to
> fscrypt_decrypt_block_inplace(), where did you suggest to store them?
> 

The same place where the pages are stored.

> >> +
> >> +void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
> >> +{
> >> +	kvfree(cc->rpages);
> >> +}
> > 
> > The memory is allocated with kzalloc(), so why is it freed with kvfree() and not
> > just kfree()?
> 
> It was allocated by f2fs_*alloc() which will fallback to kvmalloc() once
> kmalloc() failed.

This seems to be a bug in f2fs_kmalloc() -- it inappropriately falls back to
kvmalloc().  As per its name, it should only use kmalloc().  f2fs_kvmalloc()
already exists, so it can be used when the fallback is wanted.

> 
> >> +static int lzo_compress_pages(struct compress_ctx *cc)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = lzo1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
> >> +					&cc->clen, cc->private);
> >> +	if (ret != LZO_E_OK) {
> >> +		printk_ratelimited("%sF2FS-fs: lzo compress failed, ret:%d\n",
> >> +								KERN_ERR, ret);
> >> +		return -EIO;
> >> +	}
> >> +	return 0;
> >> +}
> > 
> > Why not using f2fs_err()?  Same in lots of other places.
> 
> We use printk_ratelimited at some points where we can afford to lose logs,
> otherwise we use f2fs_{err,warn...} to record info as much as possible for
> troubleshoot.
> 

It used to be the case that f2fs_msg() was ratelimited.  What stops it from
spamming the logs now?

The problem with a bare printk is that it doesn't show which filesystem instance
the message is coming from.

> >> +
> >> +	ret = cops->compress_pages(cc);
> >> +	if (ret)
> >> +		goto out_vunmap_cbuf;
> >> +
> >> +	max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
> >> +
> >> +	if (cc->clen > max_len) {
> >> +		ret = -EAGAIN;
> >> +		goto out_vunmap_cbuf;
> >> +	}
> > 
> > Since we already know the max length we're willing to compress to (the max
> > length for any space to be saved), why is more space than that being allocated?
> > LZ4_compress_default() will return an error if there isn't enough space, so that
> > error could just be used as the indication to store the data uncompressed.
> 
> AFAIK, there is no such common error code returned from all compression
> algorithms indicating there is no room for limited target size, however we need
> that information to fallback to write raw pages. Any better idea?
> 

"Not enough room" is the only reasonable way for compression to fail, so all
that's needed is the ability for compression to report errors at all.  What
specifically prevents this approach from working?

> >>  static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> >>  {
> >> -	/*
> >> -	 * We use different work queues for decryption and for verity because
> >> -	 * verity may require reading metadata pages that need decryption, and
> >> -	 * we shouldn't recurse to the same workqueue.
> >> -	 */
> > 
> > Why is it okay (i.e., no deadlocks) to no longer use different work queues for
> > decryption and for verity?  See the comment above which is being deleted.
> 
> Could you explain more about how deadlock happen? or share me a link address if
> you have described that case somewhere?
> 

The verity work can read pages from the file which require decryption.  I'm
concerned that it could deadlock if the work is scheduled on the same workqueue.
Granted, I'm not an expert in Linux workqueues, so if you've investigated this
and determined that it's safe, can you explain why?

- Eric
