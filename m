Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29999C32751
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE820880
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 02:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s7M110bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHKC1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 22:27:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43156 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfHKC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 22:27:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so244883pfn.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSdzyR3+jYPF/gjOoTrNU8w81mqUq5doextlSL/xXQ4=;
        b=s7M110bxdXziQG6liQpM/xp6bqiW8h9v45zpZw5HEmfR/k1v4bsiREzdcS2T5WUeXb
         aeEnhuMIBpEMM+8nw0JIVpnmZFeBmyB70tIguxc4Va4t55IhIm+MLdiCHwXkm1nfmrZ1
         bhTA+8SSS4ODDqq8aSie+HE+jp17gN5F96iAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSdzyR3+jYPF/gjOoTrNU8w81mqUq5doextlSL/xXQ4=;
        b=A/wS95aaxCYi0x2gVwPC5myJM6Ff6GSiTOkIATIeCF4ymi+wMmRNbntefKkLyCAxpg
         MUS/z2crEE7xHCSDNVEYlAbCa67CN6nnF660TbCO02njBQWKVMf9IEwmFEXvp9RCLYwj
         1YCYbK/QMP55hPjUjxYAjoFVs16B6Rd9V96ZKWNuIfdZ+BuEO9xTic3iFz1IZ47nYSND
         Ye6HW+YL0ngTIShIj0dvzySaDswU0lGmIO4wBSTmEXm0ftCPH8ozmPLWk39K3mgz6zOf
         3OjqUtCwtM7MzkXMwJeSlH7k/tzrkmj4PE5PqhmcLklJDD3SMeX9+FTG/FO/Fhrm6S/b
         7fKg==
X-Gm-Message-State: APjAAAVXUR6vzWowTcOK9tFYn/6aSmAuNiZvoHEXCNiLzwPekPiF8ShT
        4iL6YDnTJHlJajQO0lS2F3xvkJgoObE=
X-Google-Smtp-Source: APXvYqzC/mcnzr4WKGyOHvssnZpmX5fEBua0B7RkotLurKRAGOH8XY5yucbXkdQbIh/f2j9+JC/mrw==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr17482911pjq.32.1565490421214;
        Sat, 10 Aug 2019 19:27:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o32sm9183003pje.9.2019.08.10.19.26.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 19:27:00 -0700 (PDT)
Date:   Sat, 10 Aug 2019 22:26:58 -0400
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
Message-ID: <20190811022658.GA177703@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
 <20190810042037.GA175783@google.com>
 <20190810182446.GT28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810182446.GT28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 11:24:46AM -0700, Paul E. McKenney wrote:
> On Sat, Aug 10, 2019 at 12:20:37AM -0400, Joel Fernandes wrote:
> > On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > [snip] 
> > > > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > > > >  {
> > > > > > > >  	int cpu;
> > > > > > > >  
> > > > > > > > +	kfree_rcu_batch_init();
> > > > > > > 
> > > > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > > > like it should work, but have you tested it?
> > > > > > > 
> > > > > > > >  	rcu_early_boot_tests();
> > > > > > > 
> > > > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > > > call to kfree_rcu_batch_init() here.
> > > > > > 
> > > > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > > > 
> > > > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > > > day, so...  ;-)
> > > > 
> > > > I actually did get surprised as well!
> > > > 
> > > > It appears the timers are not fully initialized so the really early
> > > > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > > > timer spinlock (even though future kfree_rcu()s and the system are working
> > > > fine all the way into the torture tests).
> > > > 
> > > > I think to resolve this, we can just not do batching until early_initcall,
> > > > during which I have an initialization function which switches batching on.
> > > > >From that point it is safe.
> > > 
> > > Just go ahead and batch, but don't bother with the timer until
> > > after single-threaded boot is done.  For example, you could check
> > > rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> > > (See kernel/rcu/tree_exp.h.)
> > 
> > Cool, that works nicely and I tested it. Actually I made it such that we
> > don't need to batch even, before the scheduler is up. I don't see any benefit
> > of that unless we can see a kfree_rcu() flood happening that early at boot
> > which seems highly doubtful as a real world case.
> 
> The benefit is removing the kfree_rcu() special cases from the innards
> of RCU, for example, in rcu_do_batch().  Another benefit is removing the
> current restriction on the position of the rcu_head structure within the
> enclosing data structure.
> 
> So it would be good to avoid the current kfree_rcu() special casing within
> RCU itself.
> 
> Or are you using some trick that avoids both the batching and the current
> kfree_rcu() special casing?

Oh. I see what you mean. Would it be Ok with you to have that be a follow up
patch?  I am not getting rid (yet) of the special casing in rcu_do_batch in
this patch, but can do that in another patch.

For now I am just doing something like the following in kfree_call_rcu(). I
was almost about to hit send on the v1 and I have been testing this a lot so
I'll post it anyway; and we can discuss more about this point on that.

+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+       unsigned long flags;
+       struct kfree_rcu_cpu *krcp;
+       bool monitor_todo;
+
+       /* kfree_call_rcu() batching requires timers to be up. If the scheduler
+        * is not yet up, just skip batching and do non-batched kfree_call_rcu().
+        */
+       if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
+               return kfree_call_rcu_nobatch(head, func);
+

thanks,

 - Joel

