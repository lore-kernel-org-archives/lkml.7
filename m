Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6931C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6321019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568116736;
	bh=2Qzu1OR55KIUpC4driwr/YPTHgmdiIqlZOgz3jGacaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IkK5z+lFAXThJ7dDJi552+Wuz53DD9sW3SLfWDUc5K9oBm1ahdi2zL/GlHZeLUZns
	 NDeUU6CtMK6ElneWCDX6wrjyBL7Ch/FZaJCFInkAJ2sPEUobrD1TbBs3sHgzIu+66D
	 QchPuQ4qEMwv6FyzMBmFMCqtMCeoGn/jfria/Kp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfIJL6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfIJL6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:58:55 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23C82084D;
        Tue, 10 Sep 2019 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568116733;
        bh=2Qzu1OR55KIUpC4driwr/YPTHgmdiIqlZOgz3jGacaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRcKIgFH/esRCzqzXpmOpF80aa9x9o5LLXYpZpNb+HPiAjZdxRhdm7/fbybg+jDKH
         YBNt11TzFXyYfEck7TytqJxl83fR7H8ykKe/EsENXKNYdDbT+I00gPStEqqFpysgUq
         6SMgcZwMURA3fUw21yu2hwWjcAKgY7e0+UlnKxIU=
Date:   Tue, 10 Sep 2019 12:58:50 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
Message-ID: <20190910115850.GA98080@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
 <5a473076-14b8-768a-62ac-f686e850d5a6@huawei.com>
 <20190909080108.GC21625@jaegeuk-macbookpro.roam.corp.google.com>
 <bf0683d9-ac05-1edc-71ea-3d02f7b2fb55@huawei.com>
 <20190909082112.GA25724@jaegeuk-macbookpro.roam.corp.google.com>
 <2f5b844c-f722-6a80-a4ab-61bdd72b8be4@huawei.com>
 <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
 <83759349-644a-b3a0-787d-e463b0565885@huawei.com>
 <20190909143419.GB31108@jaegeuk-macbookpro.roam.corp.google.com>
 <c48f8992-eaef-9b2e-56a3-f6a922daa4af@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48f8992-eaef-9b2e-56a3-f6a922daa4af@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Chao Yu wrote:
