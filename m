Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8967C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7822220830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I2IyaB4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfCYHTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:19:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbfCYHTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ytWLZb9i6bwYoGc+Ie1SsQyY+8xydD5Gq23Ia/mqdb0=; b=I2IyaB4Cd7KsKNR8S0Rh0x1VO
        vbrfwc46TV0eYfLMrLzJpxHWtZ7uag3o1tu1EsIXrator/OP5eZCnrVopuD+Vqpx9+a5Bqai8HwtT
        wA2Wgmr3yhmC5BZ9nLqIuZ/ZQ/JaRObNGVDf2C/1YFrY6M+x01hbjjZlP5L4yZjamz+lkkNq+xEml
        ViTiY/OTo/2ZiYB3Fck40eY2QPuOGDpaY3g4u7OaXd5bcY7tlzDxOzy3xXDl11GVCTwtf8M33rOtL
        UnUIgfGQoD3F5Z1hsYx/31y52nZWdcNKeqiGv8Pe/dlQ3XixB6uMe6Y2i7gQeSlBP7hcCH8j2z+DB
        4/Kjq3uzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8JtH-0002DX-4K; Mon, 25 Mar 2019 07:19:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58B552393EF0A; Mon, 25 Mar 2019 08:19:24 +0100 (CET)
Date:   Mon, 25 Mar 2019 08:19:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        like.xu@intel.com, wei.w.wang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
Message-ID: <20190325071924.GE6058@hirez.programming.kicks-ass.net>
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com>
 <20190323172800.GD6058@hirez.programming.kicks-ass.net>
 <28851e9d-5ed4-8ce1-8ff4-9d6c04180388@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28851e9d-5ed4-8ce1-8ff4-9d6c04180388@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:47:32PM +0800, Like Xu wrote:
> On 2019/3/24 1:28, Peter Zijlstra wrote:
> > On Sat, Mar 23, 2019 at 10:18:03PM +0800, Like Xu wrote:
> > > === Brief description ===
> > > 
> > > This proposal for Intel vPMU is still committed to optimize the basic
> > > functionality by reducing the PMU virtualization overhead and not a blind
> > > pass-through of the PMU. The proposal applies to existing models, in short,
> > > is "host perf would hand over control to kvm after counter allocation".
> > > 
> > > The pmc_reprogram_counter is a heavyweight and high frequency operation
> > > which goes through the host perf software stack to create a perf event for
> > > counter assignment, this could take millions of nanoseconds. The current
> > > vPMU always does reprogram_counter when the guest changes the eventsel,
> > > fixctrl, and global_ctrl msrs. This brings too much overhead to the usage
> > > of perf inside the guest, especially the guest PMI handling and context
> > > switching of guest threads with perf in use.
> > 
> > I think I asked for starting with making pmc_reprogram_counter() less
> > retarded. I'm not seeing that here.
> 
> Do you mean pass perf_event_attr to refactor pmc_reprogram_counter
> via paravirt ? Please share more details.

I mean nothing; I'm trying to understand wth you're doing.

> > > We optimize the current vPMU to work in this manner:
> > > 
> > > (1) rely on the existing host perf (perf_event_create_kernel_counter)
> > >      to allocate counters for in-use vPMC and always try to reuse events;
> > > (2) vPMU captures guest accesses to the eventsel and fixctrl msr directly
> > >      to the hardware msr that the corresponding host event is scheduled on
> > >      and avoid pollution from host is also needed in its partial runtime;
> > 
> > If you do pass-through; how do you deal with event constraints >
> > > (3) save and restore the counter state during vCPU scheduling in hooks;
> > > (4) apply a lazy approach to release the vPMC's perf event. That is, if
> > >      the vPMC isn't used in a fixed sched slice, its event will be released.
> > > 
> > > In the use of vPMC, the vPMU always focus on the assigned resources and
> > > guest perf would significantly benefit from direct access to hardware and
> > > may not care about runtime state of perf_event created by host and always
> > > try not to pay for their maintenance. However to avoid events entering into
> > > any unexpected state, calling pmc_read_counter in appropriate is necessary.
> > 
> > what?!
> 
> The patch will reuse the created events as much as possible for same guest
> vPMC which may has different config_base in its partial runtime.

again. what?!

> The pmc_read_counter is designed to be called in kvm_pmu_rdpmc and
> pmc_stop_counter as legacy does and it's not for vPMU functionality but for
> host perf maintenance (seems to be gone in code,Oops).
> 
> > 
> > I can't follow that, and the quick look I had at the patches doesn't
> > seem to help. I did note it is intel only and that is really sad.
> 
> The basic idea of optimization is x86 generic, and the implementation is not
> intentional cause I could not access non-Intel machines and verified it.
> 
> > 
> > It also makes a mess of who programs what msr when.
> > 
> 
> who programs: vPMU does as usual in pmc_reprogram_counter
> 
> what msr: host perf scheduler make decisions and I'm not sure the hosy perf
> would do cross-mapping scheduling which means to assign a host fixed counter
> to guest gp counter and vice versa.
> 
> when programs: every time to call reprogram_gp/fixed_counter &&
> pmc_is_assigned(pmc) is false; check the fifth pacth for details.

I'm not going to reverse engineer this; if you can't write coherent
descriptions, this isn't going anywhere.

It isn't going anywhere anyway, its insane. You let perf do all its
normal things and then discard the results by avoiding the wrmsr.

Then you fudge a second wrmsr path somewhere.

Please, just make the existing event dtrt.
