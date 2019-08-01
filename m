Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CFEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770AA214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfHAH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHAH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:28:01 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ht5V7-00084G-Tp; Thu, 01 Aug 2019 09:27:50 +0200
Date:   Thu, 1 Aug 2019 09:27:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     x86@kernel.org, aubrey.li@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908010918501.1788@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
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

Daniel,

On Thu, 1 Aug 2019, Daniel Drake wrote:
> Working with a new consumer laptop based on AMD R7-3700U, we are
> seeing a kernel panic during early boot (before the display
> initializes). It's a new product and there is no previous known
> working kernel version (tested 5.0, 5.2 and current linus master).
> 
> We may have also seen this problem on a MiniPC based on AMD APU 7010
> from another vendor, but we don't have it in hands right now to
> confirm that it's the exact same crash.
> 
> earlycon shows the details: a NULL dereference under
> setup_boot_APIC_clock(), which actually happens in
> calibrate_APIC_clock():
> 
>     /* Replace the global interrupt handler */
>     real_handler = global_clock_event->event_handler;
>     global_clock_event->event_handler = lapic_cal_handler;
> 
> global_clock_event is NULL here. This is a "reduced hardware" ACPI
> platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
> avoiding the usual codepaths that would set up global_clock_event.
> 
> I tried the obvious:
>  if (!global_clock_event)
>     return -1;
> 
> However I'm probably missing part of the big picture here, as this
> only makes boot fail later on. It continues til the next point that
> something leads to schedule(), such as a driver calling msleep() or
> mark_readonly() calling rcu_barrier(), etc. Then it hangs.
> 
> Is something missing in terms of timer setup here? Suggestions
> appreciated...

So that trips over the problem that there is no timer to calibrate against
and the LAPIC freuency is obviously unknown.

How is the kernel supposed to figure that out?

The only possible option in that case is to use RTC, but we have no support
for this at all.

Thanks,

	tglx

