Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F9EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23CE21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oj/pt86Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfIZOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:44:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfIZOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iO8czRiAGMFSXvLsHxj2FyMjV9e4r3Dcesn6W8xWfKI=; b=oj/pt86QBEN1ErPbIbuM8NDbZ
        mmazJ1uvIflsbirPfKsUdNsv55NuChyEh5YjgtVNyGjbIj+MsfOfLiRLI95PmBigeaA0UK/uia8iz
        5PC+W94Y73vbaAw9YN6xcmm1uMeMfVDNkzTYCwf31ujiRuw2ePKWrpxRVptcjXJtMTXryVliUyVnc
        hJVxy270Gp+QH5sQIIH/LWTfXayvb0xmHe8jz7LzZDTP+VtIzhqRmux617CVvmh8hr4gBUAfQ9aDk
        wbNK80PbPIq1ZNjq+SqxDNqSBX0yhr98ZnBCyOs2t3YwScMkJYrakP/lQjZmVfBLKeCoI5aRV62wJ
        oHcDyO5VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDV0m-00071b-R7; Thu, 26 Sep 2019 14:44:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1516D302A71;
        Thu, 26 Sep 2019 16:44:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7683520138CCE; Thu, 26 Sep 2019 16:44:50 +0200 (CEST)
Date:   Thu, 26 Sep 2019 16:44:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20190926144450.GC4519@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614202022.GC12217@hirez.programming.kicks-ass.net>
 <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com>
 <20180621201632.GE27616@hirez.programming.kicks-ass.net>
 <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:32:39PM +0300, Alexander Shishkin wrote:
> The other problem is sampling SW events, that would require a ctx->lock
> to prevent racing with event_function_call()s from other cpus, resulting
> in somewhat cringy "if (!in_nmi()) raw_spin_lock(...)", but I don't have
> better idea as to how to handle that.

> +int perf_pmu_aux_sample_output(struct perf_event *event,
> +			       struct perf_output_handle *handle,
> +			       unsigned long size)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	/*
> +	 * NMI vs IRQ
> +	 *
> +	 * Normal ->start()/->stop() callbacks run in IRQ mode in scheduler
> +	 * paths. If we start calling them in NMI context, they may race with
> +	 * the IRQ ones, that is, for example, re-starting an event that's just
> +	 * been stopped.
> +	 */
> +	if (!in_nmi())
> +		raw_spin_lock_irqsave(&event->ctx->lock, flags);
> +
> +	ret = event->pmu->snapshot_aux(event, handle, size);
> +
> +	if (!in_nmi())
> +		raw_spin_unlock_irqrestore(&event->ctx->lock, flags);
> +
> +	return ret;
> +}

I'm confused... would not something like:

	unsigned long flags;

	local_irq_save(flags);
	ret = event->pmu->snapshot_aux(...);
	local_irq_restore(flags);

	return ret;

Be sufficient? By disabling IRQs we already hold off remote
event_function_call()s.

Or am I misunderstanding the race here?
