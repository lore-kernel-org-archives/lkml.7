Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79603214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n4rcgivh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfLLJAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:00:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbfLLJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+PW0GaE1o80mz9BCaP0NnRe4uaLh9xJ18z0GQzHpTvo=; b=n4rcgivhDeuNxhFil6/XCfbjg
        vSMK6qquyiYvdkVlLV7Zv7cKTkgkGx5iC02MdRNWs6d9y5GLqqEkv3RSTI3+F6vL8xQXjragjhMwJ
        UoSCfCbSl1BJh6ekrX4uUpHHTC0tTAa/1TcHImDeuEeEf7AGyjImf/hC7syDbN0lhNGntqtIDyjhQ
        7RjaF+SFWaD66rcND57OE6TsN1+vcxTZue1Pgf8sIXlLl9wOQXfzQAs4edndaRC/9U/3NIDnzUsHI
        KGl9IK5NBxYidjD/ZibvgNRbmQg7xyvg6r9qzVm8trsFhxxQ+R4SY7xQ+/zasBEuyhS0hjf4axvi+
        cESbWO2qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifKK7-0006AX-8n; Thu, 12 Dec 2019 08:59:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92461305E21;
        Thu, 12 Dec 2019 09:58:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D581A2B18D264; Thu, 12 Dec 2019 09:59:48 +0100 (CET)
Date:   Thu, 12 Dec 2019 09:59:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191212085948.GS2827@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125161348.GA12178@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 08:13:48AM -0800, Sean Christopherson wrote:
> On Fri, Nov 22, 2019 at 04:30:56PM -0800, Luck, Tony wrote:
> > On Fri, Nov 22, 2019 at 04:27:15PM +0100, Peter Zijlstra wrote:
> > 
> > This all looks dubious on an HT system .... three snips
> > from your patch:
> > 
> > > +static bool __sld_msr_set(bool on)
> > > +{
> > > +	u64 test_ctrl_val;
> > > +
> > > +	if (rdmsrl_safe(MSR_TEST_CTRL, test_ctrl_val))
> > > +		return false;
> > > +
> > > +	if (on)
> > > +		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> > > +	else
> > > +		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> > > +
> > > +	if (wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > 
> > > +void switch_sld(struct task_struct *prev)
> > > +{
> > > +	__sld_set_msr(true);
> > > +	clear_tsk_thread_flag(current, TIF_CLD);
> > > +}
> > 
> > > @@ -654,6 +654,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> > >  		/* Enforce MSR update to ensure consistent state */
> > >  		__speculation_ctrl_update(~tifn, tifn);
> > >  	}
> > > +
> > > +	if (tifp & _TIF_SLD)
> > > +		switch_sld(prev_p);
> > >  }
> > 
> > Don't you have some horrible races between the two logical
> > processors on the same core as they both try to set/clear the
> > MSR that is shared at the core level?
> 
> Yes and no.  Yes, there will be races, but they won't be fatal in any way.
> 
>   - Only the split-lock bit is supported by the kernel, so there isn't a
>     risk of corrupting other bits as both threads will rewrite the current
>     hardware value.
> 
>   - Toggling of split-lock is only done in "warn" mode.  Worst case
>     scenario of a race is that a misbehaving task will generate multiple
>     #AC exceptions on the same instruction.  And this race will only occur
>     if both siblings are running tasks that generate split-lock #ACs, e.g.
>     a race where sibling threads are writing different values will only
>     occur if CPUx is disabling split-lock after an #AC and CPUy is
>     re-enabling split-lock after *its* previous task generated an #AC.
> 
>   - Transitioning between modes at runtime isn't supported and disabling
>     is tracked per task, so hardware will always reach a steady state that
>     matches the configured mode.  I.e. split-lock is guaranteed to be
>     enabled in hardware once all _TIF_SLD threads have been scheduled out.

Just so, thanks for clarifying.
