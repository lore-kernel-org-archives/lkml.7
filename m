Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ABC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D9020B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KTTG06hy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JCSWVJyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKKGov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:44:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKGov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:44:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 34D6560A24; Mon, 11 Nov 2019 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573454690;
        bh=JO+MF1/DvaXK6pMxWJ29ZBKz6Hapbs4TK+9Hei9eqac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTTG06hyO5O6tscSwm/d8/oWnHl7CVDSoP7KEJU/Tc0lamwSZJJCaTYjIk6hknJHh
         lELqjVZPUH1spDL3G2dQ7MO7C02WxATtbsvczjVnxWR26YJ0VZ4osLMQm9zq8Ghtt9
         9ic3oDRcaeS59BwaPeFVtEm7jbCIcVJsf8HxTTmM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A25A360A23;
        Mon, 11 Nov 2019 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573454689;
        bh=JO+MF1/DvaXK6pMxWJ29ZBKz6Hapbs4TK+9Hei9eqac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCSWVJyEplGs/ZTll7CwTB0r6VF+bmseg3khxeonYU2znLG5ULwXDiJJfKr5rXSy3
         3yVOD1MtzioNQssuZlq9hQ/T51OJxVwD8sT/1x50m5Wmi1+XdO6cCFAubpKVMvDg3g
         s5IqS2h90B6CJAEhNIMxpz6uGtBzL0wM2tQV2Tiw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A25A360A23
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 11 Nov 2019 12:14:41 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Fix deadlock under storage almost full/dirty
 condition
Message-ID: <20191111064441.GC15669@codeaurora.org>
References: <1573211027-30785-1-git-send-email-stummala@codeaurora.org>
 <5c491884-91d3-5b85-6d49-569a8d06f3a3@huawei.com>
 <20191111034026.GA15669@codeaurora.org>
 <9ece86fd-ff53-3a70-627e-c6acb03b9264@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ece86fd-ff53-3a70-627e-c6acb03b9264@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Nov 11, 2019 at 02:28:47PM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2019/11/11 11:40, Sahitya Tummala wrote:
> > Hi Chao,
> > 
> > On Mon, Nov 11, 2019 at 10:51:10AM +0800, Chao Yu wrote:
> >> On 2019/11/8 19:03, Sahitya Tummala wrote:
> >>> There could be a potential deadlock when the storage capacity
> >>> is almost full and theren't enough free segments available, due
> >>> to which FG_GC is needed in the atomic commit ioctl as shown in
> >>> the below callstack -
> >>>
> >>> schedule_timeout
> >>> io_schedule_timeout
> >>> congestion_wait
> >>> f2fs_drop_inmem_pages_all
> >>> f2fs_gc
> >>> f2fs_balance_fs
> >>> __write_node_page
> >>> f2fs_fsync_node_pages
> >>> f2fs_do_sync_file
> >>> f2fs_ioctl
> >>>
> >>> If this inode doesn't have i_gc_failures[GC_FAILURE_ATOMIC] set,
> >>> then it waits forever in f2fs_drop_inmem_pages_all(), for this
> >>> atomic inode to be dropped. And the rest of the system is stuck
> >>> waiting for sbi->gc_mutex lock, which is acquired by f2fs_balance_fs()
> >>> in the stack above.
> >>
> >> I think the root cause of this issue is there is potential infinite loop in
> >> f2fs_drop_inmem_pages_all() for the case of gc_failure is true, because once the
> >> first inode in inode_list[ATOMIC_FILE] list didn't suffer gc failure, we will
> >> skip dropping its in-memory cache and calling iput(), and traverse the list
> >> again, most possibly there is the same inode in the head of that list.
> >>
> > 
> > I thought we are expecting for those atomic updates (without any gc failures) to be
> > committed by doing congestion_wait() and thus retrying again. Hence, I just
> 
> Nope, we only need to drop inode which encounter gc failures, and keep the rest
> inodes.
> 
> > fixed only if we are ending up waiting for commit to happen in the atomic
> > commit path itself, which will be a deadlock.
> 
> Look into call stack you provide, I don't think it's correct to drop such inode,
> as its dirty pages should be committed before f2fs_fsync_node_pages(), so
> calling f2fs_drop_inmem_pages won't release any inmem pages, and won't help
> looped GC caused by skipping due to inmem pages.
> 
> And then I figure out below fix...
> 

Thanks for the explanation.
The fix below looks good to me.

Thanks,
Sahitya.

> > 
> >> Could you please check below fix:
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 7bf7b0194944..8a3a35b42a37 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -1395,6 +1395,7 @@ struct f2fs_sb_info {
> >>  	unsigned int gc_mode;			/* current GC state */
> >>  	unsigned int next_victim_seg[2];	/* next segment in victim section */
> >>  	/* for skip statistic */
> >> +	unsigned int atomic_files;		/* # of opened atomic file */
> >>  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
> >>  	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index ecd063239642..79f4b348951a 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -2047,6 +2047,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >>  	if (list_empty(&fi->inmem_ilist))
> >>  		list_add_tail(&fi->inmem_ilist, &sbi->inode_list[ATOMIC_FILE]);
> >> +	sbi->atomic_files++;
> >>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >>
> >>  	/* add inode in inmem_list first and set atomic_file */
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 8b977bbd6822..6aa0bb693697 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -288,6 +288,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi,
> >> bool gc_failure)
> >>  	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
> >>  	struct inode *inode;
> >>  	struct f2fs_inode_info *fi;
> >> +	unsigned int count = sbi->atomic_files;
> > 
> > If the sbi->atomic_files decrements just after this, then the below exit condition
> > may not work. In that case, looped will never be >= count.
> > 
> >> +	unsigned int looped = 0;
> >>  next:
> >>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >>  	if (list_empty(head)) {
> >> @@ -296,22 +298,29 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi,
> >> bool gc_failure)
> >>  	}
> >>  	fi = list_first_entry(head, struct f2fs_inode_info, inmem_ilist);
> >>  	inode = igrab(&fi->vfs_inode);
> >> +	if (inode)
> >> +		list_move_tail(&fi->inmem_ilist, head);
> >>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >>
> >>  	if (inode) {
> >>  		if (gc_failure) {
> >> -			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
> >> -				goto drop;
> >> -			goto skip;
> >> +			if (!fi->i_gc_failures[GC_FAILURE_ATOMIC])
> >> +				goto skip;
> >>  		}
> >> -drop:
> >>  		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>  		f2fs_drop_inmem_pages(inode);
> >> +skip:
> >>  		iput(inode);
> > 
> > Does this result into f2fs_evict_inode() in this context for this inode?
> 
> Yup, we need to call igrab/iput in pair in f2fs_drop_inmem_pages_all() anyway.
> 
> Previously, we may have .i_count leak...
> 
> Thanks,
> 
> > 
> > thanks,
> > 
> >>  	}
> >> -skip:
> >> +
> >>  	congestion_wait(BLK_RW_ASYNC, HZ/50);
> >>  	cond_resched();
> >> +
> >> +	if (gc_failure) {
> >> +		if (++looped >= count)
> >> +			return;
> >> +	}
> >> +
> >>  	goto next;
> >>  }
> >>
> >> @@ -334,6 +343,7 @@ void f2fs_drop_inmem_pages(struct inode *inode)
> >>  	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >>  	if (!list_empty(&fi->inmem_ilist))
> >>  		list_del_init(&fi->inmem_ilist);
> >> +	sbi->atomic_files--;
> >>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >>  }
> >>
> >> Thanks,
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
