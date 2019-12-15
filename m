Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF4C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE9C2467B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576441009;
	bh=0xj0WQkDIWgvrFS7KGxz+D8oufmx/HpsmC8Q2WqCCJY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Pb/Cv64dgYi0f09oim1+HzWhNf95kksuM4X2M9uQPqzJ32Pna8p0OWb0NpebNLcL6
	 3TAI12D3SuHNdCvSfPnPtg6zKd/c1/qzBWB5zBrKCvegsPjCy1NAuQR6ksASAUotHS
	 rLzuLQBOpyCckuy0yJ30QOK/IBHaB7fK0kNQHZXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfLOUQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOUQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:16:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626A220700;
        Sun, 15 Dec 2019 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576441006;
        bh=0xj0WQkDIWgvrFS7KGxz+D8oufmx/HpsmC8Q2WqCCJY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fXnaZT1pyZ01sJnTU46T+81t7gSAIqEInUMUg4ZHdVqSuBsdR/61R6ZbXZsYye2fQ
         v//LeqKvKE3GYJuEWeK04CSCifw1NZFSE/egX1FEccYtz/4VqYxcc001ophak8Jmj0
         qD/4DLQa9/CNznzEAWh6CGJ0AF/wHP0SkomI4WX4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 31E26352274B; Sun, 15 Dec 2019 12:16:46 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:16:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, tj@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: fix an infinite loop in rcu_gp_cleanup()
Message-ID: <20191215201646.GK2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191215065242.7155-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215065242.7155-1-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 01:52:42AM -0500, Qian Cai wrote:
> The commit 82150cb53dcb ("rcu: React to callback overload by
> aggressively seeking quiescent states") introduced an infinite loop
> during boot here,
> 
> // Reset overload indication for CPUs no longer overloaded
> for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
> 	rdp = per_cpu_ptr(&rcu_data, cpu);
> 	check_cb_ovld_locked(rdp, rnp);
> }
> 
> because on an affected machine,
> 
> rnp->cbovldmask = 0
> rnp->grphi = 127
> rnp->grplo = 0

Your powerpc.config file from your first email shows:

	rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128

So this should be the root rcu_node structure (as opposed to one of the
eight leaf rcu_node structures, each of which should have the difference
between rnp->grphi and rnp->grplo equal to 15).  And RCU should not be
invoking for_each_leaf_node_cpu_mask() on this rcu_node structure.

> It ends up with "cpu" is always 64 and never be able to get out of the
> loop due to "cpu <= rnp->grphi". It is pointless to enter the loop when
> the cpumask is 0 as there is no CPU would be able to match it.
> 
> Fixes: 82150cb53dcb ("rcu: React to callback overload by aggressively seeking quiescent states")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/rcu/rcu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index ab504fbc76ca..fb691ec86df4 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -363,7 +363,7 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
>  	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
>  #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
>  	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
> -	     (cpu) <= rnp->grphi; \
> +	     (cpu) <= rnp->grphi && (mask); \
>  	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))

This change cannot be right, but has to be one of the better bug reports
I have ever received, so thank you very much, greatly appreciated!!!

So if I say the above change cannot be right, what change might work?

Again, it would certainly be a bug to invoke for_each_leaf_node_cpu_mask()
on anything but one of the leaf rcu_node structures, as you might guess
from the name.  And as noted above, your dump of the rcu_node fields
above looks like it is exactly that bug that happened.  So let's review
the uses of this macro:

kernel/rcu/tree.c:

o	rcu_gp_cleanup() invokes for_each_leaf_node_cpu_mask() within a
	srcu_for_each_node_breadth_first() loop, which includes non-leaf
	rcu_node structures.  This is a bug!  Please see patch below.

o	force_qs_rnp() is OK because for_each_leaf_node_cpu_mask() is
	invoked within a rcu_for_each_leaf_node() loop.

kernel/rcu/tree_exp.h:

