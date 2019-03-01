Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0792C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CA32186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfCAKKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:10:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfCAKKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:10:05 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D44DB6DDB6D80E32AAE;
        Fri,  1 Mar 2019 18:10:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 18:09:50 +0800
Subject: Re: [PATCH] aio: take an extra file reference before call vfs_poll()
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190225090332.88640-1-houtao1@huawei.com>
Message-ID: <b9976295-0324-dd98-2546-c8de6ff70a43@huawei.com>
Date:   Fri, 1 Mar 2019 18:09:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190225090332.88640-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On 2019/2/25 17:03, Hou Tao wrote:
> Taking an extra file reference before call vfs_poll(), else
> the file may be released by aio_poll_wake() if an expected
> event is triggered immediately (e.g., by the close of a
> pair of pipes) after the return of vfs_poll(), and we may
> hit a use-after-free splat as shown below:
> 
>  BUG: KASAN: use-after-free in perf_trace_lock_acquire+0x3ab/0x570
>  Read of size 8 at addr ffff888379bfd4b0 by task syz-executor.1/4953
> 
>  CPU: 0 PID: 4953 Comm: syz-executor.1 Not tainted 4.19.24
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
>  Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x79/0x330 mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report+0x18a/0x2e0 mm/kasan/report.c:412
>   trace_event_get_offsets_lock_acquire include/trace/events/lock.h:13 [inline]
>   perf_trace_lock_acquire+0x3ab/0x570 include/trace/events/lock.h:13
>   trace_lock_acquire include/trace/events/lock.h:13 [inline]
>   lock_acquire+0x202/0x310 kernel/locking/lockdep.c:3899
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2c/0x40 kernel/locking/spinlock.c:144
>   spin_lock include/linux/spinlock.h:329 [inline]
>   aio_poll fs/aio.c:1750 [inline]
>   io_submit_one+0xb90/0x1b30 fs/aio.c:1853
>   __do_sys_io_submit fs/aio.c:1919 [inline]
>   __se_sys_io_submit fs/aio.c:1890 [inline]
>   __x64_sys_io_submit+0x19b/0x500 fs/aio.c:1890
>   do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   ......
>   Allocated by task 4953:
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xa0/0xd0 mm/kasan/kasan.c:553
>   kmem_cache_alloc_trace+0x12f/0x2d0 mm/slub.c:2733
>   kmalloc include/linux/slab.h:513 [inline]
>   kzalloc include/linux/slab.h:707 [inline]
>   alloc_pipe_info+0xdf/0x410 fs/pipe.c:633
>   get_pipe_inode fs/pipe.c:712 [inline]
>   create_pipe_files+0x98/0x780 fs/pipe.c:744
>   __do_pipe_flags+0x35/0x230 fs/pipe.c:781
>   do_pipe2+0x87/0x150 fs/pipe.c:829
>   __do_sys_pipe2 fs/pipe.c:847 [inline]
>   __se_sys_pipe2 fs/pipe.c:845 [inline]
>   __x64_sys_pipe2+0x55/0x80 fs/pipe.c:845
>   do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  Freed by task 4952:
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x12e/0x180 mm/kasan/kasan.c:521
>   slab_free_hook mm/slub.c:1371 [inline]
>   slab_free_freelist_hook mm/slub.c:1398 [inline]
>   slab_free mm/slub.c:2953 [inline]
>   kfree+0xeb/0x2f0 mm/slub.c:3906
>   put_pipe_info+0xb0/0xd0 fs/pipe.c:556
>   pipe_release+0x1ab/0x240 fs/pipe.c:577
>   __fput+0x27f/0x7f0 fs/file_table.c:278
>   task_work_run+0x136/0x1b0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>   exit_to_usermode_loop+0x1a7/0x1d0 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x461/0x580 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fixes: bfe4037e722e ("aio: implement IOCB_CMD_POLL")
> Cc: stable@vger.kernel.org [4.19+]
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/aio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index aaaaf4d12c73..ea2f5de4feac 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1763,6 +1763,12 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  	/* one for removal from waitqueue, one for this function */
>  	refcount_set(&aiocb->ki_refcnt, 2);
>  
> +	/*
> +	 * file may be released by aio_poll_wake() if an expected event
> +	 * is triggered immediately after the return of vfs_poll(), so
> +	 * an extra reference is needed here to prevent use-after-free.
> +	 */
> +	get_file(req->file);
>  	mask = vfs_poll(req->file, &apt.pt) & req->events;
>  	if (unlikely(!req->head)) {
>  		/* we did not manage to set up a waitqueue, done */
> @@ -1788,6 +1794,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
>  out:
> +	/* release the extra reference for vfs_poll() */
> +	fput(req->file);
>  	if (unlikely(apt.error)) {
>  		fput(req->file);
>  		return apt.error;
> 

