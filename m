Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68789C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C720644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bikgl7W2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfGVTeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:34:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfGVTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XA38J2mrIvGomm9eDYffUQCSCdYHMKLwi/HGUwSUnwo=; b=Bikgl7W2GPCpfti4CaNgYdUOmP
        qet0WayR7rafBmhw8BikzuXKA7pTLgYNvEf0S0hbrxa9RQqL/KPhrKJcnG5Qcy0T5xyPjhdeqefGX
        No4+d1kVtBmlEaRedWn/gBQAZAihqCAMm4BT8+xldViIzOCyUJHkGxqgHfHdTuiYdDI5ruqeDPSm8
        3TQsCcY3ZeWcTKRpMOc0HpP7Pu7h9a79qIAEugVTDBnCew3WKeG/W4Kj4N4et3C0z+fPX/VsptkaV
        GTJOLVA3cE2IkxCdZrJ1PK5roOHbGhSsCECiAqJS+vKLbcgkOKi2cX7b/JogKQf+GZvbqXK5yKotU
        JviTmTQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpe4e-0006IZ-9a; Mon, 22 Jul 2019 19:34:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 806C3980C59; Mon, 22 Jul 2019 21:34:14 +0200 (CEST)
Date:   Mon, 22 Jul 2019 21:34:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Message-ID: <20190722193414.GG6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <c02833c8-8c68-4331-03c7-d9e5eb2f285c@intel.com>
 <20190722181658.GA6698@worktop.programming.kicks-ass.net>
 <CF32049E-D6AA-4AD5-A276-0CEC84B6DB11@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CF32049E-D6AA-4AD5-A276-0CEC84B6DB11@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:41:44PM +0000, Nadav Amit wrote:
> > On Jul 22, 2019, at 11:16 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Fri, Jul 19, 2019 at 11:23:06AM -0700, Dave Hansen wrote:
> >> On 7/18/19 5:58 PM, Nadav Amit wrote:
> >>> @@ -624,16 +622,11 @@ EXPORT_SYMBOL(on_each_cpu);
> >>> void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
> >>> 			void *info, bool wait)
> >>> {
> >>> -	int cpu = get_cpu();
> >>> +	preempt_disable();
> >>> 
> >>> -	smp_call_function_many(mask, func, info, wait);
> >>> -	if (cpumask_test_cpu(cpu, mask)) {
> >>> -		unsigned long flags;
> >>> -		local_irq_save(flags);
> >>> -		func(info);
> >>> -		local_irq_restore(flags);
> >>> -	}
> >>> -	put_cpu();
> >>> +	__smp_call_function_many(mask, func, func, info, wait);
> >>> +
> >>> +	preempt_enable();
> >>> }
> >> 
> >> The get_cpu() was missing it too, but it would be nice to add some
> >> comments about why preempt needs to be off.  I was also thinking it
> >> might make sense to do:
> >> 
> >> 	cfd = get_cpu_var(cfd_data);
> >> 	__smp_call_function_many(cfd, ...);
> >> 	put_cpu_var(cfd_data);
> >> 	
> >> instead of the explicit preempt_enable/disable(), but I don't feel too
> >> strongly about it.
> > 
> > It is also required for cpu hotplug.
> 
> But then smpcfd_dead_cpu() will not respect the “cpu” argument. Do you still
> prefer it this way (instead of the current preempt_enable() /
> preempt_disable())?

I just meant that the preempt_disable() (either form) is required for
hotplug (we must not send IPIs to offline CPUs, that gets things upset).

Personally I don't mind the bare preempt_disable() as you have; but I
think Dave's idea of a comment has merrit.
