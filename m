Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63579C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E89321655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="NhQMUA4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jz+I4tz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfLLEvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:51:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57023 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbfLLEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:51:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E8E5223A2;
        Wed, 11 Dec 2019 23:51:06 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 11 Dec 2019 23:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=ep04Dn5qmfs2mdZrsK/koUM1j+dGjwq
        qU1VZH2ff2Bg=; b=NhQMUA4eJdN1LLv6TG4FBgd1f4z8zBRTwyzqXT0So1EDQIE
        sWXuuyVpo9S9tTSIkd1zb17Qa0HAA/wj9iSg4kAnnuD5X9JHTU8Y5eK/nh3oRzvr
        bHJlicK0lMBa0e+qQGyrXUul9obC4WMizmBaLMwnZeO7mf4qw3PmmF0MWU9Cbo6M
        xw2iTzOM07DhZLn4yckRbdDgewhwUJF+CoNPHvg0io4FExcGPCoCNJ9wIoNWHk9j
        rHkQyHUR0eN9tZR+0/1ljg/gFPm8EsTLgaPjq7JlDblJ21pLpD4L4Wg6W8HrFqTO
        jmvZ2Pzm7zI1snTtWiJUYCtNkTvrmIb7r2FZDSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ep04Dn
        5qmfs2mdZrsK/koUM1j+dGjwqqU1VZH2ff2Bg=; b=jz+I4tz9Wi87/0G/8gRhYc
        XHQiPj3L7xwNR3yRWqsLoribVEa8oOHVS4+n4VSwVZbRxbiel6F644QBG6pRbD4q
        bqQBBfDFuhM9Zq9PB/2nKfDah52HY4Sv9okOkeI9QiuuiEX8VSi+NgwsMfvk2OTw
        7Xr/fl8PuSoh76pQl2SobYBWaWnETpJ81PGdMOdPmvrKb9sGfd36+3F5mEOQmpfS
        Z7d7n6/A2MIosHW2vwQ4xAQq0EVKsA2/skclelYwOZxK7P3U1Xfa1QABJtregqsD
        8Cb7GVOLJyZvx0c0k0PKe9RL0z9New0Ns2Iobm6i8ffw0iNpzjVE2DIX3VJk+fbA
        ==
X-ME-Sender: <xms:OMfxXTJ_voGqbigVdF8n5SuBLo2hRpb8_CZ_-L3FAu-rjeWrQmY8cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeliedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:OMfxXWa1d2H2fo0KalFXZtAtuy5LPgOhmMm4w70aXsPA4JNyF_bL5Q>
    <xmx:OMfxXX51WvkT_LD69OPWyqXr5N2f5NU61DMg8P_VMhrb3K9mNVGELA>
    <xmx:OMfxXXJzLKE4c7eUavZA4yCcDEOnIbqFsUysXT47HJSE3pBQrifQdg>
    <xmx:OsfxXU554NfgEQkg-4fSJH1Ybo_bc-NhMdbjfS1xQpJtib0U_kmHJA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 726AAE00A2; Wed, 11 Dec 2019 23:51:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
In-Reply-To: <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
 <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
Date:   Thu, 12 Dec 2019 15:22:44 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Dec 2019, at 07:09, Eddie James wrote:
> 
> On 12/10/19 9:47 PM, Andrew Jeffery wrote:
> >
> > On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> >> +
> >> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
> >> +						struct aspeed_xdma_op *op,
> >> +						u32 bmc_addr)
> >> +{
> >> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
> >> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
> >> +	unsigned int line_size;
> >> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
> >> +	unsigned int line_no = 1;
> >> +	unsigned int pitch = 1;
> >> +	struct aspeed_xdma_cmd *ncmd =
> >> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
> >> +
> >> +	if ((op->host_addr + op->len) & 0xffffffff00000000ULL)
> > Do we know that this won't wrap?
> 
> 
> No, but I assume it would be a bad transfer anyway at that point?

But what happens as a consequence? We would have a 64 bit address
but wouldn't enable 64bit addressing, so presumably the hardware
would only use the bottom 32 bits of the address?

Things could get weird yes?

Or is there some failure that would occur before we trigger the transfer?
Is that what you're depending on?

> >> +
> >> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
> >> +{
> >> +	if (ctx->current_client) {
> >> +		ctx->current_client->error = error;
> >> +		ctx->current_client->in_progress = false;
> >> +		ctx->current_client = NULL;
> > You need to take start_lock before writing these members to ensure the
> > writes are not reordered across acquisition of start_lock in
> > aspeed_xdma_start() above, unless there's some other guarantee of that?
> 
> 
> Unless we get spurious interrupts (as in, the xdma interrupt fires with 
> no transfer started, and somehow the correct status bits are set), it's 
> not possible to execute this at the same time as aspeed_xdma_start(). So 
> I did not try and lock here. Do you think it's worth locking for that 
> situation?
> 

Why is it worth not locking? How is it correct? To answer that way we invoke
all kinds of reasoning about multi-processing (interrupt handled on one core
while aspeed_xdma_start() is executing on another), value visibility and
instruction reordering (though as it happens the 2400, 2500 and 2600 are all
in-order). We'll trip ourselves up if there is eventually a switch to out-of-order
execution where the writes might be reordered and delayed until after
start_lock has been acquired in aspeed_xdma_start() by a subseqent transfer.
This line of reasoning is brittle exploitation of properties of the currently used
cores for no benefit. Finishing the DMA op isn't a hot path where you might
want to take some of these risks for performance, so we have almost zero
care for lock contention but we must always be concerned about correctness.

We avoid invoking all of those questions by acquiring the lock.

> >> +
> >> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
> >> +	if (!ctx->vga_pool) {
> >> +		dev_err(dev, "Failed to setup genalloc pool.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	rc = of_property_read_u32_array(dev->of_node, "vga-mem", vgamem, 2);
> > As mentioned, this could be any reserved memory range. Also can't we get it as
> > a resource rather than parsing a u32 array? Not sure if there's an advantage
> > but it feels like a better representation.
> 
> 
> That doesn't work unfortunately because the VGA memory is not mapped and 
> the reserved memory subsystem fails to find it.

Fair enough.

> >> +
> >> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
> >> +			   ctx->chip->sdmc_remap);
> > I disagree with doing this. As mentioned on the bindings it should be up to
> > the platform integrator to ensure that this is configured appropriately.
> 
> 
> Probably so, but then how does one actually configure that elsewhere? Do 
> you mean add code to the edac driver (and add support for the ast2600) 
> to read some dts properties to set it?

Right. That's where I was going. I don't expect you to do that as part of this
patch series, but if you could separate this code out into separate patches
(dealing with the sdmc property in the devicetree binding as well) we can at
least concentrate on getting the core XDMA driver in and work out how to
move forward with configuring the memory controller later.

> >> +/*
> >> + * aspeed_xdma_direction
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_RESET: resets the XDMA engine
> >> + */
> >> +enum aspeed_xdma_direction {
> >> +	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
> >> +	ASPEED_XDMA_DIRECTION_UPSTREAM,
> >> +	ASPEED_XDMA_DIRECTION_RESET,
> > I still think having a reset action as part of the direction is a bit funky. Can you maybe
> > put that in a separate patch so we can debate it later?
> 
> 
> I can, but I'm fairly convinced this is the cleanest way to add the 
> reset functionality.
> 

Right, but if you separate it out you'll get my reviewed-by on the core XDMA
patches much quicker :) You can convince me about it in slow-time.

Cheers,

Andrew
