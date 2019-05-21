Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150EC21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfEUJqw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:46:52 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35805 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfEUJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:46:51 -0400
X-Originating-IP: 90.88.22.185
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B16F920005;
        Tue, 21 May 2019 09:46:44 +0000 (UTC)
Date:   Tue, 21 May 2019 11:46:44 +0200
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
Subject: Re: [PATCH v4 0/4] Add device links to clocks
Message-ID: <20190521114644.7000a751@xps13>
In-Reply-To: <155502565678.20095.10517989462650657961@swboyd.mtv.corp.google.com>
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
        <155502565678.20095.10517989462650657961@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Thu, 11 Apr 2019 16:34:16
-0700:

> Quoting Miquel Raynal (2019-01-08 08:19:36)
> > Hello,
> > 
> > While working on suspend to RAM feature, I ran into troubles multiple
> > times when clocks where not suspending/resuming at the desired time. I
> > had a look at the core and I think the same logic as in the
> > regulator's core may be applied here to (very easily) fix this issue:
> > using device links.
> > 
> > The only additional change I had to do was to always (when available)
> > populate the device entry of the core clock structure so that it could
> > be used later. This is the purpose of patch 1. Patch 2 actually adds
> > support for device links.
> > 
> > Here is a step-by-step explanation of how links are managed, following
> > Maxime Ripard's suggestion.
> > 
> > 
> > The order of probe has no importance because the framework already
> > handles orphaned clocks so let's be simple and say there are two root
> > clocks, not depending on anything, that are probed first: xtal0 and
> > xtal1. None of these clocks have a parent, there is no device link in
> > the game, yet.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +----------------+            +----------------+
> > 
> > Then, a peripheral clock periph0 is probed. His parent is xtal1. The
> > clock_register_*() call will run __clk_init_parent() and a link between
> > periph0's core and xtal1's core will be created and stored in
> > periph0's core->parent_clk_link entry.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +----------------+            +-------^--------+
> >                                          |
> >                                          |
> >                           +--------------+
> >                           |   ->parent_clk_link
> >                           |
> >                   +----------------+
> >                   |                |
> >                   |                |
> >                   |  periph0 core  |
> >                   |                |
> >                   |                |
> >                   +-------^^-------+
> >                           ||
> >                           ||
> >                   +----------------+
> >                   |                |
> >                   |  periph0 clk 0 |
> >                   |                |
> >                   +----------------+
> > 
> > Then, device0 is probed and "get" the periph0 clock. clk_get() will be
> > called and a struct clk will be instantiated for device0 (called in
> > the figure clk 1). A link between device0 and the new clk 1 instance of
> > periph0 will be created and stored in the clk->consumer_link entry.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +----------------+            +-------^--------+
> >                                          |
> >                                          |
> >                           +--------------+
> >                           |   ->parent_clk_link
> >                           |
> >                   +----------------+
> >                   |                |
> >                   |                |
> >                   |  periph0 core  |
> >                   |                <-------------+
> >                   |                <-------------|
> >                   +-------^^-------+            ||
> >                           ||                    ||
> >                           ||                    ||
> >                   +----------------+    +----------------+
> >                   |                |    |                |
> >                   |  periph0 clk 0 |    |  periph0 clk 1 |
> >                   |                |    |                |
> >                   +----------------+    +----------------+
> >                                                 |
> >                                                 | ->consumer_link
> >                                                 |
> >                                                 |
> >                                                 |
> >                                         +-------v--------+
> >                                         |    device0     |
> >                                         +----------------+
> > 
> > Right now, device0 is linked to periph0, itself linked to xtal1 so
> > everything is fine.
> > 
> > Now let's get some fun: the new parent of periph0 is xtal1. The process
> > will call clk_reparent(), periph0's core->parent_clk_link will be
> > destroyed and a new link to xtal1 will be setup and stored. The
> > situation is now that device0 is linked to periph0 and periph0 is
> > linked to xtal1, so the dependency between device0 and xtal1 is still
> > clear.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +-------^--------+            +----------------+
> >            |
> >            |                           \ /
> >            +----------------------------x  
> >       ->parent_clk_link   |            / \  
> >                           |
> >                   +----------------+
> >                   |                |
> >                   |                |
> >                   |  periph0 core  |
> >                   |                <-------------+
> >                   |                <-------------|
> >                   +-------^^-------+            ||
> >                           ||                    ||
> >                           ||                    ||
> >                   +----------------+    +----------------+
> >                   |                |    |                |
> >                   |  periph0 clk 0 |    |  periph0 clk 1 |
> >                   |                |    |                |
> >                   +----------------+    +----------------+
> >                                                 |
> >                                                 | ->consumer_link
> >                                                 |
> >                                                 |
> >                                                 |
> >                                         +-------v--------+
> >                                         |    device0     |
> >                                         +----------------+
> > 
> > I assume periph0 cannot be removed while there are devices using it,
> > same for xtal0.
> > 
> > What can happen is that device0 'put' the clock periph0. The relevant
> > link is deleted and the clk instance dropped.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +-------^--------+            +----------------+
> >            |
> >            |                           \ /
> >            +----------------------------x  
> >       ->parent_clk_link   |            / \  
> >                           |
> >                   +----------------+
> >                   |                |
> >                   |                |
> >                   |  periph0 core  |
> >                   |                |
> >                   |                |
> >                   +-------^^-------+
> >                           ||
> >                           ||
> >                   +----------------+
> >                   |                |
> >                   |  periph0 clk 0 |
> >                   |                |
> >                   +----------------+
> > 
> > Now we can unregister periph0: link with the parent will be destroyed
> > and the clock may be safely removed.
> > 
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |                |            |                |
> >    |   xtal0 core   |            |   xtal1 core   |
> >    |                |            |                |
> >    |                |            |                |
> >    +-------^^-------+            +-------^^-------+
> >            ||                            ||
> >            ||                            ||
> >    +----------------+            +----------------+
> >    |                |            |                |
> >    |   xtal0 clk    |            |   xtal1 clk    |
> >    |                |            |                |
> >    +----------------+            +----------------+
> > 
> > 
> > This is my understanding of the common clock framework and how links
> > can be added to it.
> > 
> > As a result, here are the links created during the boot of an
> > ESPRESSObin:
> >   
> 
> Sorry this patch series is taking way too long to get merged. It's
> already mid-April!
> 
> So I still have some of the original questions I had from before, mostly
> around circular parent chains between clk providers. For example, there
> are clk providers that both provide clks to other providers and consume
> clks from those providers. Does device links work gracefully here?
> 
> Just speaking from my own qcom experience, I can point to the PCIe PHY
> that's a provider of a clk to GCC and a consumer of a clk in GCC. In
> block diagram form this is:
> 
> 
>       PCIE PHY                        GCC
>    +--------------+          +-------------------------+
>    |              |          |                         |
>    |     PHY clk ->----------+---- gcc_pipe_clk ---+   |
>    |              |          |                     |   |
>    |              |          |                     |   |
>    | pci_pipe_clk <----------|---------------------+   |
>    |              |          |                         |
>    +--------------+          +-------------------------+
> 
> The end result is that the PCIe PHY is a clk controller that provides
> the PHY clk to GCC's gcc_pipe_clk and then it gets the same clk signal
> back from GCC and uses it on the PCIe PHY's pci_pipe_clk input.
> 
> So is this is a problem?
> 

