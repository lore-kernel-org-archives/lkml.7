Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADBC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630082064A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555025661;
	bh=HF6B0krY2yyaDuo/RkTrbW9Wr7QNtuOSxt5dZyroLQA=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=czUW/+hP1FuVrgaBoyXptheVBRuGPArtO0l+s56I0nhq0K1L4x5gwj8NH0GrWZsnT
	 NjRDFV39MGsu3JuXMBe1AdOnOYohhWrsBpWFfuqOxq40orkYdOwtzyxPt3XwgRXDpO
	 kXh4d2C1Ke08ExE/d759WOx3xnotjGiqd70t/mD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfDKXeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfDKXeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:34:19 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995A420643;
        Thu, 11 Apr 2019 23:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555025657;
        bh=HF6B0krY2yyaDuo/RkTrbW9Wr7QNtuOSxt5dZyroLQA=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=t8XMgSRO3cU/iG/jB0wfYlzd+nALqkUk5sZXF2LfEQaExdvkCm2dfAg+ALEOBTWOS
         hSXiYQuniLnc0+MWC6jogrjkRc1g/aoxi88d+amBFYRqdyPjoZiNmX1PpnXz0zJdiE
         eGAU+dG6Q28CKtQEXZ40tt/ONCwplYNqkHibPNDM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190108161940.4814-1-miquel.raynal@bootlin.com>
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 0/4] Add device links to clocks
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Message-ID: <155502565678.20095.10517989462650657961@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 16:34:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2019-01-08 08:19:36)
> Hello,
>=20
> While working on suspend to RAM feature, I ran into troubles multiple
> times when clocks where not suspending/resuming at the desired time. I
> had a look at the core and I think the same logic as in the
> regulator's core may be applied here to (very easily) fix this issue:
> using device links.
>=20
> The only additional change I had to do was to always (when available)
> populate the device entry of the core clock structure so that it could
> be used later. This is the purpose of patch 1. Patch 2 actually adds
> support for device links.
>=20
> Here is a step-by-step explanation of how links are managed, following
> Maxime Ripard's suggestion.
>=20
>=20
> The order of probe has no importance because the framework already
> handles orphaned clocks so let's be simple and say there are two root
> clocks, not depending on anything, that are probed first: xtal0 and
> xtal1. None of these clocks have a parent, there is no device link in
> the game, yet.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +----------------+            +----------------+
>=20
> Then, a peripheral clock periph0 is probed. His parent is xtal1. The
> clock_register_*() call will run __clk_init_parent() and a link between
> periph0's core and xtal1's core will be created and stored in
> periph0's core->parent_clk_link entry.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +----------------+            +-------^--------+
>                                          |
>                                          |
>                           +--------------+
>                           |   ->parent_clk_link
>                           |
>                   +----------------+
>                   |                |
>                   |                |
>                   |  periph0 core  |
>                   |                |
>                   |                |
>                   +-------^^-------+
>                           ||
>                           ||
>                   +----------------+
>                   |                |
>                   |  periph0 clk 0 |
>                   |                |
>                   +----------------+
>=20
> Then, device0 is probed and "get" the periph0 clock. clk_get() will be
> called and a struct clk will be instantiated for device0 (called in
> the figure clk 1). A link between device0 and the new clk 1 instance of
> periph0 will be created and stored in the clk->consumer_link entry.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +----------------+            +-------^--------+
>                                          |
>                                          |
>                           +--------------+
>                           |   ->parent_clk_link
>                           |
>                   +----------------+
>                   |                |
>                   |                |
>                   |  periph0 core  |
>                   |                <-------------+
>                   |                <-------------|
>                   +-------^^-------+            ||
>                           ||                    ||
>                           ||                    ||
>                   +----------------+    +----------------+
>                   |                |    |                |
>                   |  periph0 clk 0 |    |  periph0 clk 1 |
>                   |                |    |                |
>                   +----------------+    +----------------+
>                                                 |
>                                                 | ->consumer_link
>                                                 |
>                                                 |
>                                                 |
>                                         +-------v--------+
>                                         |    device0     |
>                                         +----------------+
>=20
> Right now, device0 is linked to periph0, itself linked to xtal1 so
> everything is fine.
>=20
> Now let's get some fun: the new parent of periph0 is xtal1. The process
> will call clk_reparent(), periph0's core->parent_clk_link will be
> destroyed and a new link to xtal1 will be setup and stored. The
> situation is now that device0 is linked to periph0 and periph0 is
> linked to xtal1, so the dependency between device0 and xtal1 is still
> clear.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +-------^--------+            +----------------+
>            |
>            |                           \ /
>            +----------------------------x
>       ->parent_clk_link   |            / \
>                           |
>                   +----------------+
>                   |                |
>                   |                |
>                   |  periph0 core  |
>                   |                <-------------+
>                   |                <-------------|
>                   +-------^^-------+            ||
>                           ||                    ||
>                           ||                    ||
>                   +----------------+    +----------------+
>                   |                |    |                |
>                   |  periph0 clk 0 |    |  periph0 clk 1 |
>                   |                |    |                |
>                   +----------------+    +----------------+
>                                                 |
>                                                 | ->consumer_link
>                                                 |
>                                                 |
>                                                 |
>                                         +-------v--------+
>                                         |    device0     |
>                                         +----------------+
>=20
> I assume periph0 cannot be removed while there are devices using it,
> same for xtal0.
>=20
> What can happen is that device0 'put' the clock periph0. The relevant
> link is deleted and the clk instance dropped.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +-------^--------+            +----------------+
>            |
>            |                           \ /
>            +----------------------------x
>       ->parent_clk_link   |            / \
>                           |
>                   +----------------+
>                   |                |
>                   |                |
>                   |  periph0 core  |
>                   |                |
>                   |                |
>                   +-------^^-------+
>                           ||
>                           ||
>                   +----------------+
>                   |                |
>                   |  periph0 clk 0 |
>                   |                |
>                   +----------------+
>=20
> Now we can unregister periph0: link with the parent will be destroyed
> and the clock may be safely removed.
>=20
>    +----------------+            +----------------+
>    |                |            |                |
>    |                |            |                |
>    |   xtal0 core   |            |   xtal1 core   |
>    |                |            |                |
>    |                |            |                |
>    +-------^^-------+            +-------^^-------+
>            ||                            ||
>            ||                            ||
>    +----------------+            +----------------+
>    |                |            |                |
>    |   xtal0 clk    |            |   xtal1 clk    |
>    |                |            |                |
>    +----------------+            +----------------+
>=20
>=20
> This is my understanding of the common clock framework and how links
> can be added to it.
>=20
> As a result, here are the links created during the boot of an
> ESPRESSObin:
>=20

Sorry this patch series is taking way too long to get merged. It's
already mid-April!

So I still have some of the original questions I had from before, mostly
around circular parent chains between clk providers. For example, there
are clk providers that both provide clks to other providers and consume
clks from those providers. Does device links work gracefully here?

Just speaking from my own qcom experience, I can point to the PCIe PHY
that's a provider of a clk to GCC and a consumer of a clk in GCC. In
block diagram form this is:


      PCIE PHY                        GCC
   +--------------+          +-------------------------+
   |              |          |                         |
   |     PHY clk ->----------+---- gcc_pipe_clk ---+   |
   |              |          |                     |   |
   |              |          |                     |   |
   | pci_pipe_clk <----------|---------------------+   |
   |              |          |                         |
   +--------------+          +-------------------------+

The end result is that the PCIe PHY is a clk controller that provides
the PHY clk to GCC's gcc_pipe_clk and then it gets the same clk signal
back from GCC and uses it on the PCIe PHY's pci_pipe_clk input.

So is this is a problem?