> On 2019/9/9 22:34, Jaegeuk Kim wrote:
> > On 09/09, Chao Yu wrote:
> >> On 2019/9/9 16:38, Jaegeuk Kim wrote:
> >>> On 09/09, Chao Yu wrote:
> >>>> On 2019/9/9 16:21, Jaegeuk Kim wrote:
> >>>>> On 09/09, Chao Yu wrote:
> >>>>>> On 2019/9/9 16:01, Jaegeuk Kim wrote:
> >>>>>>> On 09/09, Chao Yu wrote:
> >>>>>>>> On 2019/9/9 15:30, Jaegeuk Kim wrote:
> >>>>>>>>> On 09/09, Chao Yu wrote:
> >>>>>>>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> >>>>>>>>>>> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
> >>>>>>>>>>> get commited pages but atomic_file being still set like:
> >>>>>>>>>>>
> >>>>>>>>>>> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
> >>>>>>>>>>>
> >>>>>>>>>>> If GC selects this block, we can get an infinite loop like this:
> >>>>>>>>>>>
> >>>>>>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> >>>>>>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> >>>>>>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> >>>>>>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> >>>>>>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> >>>>>>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> >>>>>>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> >>>>>>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> >>>>>>>>>>>
> >>>>>>>>>>> In that moment, we can observe:
> >>>>>>>>>>>
> >>>>>>>>>>> [Before]
> >>>>>>>>>>> Try to move 5084219 blocks (BG: 384508)
> >>>>>>>>>>>   - data blocks : 4962373 (274483)
> >>>>>>>>>>>   - node blocks : 121846 (110025)
> >>>>>>>>>>> Skipped : atomic write 4534686 (10)
> >>>>>>>>>>>
> >>>>>>>>>>> [After]
> >>>>>>>>>>> Try to move 5088973 blocks (BG: 384508)
> >>>>>>>>>>>   - data blocks : 4967127 (274483)
> >>>>>>>>>>>   - node blocks : 121846 (110025)
> >>>>>>>>>>> Skipped : atomic write 4539440 (10)
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  fs/f2fs/file.c | 10 +++++-----
> >>>>>>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>>>>>>>>> index 7ae2f3bd8c2f..68b6da734e5f 100644
> >>>>>>>>>>> --- a/fs/f2fs/file.c
> >>>>>>>>>>> +++ b/fs/f2fs/file.c
> >>>>>>>>>>> @@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >>>>>>>>>>>  			goto err_out;
> >>>>>>>>>>>  
> >>>>>>>>>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> >>>>>>>>>>> -		if (!ret) {
> >>>>>>>>>>> -			clear_inode_flag(inode, FI_ATOMIC_FILE);
> >>>>>>>>>>> -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> >>>>>>>>>>> -			stat_dec_atomic_write(inode);
> >>>>>>>>>>> -		}
> >>>>>>>>>>> +
> >>>>>>>>>>> +		/* doesn't need to check error */
> >>>>>>>>>>> +		clear_inode_flag(inode, FI_ATOMIC_FILE);
> >>>>>>>>>>> +		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> >>>>>>>>>>> +		stat_dec_atomic_write(inode);
> >>>>>>>>>>
> >>>>>>>>>> If there are still valid atomic write pages linked in .inmem_pages, it may cause
> >>>>>>>>>> memory leak when we just clear FI_ATOMIC_FILE flag.
> >>>>>>>>>
> >>>>>>>>> f2fs_commit_inmem_pages() should have flushed them.
> >>>>>>>>
> >>>>>>>> Oh, we failed to flush its nodes.
> >>>>>>>>
> >>>>>>>> However we won't clear such info if we failed to flush inmen pages, it looks
> >>>>>>>> inconsistent.
> >>>>>>>>
> >>>>>>>> Any interface needed to drop inmem pages or clear ATOMIC_FILE flag in that two
> >>>>>>>> error path? I'm not very clear how sqlite handle such error.
> >>>>>>>
> >>>>>>> f2fs_drop_inmem_pages() did that, but not in this case.
> >>>>>>
> >>>>>> What I mean is, for any error returned from atomic_commit() interface, should
> >>>>>> userspace application handle it with consistent way, like trigger
> >>>>>> f2fs_drop_inmem_pages(), so we don't need to handle it inside atomic_commit().
> >>>>>
> >>>>> f2fs_ioc_abort_volatile_write() will be triggered.
> >>>>
> >>>> If userspace can do this, we can get rid of this patch, or am I missing sth?
> >>>
> >>> We don't know when that will come. And, other threads are waiting for GC here.
> >>
> >> Yes, however, even atomic_write won't be called sometimes... that's why we add
> >> handling logic in f2fs_gc().
> > 
> > We need to clean this up like:
> > 
> > If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
> > get commited pages but atomic_file being still set like:
> > 
> > - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
> > 
> > If GC selects this block, we can get an infinite loop like this:
> > 
> > f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > 
> > In that moment, we can observe:
> > 
> > [Before]
> > Try to move 5084219 blocks (BG: 384508)
> >   - data blocks : 4962373 (274483)
> >   - node blocks : 121846 (110025)
> > Skipped : atomic write 4534686 (10)
> > 
> > [After]
> > Try to move 5088973 blocks (BG: 384508)
> >   - data blocks : 4967127 (274483)
> >   - node blocks : 121846 (110025)
> > Skipped : atomic write 4539440 (10)
> > 
> > So, refactor atomic_write flow like this:
> > 1. start_atomic_write
> >  - add inmem_list and set atomic_file
> > 
> > 2. write()
> >  - register it in inmem_pages
> > 
> > 3. commit_atomic_write
> >  - if no error, f2fs_drop_inmem_pages()
> >  - f2fs_commit_inmme_pages() failed
> >    : __revoked_inmem_pages() was done
> >  - f2fs_do_sync_file failed
> >    : abort_atomic_write later
> > 
> > 4. abort_atomic_write
> >  - f2fs_drop_inmem_pages
> > 
> > 5. f2fs_drop_inmem_pages
> >  - clear atomic_file
> >  - remove inmem_list
> 
> Looks good.
> 
> > 
> > Based on this change, when GC fails to move block in atomic_file,
> > f2fs_drop_inmem_pages_all() can call f2fs_drop_inmem_pages().
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/file.c    | 17 +++++++++++------
> >  fs/f2fs/segment.c | 24 +++++-------------------
> >  2 files changed, 16 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 10927a0b8df3..1f499ac13d9a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1830,6 +1830,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  {
> >  	struct inode *inode = file_inode(filp);
> >  	int ret;
> > +	struct f2fs_inode_info *fi = F2FS_I(inode);
> >  
> >  	if (!inode_owner_or_capable(inode))
> >  		return -EACCES;
> > @@ -1871,10 +1872,17 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  		goto out;
> >  	}
> >  
> > -	set_inode_flag(inode, FI_ATOMIC_FILE);
> >  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  
> > +	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> > +	if (list_empty(&fi->inmem_ilist))
> > +		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> > +	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> > +
> > +	/* add inode in inmem_list first and set atomic_file */
> > +	set_inode_flag(inode, FI_ATOMIC_FILE);
> 
> Should call up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]) here? Then in f2fs_gc(),
> we can check FI_ATOMIC_FILE atomically under i_gc_rwsem.

