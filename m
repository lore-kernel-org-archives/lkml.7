Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93117C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722FA2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHPUtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:49:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfHPUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:49:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyj9l-0000JK-Q7; Fri, 16 Aug 2019 22:49:05 +0200
Date:   Fri, 16 Aug 2019 22:49:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
In-Reply-To: <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Joel Fernandes wrote:
> On Fri, Aug 16, 2019 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Fri, 16 Aug 2019, Mathieu Desnoyers wrote:
> >
> > > If you choose not to use READ_ONCE(), then the "load tearing" issue can
> > > cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
> > > overflow as described above. The "Invented load" also becomes an issue,
> > > because the compiler could use the loaded value for a branch, and re-load
> > > that value between two branches which are expected to use the same value,
> > > effectively generating a corrupted state.
> > >
> > > I think we need a statement about whether READ_ONCE/WRITE_ONCE should
> > > be used in this kind of situation, or if we are fine dealing with the
> > > awkward compiler side-effects when they will occur.
> >
> > The only real downside (apart from readability) of READ_ONCE and
> > WRITE_ONCE is that they prevent the compiler from optimizing accesses
> > to the location being read or written.  But if you're just doing a
> > single access in each place, not multiple accesses, then there's
> > nothing to optimize anyway.  So there's no real reason not to use
> > READ_ONCE or WRITE_ONCE.
> 
> I am also more on the side of using *_ONCE. To me, by principal, I
> would be willing to convert any concurrent plain access using _ONCE,
> just so we don't have to worry about it now or in the future and also
> documents the access.

By that argumentation we need to plaster half of the kernel with _ONCE()
and I'm so not looking forward to the insane amount of script kiddies
patches to do that.

Can we finally put a foot down and tell compiler and standard committee
people to stop this insanity?

Thanks,

	tglx
