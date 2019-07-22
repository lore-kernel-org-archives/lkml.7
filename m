Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A54DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472EF2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Jj7gG+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfGVSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:17:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfGVSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=keKKeydik4bS+64TTpgAMtBX2rjNWqKMPt/hZd7gMIY=; b=3Jj7gG+Hb4FIjHDviO3i+DrFh
        A0gM4s5VsEj0u/byh4R+8ttqnd1FeXKAiVhNXZC3AvShhDQ+Yc78Oygio2hEnct+/IqcP2YLucqYU
        C7iQ/1Tud84LYi5tZxrw+x7rS84gb0nBBPb70rpEufvTBZElG144wh34V35St2tuCFYBZjCJdSIiW
        4TCHh3LVX1Z3ftOI2uwFQNNeQHZS5ws3d4c+Quwi8slujv/wj6QyfnbULQq7zUltF9fy65D8lyXdL
        D7fQns8qhCHDbQMUPYNNI8oNJIBvySpyF2o1LOTH+p3EesyKlWINJf2m6d2znhPP3ce9q0VgGWx2s
        fi/X7ricw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpcrt-0005ZB-VH; Mon, 22 Jul 2019 18:17:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6736E980D20; Mon, 22 Jul 2019 20:16:58 +0200 (CEST)
Date:   Mon, 22 Jul 2019 20:16:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Message-ID: <20190722181658.GA6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <c02833c8-8c68-4331-03c7-d9e5eb2f285c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02833c8-8c68-4331-03c7-d9e5eb2f285c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:23:06AM -0700, Dave Hansen wrote:
> On 7/18/19 5:58 PM, Nadav Amit wrote:
> > @@ -624,16 +622,11 @@ EXPORT_SYMBOL(on_each_cpu);
> >  void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
> >  			void *info, bool wait)
> >  {
> > -	int cpu = get_cpu();
> > +	preempt_disable();
> >  
> > -	smp_call_function_many(mask, func, info, wait);
> > -	if (cpumask_test_cpu(cpu, mask)) {
> > -		unsigned long flags;
> > -		local_irq_save(flags);
> > -		func(info);
> > -		local_irq_restore(flags);
> > -	}
> > -	put_cpu();
> > +	__smp_call_function_many(mask, func, func, info, wait);
> > +
> > +	preempt_enable();
> >  }
> 
> The get_cpu() was missing it too, but it would be nice to add some
> comments about why preempt needs to be off.  I was also thinking it
> might make sense to do:
> 
> 	cfd = get_cpu_var(cfd_data);
> 	__smp_call_function_many(cfd, ...);
> 	put_cpu_var(cfd_data);
> 	
> instead of the explicit preempt_enable/disable(), but I don't feel too
> strongly about it.

It is also required for cpu hotplug.
