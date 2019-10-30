Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEDCCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3892C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572457638;
	bh=sjprPqg2PbaiKLXjdDkpF8WMp02FewdHM7IhqCH/KBY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=P2bXM1fu/C+YcxeJvC0ZxZC+1Nv4nP4J9BPoqOsk75iGFdui7Uo+h4JqCJJsNOjAv
	 m57rfEaSKf95GQFQEu4sCy1p2O/Lbtoj3K1FLWxoI1ijAn/nv/uJin/ObIYTv+PXa7
	 r6P3wzxWHdqsrjVNTdI1QiGLEwpTmvjT3NQMJoaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJ3RrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfJ3RrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:47:16 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB3820659;
        Wed, 30 Oct 2019 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572457635;
        bh=sjprPqg2PbaiKLXjdDkpF8WMp02FewdHM7IhqCH/KBY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=qvf5Q3NhTT110wh2br44Y/15LJDDHIw6tTyaIc8WfsAp9TgtRSJZq1Mq29zfD47I5
         Bgnzk6Iyez0hE4pGF4Iy/UfvI8iffKZxEG3+J1wiKpGuajR11oficmHqOe2eYmZDjH
         GA2kpzpig2Q225fjWLu+HBSsUUk0UnkPOJfub28Y=
Date:   Wed, 30 Oct 2019 10:47:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs: support data compression
Message-ID: <20191030174714.GA36729@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
 <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
 <20191030165056.GA693@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030165056.GA693@sol.localdomain>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Eric Biggers wrote:
> On Wed, Oct 30, 2019 at 04:43:52PM +0800, Chao Yu wrote:
> > On 2019/10/30 10:55, Eric Biggers wrote:
> > > On Tue, Oct 29, 2019 at 04:33:36PM +0800, Chao Yu wrote:
> > >> On 2019/10/28 6:50, Eric Biggers wrote:
> > >>>> +bool f2fs_is_compressed_page(struct page *page)
> > >>>> +{
> > >>>> +	if (!page_private(page))
> > >>>> +		return false;
> > >>>> +	if (IS_ATOMIC_WRITTEN_PAGE(page) || IS_DUMMY_WRITTEN_PAGE(page))
> > >>>> +		return false;
> > >>>> +	return *((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC;
> > >>>> +}
> > >>>
> > >>> This code implies that there can be multiple page private structures each of
> > >>> which has a different magic number.  But I only see F2FS_COMPRESSED_PAGE_MAGIC.
> > >>> Where in the code is the other one(s)?
> > >>
> > >> I'm not sure I understood you correctly, did you mean it needs to introduce
> > >> f2fs_is_atomic_written_page() and f2fs_is_dummy_written_page() like
> > >> f2fs_is_compressed_page()?
> > >>
> > > 
> > > No, I'm asking what is the case where the line
> > > 
> > > 	*((u32 *)page_private(page)) == F2FS_COMPRESSED_PAGE_MAGIC
> > > 
> > > returns false?
> > 
> > Should be this?
> > 
> > if (!page_private(page))
> > 	return false;
> > f2fs_bug_on(*((u32 *)page_private(page)) != F2FS_COMPRESSED_PAGE_MAGIC)
> > return true;
> 
> Yes, that makes more sense, unless there are other cases.
> 
> > 
> > > 
> > >>>
> > >>>> +
> > >>>> +static void f2fs_set_compressed_page(struct page *page,
> > >>>> +		struct inode *inode, pgoff_t index, void *data, refcount_t *r)
> > >>>> +{
> > >>>> +	SetPagePrivate(page);
> > >>>> +	set_page_private(page, (unsigned long)data);
> > >>>> +
> > >>>> +	/* i_crypto_info and iv index */
> > >>>> +	page->index = index;
> > >>>> +	page->mapping = inode->i_mapping;
> > >>>> +	if (r)
> > >>>> +		refcount_inc(r);
> > >>>> +}
> > >>>
> > >>> It isn't really appropriate to create fake pagecache pages like this.  Did you
> > >>> consider changing f2fs to use fscrypt_decrypt_block_inplace() instead?
> > >>
> > >> We need to store i_crypto_info and iv index somewhere, in order to pass them to
> > >> fscrypt_decrypt_block_inplace(), where did you suggest to store them?
> > >>
> > > 
> > > The same place where the pages are stored.
> > 
> > Still we need allocate space for those fields, any strong reason to do so?
> > 
> 
> page->mapping set implies that the page is a pagecache page.  Faking it could
> cause problems with code elsewhere.

I've checked it with minchan, and it seems to be fine that filesystem uses
this page internally only, not in pagecache.

> 
> > > 
> > >>>> +
> > >>>> +void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
> > >>>> +{
> > >>>> +	kvfree(cc->rpages);
> > >>>> +}
> > >>>
> > >>> The memory is allocated with kzalloc(), so why is it freed with kvfree() and not
> > >>> just kfree()?
> > >>
> > >> It was allocated by f2fs_*alloc() which will fallback to kvmalloc() once
> > >> kmalloc() failed.
> > > 
> > > This seems to be a bug in f2fs_kmalloc() -- it inappropriately falls back to
> > > kvmalloc().  As per its name, it should only use kmalloc().  f2fs_kvmalloc()
> > > already exists, so it can be used when the fallback is wanted.
> > 
> > We can introduce f2fs_memalloc() to wrap f2fs_kmalloc() and f2fs_kvmalloc() as
> > below:
> > 
> > f2fs_memalloc()
> > {
> > 	mem = f2fs_kmalloc();
> > 	if (mem)
> > 		return mem;
> > 	return f2fs_kvmalloc();
> > }
> > 
> > It can be used in specified place where we really need it, like the place
> > descirbied in 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed") in where
> > we introduced original logic.
> 
> No, just use kvmalloc().  The whole point of kvmalloc() is that it tries
> kmalloc() and then falls back to vmalloc() if it fails.
> 
> - Eric
