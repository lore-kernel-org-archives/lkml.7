Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342EAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E742071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hct2zSCo";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MXnlC7Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfKYKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:08:32 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:39700
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfKYKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574676511;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=EL2996yTjmZweOQGwmsqTd/z5X3XZPc7Z11fozUUOn4=;
        b=hct2zSCob1ucnnje8u40zVR6Q3AMFNWtowLj4dvTYNFKFYxayjxTxQj0ca4ACvci
        4kf+e8xPduXEj3bDkSBm3Qj/U0PRpxt8WbJ4t/Xmm+L9nfm2rU4hQHWp5ZMCDFyx438
        v6Q0fWBv3ihnNbfp99GewYqh3V9+6LC1/meEVbEU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574676511;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=EL2996yTjmZweOQGwmsqTd/z5X3XZPc7Z11fozUUOn4=;
        b=MXnlC7Yg/F2sNay64Vz+f/O79L2/7ehI2TFpaBabFnr1UyVeygtYG7Apvy1gmNgc
        QLe9FSfcpJzarxokUxa5x5hSfLTPsUkh2tLWEDfhbCspM7WqEvSJ3CxZxH9JiixSIXF
        h4U2jXNIRWi5Chq/9F1PrNdKTkmRHmnFMTYn37kY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1D21C447B1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 25 Nov 2019 10:08:31 +0000
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Fix deadlock in f2fs_gc() context during atomic
 files handling
Message-ID: <0101016ea208ba8a-2ad7e084-c971-490a-85e7-848518cab304-000000@us-west-2.amazonses.com>
References: <1573641063-21232-1-git-send-email-stummala@codeaurora.org>
 <20191122165328.GA74621@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122165328.GA74621@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SES-Outgoing: 2019.11.25-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On Fri, Nov 22, 2019 at 08:53:28AM -0800, Jaegeuk Kim wrote:
> On 11/13, Sahitya Tummala wrote:
> > The FS got stuck in the below stack when the storage is almost
> > full/dirty condition (when FG_GC is being done).
> > 
> > schedule_timeout
> > io_schedule_timeout
> > congestion_wait
> > f2fs_drop_inmem_pages_all
> > f2fs_gc
> > f2fs_balance_fs
> > __write_node_page
> > f2fs_fsync_node_pages
> > f2fs_do_sync_file
> > f2fs_ioctl
> > 
> > The root cause for this issue is there is a potential infinite loop
> > in f2fs_drop_inmem_pages_all() for the case where gc_failure is true
> > and when there an inode whose i_gc_failures[GC_FAILURE_ATOMIC] is
> > not set. Fix this by keeping track of the total atomic files
> > currently opened and using that to exit from this condition.
> > 
> > Fix-suggested-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > v2:
> > - change fix as per Chao's suggestion
> > - decrement sbi->atomic_files protected under sbi->inode_lock[ATOMIC_FILE] and
> >   only when atomic flag is cleared for the first time, otherwise, the count
> >   goes to an invalid/high value as f2fs_drop_inmem_pages() can be called from
> >   two contexts at the same time.
> > 
> >  fs/f2fs/f2fs.h    |  1 +
> >  fs/f2fs/file.c    |  1 +
> >  fs/f2fs/segment.c | 21 +++++++++++++++------
> >  3 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index c681f51..e04a665 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1297,6 +1297,7 @@ struct f2fs_sb_info {
> >  	unsigned int gc_mode;			/* current GC state */
> >  	unsigned int next_victim_seg[2];	/* next segment in victim section */
> >  	/* for skip statistic */
> > +	unsigned int atomic_files;              /* # of opened atomic file */
> >  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
> >  	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> >  
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index f6c038e..22c4949 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1919,6 +1919,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	if (list_empty(&fi->inmem_ilist))
> >  		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> > +	sbi->atomic_files++;
> >  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  
> >  	/* add inode in inmem_list first and set atomic_file */
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index da830fc..0b7a33b 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -288,6 +288,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
> >  	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
> >  	struct inode *inode;
> >  	struct f2fs_inode_info *fi;
> > +	unsigned int count = sbi->atomic_files;
> > +	unsigned int looped = 0;
> >  next:
> >  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	if (list_empty(head)) {
> > @@ -296,22 +298,26 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
> >  	}
> >  	fi = list_first_entry(head, struct f2fs_inode_info, inmem_ilist);
> >  	inode = igrab(&fi->vfs_inode);
> > +	if (inode)
> > +		list_move_tail(&fi->inmem_ilist, head);
> >  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  
> >  	if (inode) {
> >  		if (gc_failure) {
> > -			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
> > -				goto drop;
> > -			goto skip;
> > +			if (!fi->i_gc_failures[GC_FAILURE_ATOMIC])
> > +				goto skip;
> >  		}
> > -drop:
> >  		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >  		f2fs_drop_inmem_pages(inode);
> > +skip:
> >  		iput(inode);
> >  	}
> > -skip:
> >  	congestion_wait(BLK_RW_ASYNC, HZ/50);
> >  	cond_resched();
> > +	if (gc_failure) {
> > +		if (++looped >= count)
> 
> There is a race condition when handling sbi->atomic_files?
> 
There is no concern here in this function w.r.t sbi->atomic_files value.
Since when we loop over all the atomic files, the looped counter will increment
and will exit when all the files are looped at least once.

There is an issue with f2fs_drop_inmem_pages() which is actually decrementing
the sbi->atomic_files and that was handled below.

Thanks,
Sahitya.

> > +			return;
> > +	}
> >  	goto next;
> >  }
> >  
> > @@ -327,13 +333,16 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> >  		mutex_unlock(&fi->inmem_lock);
> >  	}
> >  
> > -	clear_inode_flag(inode, FI_ATOMIC_FILE);
> >  	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> >  	stat_dec_atomic_write(inode);
> >  
> >  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >  	if (!list_empty(&fi->inmem_ilist))
> >  		list_del_init(&fi->inmem_ilist);
> > +	if (f2fs_is_atomic_file(inode)) {
> > +		clear_inode_flag(inode, FI_ATOMIC_FILE);
> > +		sbi->atomic_files--;
> > +	}
> >  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >  }
> >  
> > -- 
> > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
