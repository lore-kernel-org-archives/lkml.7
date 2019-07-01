Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D80C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223192089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NjYju7wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGACJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 22:09:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfGACJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 22:09:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so5727826pfe.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 19:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e+nV6SEqkVplGDMo9LBcx7XdOKfxU2ZqhQqt7J6g96Q=;
        b=NjYju7wWnz5EbtX6bH2cwVkIIRHS7lbzxZfh7c0+DzM4WFLUy3q4U3v7ygXkWlu0G8
         j+yUnGjvS8yOTsDEtWvh1hgo7nccEi17Z0FcYMnw1ECG6OV2heG95oSQ1fAIk2AqG70s
         BaPKPilgxjn8d44/6ju9p9Gc+GJD7Z5EfLtPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e+nV6SEqkVplGDMo9LBcx7XdOKfxU2ZqhQqt7J6g96Q=;
        b=NOQKrqnTtLXXKpntgdvWE9DN34LW/jRtI8CPn45bJvUTm1Ir7kcCMGjcNEIG6stoY8
         LJfAl1KfTqXG6DoBaP+e7NK27GQdTUPZM3sZ3/tbWV3ZG2E3+tkiYTDnZCN7gyIs4faz
         fDbfVmqutduDpTHHuMBAV88fqNk/L6d9YJACfB0TH0yfOyTQPGmVSF4Y/xw27KEn2CdC
         81zt/3GH7yNV8r3hnvS/A8pEravJH8Wuh6M+tRjaepuXqoq/Fpa+BaZsMS/NTahmdH80
         7IRGr4+RwX34hqVnUx5c72FFjVl+qgqaicF4+Eo0+KsOqMip1K+mdqbr/sN1P9sRN/59
         Nr/w==
X-Gm-Message-State: APjAAAUUbWAXLrPjfA71NZ0GFPEOmjrDa6rblgqhTpQgJ6EoKiw6d+JJ
        z6ts5+XtJ0r0Y+m7heNUneIBgQ==
X-Google-Smtp-Source: APXvYqxYLeG5CfuGOCStlY/xNilCvFjhIQ7lhtO95+sf9510YDBC+6t0zaEgRTmK90pnvc5lH6+yhg==
X-Received: by 2002:a63:4c0b:: with SMTP id z11mr22191190pga.440.1561946941135;
        Sun, 30 Jun 2019 19:09:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n5sm10469711pgd.26.2019.06.30.19.08.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 19:09:00 -0700 (PDT)
Date:   Sun, 30 Jun 2019 22:08:58 -0400
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
Message-ID: <20190701020858.GA47263@google.com>
References: <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <20190628164008.GB240964@google.com>
 <20190628164559.GC240964@google.com>
 <20190628173011.GX26519@linux.ibm.com>
 <20190628174545.pwgwi3wxl2eapkvm@linutronix.de>
 <20190628180727.GE240964@google.com>
 <20190628182045.ow4i5cncauk2jxjl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628182045.ow4i5cncauk2jxjl@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:20:45PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-06-28 14:07:27 [-0400], Joel Fernandes wrote:
> > On Fri, Jun 28, 2019 at 07:45:45PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-06-28 10:30:11 [-0700], Paul E. McKenney wrote:
> > > > > I believe the .blocked field remains set even though we are not any more in a
> > > > > reader section because of deferred processing of the blocked lists that you
> > > > > mentioned yesterday.
> > > > 
> > > > That can indeed happen.  However, in current -rcu, that would mean
> > > > that .deferred_qs is also set, which (if in_irq()) would prevent
> > > > the raise_softirq_irqsoff() from being invoked.  Which was why I was
> > > > asking the questions about whether in_irq() returns true within threaded
> > > > interrupts yesterday.  If it does, I need to find if there is some way
> > > > of determining whether rcu_read_unlock_special() is being called from
> > > > a threaded interrupt in order to suppress the call to raise_softirq()
> > > > in that case.
> > > 
> > > Please not that:
> > > | void irq_exit(void)
> > > | {
> > > |…
> > > in_irq() returns true
> > > |         preempt_count_sub(HARDIRQ_OFFSET);
> > > in_irq() returns false
> > > |         if (!in_interrupt() && local_softirq_pending())
> > > |                 invoke_softirq();
> > > 
> > > -> invoke_softirq() does
> > > |        if (!force_irqthreads) {
> > > |                 __do_softirq();
> > > |         } else {
> > > |                 wakeup_softirqd();
> > > |         }
> > > 
> > 
> > In my traces which I shared previous email, the wakeup_softirqd() gets
> > called.
> > 
> > I thought force_irqthreads value is decided at boot time, so I got lost a bit
> > with your comment.
> 
> It does. I just wanted point out that in this case
> rcu_unlock() / rcu_read_unlock_special() won't see in_irq() true.

Paul, Sebastian, This commit breaks kvm.sh for me on both my machines. I have
to revert it to make things work otherwise the test just runs for 10 seconds
or so and dies.

 "rcutorture: Tweak kvm options"
    This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438.

Any thoughts or debug ideas? I am running v4.19.37

thanks,

 - Joel

