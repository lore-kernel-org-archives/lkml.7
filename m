Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406F3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D77220850
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHXKfZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 06:35:25 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:48539 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfHXKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:35:24 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 78EFCFF803;
        Sat, 24 Aug 2019 10:35:19 +0000 (UTC)
Date:   Sat, 24 Aug 2019 12:35:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v5 1/4] clk: core: link consumer with clock driver
Message-ID: <20190824123512.24c94ca1@xps13>
In-Reply-To: <20190815000301.3ABAF2086C@mail.kernel.org>
References: <20190521125114.20357-1-miquel.raynal@bootlin.com>
        <20190521125114.20357-2-miquel.raynal@bootlin.com>
        <20190815000301.3ABAF2086C@mail.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Wed, 14 Aug 2019 17:03:00
-0700:

> Quoting Miquel Raynal (2019-05-21 05:51:10)
> > One major concern when, for instance, suspending/resuming a platform
> > is to never access registers before the underlying clock has been
> > resumed, otherwise most of the time the kernel will just crash. One
> > solution is to use syscore operations when registering clock drivers
> > suspend/resume callbacks. One problem of using syscore_ops is that the
> > suspend/resume scheduling will depend on the order of the
> > registrations, which brings (unacceptable) randomness in the process.
> > 
> > A feature called device links has been introduced to handle such
> > situation. It creates dependencies between consumers and providers,
> > enforcing e.g. the suspend/resume order when needed. Such feature is
> > already in use for regulators.
> > 
> > Add device links support in the clock subsystem by creating/deleting
> > the links at get/put time.
> > 
> > Example of a boot (ESPRESSObin, A3700 SoC) with devices linked to clocks:
> > 
> > marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
> > marvell-armada-3700-tbg-clock d0013200.tbg: Dropping the link to d0013800.pinctrl:xtal-clk
> > marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
> > marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013200.tbg
> > marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013800.pinctrl:xtal-clk
> > marvell-armada-3700-periph-clock d0018000.sb-periph-clk: Linked as a consumer to d0013200.tbg
> > mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
> > xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
> > mvebu-uart d0012000.serial: Linked as a consumer to d0013800.pinctrl:xtal-clk
> > advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
> > cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
> > cpu cpu0: Dropping the link to d0013000.nb-periph-clk
> > cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---  
> 
> This patch doesn't apply. Things have changed upstream.
> 
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index ec6f04dcf5e6..e6b84ab43f9f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1676,6 +1710,8 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
> >  
> >                 if (was_orphan != becomes_orphan)
> >                         clk_core_update_orphan_status(core, becomes_orphan);
> > +
> > +               clk_link_hierarchy(core, new_parent);  
> 
> This isn't going to work.

Strange, I didn't had that problem (on Marvell platforms).

> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:909
>  in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
>  3 locks held by swapper/0/1:
>   #0: (____ptrval____) (&dev->mutex){....}, at: __device_driver_lock+0x40/0x4c
>   #1: (____ptrval____) (prepare_lock){+.+.}, at: clk_prepare_lock+0x18/0x94
>   #2: (____ptrval____) (enable_lock){....}, at: clk_enable_lock+0x34/0xdc
>  irq event stamp: 311516
>  hardirqs last  enabled at (311515): [<ffffff901fce5c90>] _raw_spin_unlock_irqrestore+0x54/0x90
>  hardirqs last disabled at (311516): [<ffffff901f73d468>] clk_enable_lock+0x28/0xdc
>  softirqs last  enabled at (311348): [<ffffff901f28188c>] __do_softirq+0x4cc/0x514
>  softirqs last disabled at (311341): [<ffffff901f2f89ac>] irq_exit+0xd8/0xf8
>  CPU: 4 PID: 1 Comm: swapper/0 Tainted: G        W         5.3.0-rc4-00005-g6be06bbec80ef #10
>  Hardware name: Google Cheza (rev3+) (DT)
>  Call trace:
>   dump_backtrace+0x0/0x13c
>   show_stack+0x20/0x2c
>   dump_stack+0xc4/0x12c
>   ___might_sleep+0x1b4/0x1c4
>   __might_sleep+0x50/0x88
>   __mutex_lock_common+0x5c/0xbfc
>   mutex_lock_nested+0x40/0x50
>   device_link_add+0x88/0x3ac
>   clk_reparent+0xc4/0x114
>   __clk_set_parent_before+0x74/0x90
>   clk_change_rate+0x98/0x854
>   clk_core_set_rate_nolock+0x1b0/0x21c
>   clk_set_rate+0x3c/0x6c
>   of_clk_set_defaults+0x29c/0x364
>   platform_drv_probe+0x28/0xb0
>   really_probe+0x130/0x2b4
>   driver_probe_device+0x64/0xfc
>   device_driver_attach+0x4c/0x6c
>   __driver_attach+0xb0/0xc4
>   bus_for_each_dev+0x84/0xcc
>   driver_attach+0x2c/0x38
>   bus_add_driver+0xfc/0x1d0
>   driver_register+0x64/0xf0
>   __platform_driver_register+0x4c/0x58
>   msm_drm_register+0x5c/0x60
>   do_one_initcall+0x1e0/0x478
>   do_initcall_level+0x21c/0x25c
>   do_basic_setup+0x60/0x78
>   kernel_init_freeable+0x128/0x1b0
>   kernel_init+0x14/0x100
>   ret_from_fork+0x10/0x18
> 
> >         } else {
> >                 hlist_add_head(&core->child_node, &clk_orphan_list);
> >                 if (!was_orphan)
> > @@ -2402,6 +2438,8 @@ __clk_init_parent(struct clk_core *core, bool update_orphan)
> >         if (!parent_hw)
> >                 return NULL;
> >  
> > +       clk_link_hierarchy(core, parent_hw->core);
> > +  
> 
> This is the hunk that doesn't apply anymore.
> 
> >         return parent_hw->core;
> >  }
> >    
> 
> The general thought is that it would be good to _not_ call the device
> link APIs from deep within the clk parent changing code or even parent
> initialization code. It would be better to make device links based on
> the possible parents of a clk controller when the clk is registered and
> after the clk prepare lock (i.e. the registration lock) is dropped. Is
> this possible? The problem is that we're deeply nested in locks that are
> already hard to reason about and get out from underneath. I don't want
> to get into some sort of ABBA deadlock scenario with the PM core. The
> usage of runtime PM in the clk framework is probably busted right now
> because it is used under the prepare lock. Ugh.

I understand.

> 
> Is it necessary to add the device links between different clk
> controllers either? I mean, is it necessary to create links between clks
> and their parents right now?  Maybe we can take the easy way out and
> just make links between devices that call clk_get() and the devices that
> provide those clks (the consumer side). I suppose you may want to order
> suspend/resume of a device with the parent clks of some clk that is
> acquired from clk_get(). I hope it isn't required though, because this
> is a problem to do with ordering suspend/resume of the clk tree itself,
> which isn't really solved at all.

What you propose is, IIRC what I sent in the early version. Here is
what Maxime Ripard pointed with this early implementation:

        I think this doesn't address all the cases. In your case, where you
        have one consumer that is not a clock, and one provider that is a
        clock, it works just fine.

        However, if you have clocks providers chained, for example with one
        oscillator, a clock controller, and a device, the link will be created
        between the device and the controller, but there will be no link
        between the controller and the oscillator.

> 
> We probably need to solve that by doing something clk provider specific
> in the clk framework to figure out a way for device drivers that provide
> clks to get callbacks to suspend/resume clks in the clk tree in some
> sort of topo-sorted order. That way we can traverse the clk tree and
> call down into provider drivers for each clk it registered to do things
> like restore the clk frequency or clk enable/prepare state, etc. It
> needs to be done in a certain order and it's not possible to flatten
> that order into a sequential list of providers (that correspond 1:1 with
> devices) given that there are loops between providers.

Ok so this would be a clocks internal mechanism to handle clock
dependencies within the clock tree, with device links to handle
dependencies with external consumers and dependencies.

> 
> But from the perspective of a consumer driver like PCI, I don't see why
> it needs to care about the clk tree suspend/resume ordering details. It
> really only cares that the clk it's consuming, at the edge of the tree,
> is resumed before the consumer itself, PCI, is resumed. However the
> dependencies of that clk it's consuming is managed, be it with device
> links or something clk framework specific, doesn't matter to the PCI
> driver. And other clks that are parents or grandparents of the clk
> consumed by PCI could have device link dependencies themselves, on
> something like an i2c controller or such. Even then, we don't need to
> use device links in the clk tree to describe ordering between clks. We
> can do it without device links and break the device link chain when it
> crosses the clk tree.
> 
>   PCI -[device link]-> PCI leaf clk provider -[clk framework ordering black box]-> parent of leaf clk -[device link]-> i2c controller 
> 

I get your point. Well, too bad that Lorenzo refused the PCI series
because of this one because PCIe S2RAM won't be supported at all even if
someday someone contributes the "framework ordering black box" you are
talking about, anyway I will not have the time to work on it I am sorry.


Thanks,
Miquèl
