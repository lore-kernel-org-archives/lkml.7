Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA01C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569512084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r5EdQwev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfCYNgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:36:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32779 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCYNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:36:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so6464177pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tICvEDhSuRrukRLWcWuaC6wtOyBVrz3FZ+hoY0r8HM=;
        b=r5EdQwevVh3qfsn+a60TXbfe190La9Zc4b8XJzL8qN0+l5JyhPh4Iy8xznphMbZW2T
         1cA/l0JAeWPgu0A43ihvxEXigY0LnoWX37bEVTLosD+9/IF5yv1KVBr9Kf7r0TlsbAll
         IY1tqySSMvDE/x//VprqMszH76bQ/pGzaGvA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tICvEDhSuRrukRLWcWuaC6wtOyBVrz3FZ+hoY0r8HM=;
        b=OFpRcTNug7EJa2e8ssjMSjMQpHFyYPENO/mTgpVoI/vf4gvhRabRXwyUGjuTKTrvvx
         /A/8kaiAoIbsCVoxeFnEo+mJiSoBsY4IU4Ig5GOoex2ZTGuIn8IYBQ4GljVI6KFYDOoN
         0LppdcHkdct/nvbm3ar0tMo8zzw1+X0OHU87wEObRM05CoSVdWsDgBph408EOehBDOhu
         MD/fdhMI8+/9DCCJJeXM2dHLwGSCsyvFoSuwZR42HuNux7ARmHSV3m8xGF8wH/AFOoYU
         tJGfLBxXnUxwxv7VeX8/8eukJGuvyS3a7l6BEXWZ6V6zBgKdsgdQgJZEJ/DRls/4Yup/
         z7EQ==
X-Gm-Message-State: APjAAAWdSc6ftwEPLVlejHKy7snTifDG0aJn6OoEgwZeW08PIUiQLIu0
        gRWzTmlwFRVd47GVeI/EEucFDA==
X-Google-Smtp-Source: APXvYqx6Wk9Btrb5s4tdx+IGQV1O4/u1OC++zrL9mSX7HT2LQnAGdz3W+2VITeSi/ly5lGupQ7Tifg==
X-Received: by 2002:a17:902:7794:: with SMTP id o20mr26138484pll.28.1553521009159;
        Mon, 25 Mar 2019 06:36:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p34sm26138565pgb.18.2019.03.25.06.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:36:47 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:36:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        kernel-team@android.com, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 2/2] rcutree: Add checks for dynticks counters in
 rcu_is_cpu_rrupt_from_idle
Message-ID: <20190325133646.GA182885@google.com>
References: <20190323012939.15185-1-joel@joelfernandes.org>
 <20190323012939.15185-2-joel@joelfernandes.org>
 <20190323030251.GB136835@google.com>
 <20190324234351.GX4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324234351.GX4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 04:43:51PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 22, 2019 at 11:02:51PM -0400, Joel Fernandes wrote:
