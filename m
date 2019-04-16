Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF97C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485DF20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfDPUNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:13:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50511 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:13:10 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hGUS0-0003Ay-6Q; Tue, 16 Apr 2019 22:13:04 +0200
Date:   Tue, 16 Apr 2019 22:13:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Dexuan Cui <decui@microsoft.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
In-Reply-To: <87o9562o3w.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1904162206590.1780@nanos.tec.linutronix.de>
References: <20190412235341.29379-1-decui@microsoft.com> <20190415122128.GO11158@hirez.programming.kicks-ass.net> <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <20190416093123.GR11158@hirez.programming.kicks-ass.net>
 <87o9562o3w.fsf@vitty.brq.redhat.com>
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

On Tue, 16 Apr 2019, Vitaly Kuznetsov wrote:

> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Mon, Apr 15, 2019 at 11:39:57PM +0000, Dexuan Cui wrote:
> >> > From: Peter Zijlstra <peterz@infradead.org>
> >> > Sent: Monday, April 15, 2019 5:21 AM
> >> > To: Dexuan Cui <decui@microsoft.com>
> >> > 
> >> > On Fri, Apr 12, 2019 at 11:53:57PM +0000, Dexuan Cui wrote:
> >> > > If smp_call_function_single() is calling the function for itself, it's safe
> >> > > to run with irqs_disabled() == true.
> >> > >
> >> > > I hit the warning because I'm in the below path in the .suspend callback of
> >> > > a "syscore_ops" to support hibernation for a VM running on Hyper-V:
> >> > >
> >> > >   hv_synic_cleanup() ->
> >> > >     clockevents_unbind_device() ->
> >> > >       clockevents_unbind() ->
> >> > >         smp_call_function_single().
> >> > >
> >> > > When the .suspend callback runs, only CPU0 is online and irqs_disabled() is
> >> > > true.
> >> > 
> >> > Pray tell, how well do you think mutex_lock() works with interrupts
> >> > disabled?
> >> 
> >> Good point. I realized generally speaking this patch makes no sense, so let me
> >> try the solution proposed by Vitaly, i.e. fix clockevents_unbind() instead.
> >
> > That's still not the problem. You're calling clockevents_unbind_device()
> > with IRQs disabled, that's not correct. It doesn't matter what
> > clockevents_unbind() does thereafter.
> >
> 
> True. And before we start digging deeper into this, let's step back: why
> do we need to do clockevents_unbind_device() on hybernation? Can we just
> disable the device and re-enable it back on resume?

Yes. That's the right thing to do. Simple solution is to implement the
suspend/resume callbacks on the clock events device and be done with it.

> Actually, all usages of clockevents_unbind_device() in kernel are
> limited to Hyper-V and with Michael's patches moving this out of VMBus
> driver I think it can go away completely.

Correct. There was a driver which required that, but that's gone by now and
of course nobody noticed that it was the last user. The reason why this
exists was to allow switching out an active clocksource similar to the
sysfs unbind file but without user space interaction.

Thanks,

	tglx
