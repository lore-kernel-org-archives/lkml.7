Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB811C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888002072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFOXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:23:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:9090 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAFOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:23:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 06:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="216842020"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jan 2020 06:23:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A6E1F300DE4; Mon,  6 Jan 2020 06:23:43 -0800 (PST)
Date:   Mon, 6 Jan 2020 06:23:43 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH V2 2/7] perf: Init/fini PMU specific data
Message-ID: <20200106142343.GK15478@tassilo.jf.intel.com>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
 <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
 <20200106103832.GO2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106103832.GO2810@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	rcu_read_lock();
> > +	for_each_process_thread(g, p) {
> > +		mutex_lock(&p->perf_event_mutex);
> > +		if (p->perf_ctx_data) {
> > +			/*
> > +			 * The perf_ctx_data for this thread may has been
> > +			 * allocated by per-task event.
> > +			 * Only update refcount for the case.
> > +			 */
> > +			refcount_inc(&p->perf_ctx_data->refcount);
> > +			mutex_unlock(&p->perf_event_mutex);
> > +			continue;
> > +		}
> > +
> > +		if (pos < num_thread) {
> > +			refcount_set(&data[pos]->refcount, 1);
> > +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
> > +		} else {
> > +			/*
> > +			 * There may be some new threads created,
> > +			 * when we allocate space.
> > +			 * Track the number in nr_new_tasks.
> > +			 */
> > +			nr_new_tasks++;
> > +		}
> > +		mutex_unlock(&p->perf_event_mutex);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
> 
> Still NAK. That's some mightly broken code there.

Yes, Kan you cannot use a mutex (sleeping) inside rcu_read_lock().
Can perf_event_mutex be a spin lock?

-Andi
