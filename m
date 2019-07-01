Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC0FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129882146F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfGASCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:02:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfGASCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:02:10 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hi0cy-0006Ee-HZ; Mon, 01 Jul 2019 20:02:08 +0200
Date:   Mon, 1 Jul 2019 20:02:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robert Hodaszi <Robert.Hodaszi@digi.com>
Subject: Re: [patch V2 3/6] genirq: Add optional hardware synchronization
 for shutdown
In-Reply-To: <20190701145628.GC3402@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907012001550.1802@nanos.tec.linutronix.de>
References: <20190628111148.828731433@linutronix.de> <20190628111440.279463375@linutronix.de> <20190701145628.GC3402@hirez.programming.kicks-ass.net>
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

On Mon, 1 Jul 2019, Peter Zijlstra wrote:

> On Fri, Jun 28, 2019 at 01:11:51PM +0200, Thomas Gleixner wrote:
> > But that does not catch the case where the interrupt is on flight at the
> > hardware level but not yet serviced by the target CPU. That creates an
> > interesing race condition:
> 
> > + *	It does not check whether there is an interrupt on flight at the
> > + *	hardware level, but not serviced yet, as this might deadlock when
> > + *	called with interrupts disabled and the target CPU of the interrupt
> > + *	is the current CPU.
> 
> > +	/*
> > +	 * Make sure it's not being used on another CPU and if the chip
> > +	 * supports it also make sure that there is no (not yet serviced)
> > +	 * interrupt on flight at the hardware level.
> > +	 */
> > +	__synchronize_hardirq(desc, true);
> 
> s/on flight/in flight/ ?

yes