o	rcu_report_exp_cpu_mult() invokes it on whatever rcu_node structure
	was passed in:

	o	sync_rcu_exp_select_node_cpus() also relies on its
		caller (via workqueues) to do the right thing.

		o	sync_rcu_exp_select_cpus() invokes
			sync_rcu_exp_select_node_cpus() from within a
			rcu_for_each_leaf_node() loop, so is OK.

		o	sync_rcu_exp_select_cpus() also invokes
			sync_rcu_exp_select_node_cpus() indirectly
			via workqueues, but also from within the same
			rcu_for_each_leaf_node() loop, so is OK.

	o	rcu_report_exp_rdp() invokes rcu_report_exp_cpu_mult()
		on the rcu_node structure corresponding to some
		specific CPU, which will always be a leaf rcu_node
		structure.

Again, thank you very much for your testing and debugging efforts!
I have queued the three (almost untested) patches below, the first of
which I will fold into the buggy "rcu: React to callback overload by
aggressively seeking quiescent states" patch, the second of which I will
apply to prevent future bugs of this sort, even when running on small
systems, and the third of which will allow me to easily run rcutorture
tests on the larger systems that I have recently gained easy access to.

And the big question...  Does the first patch clear up your hangs?  ;-)
Either way, please let me know!

							Thanx, Paul

------------------------------------------------------------------------

commit e8d6182b015bdd8221164477f4ab1c307bd2fbe9
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Dec 15 10:59:06 2019 -0800

    squash! rcu: React to callback overload by aggressively seeking quiescent states
    
    [ paulmck: Fix bug located by Qian Cai. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1d0935e..48fba22 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1760,10 +1760,11 @@ static void rcu_gp_cleanup(void)
 		/* smp_mb() provided by prior unlock-lock pair. */
 		needgp = rcu_future_gp_cleanup(rnp) || needgp;
 		// Reset overload indication for CPUs no longer overloaded
-		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
-			rdp = per_cpu_ptr(&rcu_data, cpu);
-			check_cb_ovld_locked(rdp, rnp);
-		}
+		if (rcu_is_leaf_node(rnp))
+			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				check_cb_ovld_locked(rdp, rnp);
+			}
 		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);

------------------------------------------------------------------------

commit 793de75e086a51464e31d74746d4804816541d6b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Dec 15 11:38:57 2019 -0800

    rcu: Warn on for_each_leaf_node_cpu_mask() from non-leaf
    
    The for_each_leaf_node_cpu_mask() and for_each_leaf_node_possible_cpu()
    macros must be invoked only on leaf rcu_node structures.  Failing to
    abide by this restriction can result in infinite loops on systems with
    more than 64 CPUs (or for more than 32 CPUs on 32-bit systems).  This
    commit therefore adds WARN_ON_ONCE() calls to make misuse of these two
    macros easier to debug.
    
    Reported-by: Qian Cai <cai@lca.pw>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 1779cbf..00ddc92 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -342,7 +342,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * Iterate over all possible CPUs in a leaf RCU node.
  */
 #define for_each_leaf_node_possible_cpu(rnp, cpu) \
-	for ((cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = cpumask_next((rnp)->grplo - 1, cpu_possible_mask); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = cpumask_next((cpu), cpu_possible_mask))
 
@@ -352,7 +353,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 #define rcu_find_next_bit(rnp, cpu, mask) \
 	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
 #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
-	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
+	for (WARN_ON_ONCE(!rcu_is_leaf_node(rnp)), \
+	     (cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
 	     (cpu) <= rnp->grphi; \
 	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))
 
------------------------------------------------------------------------

commit 6ce2513f745a7b3d5f0a2ae20d1b7fedcf918a3b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Dec 15 12:11:56 2019 -0800

    rcutorture: Add 100-CPU configuration
    
    The small-system rcutorture configurations have served us well for a great
    many years, but it is now time to add a larger one.  This commit does
    just that, but does not add it to the defaults in CFLIST.  This allows
    the kvm.sh argument '--configs "4*CFLIST TREE10" to run four instances
    of each of the default configurations concurrently with one instance of
    the large configuration.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
new file mode 100644
index 0000000..2debe78
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=100
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TREE_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_TRACE=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_OBJECTS=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=n
