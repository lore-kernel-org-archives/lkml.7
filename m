Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD44C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98DD2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575939432;
	bh=iPjEr7B9gAqvHsErdiiTwedj3hMuuF7A+iqX9c94az0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CXzAAoK3HKbmUBh8KiOUwn4z237mTZJiXvpvYGRtytz5EW0fVp91hlUqihwxiLR1F
	 3Tqte3v7wuNXIMdkYiALuOPFFbxiA0toomdkhAYjbpvR6CCLB/QtKROKaJpGhs7GjS
	 VGoUeZGYCAKWe///EP2D9Xslm6xOX2NvVEwDgv8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLJA5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfLJA5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:57:10 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648C42073D;
        Tue, 10 Dec 2019 00:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575939429;
        bh=iPjEr7B9gAqvHsErdiiTwedj3hMuuF7A+iqX9c94az0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uLPnX72ZzjOTmUAXkbw8Ll7iLlK4ad41c4HqB4u5W9+1fnAU+6P48Sea0mqTplyIV
         O+/mgqj6ojsAjYsRNekjsS3vNIcxUVrLPtl4RpkL8NPNW2Dv6WdRRtjtJKbAZX1I4r
         WXfaUkyIns5wfWP0zeW8XVCHwVvw56xhPExF7Xw0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EC44C3522769; Mon,  9 Dec 2019 16:57:08 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:57:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [rcu] ed93dfc6bc: stress-ng.icache.ops_per_sec -15.0% regression
Message-ID: <20191210005708.GQ2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191208152907.GH32275@shao2-debian>
 <20191208181342.GY2889@paulmck-ThinkPad-P72>
 <b17c031c-0dfc-ff7d-1b72-0307e947012c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b17c031c-0dfc-ff7d-1b72-0307e947012c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 05:10:11PM +0800, Rong Chen wrote:
> 
> 
> On 12/9/19 2:13 AM, Paul E. McKenney wrote:
> > On Sun, Dec 08, 2019 at 11:29:07PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -15.0% regression of stress-ng.icache.ops_per_sec due to commit:
> > > 
> > > 
> > > commit: ed93dfc6bc0084485ccad1ff6bd2ea81ab2c03cd ("rcu: Confine ->core_needs_qs accesses to the corresponding CPU")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: stress-ng
> > > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > > with following parameters:
> > > 
> > > 	nr_threads: 100%
> > > 	disk: 1HDD
> > > 	testtime: 1s
> > > 	class: cpu-cache
> > > 	cpufreq_governor: performance
> > > 	ucode: 0x500002c
> > > 
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > 
> > > 
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > To reproduce:
> > > 
> > >          git clone https://github.com/intel/lkp-tests.git
> > >          cd lkp-tests
> > >          bin/lkp install job.yaml  # job file is attached in this email
> > >          bin/lkp run     job.yaml
> > > 
> > > =========================================================================================
> > > class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
> > >    cpu-cache/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-11-14.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c
> > > 
> > > commit:
> > >    516e5ae0c9 ("rcu: Reset CPU hints when reporting a quiescent state")
> > >    ed93dfc6bc ("rcu: Confine ->core_needs_qs accesses to the corresponding CPU")
> > > 
> > > 516e5ae0c9401629 ed93dfc6bc0084485ccad1ff6bd
> > > ---------------- ---------------------------
> > >           %stddev     %change         %stddev
> > >               \          |                \
> > >       39049           -15.0%      33189 ± 14%  stress-ng.icache.ops_per_sec
> > I have to ask...
> > 
> > Given a 14% standard deviation, is this 15% change statistically
> > significant?
> > 
> > On the other hand, if this is due to lengthened grace periods, which
> > are a known side-effect of this commit, there are speedups for that
> > coming down the pike.
> 
> Hi Paul,
> 
> We run the test more times and stress-ng.icache.ops_per_sec is unstable:
> 
> 516e5ae0c9401629  ed93dfc6bc0084485ccad1ff6b
> ----------------  -------------------------- ---------------------------
>          %stddev      change         %stddev
>                    \              |                         \
>      37409 ±  6%        -4%      35958 ± 11%
> stress-ng/cpu-cache-performance-1HDD-100%-1s-ucode=0x500002c/lkp-csl-2sp5
> 
> 
> > 							Thanx, Paul
> > 
> > >        7784           -36.6%       4939 ±  9%  stress-ng.membarrier.ops
> > >        7648           -37.3%       4793 ±  9%  stress-ng.membarrier.ops_per_sec
> 
> there is still a regression of stress-ng.membarrier.ops_per_sec:
> 
> 
> 516e5ae0c9401629  ed93dfc6bc0084485ccad1ff6b
> ----------------  -------------------------- ---------------------------
>          %stddev      change         %stddev
>                    \              |                      \
>       7522               -37%       4744 ±  9%
> stress-ng/cpu-cache-performance-1HDD-100%-1s-ucode=0x500002c/lkp-csl-2sp5

OK, and it is much harder for me to argue that this one is statistically
insignificant.  From the softirq stats below, I got too aggressive about
removing instances of "rdp->core_needs_qs = false".  Does the (lightly
tested) commit below help?

							Thanx, Paul

------------------------------------------------------------------------

commit 57412364506cf5262a7fdffa4718bf39b8891940
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Dec 9 15:19:45 2019 -0800

    rcu: Clear ->core_needs_qs at GP end or self-reported QS
    
    The rcu_data structure's ->core_needs_qs field does not necessarily get
    cleared in a timely fashion after the corresponding CPUs' quiescent state
    has been reported.  From a functional viewpoint, no harm done, but this
    can result in excessive invocation of RCU core processing, as witnessed
    by the kernel test robot, which saw greatly increased softirq overhead.
    
    This commit therefore restores the rcu_report_qs_rdp() function's
    clearing of this field, but only when running on the corresponding CPU.
    Cases where some other CPU reports the quiescent state (for example, on
    behalf of an idle CPU) are handled by setting this field appropriately
    within the __note_gp_changes() function's end-of-grace-period checks.
    This handling is carried out regardless of whether the end of a grace
    period actually happened, thus handling the case where a CPU goes non-idle
    after a quiescent state is reported on its behalf, but before the grace
    period ends.  This fix also avoids cross-CPU updates to ->core_needs_qs,
    
    While in the area, this commit changes the __note_gp_changes() need_gp
    variable's name to need_qs because it is a quiescent state that is needed
    from the CPU in question.
    
    Fixes: ed93dfc6bc00 ("rcu: Confine ->core_needs_qs accesses to the corresponding CPU")
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f555ea9..1d0935e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1393,7 +1393,7 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
-	bool need_gp;
+	bool need_qs;
 	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 
@@ -1407,10 +1407,13 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
+		rdp->core_needs_qs = false;
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
+		if (rdp->core_needs_qs)
+			rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -1422,9 +1425,9 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * go looking for one.
 		 */
 		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
-		need_gp = !!(rnp->qsmask & rdp->grpmask);
-		rdp->cpu_no_qs.b.norm = need_gp;
-		rdp->core_needs_qs = need_gp;
+		need_qs = !!(rnp->qsmask & rdp->grpmask);
+		rdp->cpu_no_qs.b.norm = need_qs;
+		rdp->core_needs_qs = need_qs;
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
@@ -2000,6 +2003,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
+	if (rdp->cpu == smp_processor_id())
+		rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
