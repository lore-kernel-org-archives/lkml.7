Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD6C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4862D21852
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mobHKqeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfHRWct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:32:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40234 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:32:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so5974373pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+t62dzDoveuxlx7LxDUcktLsRGM2iYfF3y6zujhsKQ=;
        b=mobHKqeQZ2IuRcoEghaxJf1kWA69qE6pHAcUyv1u0a0q7Vp5hKy+vieAlcjFX3YBHt
         UIqketDAiZh/OCibAfbq4ddI8TEEuGpTAZ5qX0gLl17O5voHpT1Xcd4kmlMukAASf4E+
         0AX4elQRRUxqB79QgfYkE9rYYibJ8vqQzVHhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+t62dzDoveuxlx7LxDUcktLsRGM2iYfF3y6zujhsKQ=;
        b=dFL1O01sTX5xZ7dRnFC+lZwpqm0v5bwW3xbbhmrlF1vK0jCp1i8pAO4YWr8xqQLWbC
         bgjsD8O1mqgN5A2Md0gwRD5hvcCsmOV2fqS9zPX1A01+YqScoFjmhD9yjPdIiJhZNETj
         hd60Gs9LR5Olw6172xn8GZMtZWUcCh0ep/cE26SbGXvdhYmKskMic8xrEwXz7RwrGtT4
         k5Imf6VDd+uZdKnWw4GKd0cLpQK2SirPRM52fp/1P8iHParAyYwZui4p+ZzUmXhv2Hsn
         8Q5cP3i1eKljXNS/u+JZ4PG3HT5t9Z0sjgFPcRwmdQtDLQII9eYXJNFOLr/UuwN9cjlS
         6eKw==
X-Gm-Message-State: APjAAAUuT8wq4leblSdfkIVperqG8qyAMT/Jf02kAY8YNrPzmYNeg8Yq
        PZFvL3U21XM4lM+T3Qwyzrv++Q==
X-Google-Smtp-Source: APXvYqzGIszjAJUSsQYnHE2gryQTajErvu2ajQPUWFyo5lqT1YNOmiEN4sR43L/pe1Boqq298b+8oA==
X-Received: by 2002:a17:90a:f:: with SMTP id 15mr17863798pja.93.1566167567869;
        Sun, 18 Aug 2019 15:32:47 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id a26sm13166894pff.174.2019.08.18.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 15:32:47 -0700 (PDT)
Date:   Sun, 18 Aug 2019 18:32:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190818223230.GA143857@google.com>
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818221210.GP28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > threads when the !use_softirq parameter is passed.  This is safe
> > to do so because:
> > 
> > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > conditions in rcu_read_unlock_special()") by checking for the same in
> > this patch.
> > 
> > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > not do any wake ups.
> > 
> > The rcuc thread which is awakened will run when the interrupt returns.
> > 
> > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > if expedited") thus doing the rcuc awakening only when none of the
> > following are true:
> >   1. Critical section is blocking an expedited GP.
> >   2. A nohz_full CPU.
> > If neither of these cases are true (exp == false), then the "else" block
> > will run to do the irq_work stuff.
> > 
> > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > check added.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> is it not safe to do raise_softirq()?

Because raise_softirq should not be done and/or doesn't do anything
if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
use_softirq == false. The "else if" condition of this patch uses for
use_softirq.

Or, did I miss your point?

> And from the nit department, looks like some whitespace damage on the
> comments.

I will fix all of these in the change log, it was just a quick RFC I sent
with the idea, tagged as RFC and not yet for merging. I should also remove
the comment about " in_irq() implies in_interrupt() which implies raising
softirq" from the changelog since this patch is only concerned with the rcuc
kthread.

thanks!

- Joel


> 							Thanx, Paul
> 
> > ---
> > v1->v2: Some minor character encoding issues in changelog corrected.
> > 
> > Note that I am still testing this patch, but I sent an early RFC for your
> > feedback. Thanks!
> > 
> >  kernel/rcu/tree_plugin.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 2defc7fe74c3..f4b3055026dc 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -621,6 +621,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  			// Using softirq, safe to awaken, and we get
> >  			// no help from enabling irqs, unlike bh/preempt.
> >  			raise_softirq_irqoff(RCU_SOFTIRQ);
> > +		} else if (exp && in_irq() && !use_softirq &&
> > +			   !t->rcu_read_unlock_special.b.deferred_qs) {
> > +			// Safe to awaken rcuc kthread which will be
> > +                       // scheduled in from the interrupt return path.
> > +			invoke_rcu_core();
> >  		} else {
> >  			// Enabling BH or preempt does reschedule, so...
> >  			// Also if no expediting or NO_HZ_FULL, slow is OK.
> > -- 
> > 2.23.0.rc1.153.gdeed80330f-goog
> > 
> 
