Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B9C2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GNkoxVhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAFKis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:38:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B2rC2/63O/1XGI+Z+Z+uPSWZtJDijMhcew4Wwr5JB4k=; b=GNkoxVhXrVsUWBrA1obrRDy80
        n5EnGO8rd4g4WOKopXzHWqmXjUhrUesIKlyHoKi4E/NmNJXmrrhnnjZU+3+ArKB901JuMGslURaQx
        XKpJ46wFTeteHAfp+knbCbH7L7STKaaCNM2A+yJhTTyA9+CXcTZ5Ut3IC0A1e4bYeeQY179tyeOht
        0LF4NblANi3l2DmRGqwrdUDp9PNRuHuhDFtE4BCnqH18eaapAsXItKfuFo1XThLglEp1Pp9Eg1ThF
        BJiZQznXYGudCPI/mKZ5C478bm1HJwn81ad5WExFiVq2xThElsxAiqB56McCiVfjxayQhERPad8xE
        9KX8VtGiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioPmM-0008E1-Ka; Mon, 06 Jan 2020 10:38:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490C53012DC;
        Mon,  6 Jan 2020 11:37:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56C8D2B27B123; Mon,  6 Jan 2020 11:38:32 +0100 (CET)
Date:   Mon, 6 Jan 2020 11:38:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, linux-kernel@vger.kernel.org, eranian@google.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        ak@linux.intel.com
Subject: Re: [RFC PATCH V2 2/7] perf: Init/fini PMU specific data
Message-ID: <20200106103832.GO2810@hirez.programming.kicks-ass.net>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
 <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:39:19AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The PMU specific data for the monitored tasks only be allocated during
> LBR call stack monitoring.
> 
> When a LBR call stack event is accounted, the perf_ctx_data for related
> tasks will be allocated/initialized by init_perf_ctx_data().
> When a LBR call stack event is unaccounted, the perf_ctx_data for
> related tasks will be detached/freed by fini_task_ctx_data().

I hate that 'fini' name. We don't use that anywhere else.

> +	raw_spin_lock_irqsave(&task_data_sys_wide_events_lock, flags);
> +
> +	/*
> +	 * Allocate perf_ctx_data for all existing threads with the first
> +	 * system-wide event.
> +	 * The perf_ctx_data for new threads will be allocated in
> +	 * perf_event_fork().
> +	 */
> +	if (atomic_inc_return(&nr_task_data_sys_wide_events) > 1)
> +		goto unlock;
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		mutex_lock(&p->perf_event_mutex);
> +		if (p->perf_ctx_data) {
> +			/*
> +			 * The perf_ctx_data for this thread may has been
> +			 * allocated by per-task event.
> +			 * Only update refcount for the case.
> +			 */
> +			refcount_inc(&p->perf_ctx_data->refcount);
> +			mutex_unlock(&p->perf_event_mutex);
> +			continue;
> +		}
> +
> +		if (pos < num_thread) {
> +			refcount_set(&data[pos]->refcount, 1);
> +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
> +		} else {
> +			/*
> +			 * There may be some new threads created,
> +			 * when we allocate space.
> +			 * Track the number in nr_new_tasks.
> +			 */
> +			nr_new_tasks++;
> +		}
> +		mutex_unlock(&p->perf_event_mutex);
> +	}
> +	rcu_read_unlock();
> +
> +	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);

Still NAK. That's some mightly broken code there.
