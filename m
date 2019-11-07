Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A77CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DBA2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfKGJyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:54:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbfKGJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:54:46 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSeV0-0002dI-9c; Thu, 07 Nov 2019 10:54:42 +0100
Date:   Thu, 7 Nov 2019 10:54:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 09/12] futex: Provide state handling for exec() as well
In-Reply-To: <20191107094943.GF4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071053400.4256@nanos.tec.linutronix.de>
References: <20191106215534.241796846@linutronix.de> <20191106224556.753355618@linutronix.de> <20191107094943.GF4131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 10:55:43PM +0100, Thomas Gleixner wrote:
> 
> > +static void futex_cleanup_end(struct task_struct *tsk, int state)
> > +{
> > +	/*
> > +	 * Lockless store. The only side effect is that an observer might
> > +	 * take another loop until it becomes visible.
> > +	 */
> > +	tsk->futex_state = state;
> 
> As I mentioned yesterday, paranoia would've made me write this as
> smp_store_release(), also to avoid it creaping back into the locked
> region.
> 
> That is, the comment above deals with it being visible late, but it
> could be visible early.
> 
> At the same time, if this is a release, what does it pair with. The
> obvious place would be the load in handle_exit_race() but that didn't
> want to make sense last night -- and I'm not sure it wants to make more
> sense today.

Right. I couldn't come up with any sensible argument either.

Thanks,

	tglx
