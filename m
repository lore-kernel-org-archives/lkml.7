Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239EEC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC3221670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfGHOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:20:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfGHOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:20:13 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkUUz-0001Ou-Ov; Mon, 08 Jul 2019 16:20:09 +0200
Date:   Mon, 8 Jul 2019 16:20:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2] cpu/hotplug: Cache number of online CPUs
In-Reply-To: <20190708140732.GI26519@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1907081618270.4709@nanos.tec.linutronix.de>
References: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
 <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com> <20190705084910.GA6592@gmail.com> <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907081531560.4709@nanos.tec.linutronix.de> <20190708140732.GI26519@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Paul E. McKenney wrote:

> On Mon, Jul 08, 2019 at 03:43:55PM +0200, Thomas Gleixner wrote:
> > Revaluating the bitmap wheight of the online cpus bitmap in every
> 
> s/wheight/weight/?
> 
> > invocation of num_online_cpus() over and over is a pretty useless
> > exercise. Especially when num_online_cpus() is used in code pathes like the
> > IPI delivery of x86 or the membarrier code.
> > 
> > Cache the number of online CPUs in the core and just return the cached
> > variable.
> 
> I do like this and the comments on limited guarantees make sense.
> One suggestion for saving a few lines below, but either way:

Nah. I have to redo it. Mathieu just pointed out in IRC that there is the
reboot and emergency/panic/kexec crap which calls set_cpu_online()
completely non serialized. Sigh....

Thanks,

	tglx


