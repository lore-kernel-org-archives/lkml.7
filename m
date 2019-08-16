Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D411C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB4E21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfHPKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:22:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfHPKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:22:31 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyZNH-0007c8-3V; Fri, 16 Aug 2019 12:22:23 +0200
Date:   Fri, 16 Aug 2019 12:22:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
In-Reply-To: <20190729205059.GA1127@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
References: <20190727164450.GA11726@roeck-us.net> <20190729093545.GV31381@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de> <20190729101349.GX31381@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net> <20190729205059.GA1127@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, Guenter Roeck wrote:
> On Mon, Jul 29, 2019 at 12:47:45PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 12:38:30PM +0200, Thomas Gleixner wrote:
> > > Reboot has two modes:
> > > 
> > >  - Regular reboot initiated from user space
> > > 
> > >  - Panic reboot
> > > 
> > > For the regular reboot we can make it go through proper hotplug, 
> > 
> > That seems sensible.
> > 
> > > for the panic case not so much.
> > 
> > It's panic, shit has already hit fan, one or two more pieces shouldn't
> > something anybody cares about.
> > 
> 
> Some more digging shows that this happens a lot with Google GCE intances,
> typically after a panic. The problem with that, if I understand correctly,
> is that it may prevent coredumps from being written. So, while of course
> the panic is what needs to be fixed, it is still quite annoying, and it
> would help if this can be fixed for panic handling as well.
> 
> How about the patch suggested by Hillf Danton ? Would that help for the
> panic case ?

I have no idea how that patch looks like, but the quick hack is below.

Thanks,

	tglx

8<---------------
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 75fea0d48c0e..625627b1457c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -601,6 +601,7 @@ void stop_this_cpu(void *dummy)
 	/*
 	 * Remove this CPU:
 	 */
+	set_cpu_active(smp_processor_id(), false);
 	set_cpu_online(smp_processor_id(), false);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));

