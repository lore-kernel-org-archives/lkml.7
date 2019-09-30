Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B3C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14E21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfI3Lu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:50:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:8975 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfI3Lu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:50:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 04:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="194151889"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.57])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 04:50:56 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
In-Reply-To: <20190926144450.GC4519@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com> <20180612075117.65420-5-alexander.shishkin@linux.intel.com> <20180614202022.GC12217@hirez.programming.kicks-ass.net> <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com> <20180621201632.GE27616@hirez.programming.kicks-ass.net> <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com> <20190926144450.GC4519@hirez.programming.kicks-ass.net>
Date:   Mon, 30 Sep 2019 14:50:55 +0300
Message-ID: <878sq657fk.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Aug 09, 2019 at 03:32:39PM +0300, Alexander Shishkin wrote:
>> The other problem is sampling SW events, that would require a ctx->lock
>> to prevent racing with event_function_call()s from other cpus, resulting
>> in somewhat cringy "if (!in_nmi()) raw_spin_lock(...)", but I don't have
>> better idea as to how to handle that.
>
>> +int perf_pmu_aux_sample_output(struct perf_event *event,
>> +			       struct perf_output_handle *handle,
>> +			       unsigned long size)
>> +{
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	/*
>> +	 * NMI vs IRQ
>> +	 *
>> +	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
>> +	 * paths. If we start calling them in NMI context, they may race with
>> +	 * the IRQ ones, that is, for example, re-starting an event that's just
>> +	 * been stopped.
>> +	 */
>> +	if (!in_nmi())
>> +		raw_spin_lock_irqsave(&event->ctx->lock, flags);
>> +
>> +	ret = event->pmu->snapshot_aux(event, handle, size);
>> +
>> +	if (!in_nmi())
>> +		raw_spin_unlock_irqrestore(&event->ctx->lock, flags);
>> +
>> +	return ret;
>> +}
>
> I'm confused... would not something like:
>
> 	unsigned long flags;
>
> 	local_irq_save(flags);
> 	ret = event->pmu->snapshot_aux(...);
> 	local_irq_restore(flags);
>
> 	return ret;
>
> Be sufficient? By disabling IRQs we already hold off remote
> event_function_call()s.
>
> Or am I misunderstanding the race here?

No, you're right, disabling IRQs covers our bases.

Thanks,
--
Alex
