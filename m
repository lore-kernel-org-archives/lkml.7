Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51521C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6E20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHSPQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfHSPQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:16:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 049F5C04D293;
        Mon, 19 Aug 2019 15:16:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8CC100197A;
        Mon, 19 Aug 2019 15:16:05 +0000 (UTC)
Subject: Re: [BUG 5.3-rc5] rwsem: use after free on task_struct if task exits
 with rwsem held
To:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org
References: <20190819064711.GL7777@dread.disaster.area>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fec29712-0756-26ff-d6ac-68f52048a231@redhat.com>
Date:   Mon, 19 Aug 2019 11:16:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190819064711.GL7777@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 19 Aug 2019 15:16:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/19 2:47 AM, Dave Chinner wrote:
> Hi folks,
>
> In trying to track down an XFS regression, I stumbled across KASAN
> warnings about use-after-free behave in rwsems.
>
> Essentially, the XFS regression is triggering an ASSERT, which is
> BUG()ing a kernel thread that is holding the superblock s_umount
> rwsem in write mode (it is a mount problem).
>
> Once that thread has been killed (segv), the rwsem it held now has
> no valid owner - the owning task_struct has been freed. When the
> next attempt to access that superblock occurs (because it's visible
> in the superblock list), either by attmepting to do something
> through the block device (e.g. bdev_invalidate()) or by trying to
> mount the block device again, we get use-after-free warnings on
> the superblock s_umount rwsem.
>
> Need 5.3-rc5 w/ CONFIG_XFS_DEBUG=y (needed for the BUG to trigger),
> CONFIG_KASAN=y (to change the memory allocation alignment to cause
> IO failures that cause the conditions for the BUG to to trigger).
>
> Access through the bdev (I was only able to reproduce this one
> through /dev/pmem0) from a thrid party:
>
> # while [ 1 ]; do sudo xfs_io -fd -c "pwrite -S 0x0 -b 1m 0 8g" /dev/pmem0; mkfs.xfs -f -l size=2000m /dev/pmem0; mount -o logbsize=256k /dev/pmem0 /mnt/test; umount /dev/pmem0; done
>
> On the third or fourth loop, everything gets really, really slow
> when mounting - instaed of taking about 100ms to mount the filesystem,
> it takes a couple of minutes before it finally fails, triggering
> a BUG() that kills the mount process:
>
> [   59.316335] XFS (pmem0): Mounting V5 Filesystem
> [   59.322858] XFS (pmem0): Ending clean mount
> [   59.368816] XFS (pmem0): Unmounting Filesystem
> [   63.864465] XFS (pmem0): Mounting V5 Filesystem
> [   63.880840] XFS (pmem0): Ending clean mount
> [   63.928850] XFS (pmem0): Unmounting Filesystem
> [   68.433309] XFS (pmem0): Mounting V5 Filesystem
> [   68.436485] XFS (pmem0): totally zeroed log
> [  188.034629] XFS: Assertion failed: head_blk != tail_blk, file: fs/xfs/xfs_log_recover.c, line: 5236
> [  188.040585] ------------[ cut here ]------------
> [  188.041687] kernel BUG at fs/xfs/xfs_message.c:102!
> [  188.042870] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [  188.044129] CPU: 1 PID: 4740 Comm: mount Not tainted 5.3.0-rc5-dgc+ #1506
> .....
> <snip XFS stracktrace of problem I was trying to reproduce>
>
>
> I outlined both methods of causing this issue because they are two
> different use-after-free cases - one is in the read slowpath, the
> other is in the write slow path. 
>
> I know that processes should not exit while holding a rwsem, but
> bugs do happen.  I'd much prefer that leaked rwsems just hang and we
> do not add the potential for random memory corruption into these
> situations as well - a lock hang is much easier to debug than a
> memory corruption....

From what I understand, a process acquires a write lock on a rwsem, then
got killed before releasing it. A pointer to the task structure will
remain in the rwsem structure. This pointer is primarily used for
optimistic spinning purpose on the on_cpu flag of the task structure.
Depending on the setting on the setting of the on_cpu flag, the spinning
task either continues spinning until its time quantum has expired or go
to sleep immediately. It is read-only access and no write to the task
structure will happen. No real harm should happen unless the memory of
the freed task structure become inaccessible. The bigger problem is that
the tasks that try to acquire the lock will hang waiting for the lock to
be freed. This use-after-free problem is the lesser of the 2 evils, IMHO.

The optimistic spinning mechanism is there for both rwsem and mutex. So
the same problem will happen if the killed task hold a mutex instead of
a rwsem. There is currently no code to detect if the task structure
pointed to by the owner field is legit or not.

-Longman

