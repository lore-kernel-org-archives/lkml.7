Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF2C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885D20656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EovcUH63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0Pmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:42:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33484 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0Pmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:42:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id y17so1923192lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdgaUYT2PaAKZsPsTmWsJv5fjayE9ehNV1SbDkzjewA=;
        b=EovcUH634m6WUf69St5UAzSvsrpd5u/ghfbOaLlVWaDekoh12bRgmDTX959HEC+u9Z
         /r80EGYTHU4SJWk0AosG7kfKYQW26oRj335YeGD476/k/tN5EHX5BsSTO8ob7Jl5hWDX
         Psqz8iXxB9d3pt0BZqZtyIGFIxcLhOVtxsqx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdgaUYT2PaAKZsPsTmWsJv5fjayE9ehNV1SbDkzjewA=;
        b=W2K8QXKDoNi+bBo4sEX3xDYlsYaod1/WqemHcI8tc3Ge65FygyTeQcJgN8LKYZq3o/
         B3ud2cvpQ6ltvaqO+21lHi3uJvjYjSenelPUqD1Q92ormS3AAAffJ1O0MR85HYJ8tZOZ
         gYGs8/RIiKjcXBFLKBwgr7YJxQ2CnJ2Lj4onu0C3RMJ7D/9nUOc4VxwkC/jElH/1Q7gj
         9KzN4TZD+R4v7aDNJHGvWtndt1On42XmZGqYsBon6JhcowqakXdpEMe7P02WWzS33fEl
         yo/DXuPdDig9CCW769pz9hkyuP5pqftjKOz8nURRXKTIQvWipfQRwEQeKMNYTph5ViDH
         C9YA==
X-Gm-Message-State: APjAAAUmvtRbrJKSsu+bxq064oJM7A7japFqy28638GvfU3vDw/NFOJg
        1RVelEOKqyukXEZaWxeeF0+xAVijInwYm2xjSt5UiQ==
X-Google-Smtp-Source: APXvYqz8Ya261fforiM9i5nm3BHn+klzpDbAH0n2lKlRCRQYmgV4/4JWiB8Gw5jFTVHIVOXFvr/SzSHV9FTjZJ3EzLg=
X-Received: by 2002:a19:7912:: with SMTP id u18mr2159784lfc.81.1561650150827;
 Thu, 27 Jun 2019 08:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com> <20190627154011.vbje64x6auaknhx4@linutronix.de>
In-Reply-To: <20190627154011.vbje64x6auaknhx4@linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 11:42:19 -0400
Message-ID: <CAEXW_YR6=3mxcoSW7hq3GxAE6LKP5-N5bV0iQf43gujSatVs3g@mail.gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > Sebastian it would be nice if possible to trace where the
> > t->rcu_read_unlock_special is set for this scenario of calling
> > rcu_read_unlock_special, to give a clear idea about whether it was
> > really because of an IPI. I guess we could also add additional RCU
> > debug fields to task_struct (just for debugging) to see where there
> > unlock_special is set.
> >
> > Is there a test to reproduce this, or do I just boot an intel x86_64
> > machine with "threadirqs" and run into it?
>
> Do you want to send me a patch or should I send you my kvm image which
> triggers the bug on boot?

I think the kvm image would be better so I reproduce it on my side.
After that I can share any debug patches with you if they are useful.
Thanks.
