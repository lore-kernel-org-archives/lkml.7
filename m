Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4207CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0102054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfJ3JNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:13:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:13:04 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 975FED29C948E39BD46E;
        Wed, 30 Oct 2019 17:12:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 17:12:57 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 30 Oct 2019 17:12:57 +0800
Date:   Wed, 30 Oct 2019 17:15:42 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
Message-ID: <20191030091542.GA24976@architecture4>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Oct 30, 2019 at 04:56:17PM +0800, Chao Yu wrote:
> On 2019/10/30 11:55, Gao Xiang wrote:
> > remove such useless code and related fault injection.
> 
> Hi Xiang,
> 
> Although, there is so many 'nofail' allocation in f2fs, I think we'd better
> avoid such allocation as much as possible (now for read path, we may allow to
> fail to allocate bio), I suggest to keep the failure path and bio allocation
> injection.
> 
> It looks bio_alloc() will use its own mempool, which may suffer deadlock
> potentially. So how about changing to use bio_alloc_bioset(, , NULL) instead of
> bio_alloc()?

Yes, I noticed the original commit 740432f83560 ("f2fs: handle failed bio allocation"),
yet I don't find any real call trace clue what happened before.

As my understanding, if we allocate bios without submit_bio (I mean write path) with
default bs and gfp_flags GFP_NOIO or GFP_KERNEL, I think it will be slept inside
mempool rather than return NULL to its caller... Please correct me if I'm wrong...

I could send another patch with bio_alloc_bioset(, , NULL), I am curious to know the
original issue and how it solved though...

For read or flush path, since it will submit_bio and bio_alloc one by one, I think
mempool will get a page quicker (memory failure path could be longer). But I can
send a patch just by using bio_alloc_bioset(, , NULL) instead as you suggested later.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> >  Documentation/filesystems/f2fs.txt |  1 -
> >  fs/f2fs/data.c                     |  6 ++----
> >  fs/f2fs/f2fs.h                     | 21 ---------------------
> >  fs/f2fs/segment.c                  |  5 +----
> >  fs/f2fs/super.c                    |  1 -
> >  5 files changed, 3 insertions(+), 31 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> > index 7e1991328473..3477c3e4c08b 100644
> > --- a/Documentation/filesystems/f2fs.txt
> > +++ b/Documentation/filesystems/f2fs.txt
> > @@ -172,7 +172,6 @@ fault_type=%d          Support configuring fault injection type, should be
> >                         FAULT_KVMALLOC		0x000000002
> >                         FAULT_PAGE_ALLOC		0x000000004
> >                         FAULT_PAGE_GET		0x000000008
> > -                       FAULT_ALLOC_BIO		0x000000010
> >                         FAULT_ALLOC_NID		0x000000020
> >                         FAULT_ORPHAN		0x000000040
> >                         FAULT_BLOCK		0x000000080
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 5755e897a5f0..3b88dcb15de6 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -288,7 +288,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
> >  	struct f2fs_sb_info *sbi = fio->sbi;
> >  	struct bio *bio;
> >  
> > -	bio = f2fs_bio_alloc(sbi, npages, true);
> > +	bio = bio_alloc(GFP_NOIO, npages);
> >  
> >  	f2fs_target_device(sbi, fio->new_blkaddr, bio);
> >  	if (is_read_io(fio->op)) {
> > @@ -682,9 +682,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> >  	struct bio_post_read_ctx *ctx;
> >  	unsigned int post_read_steps = 0;
> >  
> > -	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
> > -	if (!bio)
> > -		return ERR_PTR(-ENOMEM);
> > +	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
> >  	f2fs_target_device(sbi, blkaddr, bio);
> >  	bio->bi_end_io = f2fs_read_end_io;
> >  	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4024790028aa..40012f874be0 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -44,7 +44,6 @@ enum {
> >  	FAULT_KVMALLOC,
> >  	FAULT_PAGE_ALLOC,
> >  	FAULT_PAGE_GET,
> > -	FAULT_ALLOC_BIO,
> >  	FAULT_ALLOC_NID,
> >  	FAULT_ORPHAN,
> >  	FAULT_BLOCK,
> > @@ -2210,26 +2209,6 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> >  	return entry;
> >  }
> >  
> > -static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
> > -						int npages, bool no_fail)
> > -{
> > -	struct bio *bio;
> > -
> > -	if (no_fail) {
> > -		/* No failure on bio allocation */
> > -		bio = bio_alloc(GFP_NOIO, npages);
> > -		if (!bio)
> > -			bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
> > -		return bio;
> > -	}
> > -	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
> > -		f2fs_show_injection_info(FAULT_ALLOC_BIO);
> > -		return NULL;
> > -	}
> > -
> > -	return bio_alloc(GFP_KERNEL, npages);
> > -}
> > -
> >  static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
> >  {
> >  	if (sbi->gc_mode == GC_URGENT)
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 808709581481..28457c878d0d 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -552,10 +552,7 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
> >  	struct bio *bio;
> >  	int ret;
> >  
> > -	bio = f2fs_bio_alloc(sbi, 0, false);
> > -	if (!bio)
> > -		return -ENOMEM;
> > -
> > +	bio = bio_alloc(GFP_KERNEL, 0);
> >  	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
> >  	bio_set_dev(bio, bdev);
> >  	ret = submit_bio_wait(bio);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 1443cee15863..51945dd27f00 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -44,7 +44,6 @@ const char *f2fs_fault_name[FAULT_MAX] = {
> >  	[FAULT_KVMALLOC]	= "kvmalloc",
> >  	[FAULT_PAGE_ALLOC]	= "page alloc",
> >  	[FAULT_PAGE_GET]	= "page get",
> > -	[FAULT_ALLOC_BIO]	= "alloc bio",
> >  	[FAULT_ALLOC_NID]	= "alloc nid",
> >  	[FAULT_ORPHAN]		= "orphan",
> >  	[FAULT_BLOCK]		= "no more block",
> > 
