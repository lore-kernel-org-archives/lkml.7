Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B91C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4420854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfIGKK0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 06:10:26 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52527 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbfIGKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:10:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18407577-1500050 
        for multiple; Sat, 07 Sep 2019 11:10:07 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
Cc:     Bandan Das <bsd@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
Message-ID: <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.3-rc7
Date:   Sat, 07 Sep 2019 11:10:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2019-09-02 18:28:26)
> Bandan Das:
>       x86/apic: Include the LDR when clearing out APIC registers

Apologies if this is known already, I'm way behind on email.

I've bisected

[   18.693846] smpboot: CPU 0 is now offline
[   19.707737] smpboot: Booting Node 0 Processor 0 APIC 0x0
[   29.707602] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0

https://intel-gfx-ci.01.org/tree/drm-tip/igt@perf_pmu@cpu-hotplug.html

to 558682b52919. (Reverts cleanly and fixes the problem.)

I'm guessing that this is also behind the suspend failures, missing
/dev/cpu/0/msr, and random perf_event_open() failures we have observed
in our CI since -rc7 across all generations of Intel cpus.
-Chris
