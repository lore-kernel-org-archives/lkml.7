Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF6CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8620700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="aOE2eqQs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PO4RGiV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfDAWLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:11:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40357 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfDAWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:11:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A5D821F3A;
        Mon,  1 Apr 2019 18:04:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 01 Apr 2019 18:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=m
        v+V+ASGJHLX8XmrMvfDgVwQnqd0lgybTRdwlBX7foQ=; b=aOE2eqQs6M1GGGhBU
        9n7E6WO2batlDmLDDqXDKsamX8LLrJipWqny1AlgIC1BxC23pWkIZz6eRnPT4AXH
        j68UktnxCwGmWtsuRSVvTPbEydT+E7O6unsSYVyhYP0/kwYxDHrzALVZ+m1ZO6lB
        22lQCoc8/+SOpwFnvaZ9h0vY+kM3fsf5791iWmKSE7wuVGgkcn6FoziJV3L85fol
        KP4Y/9eFNLGjK6v28P0CAv2gF9hQJGCUp0oFunCEDUIm5lVt3RFB656k6Z25vWnf
        vCumt0Xfi2JgGdrAJcbmqmnKF2MZos70qiJHZw0o6Tqy4mJzojnMyb2/Wj13+aoV
        0kbEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=mv+V+ASGJHLX8XmrMvfDgVwQnqd0lgybTRdwlBX7f
        oQ=; b=PO4RGiV/NylXBMMit8XxwO8emwCbp4aE/RQlzYLfdIlUEz1W/maOgP/4P
        HQpDh6WVBbh0r3B4VrejVvdrdV8WRzb037ZiT8Fgzu5+ApFO7nf1eIRHNSj6rCUh
        TZ50XiZcEXX1jWypoz5VNbt4VaazVowONZmLdqPSoLaP5ebF6vLDk24EuIh1lSIL
        3084dnM9D4xg3udbN/AjjOKI96OU7EYTCjuUDsvxJrE2gS0oPqKfLh10qIhVfrg0
        fcJhpIyNPbsARoG9ln/yOfk4HhIR5n2yvN9YZWTNNlJl0ovwB3oRAPv/adXlcf+c
        VT/LbjLT3U4q6JkCasYWncrnF33Og==
X-ME-Sender: <xms:CouiXBVtMe9YFVY14KRe5H435WPPG2ud9RdFWaRmllGUi5VsvCi8og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrleehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CouiXHssO6MKw9FUY7e__QfFyWXANEbj8d8YFchU8XzGUwbMS02P8Q>
    <xmx:CouiXKIh2jpXZzzJYoV8V-F72MpzikCQoX3zDHdExH9vMaScH_u6pQ>
    <xmx:CouiXKOD-vVWqX2r1QWJjPOT08DBUs2-ADRcSFjUIhTHyx8fP7_DKg>
    <xmx:C4uiXDYb9pRDeeZDgmFWFS4ueA90cdzG7lKvkys4tact1K4H3Asm-w>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA421E4910;
        Mon,  1 Apr 2019 18:04:57 -0400 (EDT)
Subject: Re: [linux-sunxi] Re: [PATCH] soc: sunxi: Fix missing dependency on
 REGMAP_MMIO
To:     Bin Liu <b-liu@ti.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190301022044.24431-1-samuel@sholland.org>
 <20190301144348.titicfsmukd3kogj@flea> <20190401152943.GI25852@uda0271908>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <971c2594-91e0-0567-78fd-979442040209@sholland.org>
Date:   Mon, 1 Apr 2019 17:04:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190401152943.GI25852@uda0271908>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 10:29 AM, 'Bin Liu' via linux-sunxi wrote:
> On Fri, Mar 01, 2019 at 03:43:48PM +0100, Maxime Ripard wrote:
>> On Thu, Feb 28, 2019 at 08:20:44PM -0600, Samuel Holland wrote:
>>> When enabling ARCH_SUNXI from allnoconfig, SUNXI_SRAM is enabled, but
>>> not REGMAP_MMIO, so the kernel fails to link with an undefined reference
>>> to __devm_regmap_init_mmio_clk. Select REGMAP_MMIO, as suggested in
>>> drivers/base/regmap/Kconfig.
>>>
>>> This creates the following dependency loop:
>>>
>>>   drivers/of/Kconfig:68:                symbol OF_IRQ depends on IRQ_DOMAIN
>>>   kernel/irq/Kconfig:63:                symbol IRQ_DOMAIN is selected by REGMAP
>>>   drivers/base/regmap/Kconfig:7:        symbol REGMAP default is visible depending on REGMAP_MMIO
>>>   drivers/base/regmap/Kconfig:39:       symbol REGMAP_MMIO is selected by SUNXI_SRAM
>>>   drivers/soc/sunxi/Kconfig:4:          symbol SUNXI_SRAM is selected by USB_MUSB_SUNXI
>>>   drivers/usb/musb/Kconfig:63:          symbol USB_MUSB_SUNXI depends on GENERIC_PHY
>>>   drivers/phy/Kconfig:7:                symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
>>>   drivers/phy/broadcom/Kconfig:29:      symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
>>>   drivers/net/phy/Kconfig:12:           symbol MDIO_BUS default is visible depending on PHYLIB
>>>   drivers/net/phy/Kconfig:181:          symbol PHYLIB is selected by ARC_EMAC_CORE
>>>   drivers/net/ethernet/arc/Kconfig:18:  symbol ARC_EMAC_CORE is selected by ARC_EMAC
>>>   drivers/net/ethernet/arc/Kconfig:24:  symbol ARC_EMAC depends on OF_IRQ
>>>
>>> To fix the circular dependency, make USB_MUSB_SUNXI select GENERIC_PHY
>>> instead of depending on it. This matches the use of GENERIC_PHY by all
>>> but two other drivers.
> 
> Should this go to stable tree as well? Is a 'Fixes' tag for it?

Yes, I just sent v2 with these tags (although I forgot Maxime's Ack).

>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>
>> I assume it would go through the USB tree.
>>
>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Cheers,
Samuel

