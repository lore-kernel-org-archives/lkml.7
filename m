Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65995C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3792C206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 12:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgVYKa+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLBMlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:41:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44038 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLBMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 07:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QQVFiLaKtWz8/87xlWuZWGTM6aKj6MiwHzOhtOqM+Kg=; b=RgVYKa+Fv+UL9Bo3kZWCRmezD
        v6ob10/58yNO8kTMUqM+WP7DSOCvOqBZQsLxiWqpzNzBHMzN0lhCupEACXAQQ2CXo+SXxWkt+Ow11
        1MIotONSRD5h97ojPAijNKyfySu6Nm4BGwZgtnkmsMQ0kY+Rp8QDe6Un1R5mzdX2HRsAczi/2p/0J
        LCT5q2EmdKnifoFUqmzOi7LZ/MLJE8j2qgwEJGpijXMWZygM4+eYKDPm9DJjbbZUTtdquTZNpj5RE
        Vk9FSkCsyGnaANQ9s26JL2gLat4hMBavpRLUr1OEwEoT7AbtENC3NWy3aba0glXt3AMzkLVQPgrlx
        6sS40t0AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibl0c-0007qf-38; Mon, 02 Dec 2019 12:40:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EEA3301A6C;
        Mon,  2 Dec 2019 13:39:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AEB220236A49; Mon,  2 Dec 2019 13:40:55 +0100 (CET)
Date:   Mon, 2 Dec 2019 13:40:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        ak@linux.intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191202124055.GC2827@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 07:14:26AM -0800, kan.liang@linux.intel.com wrote:
> +static int
> +init_system_wide_ctx_data(size_t ctx_size)
> +{
> +	struct task_struct *g, *p;
> +	int failed_alloc = 0;
> +	unsigned long flags;
> +
> +	/*
> +	 * Allocate perf_ctx_data for all existing threads by the first event.
> +	 *
> +	 * The perf_ctx_data for new thread will be allocated in
> +	 * perf_event_fork(). The perf_event_fork() is called after the thread
> +	 * is added into the tasklist. It guarantees that any new threads will
> +	 * not be missed.
> +	 */
> +	raw_spin_lock_irqsave(&task_data_events_lock, flags);
> +	if (atomic_inc_return(&nr_task_data_events) > 1)
> +		goto unlock;
> +
> +	read_lock(&tasklist_lock);
> +
> +	for_each_process_thread(g, p) {
> +		/*
> +		 * The PMU specific data may already be allocated by
> +		 * per-process event. Need to update refcounter.
> +		 * init_task_ctx_data_rcu() is called here.
> +		 * Do a quick allocation in first round with GFP_ATOMIC.
> +		 */
> +		if (init_task_ctx_data_rcu(p, ctx_size, GFP_ATOMIC))
> +			failed_alloc++;
> +	}

This is atricous crap. Also it is completely broken for -RT.
