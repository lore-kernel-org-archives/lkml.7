Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26825242BD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559169868;
	bh=aKHSIkDbzxATBUyOwATnE+u9n6O5//MnT+XxsgiEgMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=In4nV7F+rIa7j4y518Odur6ra6jb+P5dnDkwHzqS7evok+HU6KWJFVrd5TyOm0wJk
	 kUNPXi28UGvJdlQTppbkwfw4sM89cKGCK+oqFQZ3xiI49PaBbnNf/JK9gYlwZF5BJu
	 cieThaBr4YtTdbeqShRMCOB9ZRqijLLblo8u1x88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2Wo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfE2Wo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:44:27 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F55242B7;
        Wed, 29 May 2019 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559169865;
        bh=aKHSIkDbzxATBUyOwATnE+u9n6O5//MnT+XxsgiEgMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lua8D0OEdQGWNihWIIxnwi8g2DSd4p3FPHXUy/wPDm2mJJFGtr9iud1QVtqcVZ6nY
         JjU1tC6/svRlClz2RLkeEg487A1MsvGqcAmQhInkA6731FKKDXGUVB4BtZZvHthQLM
         YtliyN5/GyYmIF4EAyFC4b2Zxh+Ilh06OTNDKszc=
Date:   Wed, 29 May 2019 15:44:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     axboe@kernel.dk, hch@lst.de, peterz@infradead.org, oleg@redhat.com,
        gkohli@codeaurora.org, mingo@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_io: fix a crash in do_task_dead()
Message-Id: <20190529154424.c0fe2758cf5af42ff258714a@linux-foundation.org>
In-Reply-To: <1559156813-30681-1-git-send-email-cai@lca.pw>
References: <1559156813-30681-1-git-send-email-cai@lca.pw>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 15:06:53 -0400 Qian Cai <cai@lca.pw> wrote:

> The commit 0619317ff8ba ("block: add polled wakeup task helper")
> replaced wake_up_process() with blk_wake_io_task() in
> end_swap_bio_read() which triggers a crash when running heavy swapping
> workloads.
> 
> [T114538] kernel BUG at kernel/sched/core.c:3462!
> [T114538] Process oom01 (pid: 114538, stack limit = 0x000000004f40e0c1)
> [T114538] Call trace:
> [T114538]  do_task_dead+0xf0/0xf8
> [T114538]  do_exit+0xd5c/0x10fc
> [T114538]  do_group_exit+0xf4/0x110
> [T114538]  get_signal+0x280/0xdd8
> [T114538]  do_notify_resume+0x720/0x968
> [T114538]  work_pending+0x8/0x10
> 
> This is because shortly after set_special_state(TASK_DEAD),
> end_swap_bio_read() is called from an interrupt handler that revive the
> task state to TASK_RUNNING causes __schedule() to return and trip the
> BUG() later.
> 
> [  C206] Call trace:
> [  C206]  dump_backtrace+0x0/0x268
> [  C206]  show_stack+0x20/0x2c
> [  C206]  dump_stack+0xb4/0x108
> [  C206]  blk_wake_io_task+0x7c/0x80
> [  C206]  end_swap_bio_read+0x22c/0x31c
> [  C206]  bio_endio+0x3d8/0x414
> [  C206]  dec_pending+0x280/0x378 [dm_mod]
> [  C206]  clone_endio+0x128/0x2ac [dm_mod]
> [  C206]  bio_endio+0x3d8/0x414
> [  C206]  blk_update_request+0x3ac/0x924
> [  C206]  scsi_end_request+0x54/0x350
> [  C206]  scsi_io_completion+0xf0/0x6f4
> [  C206]  scsi_finish_command+0x214/0x228
> [  C206]  scsi_softirq_done+0x170/0x1a4
> [  C206]  blk_done_softirq+0x100/0x194
> [  C206]  __do_softirq+0x350/0x790
> [  C206]  irq_exit+0x200/0x26c
> [  C206]  handle_IPI+0x2e8/0x514
> [  C206]  gic_handle_irq+0x224/0x228
> [  C206]  el1_irq+0xb8/0x140
> [  C206]  _raw_spin_unlock_irqrestore+0x3c/0x74
> [  C206]  do_task_dead+0x88/0xf8
> [  C206]  do_exit+0xd5c/0x10fc
> [  C206]  do_group_exit+0xf4/0x110
> [  C206]  get_signal+0x280/0xdd8
> [  C206]  do_notify_resume+0x720/0x968
> [  C206]  work_pending+0x8/0x10
> 
> Before the offensive commit, wake_up_process() will prevent this from
> happening by taking the pi_lock and bail out immediately if TASK_DEAD is
> set.
> 
> if (!(p->state & TASK_NORMAL))
> 	goto out;

Nice description, thanks.

And...  ouch.  blk_wake_io_task() is a scary thing - changing a task to
TASK_RUNNING state from interrupt context.  I wonder whether the
assumptions which that is making hold true in all situations even after
this change.

Is polled block IO important enough for doing this stuff?

> Fixes: 0619317ff8ba ("block: add polled wakeup task helper")

That will be needing a cc:stable, no?

> ...
>
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -140,7 +140,8 @@ static void end_swap_bio_read(struct bio *bio)
>  	unlock_page(page);
>  	WRITE_ONCE(bio->bi_private, NULL);
>  	bio_put(bio);
> -	blk_wake_io_task(waiter);
> +	/* end_swap_bio_read() could be called from an interrupt handler. */
> +	wake_up_process(waiter);
>  	put_task_struct(waiter);
>  }

