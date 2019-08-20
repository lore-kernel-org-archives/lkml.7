Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D8C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434722D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LiOhSbi5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EypA7Rvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfHTNDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:03:01 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50539 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:03:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CB561A74;
        Tue, 20 Aug 2019 09:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Aug 2019 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=1
        usIyl6jBRrcd9bI7o9gbxd6pE66tvE7eiKPLxty27A=; b=LiOhSbi5IJNsXVgMD
        Qnc0zT60+2lOlbSltEck6AJ4prekCDYxWAEMv+giRPRCuqVRDlWwauFKrOmNhAiE
        +CB34WVyU2GhNxPodFT4AP9Wj7f3AG+6/ftZfXnggizy131pduBImIiQdkk02k0C
        D7ZfEBMzrYkXyBzw9VAolt8g5vUXhNxtyXaq7NjxBZNR6IbCTwjakdMPu+mF11KG
        vv0vEtjYbpqm60N8UmlEADyzbMLfORa/UURKAwN8PFVg4CS5B6Li0AVw5wTScLiq
        m4YTHdrPqQlUpfba3IGXJAo/84yWF8bvAIaEL1P1pFxeFPVJvALbceqcHtSGxPdK
        yFnxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=1usIyl6jBRrcd9bI7o9gbxd6pE66tvE7eiKPLxty2
        7A=; b=EypA7RvfDE5jwfTIyRB0mMJuOIfQQfHGCG4abVQDW7zn/6LTV5aNNK8aV
        XBBCGD/e4ZIPZeR+CNMqhnlLKM3jlOEI/8ig5ERwuVUfZepuSs8HH0zUivTvIQO+
        uztQKYIYeioz7JTl6ZwPtV4josiU3V4lRdm0gazn4xVKPSFICJSxpfq3V9QAjJLS
        U85qzTyHCKWqfaeuwMRt6yDlxptdnTj2FWYPpTLJ3b9iVW7lA1V772f6JWpsczkl
        Z6vWDNPKyC+yzZnHU3Mgc3HdEtv0r3FqLATGNppq+azRapLXUlMhBzQcuE5P7QSP
        mlxCL+n37OQIVVbnKOFocIcYnrMyQ==
X-ME-Sender: <xms:ge9bXYgRHXVxUiYDoQyP6boSZH3D_2mW33CKOUYLXTPC16V198SkNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhprghmkfhpqdhouhhtucdlhedttddmnecujfgurhepuffvfhfhkffffgggjggtgfes
    thejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvg
    hlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtddrudefhedrudegkedrudehuden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ge9bXaY4wThlynGNdxR2RoMtj90VMsONx9Gr7i1fJkXkUA-tMJH8UQ>
    <xmx:ge9bXZPBVP-n5D76B7tsNqU1FUWFgUKybxt3nLKCRPrrVSkAe7bk8Q>
    <xmx:ge9bXcSrYQWR-HKkZyvnl5gVZWID451AXgTjTo9-4BKPiq90UXS6ug>
    <xmx:g-9bXRhUUZYoxA7ROwch_EfWRiGPjBXmQuQh6ZEm_2DY1jQhbtAHxRscFqA>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB527380083;
        Tue, 20 Aug 2019 09:02:56 -0400 (EDT)
Subject: Re: [PATCH v4 02/10] clk: sunxi-ng: Mark AR100 clocks as critical
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
 <20190820032311.6506-3-samuel@sholland.org>
 <20190820071142.2bgfsnt75xfeyusp@flea>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3b67534a-eb1b-c1e8-b5e8-e0a74ae85792@sholland.org>
Date:   Tue, 20 Aug 2019 08:02:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820071142.2bgfsnt75xfeyusp@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 2:11 AM, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Aug 19, 2019 at 10:23:03PM -0500, Samuel Holland wrote:
>> On sun8i, sun9i, and sun50i SoCs, system suspend/resume support requires
>> firmware running on the AR100 coprocessor (the "SCP"). Such firmware can
>> provide additional features, such as thermal monitoring and poweron/off
>> support for boards without a PMIC.
>>
>> Since the AR100 may be running critical firmware, even if Linux does not
>> know about it or directly interact with it (all requests may go through
>> an intermediary interface such as PSCI), Linux must not turn off its
>> clock.

This paragraph here is the key. The firmware won't necessarily have a device
tree node, and in the current design it will not, since Linux never communicates
with it directly. All communication goes through ATF via PSCI.

>> At this time, such power management firmware only exists for the A64 and
>> H5 SoCs.  However, it makes sense to take care of all CCU drivers now
>> for consistency, and to ease the transition in the future once firmware
>> is ported to the other SoCs.
>>
>> Leaving the clock running is safe even if no firmware is present, since
>> the AR100 stays in reset by default. In most cases, the AR100 clock is
>> kept enabled by Linux anyway, since it is the parent of all APB0 bus
>> peripherals. This change only prevents Linux from turning off the AR100
>> clock in the rare case that no peripherals are in use.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> So I'm not really sure where you want to go with this.
> 
> That clock is only useful where you're having a firmware running on
> the AR100, and that firmware would have a device tree node of its own,
> where we could list the clocks needed for the firmware to keep
> running, if it ever runs. If the driver has not been compiled in /
> loaded, then we don't care either.

See above. I don't expect that the firmware would have a device tree node,
because the firmware doesn't need any Linux drivers.

> But more fundamentally, if we're going to use SCPI, then those clocks
> will not be handled by that driver anyway, but by the firmware, right?

In the future, we might use SCPI clocks/sensors/regulators/etc. from Linux, but
that's not the plan at the moment. Given that it's already been two years since
I started this project, I'm trying to limit its scope so I can get at least some
part merged. The first step is to integrate a firmware that provides
suspend/resume functionality only. That firmware does implement SCPI, and if the
top-level Linux SCPI driver worked with multiple mailbox channels, it could
query the firmware's version and fetures. But all of the SCPI commands used for
suspend/resume must go through ATF via PSCI.

> So I'm not really sure that we should do it statically this way, and
> that we should do it at all.

Do you have a better way to model "firmware uses this clock behind the scenes,
so Linux please don't touch it"? It's unfortunate that we have Linux and
firmware fighting over the R_CCU, but since we didn't have firmware (e.g. SCPI
clocks) in the beginning, it's where we are today.

The AR100 clock doesn't actually have a gate, and it generally has dependencies
like R_INTC in use. So as I mentioned in the commit message, the clock will
normally be on anyway. The goal was to model the fact that there are users of
this clock that Linux doesn't/can't know about.

> Maxime

Thanks,
Samuel