It's now my turn to get back on this topic.

I just put my noise back into this and for what I understand of the
clk subsystem, I think the situation you describe could be pictured
like this:


         +---------------+
         |               |
         |               |
         | PCIe PHY      |
         |               |
         |               |
         +-----^^--------+
               ||
               ||
         +---------------+
         |               |
         | pcie_pipe_clk |
         |               |
         +------^--------+
                |
                | ->parent_clk_link
                |
                |
         +---------------+
         |               |
         |               |
         | GCC           |
         |               |
         |               |
         +------^^-------+
                ||
                ||
         +---------------+
         |               |
         | gcc_pipe_clk  |
         |               |
         +------^--------+
                |
                | ->parent_clk_link
                |
                |
         +---------------+
         |               |
         |               |
         | PCIe PHY      |
         |               |
         |               |
         +------^^-------+
                ||
                ||
         +---------------+
         |               |
         | phy_clk       |
         |               |
         +---------------+


IMHO the fact that the first and third blocks are the same does not
interfere with device links.

Honestly, I cannot be 100% sure it won't break on qcom designs, maybe
the best would be to have someone to test. I don't have the relevant
hardware. Do you? It would be really helpful!

There is an entire PCIe series blocked, waiting for these device links
to be merged so it would help a lot if someone could test.

Thank you very much,
Miquèl
