Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A84C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686C20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfF1J2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:28:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfF1J2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:28:31 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgnB9-00088O-2B; Fri, 28 Jun 2019 11:28:23 +0200
Date:   Fri, 28 Jun 2019 11:28:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [patch 1/5] genirq: Delay deactivation in free_irq()
In-Reply-To: <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
Message-ID: <alpine.DEB.2.21.1906281126290.1802@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.573914765@linutronix.de> <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
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

Marc,

On Fri, 28 Jun 2019, Marc Zyngier wrote:
> > --- a/kernel/irq/autoprobe.c
> > +++ b/kernel/irq/autoprobe.c
> > @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
> >  	/* If this was the last handler, shut down the IRQ line: */
> >  	if (!desc->action) {
> >  		irq_settings_clr_disable_unlazy(desc);
> > +		/* Only shutdown. Deactivate after synchronize_irq() */
> 
> synchronize_hardirq()

Correct.

> >  
> >  	irq_release_resources(desc);
> The patch makes complete sense, so this comment is only a nit, feel free 
> to ignore me: I find it a bit odd that irq_shutdown() doesn't do the 
> full thing anymore, given that it is the "canonical" function, and that 
> __free_irq is the only one that has special needs. Suggestion below.

We have pretty much the same thing with startup, so I made it symmetric.

> Irrespective of which version you prefer:
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for looking into this!

       tglx
