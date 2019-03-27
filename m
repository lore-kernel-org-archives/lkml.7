Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbfC0TKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:10:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbfC0TKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:10:18 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9DwC-0006zR-UV; Wed, 27 Mar 2019 20:10:13 +0100
Date:   Wed, 27 Mar 2019 20:10:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] watchdog: Respect watchdog cpumask on CPU hotplug
In-Reply-To: <20190327151653.GA23811@redhat.com>
Message-ID: <alpine.DEB.2.21.1903272009000.1789@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de> <20190327151653.GA23811@redhat.com>
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

On Wed, 27 Mar 2019, Oleg Nesterov wrote:
> On 03/26, Thomas Gleixner wrote:
> >
> > The rework of the watchdog core to use cpu_stop_work broke the watchdog
> > cpumask on CPU hotplug.
> >
> > The watchdog_enable/disable() functions are now called unconditionally from
> > the hotplug callback, i.e. even on CPUs which are not in the watchdog
> > cpumask.
> >
> > Only invoke them when the plugged CPU is in the watchdog cpumask.
> 
> IIUC without this fix an NMI watchdog can too be enabled at boot time even
> if the initial watchdog_cpumask = housekeeping_cpumask(HK_FLAG_TIMER) doesn't
> include the plugged CPU.

Yes.

> And after that writing 0 to /proc/sys/kernel/nmi_watchdog clears
> NMI_WATCHDOG_ENABLED but this can't disable NMI watchdog's outside of
> watchdog_allowed_mask.

Correct

> So may be this can explain the problem reported by Maxime ?
> See https://lore.kernel.org/lkml/b99c5a25-a5fe-18dd-2f1d-bdd6834f03e5@redhat.com/

That looks so.

Thanks,

	tglx
