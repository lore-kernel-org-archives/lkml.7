Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCFC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kgBPmYp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfF1SHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:07:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38464 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1SHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:07:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so2888322ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8ZhJI+lYgRUO8rdxMS+hjE1BURI/6fZ6/mpcmouJBCY=;
        b=kgBPmYp+EjP5VQsfkBrRFPURU53KhnyLBrDQXUV4iUMlO25Edc8cP0efyJyCrx4dnW
         AXcOe+bEVrHlbIXBP2Ul04vxmtLZGSkxVCnUubXtLSSmEN2rh2+nEGNMWI+Fd7V9zqRK
         oi8ExmuZ9LWNLrJwpltjC1Z49nXffdkvi+KW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8ZhJI+lYgRUO8rdxMS+hjE1BURI/6fZ6/mpcmouJBCY=;
        b=sBbo/sLy8CMEx126Oeo7hbh4iql7YtHts0eQE4Fon9EuUT8t8NSB5A2feODbYx7118
         PWD0bpGUa6InHcXbr8twgBDA93SQhVmD0e7tQqkj82ac08CamQlNAA5geTmKTKQ1e7fx
         +jJDnpW1lkWSmuIttQqzFKipbD7ow+JWJeRBPhYsw008YBPgFMbOkxKWaGClMykcce/8
         k0VslU5q4WU7rJagXUlEpGUiu1liNgFukgvY4o0GhGreGlGw3eef8d9TIRclsTRh/Osu
         V4MPVsvJLEdpmtnKcQFajkzKLx67+YKYiKUJmSKDq76jQ8eSw60wynaYR7Mv47cNomdQ
         FBpw==
X-Gm-Message-State: APjAAAWzj7cQuR26kCpbIV48Iw3rbKzZFSW8J3YnQfCe6HOznQnAHPmS
        pVB9uadwVXqzd1p+17yqfV9WkA==
X-Google-Smtp-Source: APXvYqz3rjeW8Whpvm3o8bP3fclk23APniYumJIl7rHCuaKTJRH5StXw3adl/naL/oOKyNjwoGnzHA==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr13325253plz.335.1561745249278;
        Fri, 28 Jun 2019 11:07:29 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n2sm2412561pgp.27.2019.06.28.11.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 11:07:28 -0700 (PDT)
Date:   Fri, 28 Jun 2019 14:07:27 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628180727.GE240964@google.com>
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:45:45PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-06-28 10:30:11 [-0700], Paul E. McKenney wrote:
> > > I believe the .blocked field remains set even though we are not any more in a
> > > reader section because of deferred processing of the blocked lists that you
> > > mentioned yesterday.
> > 
> > That can indeed happen.  However, in current -rcu, that would mean
> > that .deferred_qs is also set, which (if in_irq()) would prevent
> > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > asking the questions about whether in_irq() returns true within threaded
> > interrupts yesterday.  If it does, I need to find if there is some way
> > of determining whether rcu_read_unlock_special() is being called from
> > a threaded interrupt in order to suppress the call to raise_softirq()
> > in that case.
> 
> Please not that:
> | void irq_exit(void)
> | {
> |…
> in_irq() returns true
> |         preempt_count_sub(HARDIRQ_OFFSET);
> in_irq() returns false
> |         if (!in_interrupt() && local_softirq_pending())
> |                 invoke_softirq();
> 
> -> invoke_softirq() does
> |        if (!force_irqthreads) {
> |                 __do_softirq();
> |         } else {
> |                 wakeup_softirqd();
> |         }
> 

In my traces which I shared previous email, the wakeup_softirqd() gets
called.

I thought force_irqthreads value is decided at boot time, so I got lost a bit
with your comment.

