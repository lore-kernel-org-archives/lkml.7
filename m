Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41917C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBBC2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbfGYJht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:37:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfGYJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:37:49 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqaC3-0002BV-8U; Thu, 25 Jul 2019 11:37:47 +0200
Date:   Thu, 25 Jul 2019 11:37:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
In-Reply-To: <CALjTZvb6aiUEgLN9BxOxBZCBXHoFxOx4TpBxkRQbZjgCna4WUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907251127430.1791@nanos.tec.linutronix.de>
References: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com> <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de> <CALjTZvZtu8sSycu2soSXCEP1yZiVNFKkxs4JY_puFahwFuuRcQ@mail.gmail.com> <alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de>
 <CALjTZvb6aiUEgLN9BxOxBZCBXHoFxOx4TpBxkRQbZjgCna4WUA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-442860888-1564047204=:1791"
Content-ID: <alpine.DEB.2.21.1907251135370.1791@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-442860888-1564047204=:1791
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1907251135371.1791@nanos.tec.linutronix.de>

Rui,

On Thu, 25 Jul 2019, Rui Salvaterra wrote:
> On Thu, 25 Jul 2019 at 07:28, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > The only reason I can think of is that the HPET on that machine has a weird
> > register state (it's not advertised by the BIOS ... )
> >
> > But that does not explain the boot failure completely. If the HPET is not
> > available then the kernel should automatically do the right thing and fall
> > back to something else.
> 
> This may be a useful data point, the relevant part of the dmesg on a
> pristine 5.3-rc1 with clocksource=jiffies:

Duh. Yes, this explains it nicely.

> [    1.123548] clocksource: timekeeping watchdog on CPU1: Marking
> clocksource 'tsc-early' as unstable because the skew is too large:
> [    1.123552] clocksource:                       'hpet' wd_now: 33
> wd_last: 33 mask: ffffffff

The HPET counter check succeeded, but the early enable and the following
reconfiguration confused it completely. So the HPET is not counting:

	'hpet' wd_now: 33 wd_last: 33 mask: ffffffff

Which is a full explanation for the boot fail because if the counter is not
working then the HPET timer is not expiring and the early boot is waiting
for HPET to fire forever.

> > Then boot these kernels with 'hpet=disable' on the command line and see
> > whether they come up. If so please provide the same output.
> 
> Fortunately (as I'm doing this remotely) they did come up.
> With hpet=disabled…
> 
> Linux 5.2:
> available_clocksource: tsc acpi_pm
> current_clocksource: tsc
> 
> Linux 5.3-rc1 patched:
> available_clocksource: tsc acpi_pm
> current_clocksource: tsc

That's consistent with the above. 5.3-rc1 unpatched would of course boot as
well with hpet=disable now that we know the root cause.

I'll write a changelog and route it to Linus for -rc2.

Thanks a lot for debugging this and providing all the information!

       tglx
--8323329-442860888-1564047204=:1791--
