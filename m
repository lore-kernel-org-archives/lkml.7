Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30594C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B74220874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407611AbfFKVJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:09:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406701AbfFKVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:09:27 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hao1B-0005pT-4J; Tue, 11 Jun 2019 23:09:21 +0200
Date:   Tue, 11 Jun 2019 23:09:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
In-Reply-To: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
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

Jason,

On Fri, 7 Jun 2019, Jason A. Donenfeld wrote:

Adding a few more people on cc and keeping full context.

> Hey Thomas,
> 
> After some discussions here prior about the different clocks
> available, WireGuard uses ktime_get_boot_fast_ns() pretty extensively.
> The requirement is for a quasi-accurate monotonic counter that takes
> into account sleep time, and this seems to fit the bill pretty well.
> Sultan (CC'd) reported to me a non-reproducible bug he encountered in
> 4.19.47 (arch's linux-lts package), where the CPU was hung in
> read_hpet.
> 
> CPU: 1 PID: 7927 Comm: kworker/1:3 Tainted: G           OE     4.19.47-1-lts #1
> Hardware name: Dell Inc. XPS 15 9570/02MJVY, BIOS 1.10.1 04/26/2019
> Workqueue: wg-crypt-interface wg_packet_tx_worker [wireguard]
> RIP: 0010:read_hpet+0x67/0xc0
> Code: c0 75 11 ba 01 00 00 00 f0 0f b1 15 a3 3d 1a 01 85 c0 74 37 48
> 89 cf 57 9d 0f 1f 44 00 00 48 c1 ee 20 eb 04 85 c9 74 12 f3 90 <49> 8b
> 08 48 89 ca 48 c1 ea 20 89 d0 39 f2 74 ea c3 48 8b 05 89 56
> RSP: 0018:ffffb8d382533e18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> RAX: 0000000018a4c89e RBX: 0000000000000000 RCX: 18a4c89e00000001
> RDX: 0000000018a4c89e RSI: 0000000018a4c89e RDI: ffffffffb8227980
> RBP: 000006c1c3f602a2 R08: ffffffffb8205040 R09: 0000000000000000
> R10: 000001d58fd28efc R11: 0000000000000000 R12: ffffffffb8259a80
> R13: 00000000ffffffff R14: 0000000518a0d8c4 R15: 000000000010fa5a
> FS:  0000000000000000(0000) GS:ffff9b90ac240000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00003663b14d9ce8 CR3: 000000030f20a006 CR4: 00000000003606e0
> Call Trace:
>  ktime_get_mono_fast_ns+0x53/0xa0
>  ktime_get_boot_fast_ns+0x5/0x10
>  wg_packet_tx_worker+0x183/0x220 [wireguard]
>  process_one_work+0x1f4/0x3e0
>  worker_thread+0x2d/0x3e0
>  ? process_one_work+0x3e0/0x3e0
>  kthread+0x112/0x130
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x35/0x40
> watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/1:3:7927]
> 
> It looks like RIP is spinning in this loop in read_hpet:
> 
> do {
>     cpu_relax();
>     new.lockval = READ_ONCE(hpet.lockval);
> } while ((new.value == old.value) && arch_spin_is_locked(&new.lock));
> 
> I imagine this could be a bug in the hpet code, or a failure of the
> hpet hardware. But I thought it'd be most prudent to check, first,
> whether there are actually very particular conditions on when and
> where ktime_get_boot_fast_ns and friends can be called. In other
> words, maybe the bug is actually in my code. I was under the
> impression that invoking it from anywhere was fine, given the
> documentation says "NMI safe", but maybe there are still some
> requirements I should keep in mind?

I think your code is fine. Just 'fast' is relative with the HPET selected
as clocksource (it's actually aweful slow).

It probably livelocks in the HPET optimization Waiman did for large
machines. I'm having a dejavu with that spinlock livelock we debugged last
year. Peter?

Can you please ask the reporter to try the hack below?

Thanks,

	tglx

8<---------------
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a0573f2e7763..0c9044698489 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -795,8 +795,7 @@ static u64 read_hpet(struct clocksource *cs)
 	/*
 	 * Read HPET directly if in NMI.
 	 */
-	if (in_nmi())
-		return (u64)hpet_readl(HPET_COUNTER);
+	return (u64)hpet_readl(HPET_COUNTER);
 
 	/*
 	 * Read the current state of the lock and HPET value atomically.
