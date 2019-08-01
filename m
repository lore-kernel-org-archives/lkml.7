Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8EC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07F214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfHAKRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:17:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34517 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:17:44 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ht89O-0002mO-Bu; Thu, 01 Aug 2019 12:17:34 +0200
Date:   Thu, 1 Aug 2019 12:17:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     Aubrey Li <aubrey.intel@gmail.com>, x86@kernel.org,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <CAD8Lp452GdoL-Bt7rSP=u3RKEZ2H3qm3LvKfe=cCsjP0biG_sQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908011214150.1965@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <CAD8Lp452GdoL-Bt7rSP=u3RKEZ2H3qm3LvKfe=cCsjP0biG_sQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019, Daniel Drake wrote:
> On Thu, Aug 1, 2019 at 3:16 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
> However, the only way this can be called is from hpet_enable().
> 
> hpet_enable() is called from 2 places:
>  1. From hpet_time_init(). This is the default x86 timer_init that
> acpi_generic_reduced_hw_init() took out of action here.
>  2. From hpet_late_init(). However that function is only called late,
> after calibrate_APIC_clock() has already crashed the kernel. Also,
> even if moved earlier it would also not call hpet_enable() here
> because the ACPI HPET table parsing has already populated
> hpet_address.
> 
> I tried slotting in a call to hpet_enable() at an earlier point
> regardless, but I still end up with the kernel hanging later during
> boot, probably because irq0 fails to be setup and this error is hit:
>     if (setup_irq(0, &irq0))
>         pr_info("Failed to register legacy timer interrupt\n");

Right. The thing also lacks PIT :)

So there are two options:

   1) Make sure the HPET is parsed somehow even with the reduced stuff

   2) Make the clock frequency detection work.

#1 is a trainwreck

#2 is something we really want to have anyway. See the other reply. I cc'ed
   Tom there, he should be able to give us the missing link.

Thanks,

	tglx
