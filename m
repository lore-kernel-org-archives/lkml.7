Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A8BC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E38024679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576775645;
	bh=uAMMjNIlagJKp+x3jQrVT66BTGLAiz2Mgu5j/5XkSHM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LUSYSn/47pg2LywoXMGQbtM7IdEWnd9trTInHfdtGEKsM1J3+CqeZkZsOIMKP9bu3
	 9ovThiDlwUhKugeve9DEh1zda65n9J+h7DXDrc/pTbZ36mDH7kDrNU7l6sFbb88DtA
	 ur0bX1MLRQcBVnQzcvv0pn8H1I4dofHVK8O04XSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSROE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:14:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA032053B;
        Thu, 19 Dec 2019 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576775642;
        bh=uAMMjNIlagJKp+x3jQrVT66BTGLAiz2Mgu5j/5XkSHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hbXyrMl4mejHGkmb/S1AztF+nWkpnnsjo+19Se6c0cMPkpz/xRmYIFV3hMhzqLYzQ
         7xzNyjm5G5yTwsH6IxgZ7/VdjDEkvWJndfxksjYfeJNUFb7W4CTQyUzVMehBVF0L57
         Yqpbd563U8t8jKwsXU19WlDT538qxhOD1CaE3H9A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58BF9352274B; Thu, 19 Dec 2019 09:14:02 -0800 (PST)
Date:   Thu, 19 Dec 2019 09:14:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20191219171402.GB2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191219162242.128282-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219162242.128282-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:22:42AM -0500, Joel Fernandes (Google) wrote:
> During changes to kfree_rcu() code, we often check how much is free
> memory. Instead of doing so manually, add a measurement in the test
> itself. We measure 4 times during the test for available memory and
> compare with the beginning.
> 
> A sample run shows something like:
> 
> Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Does the following make sense for the commit log?

------------------------------------------------------------------------

During changes to kfree_rcu() code, we often check the amount of free
memory.  As an alternative to checking this manually, this commit adds a
measurement in the test itself.  It measures four times during the test
for available memory, digitally filters these measurements to produce a
running average with a weight of 0.5, and compares this digitally filtered
value with the amount of available memory at the beginning of the test.

Something like the following is printed at the end of the run:

Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB

------------------------------------------------------------------------

And some questions below.  I have queued this for testing and further
review with the commit log above in the meantime.

							Thanx, Paul

> ---
> v1->v2 : Minor corrections
> 
> Cc: bristot@redhat.com
> Cc: frextrite@gmail.com
> Cc: madhuparnabhowmik04@gmail.com
> Cc: urezki@gmail.com
> 
>  kernel/rcu/rcuperf.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index da94b89cd531..91f0650914cc 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/err.h>
> @@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
>  	long me = (long)arg;
>  	struct kfree_obj *alloc_ptr;
>  	u64 start_time, end_time;
> +	long mem_begin, mem_during = 0;
>  
>  	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> @@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
>  	}
>  
>  	do {
> +		if (!mem_during) {
> +			mem_during = mem_begin = si_mem_available();

So we sample at the beginning of the test before we have either allocated
or freed.  Or did I miss a beginning-of-test allocation somehow?

> +		} else if (loop % (kfree_loops / 4) == 0) {
> +			mem_during = (mem_during + si_mem_available()) / 2;

This is the digital-filter step.  The truncating nature of integer
division could actually get us four samples counting the first one if
kfree_loops evenly divides by four, or five otherwise, correct?  In the
latter case, we would have a measurement near the end of the test,
but not exactly at the end of the test, right?

And I have to ask, having studied control systems back in the day...

Why digitally filter by 0.5 as opposed to any other choice?  For
example, you could weight recent history more heavily:

			mem_during = (mem_during + 3 * si_mem_available()) / 4;

Or vice versa:

			mem_during = (3 * mem_during + si_mem_available()) / 4;

So why the specific choice of 0.5?

Oh, and integer overflow is a problem on 32-bit platforms with more
than 2GB of memory, for example x86 or ARM physical-address-extension
(PAE) systems.  I therefore changed the declarations to "long long"
(and adjusted the format accordingly), but please let me know if I am
missing some other effect that prevents overflow.

This does not address the possible problem of 64-bit systems that really
have 64 bits worth of physical memory, but I am happy to leave that one
for the time being, to be fixed if and when.  ;-)

Adjusted patch shown below.  Please let me know if I have messed anything
up, and if there is nothing obviously wrong, please give it a good testing.

> +		}
> +
>  		for (i = 0; i < kfree_alloc_num; i++) {
>  			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
> @@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
>  		else
>  			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
>  
> -		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
> +		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %ldMB\n",
>  		       (unsigned long long)(end_time - start_time), kfree_loops,
> -		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
> +		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
> +		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
> +
>  		if (shutdown) {
>  			smp_mb(); /* Assign before wake. */
>  			wake_up(&shutdown_wq);
> -- 
> 2.24.1.735.g03f4e72817-goog

------------------------------------------------------------------------

commit 8bf389d441538030d07a9a0f9e38ec0843f7a83e
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Thu Dec 19 11:22:42 2019 -0500

    rcuperf: Measure memory footprint during kfree_rcu() test
    
    During changes to kfree_rcu() code, we often check the amount of free
    memory.  As an alternative to checking this manually, this commit adds a
    measurement in the test itself.  It measures four times during the test
    for available memory, digitally filters these measurements to produce a
    running average with a weight of 0.5, and compares this digitally filtered
    value with the amount of available memory at the beginning of the test.
    
    Something like the following is printed at the end of the run:
    
    Total time taken by all kfree'ers: 6369738407 ns, loops: 10000, batches: 764, memory footprint: 216MB
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89..a4a8d09 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/err.h>
@@ -611,6 +612,7 @@ kfree_perf_thread(void *arg)
 	long me = (long)arg;
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
+	long long mem_begin, mem_during = 0;
 
 	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
@@ -626,6 +628,12 @@ kfree_perf_thread(void *arg)
 	}
 
 	do {
+		if (!mem_during) {
+			mem_during = mem_begin = si_mem_available();
+		} else if (loop % (kfree_loops / 4) == 0) {
+			mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
 		for (i = 0; i < kfree_alloc_num; i++) {
 			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
@@ -645,9 +653,11 @@ kfree_perf_thread(void *arg)
 		else
 			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
 
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld\n",
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started));
+		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
 		if (shutdown) {
 			smp_mb(); /* Assign before wake. */
 			wake_up(&shutdown_wq);
