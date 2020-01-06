Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F6C2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BICInZD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFOb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:31:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uumXoL+eYMvAU/Zhkw4q7M7e56seiyLsNiF+bQNF7sE=; b=BICInZD+JKwdDFrOYAuBrn8Cs
        yxZBuD06qT5ZkcbPLGVRyV4H8q8S+E0mpqpxBeuWbRV1XdqVTsxa+uzzNy/AsQ31Mersxn7vPI2z1
        szBg4Xgm1dzB5EK95/T538UMfksmWU4Yq49ng2gx8p5EF+gudK2fdielHviqK1NsrLrJciJDusf6j
        F9ihZ13fbRgevOUMpANt5aXUOH1oERvnkpw8z+M9OgO/fKwkdWLkHrrldxiF6g/ukXAe0WQ6iq03L
        ZFeGkcg6NSnTD1nI1cheNvcEaVEwX0zJg1V9dRmI+6FY0X+U9FPdXqD8CRRl5I7O1E+w1EEqxUKF6
        VHYDjFO2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioTPx-0002qk-GX; Mon, 06 Jan 2020 14:31:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B12A306CEE;
        Mon,  6 Jan 2020 15:30:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 365EC2B283CC0; Mon,  6 Jan 2020 15:31:38 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:31:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH V2 2/7] perf: Init/fini PMU specific data
Message-ID: <20200106143138.GN2844@hirez.programming.kicks-ass.net>
References: <1578080364-5928-1-git-send-email-kan.liang@linux.intel.com>
 <1578080364-5928-2-git-send-email-kan.liang@linux.intel.com>
 <20200106103832.GO2810@hirez.programming.kicks-ass.net>
 <20200106142343.GK15478@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106142343.GK15478@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:23:43AM -0800, Andi Kleen wrote:
> > > +	rcu_read_lock();
> > > +	for_each_process_thread(g, p) {
> > > +		mutex_lock(&p->perf_event_mutex);
> > > +		if (p->perf_ctx_data) {
> > > +			/*
> > > +			 * The perf_ctx_data for this thread may has been
> > > +			 * allocated by per-task event.
> > > +			 * Only update refcount for the case.
> > > +			 */
> > > +			refcount_inc(&p->perf_ctx_data->refcount);
> > > +			mutex_unlock(&p->perf_event_mutex);
> > > +			continue;
> > > +		}
> > > +
> > > +		if (pos < num_thread) {
> > > +			refcount_set(&data[pos]->refcount, 1);
> > > +			rcu_assign_pointer(p->perf_ctx_data, data[pos++]);
> > > +		} else {
> > > +			/*
> > > +			 * There may be some new threads created,
> > > +			 * when we allocate space.
> > > +			 * Track the number in nr_new_tasks.
> > > +			 */
> > > +			nr_new_tasks++;
> > > +		}
> > > +		mutex_unlock(&p->perf_event_mutex);
> > > +	}
> > > +	rcu_read_unlock();
> > > +
> > > +	raw_spin_unlock_irqrestore(&task_data_sys_wide_events_lock, flags);
> > 
> > Still NAK. That's some mightly broken code there.
> 
> Yes, Kan you cannot use a mutex (sleeping) inside rcu_read_lock().
> Can perf_event_mutex be a spin lock?

Or insize that raw_spin_lock. And last time I expressly said to not do
what whole tasklist iteration under a spinlock.
