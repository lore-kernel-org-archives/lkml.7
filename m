Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAHQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:50:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:45717 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgAHQuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:50:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="218116149"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jan 2020 08:50:09 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9D8BF301003; Wed,  8 Jan 2020 08:50:09 -0800 (PST)
Date:   Wed, 8 Jan 2020 08:50:09 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH V3 2/7] perf: attach/detach PMU specific data
Message-ID: <20200108165009.GQ15478@tassilo.jf.intel.com>
References: <1578495789-95006-1-git-send-email-kan.liang@linux.intel.com>
 <1578495789-95006-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578495789-95006-2-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int
> +attach_system_wide_ctx_data(size_t ctx_size)
> +{
> +	int i, num_thread, pos, nr_failed_alloc;
> +	unsigned long flags = GFP_ATOMIC;
> +	struct perf_ctx_data *tsk_data;
> +	struct perf_ctx_data **data;
> +	struct task_struct *g, *p;
> +	bool re_alloc = true;
> +
> +	/* Retrieve total number of threads */
> +	num_thread = nr_threads;
> +
> +	data = kcalloc(num_thread, sizeof(*data), GFP_KERNEL);

This probably needs kvcalloc for reliability and avoiding stalls.

> +	if (!data) {
> +		printk_once(KERN_DEBUG
> +			    "Failed to allocate space for LBR callstack. "
> +			    "The LBR callstack for all tasks may be cutoff.\n");
> +		return -ENOMEM;
> +	}
> +
> +	atomic_inc(&nr_task_data_sys_wide_events);
> +
> +repeat:
> +	/*
> +	 * Allocate perf_ctx_data for all existing threads.
> +	 * The perf_ctx_data for new threads will be allocated in
> +	 * perf_event_fork().
> +	 * Do a quick allocation in first round with GFP_ATOMIC.
> +	 */
> +	for (i = 0; i < num_thread; i++) {
> +		if (alloc_perf_ctx_data(ctx_size, flags, &data[i]))
> +			break;
> +	}
> +	num_thread = i;
> +	nr_failed_alloc = 0;
> +	pos = 0;
> +

> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		raw_spin_lock(&p->perf_ctx_data_lock);
> +		tsk_data = p->perf_ctx_data;
> +		if (tsk_data) {

That will be a lot of locks even for tasks that don't use perf, but I guess we 
really need it and it's bounded by the number of tasks.

> +		}
> +
> +		if (pos < num_thread) {
> +			refcount_set(&data[pos]->refcount, TASK_DATA_SYS_WIDE);
> +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
> +		} else {
> +			/*
> +			 * The quick allocation in first round may be failed.
> +			 * Track the number in nr_failed_alloc.
> +			 */
> +			nr_failed_alloc++;
> +		}
> +		raw_spin_unlock(&p->perf_ctx_data_lock);
> +	}
> +	rcu_read_unlock();


-Andi
