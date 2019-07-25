Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2324DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1114217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGYG2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:28:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGYG2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:28:50 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqXF9-0007qn-56; Thu, 25 Jul 2019 08:28:47 +0200
Date:   Thu, 25 Jul 2019 08:28:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
In-Reply-To: <CALjTZvZtu8sSycu2soSXCEP1yZiVNFKkxs4JY_puFahwFuuRcQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de>
References: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com> <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de> <CALjTZvZtu8sSycu2soSXCEP1yZiVNFKkxs4JY_puFahwFuuRcQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1596934924-1564036127=:1791"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1596934924-1564036127=:1791
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Rui,

On Thu, 25 Jul 2019, Rui Salvaterra wrote:
> Looks like we have a winner. Actually, I did a full bisection between
> 5.2 and 5.3-rc1. Full log follows:
> 
> git bisect start
> # good: [0ecfebd2b52404ae0c54a878c872bb93363ada36] Linux 5.2
> git bisect good 0ecfebd2b52404ae0c54a878c872bb93363ada36
>
> # first bad commit: [3222daf970f30133cc4c639cbecdc29c4ae91b2b]
> x86/hpet: Separate counter check out of clocksource register code
> 
> I haven't tried reverting this commit and recompiling (it's already

'Revert' on top of Linus tree below.

> past 1:00 here, need to sleep), but I'll try it tomorrow, if required.
> Note that on this machine (i945G) the HPET is disabled at boot and is
> forcefully enabled by the kernel…
 
> [    0.147527] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000

Ok. 

> … and the commit message reads…
> 
> "The init code checks whether the HPET counter works late in the init
> function when the clocksource is registered. That should happen right
> with the other sanity checks."
> 
> … maybe now the check is happening a bit too early…?

The only reason I can think of is that the HPET on that machine has a weird
register state (it's not advertised by the BIOS ... )

But that does not explain the boot failure completely. If the HPET is not
available then the kernel should automatically do the right thing and fall
back to something else.

Can you please provide the output of:

 cat /sys/devices/system/clocksource/clocksource0/available_clocksource
and
 cat /sys/devices/system/clocksource/clocksource0/current_clocksource

from a successful boot with 5.2 and 5.3 head with the 'fix' applied?

Then boot these kernels with 'hpet=disable' on the command line and see
whether they come up. If so please provide the same output.

The dmesg output of each boot would be useful as well.

Thanks,

	tglx

8<--------------------
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -827,10 +827,6 @@ int __init hpet_enable(void)
 	if (!hpet_cfg_working())
 		goto out_nohpet;
 
-	/* Validate that the counter is counting */
-	if (!hpet_counting())
-		goto out_nohpet;
-
 	/*
 	 * Read the period and check for a sane value:
 	 */
@@ -896,6 +892,14 @@ int __init hpet_enable(void)
 	}
 	hpet_print_config();
 
+	/*
+	 * Validate that the counter is counting. This needs to be done
+	 * after sanitizing the config registers to properly deal with
+	 * force enabled HPETs.
+	 */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
--8323329-1596934924-1564036127=:1791--
