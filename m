Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9A2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syZhDELX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfH0Ogn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:36:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfH0Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6iDUQNuqkLD0xEwbJW3kzAA85PwkQYPVuQbWXE7HlX4=; b=syZhDELXtKZKB8rOQCi7kyToH
        sMosz2S+BuGhoxzneQS7sha/O3hfcgG16Qh0dNcp/+6YWdzsYcpKACq5RoBqBuF0nmiz1R8VQa1CJ
        oGOzrslrkqgfq8vKxAuc0jkgjD2SZNEaZMRwYLQPHfgn21b82afw1TgS7Fp8Mj7mea9cDgv99cFOd
        TkQ0PREbve0Vkw40NX1cSWNDXRxNqXGme1byEumJcb80WxlyYl6IyRYpnIEqQ9FkBNs7q3Pqs1E32
        ewhK8GvRJrTPzHSFX5af1z/L3DDu/4ySShZFwKxQxThLwr8xjU/Z6llNi+g3ayDgFifEhBooeuA7X
        8ETJt1YsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2caL-0002eg-5F; Tue, 27 Aug 2019 14:36:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45E5F30768B;
        Tue, 27 Aug 2019 16:35:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBB8620B16823; Tue, 27 Aug 2019 16:36:32 +0200 (CEST)
Date:   Tue, 27 Aug 2019 16:36:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     QiaoChong <qiaochong@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: update_curr changed sum_exec_runtime to 1
 when sum_exec_runtime is 0 beacuse some kernel code use sum_exec_runtime==0
 to test task just be forked.
Message-ID: <20190827143632.GF2332@hirez.programming.kicks-ass.net>
References: <20190826114650.10948-1-qiaochong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826114650.10948-1-qiaochong@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:46:50PM +0800, QiaoChong wrote:
> From: Chong Qiao <qiaochong@loongson.cn>
> 
> Such as:
> cpu_cgroup_attach>
>  sched_move_task>
>   task_change_group_fair>
>    task_move_group_fair>
>     detach_task_cfs_rq>
>      vruntime_normalized>
> 
> 	/*
> 	 * When !on_rq, vruntime of the task has usually NOT been normalized.
> 	 * But there are some cases where it has already been normalized:
> 	 *
> 	 * - A forked child which is waiting for being woken up by
> 	 *   wake_up_new_task().
> 	 * - A task which has been woken up by try_to_wake_up() and
> 	 *   waiting for actually being woken up by sched_ttwu_pending().
> 	 */
> 	if (!se->sum_exec_runtime ||
> 	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
> 		return true;
> 
> p->se.sum_exec_runtime is 0, does not mean task not been run (A forked child which is waiting for being woken up by  wake_up_new_task()).
> 
> Task may have been scheduled multimes, but p->se.sum_exec_runtime is still 0, because delta_exec maybe 0 in update_curr.
> 
> static void update_curr(struct cfs_rq *cfs_rq)
> {
> ...
> 	delta_exec = now - curr->exec_start;
> 	if (unlikely((s64)delta_exec <= 0))
> 		return;
> ...
> 
> 	curr->sum_exec_runtime += delta_exec;
> ...
> }
> 
> Task has been run and is stopped(on_rq == 0), vruntime not been normalized, but se->sum_exec_runtime == 0.
> This cause vruntime_normalized set on_rq 1, and does not normalize vruntime.
> This may cause task use old vruntime in old cgroup, which maybe very large than task's vruntime in new cgroup.
> Which may cause task may not scheduled in run queue for long time after been waked up.
> 
> Now I change sum_exec_runtime to 1 when sum_exec_runtime == 0 in update_curr to make sun_exec_runtime not 0.

Have you actually observed this? It is very hard to have a 0 delta
between two scheduling events.
