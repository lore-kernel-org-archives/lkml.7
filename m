Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A216208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFZUqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:46:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:60319 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:46:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 13:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="360439398"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2019 13:46:21 -0700
Date:   Wed, 26 Jun 2019 13:36:37 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20190626203637.GC245468@romley-ivt3.sc.intel.com>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-10-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:20:05PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Jun 2019, Fenghua Yu wrote:
> > +
> > +static atomic_t split_lock_debug;
> > +
> > +void split_lock_disable(void)
> > +{
> > +	/* Disable split lock detection on this CPU */
> > +	this_cpu_and(msr_test_ctl_cached, ~MSR_TEST_CTL_SPLIT_LOCK_DETECT);
> > +	wrmsrl(MSR_TEST_CTL, this_cpu_read(msr_test_ctl_cached));
> > +
> > +	/*
> > +	 * Use the atomic variable split_lock_debug to ensure only the
> > +	 * first CPU hitting split lock issue prints one single complete
> > +	 * warning. This also solves the race if the split-lock #AC fault
> > +	 * is re-triggered by NMI of perf context interrupting one
> > +	 * split-lock warning execution while the original WARN_ONCE() is
> > +	 * executing.
> > +	 */
> > +	if (atomic_cmpxchg(&split_lock_debug, 0, 1) == 0) {
> > +		WARN_ONCE(1, "split lock operation detected\n");
> > +		atomic_set(&split_lock_debug, 0);
> 
> What's the purpose of this atomic_set()?

atomic_set() releases the split_lock_debug flag after WARN_ONCE() is done.
The same split_lock_debug flag will be used in sysfs write for atomic
operation as well, as proposed by Ingo in https://lkml.org/lkml/2019/4/25/48
So that's why the flag needs to be cleared, right?

> 
> > +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> > +{
> > +	unsigned int trapnr = X86_TRAP_AC;
> > +	char str[] = "alignment check";
> > +	int signr = SIGBUS;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> > +
> > +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
> > +		return;
> > +
> > +	cond_local_irq_enable(regs);
> > +	if (!user_mode(regs) && static_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT)) {
> > +		/*
> > +		 * Only split locks can generate #AC from kernel mode.
> > +		 *
> > +		 * The split-lock detection feature is a one-shot
> > +		 * debugging facility, so we disable it immediately and
> > +		 * print a warning.
> > +		 *
> > +		 * This also solves the instruction restart problem: we
> > +		 * return the faulting instruction right after this it
> 
> we return the faulting instruction ... to the store so we get our deposit
> back :)
> 
>   the fault handler returns to the faulting instruction which will be then
>   executed without ....
> 
> Don't try to impersonate code, cpus or whatever. It doesn't make sense and
> confuses people.
> 
> > +		 * will be executed without generating another #AC fault
> > +		 * and getting into an infinite loop, instead it will
> > +		 * continue without side effects to the interrupted
> > +		 * execution context.
> 
> That last part 'instead .....' is redundant. It's entirely clear from the
> above that the faulting instruction is reexecuted ....
> 
> Please write concise comments and do try to repeat the same information
> with a different painting.

I copied the comment completely from Ingo's comment on v8:
https://lkml.org/lkml/2019/4/25/40

Thanks.

-Fenghua
