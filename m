Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A564C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F57621924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568018704;
	bh=SfOVF0UVj2/iqk0P+Dqr6jBUTLzBE5GoykPWadjNIXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W9Dwn7cLbkXwymw/ig7Xryot4noKMEHt1st7KhfhBx3rMe2TjS3LVM6nxX0etdfbU
	 JuIIJxPLNlh3jNb2ZNu4th90nrNmfx41WATwWw2t3Rnwlou6ghwO4mfqWHYLblnCU3
	 cOgZwP5LzgQqhtraJB9n5rDXfesZJECTBOmvfQRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbfIIIpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfIIIpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:45:03 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B56218DE;
        Mon,  9 Sep 2019 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568018701;
        bh=SfOVF0UVj2/iqk0P+Dqr6jBUTLzBE5GoykPWadjNIXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTrc87a2UvuQf1FVQDO3tPM9Yg5s20LfGJLz6DJUvrOYAOmlr+YVaKiCpiJx8vBE3
         s9HvF77EEnwZBcisA68SJ3ktfQ0x2ni7n0C8tV4gKLtqnkBXBtNTbViPkU7RQIk+rv
         8qf4Oe96b8JHTPVNx5sfHPjgn3CE3474vv3fxPZE=
Date:   Mon, 9 Sep 2019 09:44:58 +0100
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        g@jaegeuk-macbookpro.roam.corp.google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
Message-ID: <20190909084458.GA26885@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190909012532.20454-1-jaegeuk@kernel.org>
 <20190909012532.20454-2-jaegeuk@kernel.org>
 <f446ff29-38a5-61fd-4056-b4067b01c630@huawei.com>
 <20190909073011.GA21625@jaegeuk-macbookpro.roam.corp.google.com>
 <5a473076-14b8-768a-62ac-f686e850d5a6@huawei.com>
 <20190909080108.GC21625@jaegeuk-macbookpro.roam.corp.google.com>
 <bf0683d9-ac05-1edc-71ea-3d02f7b2fb55@huawei.com>
 <20190909082112.GA25724@jaegeuk-macbookpro.roam.corp.google.com>
 <2f5b844c-f722-6a80-a4ab-61bdd72b8be4@huawei.com>
 <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Jaegeuk Kim wrote:
> On 09/09, Chao Yu wrote:
> > On 2019/9/9 16:21, Jaegeuk Kim wrote:
> > > On 09/09, Chao Yu wrote:
> > >> On 2019/9/9 16:01, Jaegeuk Kim wrote:
> > >>> On 09/09, Chao Yu wrote:
> > >>>> On 2019/9/9 15:30, Jaegeuk Kim wrote:
> > >>>>> On 09/09, Chao Yu wrote:
> > >>>>>> On 2019/9/9 9:25, Jaegeuk Kim wrote:
> > >>>>>>> If committing atomic pages is failed when doing f2fs_do_sync_file(), we can
> > >>>>>>> get commited pages but atomic_file being still set like:
> > >>>>>>>
> > >>>>>>> - inmem:    0, atomic IO:    4 (Max.   10), volatile IO:    0 (Max.    0)
> > >>>>>>>
> > >>>>>>> If GC selects this block, we can get an infinite loop like this:
> > >>>>>>>
> > >>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > >>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > >>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > >>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > >>>>>>> f2fs_submit_page_bio: dev = (253,7), ino = 2, page_index = 0x2359a8, oldaddr = 0x2359a8, newaddr = 0x2359a8, rw = READ(), type = COLD_DATA
> > >>>>>>> f2fs_submit_read_bio: dev = (253,7)/(253,7), rw = READ(), DATA, sector = 18533696, size = 4096
> > >>>>>>> f2fs_get_victim: dev = (253,7), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 4355, cost = 1, ofs_unit = 1, pre_victim_secno = 4355, prefree = 0, free = 234
> > >>>>>>> f2fs_iget: dev = (253,7), ino = 6247, pino = 5845, i_mode = 0x81b0, i_size = 319488, i_nlink = 1, i_blocks = 624, i_advise = 0x2c
> > >>>>>>>
> > >>>>>>> In that moment, we can observe:
> > >>>>>>>
> > >>>>>>> [Before]
> > >>>>>>> Try to move 5084219 blocks (BG: 384508)
> > >>>>>>>   - data blocks : 4962373 (274483)
> > >>>>>>>   - node blocks : 121846 (110025)
> > >>>>>>> Skipped : atomic write 4534686 (10)
> > >>>>>>>
> > >>>>>>> [After]
> > >>>>>>> Try to move 5088973 blocks (BG: 384508)
> > >>>>>>>   - data blocks : 4967127 (274483)
> > >>>>>>>   - node blocks : 121846 (110025)
> > >>>>>>> Skipped : atomic write 4539440 (10)
> > >>>>>>>
> > >>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > >>>>>>> ---
> > >>>>>>>  fs/f2fs/file.c | 10 +++++-----
> > >>>>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> > >>>>>>>
> > >>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > >>>>>>> index 7ae2f3bd8c2f..68b6da734e5f 100644
> > >>>>>>> --- a/fs/f2fs/file.c
> > >>>>>>> +++ b/fs/f2fs/file.c
> > >>>>>>> @@ -1997,11 +1997,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> > >>>>>>>  			goto err_out;
> > >>>>>>>  
> > >>>>>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> > >>>>>>> -		if (!ret) {
> > >>>>>>> -			clear_inode_flag(inode, FI_ATOMIC_FILE);
> > >>>>>>> -			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> > >>>>>>> -			stat_dec_atomic_write(inode);
> > >>>>>>> -		}
> > >>>>>>> +
> > >>>>>>> +		/* doesn't need to check error */
> > >>>>>>> +		clear_inode_flag(inode, FI_ATOMIC_FILE);
> > >>>>>>> +		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> > >>>>>>> +		stat_dec_atomic_write(inode);
> > >>>>>>
> > >>>>>> If there are still valid atomic write pages linked in .inmem_pages, it may cause
> > >>>>>> memory leak when we just clear FI_ATOMIC_FILE flag.
> > >>>>>
> > >>>>> f2fs_commit_inmem_pages() should have flushed them.
> > >>>>
> > >>>> Oh, we failed to flush its nodes.
> > >>>>
> > >>>> However we won't clear such info if we failed to flush inmen pages, it looks
> > >>>> inconsistent.
> > >>>>
> > >>>> Any interface needed to drop inmem pages or clear ATOMIC_FILE flag in that two
> > >>>> error path? I'm not very clear how sqlite handle such error.
> > >>>
> > >>> f2fs_drop_inmem_pages() did that, but not in this case.
> > >>
> > >> What I mean is, for any error returned from atomic_commit() interface, should
> > >> userspace application handle it with consistent way, like trigger
> > >> f2fs_drop_inmem_pages(), so we don't need to handle it inside atomic_commit().
> > > 
> > > f2fs_ioc_abort_volatile_write() will be triggered.
> > 
> > If userspace can do this, we can get rid of this patch, or am I missing sth?
> 
> We don't know when that will come. And, other threads are waiting for GC here.
> 

Actually, we can call this.

---
 fs/f2fs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ae2f3bd8c2f..98e2f58467d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1997,11 +1997,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			goto err_out;
 
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-		if (!ret) {
-			clear_inode_flag(inode, FI_ATOMIC_FILE);
-			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
-			stat_dec_atomic_write(inode);
-		}
+		f2fs_drop_inmem_pages(inode);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
-- 
2.19.0.605.g01d371f741-goog

