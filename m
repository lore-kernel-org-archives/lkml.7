Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F5EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4B420674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oz6AzYkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLBNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:17:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44202 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLBNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cfCiwtxTe+vevwBzRpyd6UE5jtUfQLTraXDXuVr+qRs=; b=oz6AzYkz5r2qVrpoW55f7cxZF
        bYrx7ddyJSjgxjKGmgL/qrow4MBusbBYzLMT9anlmqyIYM3Z/AalDWHpb86HJV4oY5+CxzEaDS1YX
        EjO/VeiNi//RSFp+GKz6XsvM1ou2X5UqS/aDhAaxy33zp63wcDExllZb8JtFxjFa4CnH8xsSWYzrB
        R6vpSDR+2VYagy0x9qLu7XMc9XdkQ0JiodG7pFcrN3gFdoLNBEdvzzFifOSj0/4Or8IfRigk3AOJi
        bCA2mdhg1BNxI3TDfl9mLDybL5+xlyEBu3A9Vq1nRHaLRvGMP3jOVy2T0eBvBKWPR7GnB4uLh0MrT
        LHeg28ijw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iblZJ-0008BE-AR; Mon, 02 Dec 2019 13:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 039463011DD;
        Mon,  2 Dec 2019 14:15:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8A8620236A49; Mon,  2 Dec 2019 14:16:46 +0100 (CET)
Date:   Mon, 2 Dec 2019 14:16:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        ak@linux.intel.com
Subject: Re: [RFC PATCH 2/8] perf: Helpers for alloc/init/fini PMU specific
 data
Message-ID: <20191202131646.GD2827@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574954071-6321-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 07:14:25AM -0800, kan.liang@linux.intel.com wrote:

> +static int
> +__alloc_task_ctx_data_rcu(struct task_struct *task,
> +			  size_t ctx_size, gfp_t flags)
> +{
> +	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
> +	int ret;
> +
> +	lockdep_assert_held_once(&task->perf_ctx_data_lock);
> +
> +	ret = alloc_perf_ctx_data(ctx_size, flags, &ctx_data);
> +	if (ret)
> +		return ret;
> +
> +	ctx_data->refcount = 1;
> +
> +	rcu_assign_pointer(task->perf_ctx_data, ctx_data);
> +
> +	return 0;
> +}

> +static int
> +__init_task_ctx_data_rcu(struct task_struct *task, size_t ctx_size, gfp_t flags)
> +{
> +	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
> +
> +	lockdep_assert_held_once(&task->perf_ctx_data_lock);
> +
> +	if (ctx_data) {
> +		ctx_data->refcount++;
> +		return 0;
> +	}
> +
> +	return __alloc_task_ctx_data_rcu(task, ctx_size, flags);
> +}

> +/**
> + * Free perf_ctx_data RCU pointer for a task
> + * @task:        Target Task
> + * @force:       Unconditionally free perf_ctx_data
> + *
> + * If force is set, free perf_ctx_data unconditionally.
> + * Otherwise, free perf_ctx_data when there are no users.
> + * Lock is required to sync the writers of perf_ctx_data RCU pointer
> + * and refcount.
> + */
> +static void
> +fini_task_ctx_data_rcu(struct task_struct *task, bool force)
> +{
> +	struct perf_ctx_data *ctx_data;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, flags);
> +
> +	ctx_data = task->perf_ctx_data;
> +	if (!ctx_data)
> +		goto unlock;
> +
> +	if (!force && --ctx_data->refcount)
> +		goto unlock;
> +
> +	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
> +	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data);
> +
> +unlock:
> +	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, flags);
> +}

All this refcount under lock is an anti-pattern. Also the naming is
insane.
