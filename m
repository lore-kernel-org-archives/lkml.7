Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32417C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067B220840
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfG0GQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 02:16:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG0GQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 02:16:13 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrG01-0000dy-SD; Sat, 27 Jul 2019 08:16:10 +0200
Date:   Sat, 27 Jul 2019 08:16:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 0/8] core, x86: Preparatory steps for RT
In-Reply-To: <20190726213036.2889a17d@oasis.local.home>
Message-ID: <alpine.DEB.2.21.1907270814320.1791@nanos.tec.linutronix.de>
References: <20190726211936.226129163@linutronix.de> <20190726213036.2889a17d@oasis.local.home>
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

On Fri, 26 Jul 2019, Steven Rostedt wrote:

> On Fri, 26 Jul 2019 23:19:36 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
> > CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
> > functionality which today depends on CONFIG_PREEMPT.
> > 
> > The following series adjusts the core and x86 code to use
> > CONFIG_PREEMPTION where appropriate and extends the x86 dumpstack
> > implementation to display PREEMPT_RT instead of PREEMPT on a RT
> > enabled kernel.
> >
> 
> Hmm, I'm looking at v5.3-rc1 and I don't see a CONFIG_PREEMPTION
> defined. And the first patch doesn't define it. Did I miss a patch
> series that adds it?

It came right after rc1. The initial commit renamed PREEMPT to PREEMPT_LL
and seletced PREEMPT, but that broke defconfigs and make olddefconfig :(

And in fact it was a good thing that I had to stare at all CONFIG_PREEMPT
dependencies. Found some interesting things already :)

Thanks,

	tglx
