Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD41CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D2F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572454971;
	bh=pDmWHhgixxSGSlKcG7JAEENyJI4HshThaEn6KOyP4vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ODh5S7p4b6gYNSnXuYRapD/oUk3ikYDD7wt9r/Yw/azJHv88UTK27xeyJi/8+/BzV
	 /xX24XePv67vKkWScydnvvlGoygZjW4TE/Qtk+MpcYA8IYmkUoeS4my3LgsfpIzs1K
	 A5AjpH+OxC5hvkXP55wy28/p5Ivv2i3HWKDBMPi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfJ3RCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfJ3RCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:02:49 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A82020650;
        Wed, 30 Oct 2019 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572454968;
        bh=pDmWHhgixxSGSlKcG7JAEENyJI4HshThaEn6KOyP4vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qlid3cbSHifQ5VBTBwWCswcADBqOYlpYNTDwf18VN+2n0WwB98+Zk2NE12TtkO7VZ
         RchFjNgMFSiOxgytvgE1gHS8eoJ3KsezXMVzIY3ylNRKv/nww7t/trpPdz5rgY1je/
         OjWRmIQCVFBnYSuVgOMHOUMuDJqxFspxdMM4fUak=
Date:   Wed, 30 Oct 2019 10:02:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs: support data compression
Message-ID: <20191030170246.GB693@sol.localdomain>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
 <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:43:52PM +0800, Chao Yu wrote:
