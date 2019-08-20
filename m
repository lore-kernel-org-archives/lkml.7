Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E8C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80E622DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TKnHxb30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P566rOuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfHTNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:17:53 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35975 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:17:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E18FC19FC;
        Tue, 20 Aug 2019 09:17:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Aug 2019 09:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=q
        1zMCHP9N5dVVFnUfRVs/+hK9HwHAxsq2830Gk8Otsg=; b=TKnHxb30U2xLo5RnR
        KlEyBBAb+ChXyncMtNVmDnLF3EhbIBW6zwW4BUbMpJA8iBZ5R1EfCY5gtOhqtvbN
        7cnfPLR/vxNLffoxJrjRxpkon7yCCkCPK1pyhjplXtX4I8Jq9HA/+rIQid+SIh7i
        A2/n3pj7quWpytyiSvRWasKIAPB7/7sKnGG203xhTbkOOJX1TpVTkt+ZujqmlSTl
        nBi7/kKyP/ed8hP6NA8Fq9NDTD9LNEKmMtyO1TYWA3HAyvoJrISpLW+qEAnF8K7T
        Lcf8nAneMs1AF5g4iPiM1R7CnwgYbAJI3F4Dg/nhGenlRm1Y9bROVXSxH7pYqxyD
        3F0rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=q1zMCHP9N5dVVFnUfRVs/+hK9HwHAxsq2830Gk8Ot
        sg=; b=P566rOuk25uZ8kvW2Qcy7xPqQAvYpqGna+vaACB0COl254I6sG+rJM8tV
        og8Fq/f/OM9udD0D3TzgO1xxeOc+GBLa8IUnAYiezLITXVA+SNtOZdbZqX6qYxlp
        TMLh9jNmz9Mam7DExzTC6n5C4l6ZSOQelzMDaKVrhPu2F4VwIoG5yXX1c5w1u7Pt
        nX/UC/VAeN3bT0vm31KpIlpZw/o7H/EJ+EcJ+nvNiMKQyBx1SoplMIWhKq+m7rw6
        gr3qOWX7lGJQXGRyA7AudPZcBGSWp0IfNAuSd8CcUf9nPJ24P9hQqER06VOWXLu0
        sBNel/sEsBdSWzh3uZrhNZM+IMagg==
X-ME-Sender: <xms:_vJbXQ5RO5O9O1Rczy5smOCcSkohwcFzrAUqNdmYYmKfsUWO1G3zkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhprghmkfhpqdhouhhtucdlhedttddmnecujfgurhepuffvfhfhkffffgggjggtgfes
    thejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvg
    hlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtddrudefhedrudegkedrudehuden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_vJbXQLP4-G8J52XBWp3Oa34_OhDPDoTAN1cAfUR217WjvVuk-9gJw>
    <xmx:_vJbXclwYk_iWxKdsVVnmGdYi1LS2aMU48Q4RjV-T4EW3k6R1X5sXQ>
    <xmx:_vJbXX_maJBFjW-7ggTBO5hZDoiWM227wr87IFn7VVbempcryJfYRg>
    <xmx:__JbXWfxxQEm5aSfIkZCk4bK5_ro-AT2199PORzHo8kYpsHUbVPJ2q1jzw4>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C09B1380075;
        Tue, 20 Aug 2019 09:17:49 -0400 (EDT)
Subject: Re: [PATCH v4 05/10] ARM: dts: sunxi: a80: Add msgbox node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-6-samuel@sholland.org>
 <20190820081528.7g2lo4njkut5lanu@flea>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f3e3420e-450a-7d41-edf8-776c0cd5a320@sholland.org>
Date:   Tue, 20 Aug 2019 08:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820081528.7g2lo4njkut5lanu@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/19 3:15 AM, Maxime Ripard wrote:
> On Mon, Aug 19, 2019 at 10:23:06PM -0500, Samuel Holland wrote:
>> The A80 SoC contains a message box that can be used to send messages and
>> interrupts back and forth between the ARM application CPUs and the ARISC
>> coprocessor. Add a device tree node for it.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> I think you mentionned that crust has been tested only on the A64 and
> the H3/H5, did you test the mailbox on those other SoCs as well?

No, I only have A64/H3/H5, and recently H6, hardware to test. I've looked
through the manuals to verify that the registers are all the same, but I haven't
run the driver on earlier SoCs.

On 32-bit SoCs, where there's no other user of SRAM A2, it should be easy to get
the toy firmware running. All you should need to do is:
  1) Update the MMIO base/clock addresses in drivers/msgbox/sunxi-msgbox.c
  2) Update the load address in platform/sun50i/include/platform/memory.h
  3) Load the firmware to SRAM A2 (can be done from a U-Boot shell)
  4) Initialize the reset vector (algorithm is in tools/test.c:109)
  5) Deassert AR100 reset (again, these last two steps can be done from U-Boot)

Thanks,
Samuel
