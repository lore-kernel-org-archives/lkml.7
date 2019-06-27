Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D94C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993032086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QWWe0qbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfF0Rqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:46:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44674 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfF0Rqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:46:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so2123592lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6W2K1b/3xwaEs6Qc9I8DS4+zNASP1N/uvlbH7rl76E=;
        b=QWWe0qbfaNHsWfqWaCYdMOBPZHNLceVVMR6vo2C0NhBVUEkOfYuBTroEj8kpUTMql1
         rXzc3hbrJRRsVASyBuBynXo0SCOy7RhsLn+Y3VerNa+90OQyEGkwypBsKGlss90teIQ1
         4Ymwesw1pbrDbXIg/UidFML1hwz2CZ6XGbKI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6W2K1b/3xwaEs6Qc9I8DS4+zNASP1N/uvlbH7rl76E=;
        b=cKaX1VI/gXB1eMTkiPDkKo5uOIuqbFDaxNEsYBTHn4JjnPwWkz7GbhAFNwKGkNOoZP
         F2uGBVjTFXgVHXhQ4d48+zLpB+wBrO7j8Mc4FQa37/Xufqc6LmtrL4dV05Ick8HrJllE
         KPAe+u9AxKwJAoKBLw9S+t9uXwM1rPnSWjdazT5po6IusPRx2Ccok1s0TgIoCSJPqZdJ
         Qex3yK/HccCuiJpVp/nRpKKZGaZPnN0feQfimWGZYcf/LGZ3A5we40ARA3DQ/w+jawpt
         w2UGZ325pY1/KVBp345DQSqKb7rpOohftcj83DC7OWZsvS7LEs1Z2Lz4VMxcMLqjlhUY
         jCiw==
X-Gm-Message-State: APjAAAXwTJMOCDyXE7Iz+2oDqPVqt2NJ7FvaZ94+YN/xkr7NqyoX6QYq
        ijaZy8qRxzEk1ECqkOSRjuP/ChYqM9PtO5iz7p794g==
X-Google-Smtp-Source: APXvYqz9iEOx/i8x1nneYf64spCLIhIGQctI2cYF2AgnsIMMkq0ImZOf1fr5lkeGoyZnYomWg+JLp/yWoIKJfv8smD0=
X-Received: by 2002:a19:ed0c:: with SMTP id y12mr2596505lfy.191.1561657598836;
 Thu, 27 Jun 2019 10:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com> <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home> <20190627153031.GA249127@google.com>
 <CAEXW_YT5LgdP_9SrachU4ZrhV9a7o_DM8eBfgxj=n7yRRyS-TQ@mail.gmail.com>
 <20190627154011.vbje64x6auaknhx4@linutronix.de> <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTvkSTqwi_jOE2Pr+uD-GC4Xv0CtBEL9YO7=LvJcM3FBQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 27 Jun 2019 13:46:27 -0400
Message-ID: <CAEXW_YTmx3wFKuiLyrQO6uSPYAL179EPa6N3WO7qZahccCs-pg@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 1:43 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Jun 27, 2019 at 11:40 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2019-06-27 11:37:10 [-0400], Joel Fernandes wrote:
> > > Sebastian it would be nice if possible to trace where the
> > > t->rcu_read_unlock_special is set for this scenario of calling
> > > rcu_read_unlock_special, to give a clear idea about whether it was
> > > really because of an IPI. I guess we could also add additional RCU
> > > debug fields to task_struct (just for debugging) to see where there
> > > unlock_special is set.
> > >
> > > Is there a test to reproduce this, or do I just boot an intel x86_64
> > > machine with "threadirqs" and run into it?
> >
> > Do you want to send me a patch or should I send you my kvm image which
> > triggers the bug on boot?
>
> I could reproduce this as well just booting Linus tree with threadirqs
> command line and running rcutorture. In 15 seconds or so it locks
> up... gdb backtrace shows the recursive lock:

Sorry that got badly wrapped, so I pasted it here:
https://hastebin.com/ajivofomik.shell
