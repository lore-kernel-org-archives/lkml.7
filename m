Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B5D20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfHAINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:13:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHAINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:13:38 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ht6DM-0000OO-2f; Thu, 01 Aug 2019 10:13:32 +0200
Date:   Thu, 1 Aug 2019 10:13:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.intel@gmail.com>
cc:     Daniel Drake <drake@endlessm.com>, x86@kernel.org,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
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

On Thu, 1 Aug 2019, Aubrey Li wrote:
> On Thu, Aug 1, 2019 at 3:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 1 Aug 2019, Aubrey Li wrote:
> > > On Thu, Aug 1, 2019 at 2:26 PM Daniel Drake <drake@endlessm.com> wrote:
> > > > global_clock_event is NULL here. This is a "reduced hardware" ACPI
> > > > platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
> > > > avoiding the usual codepaths that would set up global_clock_event.
> > > >
> > > IIRC, acpi_generic_reduced_hw_init() avoids initializing PIT, the status of
> > > this legacy device is unknown in ACPI hw-reduced mode.
> > >
> > > > I tried the obvious:
> > > >  if (!global_clock_event)
> > > >     return -1;
> > > >
> > > No, the platform needs a global clock event, can you turn on some other
> >
> > Wrong. The kernel boots perfectly fine without a global clock event. But
> > for that the TSC and LAPIC frequency must be known.
> 
> I think LAPIC fast calibrate is only supported on intel platform, while
> Daniel's box is an AMD platform. That's why lapic_init_clockevent() failed
> and fall into the code path which needs a global clock event.

We know that.

The point is that it does not matter which vendor a CPU comes from. The
kernel does support legacyless boot when the frequencies are known. Whether
that's currently possible on that particular CPU is a different question.

Thanks,

	tglx
