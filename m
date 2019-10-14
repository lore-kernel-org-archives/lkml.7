Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A178ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1884C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfJNMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:25:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38339 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfJNMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:25:38 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iJzPs-0007vo-1j; Mon, 14 Oct 2019 14:25:36 +0200
Date:   Mon, 14 Oct 2019 14:25:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Is IRQ number 0 a valid IRQ ?
In-Reply-To: <4ef7a462-5ded-0ac7-242e-888a9d36362b@redhat.com>
Message-ID: <alpine.DEB.2.21.1910141414210.2531@nanos.tec.linutronix.de>
References: <4ef7a462-5ded-0ac7-242e-888a9d36362b@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

On Sat, 5 Oct 2019, Hans de Goede wrote:

> This is something which I have been wondering for ever since there are
> several places in the kernel where IRQ number 0 is treated as not being
> valid (as no IRQ found mostly I guess). Where as other places do treat
> IRQ number 0 as valid... ?

IRQ0 is a historical x86 nuisance. On x86 irq0 is still valid - it's the
legacy timer irq. I'd be happy to fix that up, but there are quite some
assumptions vs. the irq numbering of the x86 legacy interrupt numbers in
general. BIOS/ACPI has them hard coded as well, so it's not entirely
trivial to fix that up.

For everything else than x86 (and maybe ia64( irq 0 should not exist and DT
based irq enumeration treated it as invalid interrupt number forever.

Though there were some old ARM subarchs which used to have hardcoded legacy
interrupt numbers including 0 as well.
 
> Some examples which treat IRQ 0 special:
> 
> drivers/base/platform.c: __platform_get_irq() :
> 
>         if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
>                 int ret;
> 
>                 ret = of_irq_get(dev->dev.of_node, num);
>                 if (ret > 0 || ret == -EPROBE_DEFER)
>                         return ret;
>         }
> 
> Note if (ret > 0) not if (ret >= 0)

Yeah. It makes the code fall through when ret == 0 so it can try the other
methods. What a mess...

> Other example: drivers/usb/dwc3/gadget.c: dwc3_gadget_get_irq() :
> 
>         if (!irq)
>                 irq = -EINVAL;

That one translates irq0 into an error code.
 
> So 2 questions:
> 
> 1) Is this special handling of IRQ number 0 valid code, or just
> mostly some leftover from older days when IRQ number 0 was maybe
> special ?

Kinda both.

> 2) Either way (*) I think we (I volunteer) should document this somewhere,
> other then adding a note about this to the platform_get_irq docs any
> other place where it would be good to specify this?
> 
> *) Either IRQ number 0 is not special and then we need to stop the
> cargo-culting of treating it special, or it is special and then we
> need to document that.

One way to solve it would be to change the '0' return value from the core
functions (irqdomain) to -EINVAL or such, but that needs some thorough
analysis whether there is valid irq 0 usage outside of x86/ia64.

Thanks,

	tglx