Yup.

If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
get commited pages but atomic_file being still set like:

- inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)

If GC selects this block, we can get an infinite loop like this:

f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c

In that moment, we can observe:

[Before]
Try to move 5084219 blocks (BG: 384508)
  - data blocks : 4962373 (274483)
  - node blocks : 121846 (110025)
Skipped : atomic write 4534686 (10)

[After]
Try to move 5088973 blocks (BG: 384508)
  - data blocks : 4967127 (274483)
  - node blocks : 121846 (110025)
Skipped : atomic write 4539440 (10)

So, refactor atomic_write flow like this:
1. start_atomic_write
 - add inmem_list and set atomic_file

2. write()
 - register it in inmem_pages

3. commit_atomic_write
 - if no error, f2fs_drop_inmem_pages()
 - f2fs_commit_inmme_pages() failed
   : __revoked_inmem_pages() was done
 - f2fs_do_sync_file failed
   : abort_atomic_write later

4. abort_atomic_write
 - f2fs_drop_inmem_pages

5. f2fs_drop_inmem_pages
 - clear atomic_file
 - remove inmem_list

Based on this change, when GC fails to move block in atomic_file,
f2fs_drop_inmem_pages_all() can call f2fs_drop_inmem_pages().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c    | 15 ++++++++++-----
 fs/f2fs/segment.c | 27 ++++++---------------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 10927a0b8df3..fab6e4cf8f06 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1829,6 +1829,8 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 static int f2fs_ioc_start_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
 	if (!inode_owner_or_capable(inode))
@@ -1871,6 +1873,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 	}
 
+	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
+	if (list_empty(&fi->inmem_ilist))
+		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
+	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+
+	/* add inode in inmem_list first and set atomic_file */
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -1912,11 +1920,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			goto err_out;
 
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-		if (!ret) {
-			clear_inode_flag(inode, FI_ATOMIC_FILE);
-			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
-			stat_dec_atomic_write(inode);
-		}
+		if (!ret)
+			f2fs_drop_inmem_pages(inode);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 18584d4c078a..66343f451d73 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -185,8 +185,6 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 
 void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct inmem_pages *new;
 
 	f2fs_trace_pid(page);
@@ -200,15 +198,9 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 	INIT_LIST_HEAD(&new->list);
 
 	/* increase reference count with clean state */
-	mutex_lock(&fi->inmem_lock);
 	get_page(page);
-	list_add_tail(&new->list, &fi->inmem_pages);
-	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-	if (list_empty(&fi->inmem_ilist))
-		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
-	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+	list_add_tail(&new->list, &F2FS_I(inode)->inmem_pages);
 	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
-	mutex_unlock(&fi->inmem_lock);
 
 	trace_f2fs_register_inmem_page(page, INMEM);
 }
@@ -330,19 +322,17 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 		mutex_lock(&fi->inmem_lock);
 		__revoke_inmem_pages(inode, &fi->inmem_pages,
 						true, false, true);
-
-		if (list_empty(&fi->inmem_pages)) {
-			spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-			if (!list_empty(&fi->inmem_ilist))
-				list_del_init(&fi->inmem_ilist);
-			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
-		}
 		mutex_unlock(&fi->inmem_lock);
 	}
 
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
 	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
 	stat_dec_atomic_write(inode);
+
+	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
+	if (!list_empty(&fi->inmem_ilist))
+		list_del_init(&fi->inmem_ilist);
+	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 }
 
 void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
@@ -471,11 +461,6 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 
 	mutex_lock(&fi->inmem_lock);
 	err = __f2fs_commit_inmem_pages(inode);
-
-	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
-	if (!list_empty(&fi->inmem_ilist))
-		list_del_init(&fi->inmem_ilist);
-	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
 	mutex_unlock(&fi->inmem_lock);
 
 	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
-- 
2.19.0.605.g01d371f741-goog

