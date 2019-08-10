Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88328C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E72C21743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 02:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FnLYxeje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHJCmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 22:42:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfHJCmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 22:42:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so42998297pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 19:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cN2BKNTTIR5ZUApm11Gd7dsomDl+MPoDIlmutBIQJJk=;
        b=FnLYxejejnrWFaItaSxb0+ngXX4ZbpnHXTXj+7RB/Vtn3fpX1nNU1evZ7FtcGCdho9
         vvG2OEGHLN5EXJ7gZW5J4tDJXRXO7VuQSIsDZ7Z8EkfiK1Y6b0W2d/XYpytnFhGyQGvE
         a5FuWf7x49CujHt4wRzi7Z6GhMrIJiULe1cao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cN2BKNTTIR5ZUApm11Gd7dsomDl+MPoDIlmutBIQJJk=;
        b=rmB0lcenC6BA5qfopOGxm+vPussa/fOzUE6vnTyAfczxF1p60x0xME3QOZimyjbASt
         nu1O/L96/qzIvqQroItVtg9PSjgw4G1HdPFTULh8u8erikysam/VAuNo73FLvp/+zU67
         9YeorOweGwtRI8yu2pddQTEckssr/fqBWHJk2N5c/7zM1WIgrXgopuvxj24XRiRw6D3V
         CWJglw6abEgYTi2nc0VeSDv+2BA0bOLzTW/p6bHDphpvmsmbvsQqJV5AXwinInxZw9zU
         y5ZP4afVWyV92b7/WbZHCrfMOf67aJkeYk1YYO0FNvspkEExU6K4q506/oObmWyeE5HV
         IN1w==
X-Gm-Message-State: APjAAAV3rtL+/LjHRNKDHJEzLg2xodfDlvP1S9yIQqnEGnlfQ5ka5kSJ
        1U5E+csny+gVds3T5jmQT0rm3g==
X-Google-Smtp-Source: APXvYqzUdjhImPr/fW5noawGuY8xMGnEMaPX12PCHh/IgnS5p2p/4oJe1+O3Nl7BXOSsYDA0h70Hxw==
X-Received: by 2002:a62:e815:: with SMTP id c21mr25760214pfi.244.1565404955863;
        Fri, 09 Aug 2019 19:42:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d14sm118496455pfo.154.2019.08.09.19.42.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 19:42:34 -0700 (PDT)
Date:   Fri, 9 Aug 2019 22:42:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190810024232.GA183658@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807175215.GE28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
[snip] 
> > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > >  {
> > > >  	int cpu;
> > > >  
> > > > +	kfree_rcu_batch_init();
> > > 
> > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > like it should work, but have you tested it?
> > > 
> > > >  	rcu_early_boot_tests();
> > > 
> > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > call to kfree_rcu_batch_init() here.
> > 
> > I have not tried to do the kfree_rcu() this early. I will try it out.
> 
> Yeah, well, call_rcu() this early came as a surprise to me back in the
> day, so...  ;-)

I actually did get surprised as well!

It appears the timers are not fully initialized so the really early
kfree_rcu() call from rcu_init() does cause a splat about an initialized
timer spinlock (even though future kfree_rcu()s and the system are working
fine all the way into the torture tests).

I think to resolve this, we can just not do batching until early_initcall,
during which I have an initialization function which switches batching on.
From that point it is safe.

Below is the diff on top of this patch, I think this should be good but let
me know if anything looks odd to you. I tested it and it works.

have a great weekend! thanks,
-Joel

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a09ef81a1a4f..358f5c065fa4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2634,6 +2634,7 @@ struct kfree_rcu_cpu {
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+int kfree_rcu_batching_ready;
 
 /*
  * This function is invoked in workqueue context after a grace period.
@@ -2742,6 +2743,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+/*
+ * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
+ * Used only by rcuperf torture test for comparison with kfree_rcu_batch()
+ * or during really early init.
+ */
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
+{
+	__call_rcu(head, func, -1, 1);
+}
+EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
+
 /*
  * Queue a request for lazy invocation of kfree() after a grace period.
  *
@@ -2764,6 +2775,10 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 	bool monitor_todo;
+	static int once;
+
+	if (!READ_ONCE(kfree_rcu_batching_ready))
+		return kfree_call_rcu_nobatch(head, func);
 
 	local_irq_save(flags);
 	krcp = this_cpu_ptr(&krc);
@@ -2794,16 +2809,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-/*
- * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
- * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
- */
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func, -1, 1);
-}
-EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
-
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPT.
@@ -3650,17 +3655,6 @@ static void __init rcu_dump_rcu_node_tree(void)
 	pr_cont("\n");
 }
 
-void kfree_rcu_batch_init(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		spin_lock_init(&krcp->lock);
-		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-	}
-}
-
 struct workqueue_struct *rcu_gp_wq;
 struct workqueue_struct *rcu_par_gp_wq;
 
@@ -3668,8 +3662,6 @@ void __init rcu_init(void)
 {
 	int cpu;
 
-	kfree_rcu_batch_init();
-
 	rcu_early_boot_tests();
 
 	rcu_bootup_announce();
@@ -3700,6 +3692,21 @@ void __init rcu_init(void)
 	srcu_init();
 }
 
+static int __init kfree_rcu_batch_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		spin_lock_init(&krcp->lock);
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+	}
+
+	WRITE_ONCE(kfree_rcu_batching_ready, 1);
+	return 0;
+}
+early_initcall(kfree_rcu_batch_init);
+
 #include "tree_stall.h"
 #include "tree_exp.h"
 #include "tree_plugin.h"
