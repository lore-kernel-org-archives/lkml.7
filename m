Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766BC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0813F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfHPTTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:19:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58434 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726527AbfHPTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:19:44 -0400
Received: (qmail 4672 invoked by uid 2102); 16 Aug 2019 15:19:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2019 15:19:43 -0400
Date:   Fri, 16 Aug 2019 15:19:43 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
In-Reply-To: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
Message-ID: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Mathieu Desnoyers wrote:

> If you choose not to use READ_ONCE(), then the "load tearing" issue can
> cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
> overflow as described above. The "Invented load" also becomes an issue,
> because the compiler could use the loaded value for a branch, and re-load
> that value between two branches which are expected to use the same value,
> effectively generating a corrupted state.
> 
> I think we need a statement about whether READ_ONCE/WRITE_ONCE should
> be used in this kind of situation, or if we are fine dealing with the
> awkward compiler side-effects when they will occur.

The only real downside (apart from readability) of READ_ONCE and
WRITE_ONCE is that they prevent the compiler from optimizing accesses
to the location being read or written.  But if you're just doing a
single access in each place, not multiple accesses, then there's
nothing to optimize anyway.  So there's no real reason not to use
READ_ONCE or WRITE_ONCE.

Alan Stern