> >>>>  static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> >>>>  {
> >>>> -	/*
> >>>> -	 * We use different work queues for decryption and for verity because
> >>>> -	 * verity may require reading metadata pages that need decryption, and
> >>>> -	 * we shouldn't recurse to the same workqueue.
> >>>> -	 */
> >>>
> >>> Why is it okay (i.e., no deadlocks) to no longer use different work queues for
> >>> decryption and for verity?  See the comment above which is being deleted.
> >>
> >> Could you explain more about how deadlock happen? or share me a link address if
> >> you have described that case somewhere?
> >>
> > 
> > The verity work can read pages from the file which require decryption.  I'm
> > concerned that it could deadlock if the work is scheduled on the same workqueue.
> 
> I assume you've tried one workqueue, and suffered deadlock..
> 
> > Granted, I'm not an expert in Linux workqueues, so if you've investigated this
> > and determined that it's safe, can you explain why?
> 
> I'm not familiar with workqueue...  I guess it may not safe that if the work is
> scheduled to the same cpu in where verity was waiting for data? if the work is
> scheduled to other cpu, it may be safe.
> 
> I can check that before splitting the workqueue for verity and decrypt/decompress.
> 

Yes this is a real problem, try 'kvm-xfstests -c f2fs/encrypt generic/579'.
The worker thread gets deadlocked in f2fs_read_merkle_tree_page() waiting for
the Merkle tree page to be decrypted.  This is with the v2 compression patch;
it works fine on current mainline.

INFO: task kworker/u5:0:61 blocked for more than 30 seconds.
      Not tainted 5.4.0-rc1-00119-g464e31ba60d0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u5:0    D    0    61      2 0x80004000
Workqueue: f2fs_post_read_wq f2fs_post_read_work
Call Trace:
 context_switch kernel/sched/core.c:3384 [inline]
 __schedule+0x299/0x6c0 kernel/sched/core.c:4069
 schedule+0x44/0xd0 kernel/sched/core.c:4136
 io_schedule+0x11/0x40 kernel/sched/core.c:5780
 wait_on_page_bit_common mm/filemap.c:1174 [inline]
 wait_on_page_bit mm/filemap.c:1223 [inline]
 wait_on_page_locked include/linux/pagemap.h:527 [inline]
 wait_on_page_locked include/linux/pagemap.h:524 [inline]
 wait_on_page_read mm/filemap.c:2767 [inline]
 do_read_cache_page+0x407/0x660 mm/filemap.c:2810
 read_cache_page+0xd/0x10 mm/filemap.c:2894
 f2fs_read_merkle_tree_page+0x2e/0x30 include/linux/pagemap.h:396
 verify_page+0x110/0x560 fs/verity/verify.c:120
 fsverity_verify_bio+0xe6/0x1a0 fs/verity/verify.c:239
 verity_work fs/f2fs/data.c:142 [inline]
 f2fs_post_read_work+0x36/0x50 fs/f2fs/data.c:160
 process_one_work+0x225/0x550 kernel/workqueue.c:2269
 worker_thread+0x4b/0x3c0 kernel/workqueue.c:2415
 kthread+0x125/0x140 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/u5:1:1140 blocked for more than 30 seconds.
      Not tainted 5.4.0-rc1-00119-g464e31ba60d0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u5:1    D    0  1140      2 0x80004000
Workqueue: f2fs_post_read_wq f2fs_post_read_work
Call Trace:
 context_switch kernel/sched/core.c:3384 [inline]
 __schedule+0x299/0x6c0 kernel/sched/core.c:4069
 schedule+0x44/0xd0 kernel/sched/core.c:4136
 io_schedule+0x11/0x40 kernel/sched/core.c:5780
 wait_on_page_bit_common mm/filemap.c:1174 [inline]
 wait_on_page_bit mm/filemap.c:1223 [inline]
 wait_on_page_locked include/linux/pagemap.h:527 [inline]
 wait_on_page_locked include/linux/pagemap.h:524 [inline]
 wait_on_page_read mm/filemap.c:2767 [inline]
 do_read_cache_page+0x407/0x660 mm/filemap.c:2810
 read_cache_page+0xd/0x10 mm/filemap.c:2894
 f2fs_read_merkle_tree_page+0x2e/0x30 include/linux/pagemap.h:396
 verify_page+0x110/0x560 fs/verity/verify.c:120
 fsverity_verify_bio+0xe6/0x1a0 fs/verity/verify.c:239
 verity_work fs/f2fs/data.c:142 [inline]
 f2fs_post_read_work+0x36/0x50 fs/f2fs/data.c:160
 process_one_work+0x225/0x550 kernel/workqueue.c:2269
 worker_thread+0x4b/0x3c0 kernel/workqueue.c:2415
 kthread+0x125/0x140 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Showing all locks held in the system:
1 lock held by khungtaskd/21:
 #0: ffffffff82250520 (rcu_read_lock){....}, at: rcu_lock_acquire.constprop.0+0x0/0x30 include/trace/events/lock.h:13
2 locks held by kworker/u5:0/61:
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: set_work_data kernel/workqueue.c:619 [inline]
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: process_one_work+0x1ad/0x550 kernel/workqueue.c:2240
 #1: ffffc90000253e50 ((work_completion)(&ctx->work)){+.+.}, at: set_work_data kernel/workqueue.c:619 [inline]
 #1: ffffc90000253e50 ((work_completion)(&ctx->work)){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
 #1: ffffc90000253e50 ((work_completion)(&ctx->work)){+.+.}, at: process_one_work+0x1ad/0x550 kernel/workqueue.c:2240
2 locks held by kworker/u5:1/1140:
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: set_work_data kernel/workqueue.c:619 [inline]
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
 #0: ffff88807b78eb28 ((wq_completion)f2fs_post_read_wq){+.+.}, at: process_one_work+0x1ad/0x550 kernel/workqueue.c:2240
 #1: ffffc9000174be50 ((work_completion)(&ctx->work)){+.+.}, at: set_work_data kernel/workqueue.c:619 [inline]
 #1: ffffc9000174be50 ((work_completion)(&ctx->work)){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
 #1: ffffc9000174be50 ((work_completion)(&ctx->work)){+.+.}, at: process_one_work+0x1ad/0x550 kernel/workqueue.c:2240
