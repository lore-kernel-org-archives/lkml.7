Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F286C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3382C218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfCWJnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:43:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42426 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCWJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:43:03 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7dB4-0000Ni-T0; Sat, 23 Mar 2019 10:42:59 +0100
Date:   Sat, 23 Mar 2019 10:42:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] genirq: Respect IRQCHIP_SKIP_SET_WAKE in
 irq_chip_set_wake_parent()
In-Reply-To: <155329862018.20095.14024385652448015564@swboyd.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1903231035140.2157@nanos.tec.linutronix.de>
References: <20190315200759.139479-1-swboyd@chromium.org> <alpine.DEB.2.21.1903211007310.1777@nanos.tec.linutronix.de> <155329862018.20095.14024385652448015564@swboyd.mtv.corp.google.com>
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

Stephen,

On Fri, 22 Mar 2019, Stephen Boyd wrote:
> Quoting Thomas Gleixner (2019-03-21 02:26:26)
> > 
> > set_irq_wake_real() returns 0 when the topmost chip has SKIP_SET_WAKE set.
> 
> Just to confirm, the topmost chip would be chip B or chip C below?

Yes. A is the parent of B, resp. the grandparent of C

> > 
> > So let's assume we have the following chains:
> > 
> >   chip A -> chip B 
> > 
> >   chip A -> chip B -> chip C
> > 
> > chip A has SKIP_SET_WAKE not set
> > chip B has SKIP_SET_WAKE set
> > chip C has SKIP_SET_WAKE not set and invokes irq_chip_set_wake_parent()
> > 
> > Now assume we have interrupt X connected to chip B and interrupt Y
> > connected to chip C.
> > 
> > If irq_set_wake() is called for interrupt X, then the function returns
> > without trying to invoke the set_wake() callback of chip A.
> 
> It's not clear to me that having SKIP_SET_WAKE set means "completely
> ignore set wake for irqs from this domain" vs. "skip setting wake here
> because the .irq_set_wake() is intentionally omitted for this chip".

That's a really good question, but I'd say that if one part of the
hierarchy does not require set wake, then this means no further action
required.

> Reading Santosh's reasoning in commit 60f96b41f71d ("genirq: Add
> IRQCHIP_SKIP_SET_WAKE flag") just further confuses me because it sounds
> like the latter.

That preceeds hierarchical irq domains. So back then a hierarchy was
expressed by weird callbacks, hardcoded dependencies, etc. That means if
the top level chip had SKIP_SET_WAKE set, the whole hierarchy was excluded.

> > If irq_set_wake() is called for interrupt Y, irq_chip_set_wake_parent() is
> > invoked from chip C which then skips chip B, but tries to invoke the
> > callback on chip A.
> > 
> > That's inconsistent and changes the existing behaviour. So IMO, the right
> > thing to do is to return 0 from irq_chip_set_wake_parent() when the parent
> > has SKIP_SET_WAKE set and not to try to follow the whole chain. That should
> > fix your problem nicely w/o changing behaviour.
> 
> Ok. I understand that with hierarchical chips you want it to be explicit
> in the code that a parent chip needs to be called or not. This works for

I think so.

> me, and it's actually how I had originally solved this problem. Will you
> merge your patch or do you want me to resend it with some updated commit
> text?

Please send a new version.

Thanks,

	tglx
