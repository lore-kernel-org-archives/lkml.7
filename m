Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C46C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0563218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfGDVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:10:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGDVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:10:15 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj8zb-0000KI-Vc; Thu, 04 Jul 2019 23:10:12 +0200
Date:   Thu, 4 Jul 2019 23:10:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
In-Reply-To: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com>
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

On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:

> ----- On Jul 4, 2019, at 4:42 PM, Thomas Gleixner tglx@linutronix.de wrote:
> 
> > Revaluating the bitmap wheight of the online cpus bitmap in every
> > invocation of num_online_cpus() over and over is a pretty useless
> > exercise. Especially when num_online_cpus() is used in code pathes like the
> > IPI delivery of x86 or the membarrier code.
> > 
> > Cache the number of online CPUs in the core and just return the cached
> > variable.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > include/linux/cpumask.h |   16 +++++++---------
> > kernel/cpu.c            |   16 ++++++++++++++++
> > 2 files changed, 23 insertions(+), 9 deletions(-)
> > 
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -95,8 +95,13 @@ extern struct cpumask __cpu_active_mask;
> > #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
> > #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
> > 
> > +extern unsigned int __num_online_cpus;
> 
> [...]
> 
> > +
> > +void set_cpu_online(unsigned int cpu, bool online)
> > +{
> > +	lockdep_assert_cpus_held();
> 
> I don't think it is required that the cpu_hotplug lock is held
> when reading __num_online_cpus, right ?

Errm, that's the update function. And this is better called from a hotplug
lock held region and not from some random crappy code.

> I would have expected the increment/decrement below to be performed
> with a WRITE_ONCE(), and use a READ_ONCE() when reading the current
> value.

What for?

num_online_cpus() is racy today vs. CPU hotplug operations as
long as you don't hold the hotplug lock.

Thanks,

	tglx



