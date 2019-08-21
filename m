Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650AFC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1722DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SHY3DgKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfHUPrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:47:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:47:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so1664064pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOBbJN45iHqXxR/gBNdoNYAgJ/CyoBS8RIPcRADxDEc=;
        b=SHY3DgKe0mDIhYCW9/diYH6Zz7SEbIzzmMOuRcjtV96jN+8od32WphPqg5LntC/+s7
         0GFp3LWmE0Qtee3TVs8xMMbyOmy0abnPc3haPeDN/xyEcsYXXxBkn07wP8G9kMjcjAv+
         4f5R1OOw1m858fU2AyC3d6IOy1f6HY2BBuLew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOBbJN45iHqXxR/gBNdoNYAgJ/CyoBS8RIPcRADxDEc=;
        b=Un5vQgu5t0z+fx0zEg0co5CxptqJ5slG2fAJziJFYMrI+it4QjxKcLdu1E1wJi3sB5
         3qfbPbEIA+dRPkZcnYAV1wIMYg9+NmCM+IM+A+A8331rhF/JXUkllwif101pm3gohSk5
         mW9BwhIBJh4W0vI5YclM8j4x/53N0JmSEonLYl8Jg1Q/5UApAO8wfY+nnXPTaIiMvFi/
         sckx1FNY5lxqhw/qUUvQk4TWkhYWuT3uvE42sE/jOIQL4maMUUiLhpsSougYGShWQMXG
         O5KZ+IvZ3NGLMX8rAqTZ4iTNrgqn1ygMGv0k36uYFyFDEcO9dwKIrjVgTLd2VTROQOmR
         evXA==
X-Gm-Message-State: APjAAAXQ09u8Ipf7aasb9eMPFoR5AkIAdrWsF3+/exGr5p2NBQPtI5lR
        qv+ui1DBgXyXGpOPJuFBa2KPmA==
X-Google-Smtp-Source: APXvYqxlI5e54u4V29MJ9RkgxyicZq5p6A26lSLTKMa0sCmB1Dx6uM4T4G1YwhdbTSX2NvMZUYEkYA==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr656457pjs.88.1566402423641;
        Wed, 21 Aug 2019 08:47:03 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v15sm25179030pfn.69.2019.08.21.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 08:47:02 -0700 (PDT)
Date:   Wed, 21 Aug 2019 11:46:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190821154646.GG147977@google.com>
References: <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
 <20190819143314.GT28441@linux.ibm.com>
 <20190819154143.GA18470@linux.ibm.com>
 <20190821143841.GC147977@google.com>
 <20190821145617.GD147977@google.com>
 <20190821153957.GG28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821153957.GG28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:39:57AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 10:56:17AM -0400, Joel Fernandes wrote:
[snip]
> > I think one reason could be, in_irq() is false when the timer callback
> > executes, since the timer callback is executing after a grace-period. The
> > stack is as follows:
> > 
> > Any reason why we cannot both test for call_rcu() and execute the RCU
> > callback from the timer hardirq handler?
> > 
> > In fact, I guess on use_nosoftirq systems, the callback will not even run
> > in softirq context.
> > 
> > [   20.553361]  => rcu_torture_timer_cb
> > [   20.553361]  => rcu_do_batch
> > [   20.553361]  => rcu_core
> > [   20.553361]  => __do_softirq
> > [   20.553361]  => do_softirq_own_stack
> > [   20.553361]  => do_softirq.part.16
> > [   20.553361]  => __local_bh_enable_ip
> > [   20.553361]  => rcutorture_one_extend
> > [   20.553361]  => rcu_torture_one_read
> > [   20.553361]  => rcu_torture_reader
> > [   20.553361]  => kthread
> > [   20.553361]  => ret_from_fork
> 
> Well, it is rcu_read_lock() and rcu_read_unlock() that matters

True!

> for this case rather than the callback.  But yes, given in_irq(),
> rcu_read_lock() and rcu_read_unlock() would need to have executed
> from a hardware interrupt handler.  And would need to get one of the
> ->rcu_read_lock_special bits set somehow.
> 
> But you can use smp_call_function() to invoke a function that runs in
> hardware interrupt handler context, and you can do this within either
> rcuperf or rcutorture.
> 
> And yes, this line of reasoning did inform at least some of my skepticism
> surrounding your initial patch, in case you were wondering about some
> of my earlier questions.  ;-)

Sounds great, I will try to modify the tests to trigger this case and also
look into your other questions. Thanks!!

 - Joel