> > On Fri, Mar 22, 2019 at 09:29:39PM -0400, Joel Fernandes (Google) wrote:
> > > In the future we would like to combine the dynticks and dynticks_nesting
> > > counters thus leading to simplifying the code. At the moment we cannot
> > > do that due to concerns about usermode upcalls appearing to RCU as half
> > > of an interrupt. Byungchul tried to do it in [1] but the
> > > "half-interrupt" concern was raised. It is half because, what RCU
> > > expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
> > > exception happens. However, only rcu_irq_enter() is observed. This
> > > concern may not be valid anymore, but at least it used to be the case.
> > > 
> > > Out of abundance of caution, Paul added warnings [2] in the RCU code
> > > which if not fired by 2021 may allow us to assume that such
> > > half-interrupt scenario cannot happen any more, which can lead to
> > > simplification of this code.
> > > 
> > > Summary of the changes are the following:
> > > 
> > > (1) In preparation for this combination of counters in the future, we
> > > first need to first be sure that rcu_rrupt_from_idle cannot be called
> > > from anywhere but a hard-interrupt because previously, the comments
> > > suggested otherwise so let us be sure. We discussed this here [3]. We
> > > use the services of lockdep to accomplish this.
> > > 
> > > (2) Further rcu_rrupt_from_idle() is not explicit about how it is using
> > > the counters which can lead to weird future bugs. This patch therefore
> > > makes it more explicit about the specific counter values being tested
> > > 
> > > (3) Lastly, we check for counter underflows just to be sure these are
> > > not happening, because the previous code in rcu_rrupt_from_idle() was
> > > allowing the case where the counters can underflow, and the function
> > > would still return true. Now we are checking for specific values so let
> > > us be confident by additional checking, that such underflows don't
> > > happen. Any case, if they do, we should fix them and the screaming
> > > warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
> > > and PROVE_LOCKING are disabled.
> > > 
> > > [1] https://lore.kernel.org/patchwork/patch/952349/
> > > [2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
> > > [3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/
> > > 
> > > Cc: byungchul.park@lge.com
> > > Cc: kernel-team@android.com
> > > Cc: rcu@vger.kernel.org
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9180158756d2..d94c8ed29f6b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -381,16 +381,29 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
> > >  }
> > >  
> > >  /**
> > > - * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
> > > + * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> > >   *
> > > - * If the current CPU is idle or running at a first-level (not nested)
> > > + * If the current CPU is idle and running at a first-level (not nested)
> > >   * interrupt from idle, return true.  The caller must have at least
> > >   * disabled preemption.
> > >   */
> > >  static int rcu_is_cpu_rrupt_from_idle(void)
> > >  {
> > > -	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
> > > -	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
> > > +	/* Called only from within the scheduling-clock interrupt */
> > > +	lockdep_assert_in_irq();
> > > +
> > > +	/* Check for counter underflows */
> > > +	RCU_LOCKDEP_WARN(
> > > +		(__this_cpu_read(rcu_data.dynticks_nesting) < 0) &&
> > > +		(__this_cpu_read(rcu_data.dynticks_nmi_nesting) < 0),
> > 
> >  
> > This condition for the warning is supposed to be || instead of &&. Sorry.
> > 
> > Or, I will just use 2 RCU_LOCKDEP_WARN(s) here, that's better.
> 
> Also, the dynticks_nmi_nesting being zero is a bug given that we know
> we are in an interrupt handler, right?  Or am I off by one again?

You are right, we can do additional checking for making sure its never zero.
I refreshed the patch as below, does this look Ok?

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v2] rcutree: Add checks for dynticks counters in

In the future we would like to combine the dynticks and dynticks_nesting
counters thus leading to simplifying the code. At the moment we cannot
do that due to concerns about usermode upcalls appearing to RCU as half
of an interrupt. Byungchul tried to do it in [1] but the
"half-interrupt" concern was raised. It is half because, what RCU
expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
exception happens. However, only rcu_irq_enter() is observed. This
concern may not be valid anymore, but at least it used to be the case.

Out of abundance of caution, Paul added warnings [2] in the RCU code
which if not fired by 2021 may allow us to assume that such
half-interrupt scenario cannot happen any more, which can lead to
simplification of this code.

Summary of the changes are the following:

(1) In preparation for this combination of counters in the future, we
first need to first be sure that rcu_rrupt_from_idle cannot be called
from anywhere but a hard-interrupt because previously, the comments
suggested otherwise so let us be sure. We discussed this here [3]. We
use the services of lockdep to accomplish this.

(2) Further rcu_rrupt_from_idle() is not explicit about how it is using
the counters which can lead to weird future bugs. This patch therefore
makes it more explicit about the specific counter values being tested

(3) Lastly, we check for counter underflows just to be sure these are
not happening, because the previous code in rcu_rrupt_from_idle() was
allowing the case where the counters can underflow, and the function
would still return true. Now we are checking for specific values so let
us be confident by additional checking, that such underflows don't
happen. Any case, if they do, we should fix them and the screaming
warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
and PROVE_LOCKING are disabled.

[1] https://lore.kernel.org/patchwork/patch/952349/
[2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
[3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/

Cc: byungchul.park@lge.com
Cc: kernel-team@android.com
Cc: rcu@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158756d2..c2a56de098da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -381,16 +381,29 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
 }
 
 /**
- * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
+ * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
  *
- * If the current CPU is idle or running at a first-level (not nested)
+ * If the current CPU is idle and running at a first-level (not nested)
  * interrupt from idle, return true.  The caller must have at least
  * disabled preemption.
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
+	/* Called only from within the scheduling-clock interrupt */
+	lockdep_assert_in_irq();
+
+	/* Check for counter underflows */
+	RCU_LOCKDEP_WARN(_this_cpu_read(rcu_data.dynticks_nesting) < 0,
+			 "RCU dynticks_nesting counter underflow!");
+	RCU_LOCKDEP_WARN(_this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
+			 "RCU dynticks_nmi_nesting counter underflow/zero!");
+
+	/* Are we at first interrupt nesting level? */
+	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
+		return false;
+
+	/* Does CPU appear to be idle from an RCU standpoint? */
+	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
-- 
2.21.0.392.gf8f6787159e-goog

