Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C27C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE221871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394757AbfIGPY6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:24:58 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51136 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394740AbfIGPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:24:57 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18409779-1500050 
        for multiple; Sat, 07 Sep 2019 16:24:50 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de>
Message-ID: <156786988815.13300.14460569616117208043@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.3-rc7
Date:   Sat, 07 Sep 2019 16:24:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-09-07 16:00:17)
> Does this only happen with that CPU0 hotplug stuff enabled or on CPUs other
> than CPU0 as well? That hotplug CPU0 stuff is a bandaid so I wouldn't be
> surprised if we broke that somehow.

If I ignore cpu0 in that test and so use

[  133.847187] smpboot: CPU 1 is now offline
[  134.861861] x86: Booting SMP configuration:
[  134.861875] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  134.880218] smpboot: CPU 2 is now offline
[  135.893806] smpboot: Booting Node 0 Processor 2 APIC 0x1
[  135.935115] smpboot: CPU 3 is now offline
[  136.949760] smpboot: Booting Node 0 Processor 3 APIC 0x3

that has run for 10 minutes without failure, so it seems confined to
cpu0 hotplugging. All we are doing in the test to generate the hotplugs
is:

for (int cpu = 0;; cpu++) {
	char name[128];
	int cpufd;

	snprintf(name, sizeof(name),
		 "/sys/devices/system/cpu/cpu%d/online",
		 cpu), sizeof(name));
	cpufd = open(name, O_WRONLY);
	if (cpufd < 0)
		break;

	write(cpufd, "0", 2);
	usleep(1e6);
	write(cpufd, "1", 2);

	close(cpufd);
}

-Chris
