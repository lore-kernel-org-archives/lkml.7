Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF98C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D346D2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfFMTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:53:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfFMTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:53:12 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbVmW-0002Bd-KP; Thu, 13 Jun 2019 21:53:08 +0200
Date:   Thu, 13 Jun 2019 21:53:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
In-Reply-To: <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com> <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de> <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com> <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com> <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com> <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
 <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de> <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
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

On Thu, 13 Jun 2019, Jason A. Donenfeld wrote:

> On Thu, Jun 13, 2019 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > That does not make sense. The coarse time getters use
> > tk->tkr_mono.base. base is updated every tick (or if the machine is
> > completely idle right when the first CPU wakes up again).
> 
> Sense or not, it seems to be happening, at least on 5.2-rc4:

Bah. Seems I had paged out all the subtle parts of timekeeping and answered
from my blurred memory while traveling. Stared at it for a while and of
course base is only updated every second. The nsec part uses the
accumulated nsecs (< 1sec) plus the time delta read from the hardware. So
yes, the ktime_get_coarse* stuff has been broken from day one.

Fix below.

Thanks,

	tglx

8<------------------
Subject: timekeeping: Repair ktime_get_coarse*() granularity
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 13 Jun 2019 21:40:45 +0200

Jason reported that the coarse ktime based time getters advance only once
per second and not once per tick as advertised.

The code reads only the monotonic base time, which advances once per
second. The nanoseconds are accumulated on every tick in xtime_nsec up to
a second and the regular time getters take this nanoseconds offset into
account, but the ktime_get_coarse*() implementation fails to do so.

Add the accumulated xtime_nsec value to the monotonic base time to get the
proper per tick advancing coarse tinme.

Fixes: b9ff604cff11 ("timekeeping: Add ktime_get_coarse_with_offset")
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/time/timekeeping.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -810,17 +810,18 @@ ktime_t ktime_get_coarse_with_offset(enu
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
+		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base;
-
+	return base + nsecs;
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
