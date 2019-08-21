Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF53C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759322CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfHUVPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:15:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfHUVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:15:40 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0XxB-0005fR-Ae; Wed, 21 Aug 2019 23:15:37 +0200
Date:   Wed, 21 Aug 2019 23:15:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Woody Suwalski <terraluna977@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit
 guests
In-Reply-To: <CAM6Zs0XE8GW-P4Q3YM3KZo-1L+g2wt5QRN+JM3_m1xuwgFDVXQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908212313340.1983@nanos.tec.linutronix.de>
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com> <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com> <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com> <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com>
 <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com> <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com> <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de> <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com>
 <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com> <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de> <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com> <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
 <CAM6Zs0XE8GW-P4Q3YM3KZo-1L+g2wt5QRN+JM3_m1xuwgFDVXQ@mail.gmail.com>
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

On Tue, 20 Aug 2019, Woody Suwalski wrote:
> On Thu, Aug 15, 2019 at 2:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 13 Aug 2019, Woody Suwalski wrote:
> > > On Mon, Aug 12, 2019 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > The ACPI handler is not the culprit. This is either an emulation bug or
> > > > something really strange. Can you please use a WARN_ON() if the loop is
> > > > exited via the timeout so we can see in which context this happens?
> > > >
> > >
> > > B. On 5.3-rc4 problem is gone. I guess it is overall good sign.
> >
> > Now the interesting question is what changed between 5.3-rc3 and
> > 5.3-rc4. Could you please try to bisect that?
> >
> 
> Apparently I can not, and frustrated'ingly do not understand it.
> Tried twice, and every time I get it broken to the end of bisection -
> so the fixed-in-5.3-rc4 theory falls apart. Yet if I build cleanly
> 5.3-rc4 or -rc5, it works OK.
> Then on a 32 bit system - I first tried with a scaled-down kernel
> (just with the drivers needed in the VM). That one is never working,
> even in rc5. Yet the "full" kernel works OK. So now there is a config
> issue variation on top of other problem?

Looks like and it would be good to know which knob it is.

Can you send me the two configs please?

> > dpm_suspend_noirq() is called with all CPUs online and interrupts
> > enabled. In that case an interrupt pending in IRR does not make any sense
> > at all. Confused.
> >
> For now I use a timeout counter patch - and it is showing 100% irq9
> jammed and needing rescue. And I am even more confused...

You're not alone, if that gives you a bit of comfort :)

Thanks,

	tglx
