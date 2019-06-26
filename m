Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEE6C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925B8208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561584253;
	bh=EDc7fUe3Q9b1829b2b+AJfN4Y88B5C30t7QV0u7qKUY=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=JBYxxluPZ4RHt/BEXiveGPTt4l7x9VZyYoL4CijJMOppe8VP9BiQ9yEZGJkSrUjaa
	 9ABCNt7hyLxBXqj2nwyNV1ShM4P3ywmmpzxSZaD9bbr80SRUBgjdNurqi83l8Wym1Q
	 TRMlIkJhpXOMpVFnXBKQQWkJEvQ6YqAqXw2ihxuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFZVYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZVYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:24:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C0E6208E3;
        Wed, 26 Jun 2019 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561584249;
        bh=EDc7fUe3Q9b1829b2b+AJfN4Y88B5C30t7QV0u7qKUY=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=fK6R01FDqc9RKpZKNZFTy7N7NHsXQZx8Dqpuvy0wA1cisncjw6lgw3dFb59VIoWt9
         l7RQIsJdvTSKQHSdX8tcD6tErcWU6Yh/KMXgbjbUPoQmCx4kBL3r11oBCshn1IuTdO
         bsP+yICDFOUN2eVtZCrCxIoPr3QIjpBnzRSYFaoo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7f5184f-f484-e8ad-33ae-36b0da061113@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl> <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com> <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl> <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com> <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl> <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com> <c7f5184f-f484-e8ad-33ae-36b0da061113@topic.nl>
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 14:24:08 -0700
Message-Id: <20190626212409.9C0E6208E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'm getting through my inbox pile and saw this one.

Quoting Mike Looijmans (2019-04-30 22:46:55)
> On 30-04-19 02:17, Stephen Boyd wrote:
> >=20
> > Why can't that driver call clk_prepare_enable()? Is there some sort of
> > assumption that this clk will always be enabled and not have a driver
> > that configures the rate and gates/ungates it?
>=20
> Not only clk_prepare_enable(), but the driver could also call clk_set_rat=
e()=20
> and clk_set_parent() and the likes, but it doesn't, so that's why there i=
s=20
> "assigned-clocks" right?
>=20
> There are multiple scenario's, similar to why regulators also have proper=
ties=20
> like these.
>=20
> - The clock is related to hardware that the kernel is not aware of.
> - The clock is for a driver that isn't aware of its clock requirements. I=
t=20
> might be an extra clock for an FPGA implemented controller that mimics=20
> existing hardware.

Are these hypothetical scenarios or actual scenarios you need to
support?

>=20
> I'd also consider patching "assigned-clocks" to call "clk_prepare_enable(=
)",=20
> would that make sense, or is it intentional that assigned-clocks doesn't =
do that?
>=20

It's intentional that assigned-clocks doesn't really do anything besides
setup the list of clks to operate on with the rate or parent settings
specified in other properties. We would need to add another property
indicating which clks we want to mark as 'critical' or 'always-on'.

There have been prior discussions where we had developers want to mark
clks with the CLK_IS_CRITICAL flag from DT, but we felt like that was
putting SoC level details into the DT. While that was correct for SoC
specific clk drivers, I can see board designs where it's configurable
and we want to express that a board has some clks that must be enabled
early on and left enabled forever because the hardware engineer has
design the board that way. In this case, marking the clk with the
CLK_IS_CRITICAL flag needs to be done from DT.

In fact, we pretty much already have support for this with
of_clk_detect_critical(). Maybe we should re-use that binding with
'clock-critical' to let clk providers indicate that they have some clks
that should be marked critical once they're registered. We could
probably add another property too that indicates certain clks are
enabled out of the bootloader, similar to the regulator-boot-on
property, but where it takes a clock-cells wide list for the provider
the property is inside of.

We need to be careful though and make sure that clk drivers don't start
putting everything in DT. In your example, it sounds like you have a
consumer driver that wants to make sure the clk is prepared or enabled
when the consumer probes. In this case the prepare/enable calls should
be put directly into the consumer driver so it can manage the clk state.
For the case of rates and parents, it's essentially a oneshot
configuration of the rate or the parents of a clk. We don't need to
"undo" the configuration when the device driver is removed. For prepare
and enable though, we typically want to disable clks when the hardware
is not in use to save power. Adding a property to DT should only be done
to indicate a clk must always be on in this board configuration, not to
avoid calling clk_prepare_enable() in the driver probe.

To put it another way, I'm looking to describe how the board is designed
and to indicate that certain clks are always enabled at power on or are
enabled by the bootloader. Configuration has it's place too, just that
configuration is a oneshot sort of thing that never needs to change at
runtime.

