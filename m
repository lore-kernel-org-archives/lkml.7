Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C179BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94781233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566394376;
	bh=8UZ7sUhD0uUW460zXnAKiEGlV69odyLV+7fBevexDSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CRIrZtdx7FytzofHO+5aNPV2fCm8UVdoE+j2lfWBQW5hQJkviB+y/KXHGZta8S25u
	 aJD1vQ5hIpbfeiUYAB6JrCMsTEdyfvguDrT5RDmi3FJgnhCmRQT+7Ddhj13OMS0wbg
	 +1kcJV+L/MXbVA8oW4sAivwCaGzVOnaxjwtzTScc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfHUNcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfHUNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:32:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C24233A1;
        Wed, 21 Aug 2019 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566394373;
        bh=8UZ7sUhD0uUW460zXnAKiEGlV69odyLV+7fBevexDSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKdvOh3GEC+mSY2RlfFm3fjWgTG1iCONlGnPjECVgcz+rOoxhRiXinIDNu+IbF4O5
         JS44pOO6w1XwHPTc6QHEQDN3lZWbQiJppVWIrbyddELzRuuwTH7DWkFuyZXvLFGs54
         uE3JzKAD669fBsFDuvlVr2N2mgNbOrPcir4daemc=
Date:   Wed, 21 Aug 2019 14:32:48 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190821133247.vke6fnndm64h2lla@willie-the-truck>
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
 <20190821132310.GC28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132310.GC28441@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> > void bar(u64 *x)
> > {
> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> > }
> > 
> > then I get:
> > 
> > bar:
> > 	mov	w1, 61200
> > 	movk	w1, 0xabcd, lsl 16
> > 	str	w1, [x0]
> > 	str	w1, [x0, 4]
> > 	ret
> > 
> > so I'm not sure that WRITE_ONCE would even help :/
> 
> Well, I can have the LWN article cite your email, then.  So thank you
> very much!
> 
> Is generation of this code for a 64-bit volatile store considered a bug?

I consider it a bug for the volatile case, and the one compiler person I've
spoken to also seems to reckon it's a bug, so hopefully it will be fixed.
I'm led to believe it's an optimisation in the AArch64 backend of GCC.

> Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
> would guess that Thomas and Linus would ask a similar bugginess question
> for normal stores.  ;-)

We use inline asm for MMIO, fwiw.

Will
