Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21697C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58382196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="iu4B9w0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYLSv09/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfIIDyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:54:25 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54797 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387833AbfIIDyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:54:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5EF832963;
        Sun,  8 Sep 2019 23:54:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 08 Sep 2019 23:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=R
        8LbfYJffu40yx4D2FHnjPmSQXgd166zgHqkOmUJu4c=; b=iu4B9w0ov0PFn7Z43
        B2kcCLpfVBG6uYLLzqLuSL98yBobuzoF1/4a0hV75u06BO+EOstibZgvlQMGIx6D
        8cUn42fyLS9kpmfTUmrl0IEYNO0FJW6nRM/wyFkPUkTHTyvhC7DgS1sBxxPLMyyb
        utgvh33+KpRX0AKtR6CZR42Mt6cDhF/ts1oHapoUjNFtH7gAey6xiDTVTVFm+7K1
        Z5JQ/qQlEkR+0uCSWbVz02fR3qN0oewL/XpcLlBlLal05fT9wtgVJdEaqtQ5UPWs
        qDUn+1hcbZEF89aN69qSRtuifrxbYLCELx5DZ1xO1ex02Wv/THyMm9N8T3UpsLKB
        J8cHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=R8LbfYJffu40yx4D2FHnjPmSQXgd166zgHqkOmUJu
        4c=; b=TYLSv09/4b1ljpj1zIOINXn54LVaUxu5XSh16wEUAzmcv4sgf8vD1wbgI
        1Yq0/cKY4npJSLvprYSOqKCl3qAmBm3k9QyweaORoGvMWMFhrsIL7c6ai3d3X4kq
        5J7IYa5Go+GAUqXX29ic46/slZprthadLNjqAtgznvgqi+h406xkmqTk0cB4qt2z
        aGiL7Kf3aeGloQbdC389ODVtZIlxwAdlZ+7kSUL9iw9qNbWi+1UuVu2/BeVGFPte
        i73WMnKlOI1g9q0wxUt1jWzZnCAoJxXQ7LSrVR8GVRTxjFwVx7ViBVvUE48Syfjg
        7mp+Wl9SwhRebAT6bsTZnlyBsac6w==
X-ME-Sender: <xms:68x1XcjwMybboUx96Nz6iK21VOZ6DSCQdMlfuKtWOC02Do5B_iKODg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudekhedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuff
    homhgrihhnpehlkhhmlhdrohhrghdpghhithhhuhgsrdgtohhmpdhinhhfrhgruggvrggu
    rdhorhhgnecukfhppeejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:68x1XQZUEHW157Lt9IVLaDo51zS-UFCxLz5NVTawGFTv0MywjFMumA>
    <xmx:68x1XdcwqlkSlLXVhRY1rvm-uQEONXHXq68SIpWQL8YHpn1HhtfX-A>
    <xmx:68x1XVA99wDS0AVgMWorin6YsHvHi5Qtk6G_kOWEA7X85xIUhNlLiw>
    <xmx:78x1XcuWOUsyYKxFMvX376sVeg2m-iXP4Qk6yhVmb5fkfhlbqAqPHA>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D055580059;
        Sun,  8 Sep 2019 23:54:18 -0400 (EDT)
Subject: Re: [PATCH v4 00/10] Allwinner sunxi message box support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190909032208.rlorx2ppytymtyej@core.my.home>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bb6eab9a-f9cc-81ca-5e8c-9fb867c61ec2@sholland.org>
Date:   Sun, 8 Sep 2019 22:54:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190909032208.rlorx2ppytymtyej@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/19 10:22 PM, Ondřej Jirman wrote:
> Hello Samuel,
> 
> On Mon, Aug 19, 2019 at 10:23:01PM -0500, Samuel Holland wrote:
>> This series adds support for the "hardware message box" in sun8i, sun9i,
>> and sun50i SoCs, used for communication with the ARISC management
>> processor (the platform's equivalent of the ARM SCP). The end goal is to
>> use the arm_scpi driver as a client, communicating with firmware running
>> on the AR100 CPU, or to use the mailbox to forward NMIs that the
>> firmware picks up from R_INTC.
>>
>> Unfortunately, the ARM SCPI client no longer works with this driver
>> since it now exposes all 8 hardware FIFOs individually. The SCPI client
>> could be made to work (and I posted proof-of-concept code to that effect
>> with v1 of this series), but that is a low priority, as Linux does not
>> directly use SCPI with the current firmware version; all SCPI use goes
>> through ATF via PSCI.
>>
>> As requested in the comments to v3 of this patchset, a demo client is
>> provided in the final patch. This demo goes along with a toy firmware
>> which shows that the driver does indeed work for two-way communication
>> on all channels. To build the firmware component, run:
> 
> I've tried using this driver with mainline arm_scpi driver (which is probably
> an expected future use, since crust provides SCPI interface).

If you've verified in some way that this driver works on A83T, I'd appreciate
your Tested-by, so I can send a patch for the A83T device tree node.

> The problem I've found is that arm_scpi expects message box to be
> bi-directional, but this driver provides uni-directional interface.
> 
> What do you think about making this driver provide bi-directional interface?
> We could halve the number of channels to 4 and mandate TX/RX configuration
> (from main CPU's PoV) as ABI.

Funny you mention that. That's what I did originally for v1, but it got NAKed by
Maxime, Andre, and Jassi:

https://lkml.org/lkml/2018/2/28/125
https://lkml.org/lkml/2018/2/28/944

> Otherwise it's impossible to use it with the arm_scpi driver.
> 
> Or do you have any other ideas? I guess arm_scpi can be fixed to add a
> property that would make it possible to use single shmem with two
> mailboxes, one for rx and one for tx, but making sun6i mailbox have
> bi-directional interface sounds easier.

Yes, you can use the existence of the mbox-names property to determine if the
driver needs one mailbox or two, as I did in this driver:

https://lkml.org/lkml/2019/3/1/789

I'll have a patch available soon that implements this for arm_scpi.

Cheers,
Samuel

> regards,
> 	o.
> 
>>   git clone https://github.com/crust-firmware/meta meta
>>   git clone -b mailbox-demo https://github.com/crust-firmware/crust meta/crust
>>   cd meta
>>   make
>>
>> That will by default produce a U-Boot + ATF + SCP firmware image in
>> [meta/]build/pinebook/u-boot-sunxi-with-spl.bin. See the top-level
>> README.md for more information, such as cross-compiler setup.
>>
>> I've now used this driver with three separate clients over the past two
>> years, and they all work. If there are no remaining concerns with the
>> driver, I'd like it to get merged.
>>
>> Even without the driver, the clock patches (1-2) can go in at any time.
>>
>> Changes from v3:
>>   - Rebased on sunxi-next
>>   - Added Rob's Reviewed-by for patch 3
>>   - Fixed a crash when receiving a message on a disabled channel
>>   - Cleaned up some comments/formatting in the driver
>>   - Fixed #mbox-cells in sunxi-h3-h5.dtsi (patch 7)
>>   - Removed the irqchip example (no longer relevant to the fw design)
>>   - Added a demo/example client that uses the driver and a toy firmware
>>
>> Changes from v2:
>>   - Merge patches 1-3
>>   - Add a comment in the code explaining the CLK_IS_CRITICAL usage
>>   - Add a patch to mark the AR100 clocks as critical
>>   - Use YAML for the device tree binding
>>   - Include a not-for-merge example usage of the mailbox
>>
>> Changes from v1:
>>   - Marked message box clocks as critical instead of hacks in the driver
>>   - 8 unidirectional channels instead of 4 bidirectional pairs
>>   - Use per-SoC compatible strings and an A31 fallback compatible
>>   - Dropped the mailbox framework patch
>>   - Include DT patches for SoCs that document the message box
>>
>> Samuel Holland (10):
>>   clk: sunxi-ng: Mark msgbox clocks as critical
>>   clk: sunxi-ng: Mark AR100 clocks as critical
>>   dt-bindings: mailbox: Add a sunxi message box binding
>>   mailbox: sunxi-msgbox: Add a new mailbox driver
>>   ARM: dts: sunxi: a80: Add msgbox node
>>   ARM: dts: sunxi: a83t: Add msgbox node
>>   ARM: dts: sunxi: h3/h5: Add msgbox node
>>   arm64: dts: allwinner: a64: Add msgbox node
>>   arm64: dts: allwinner: h6: Add msgbox node
>>   [DO NOT MERGE] drivers: firmware: msgbox demo
>>
>>  .../mailbox/allwinner,sunxi-msgbox.yaml       |  79 +++++
>>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
>>  arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
>>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  34 ++
>>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  24 ++
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   2 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   3 +-
>>  drivers/clk/sunxi-ng/ccu-sun8i-r.c            |   2 +-
>>  drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   3 +-
>>  drivers/firmware/Kconfig                      |   6 +
>>  drivers/firmware/Makefile                     |   1 +
>>  drivers/firmware/sunxi_msgbox_demo.c          | 307 +++++++++++++++++
>>  drivers/mailbox/Kconfig                       |  10 +
>>  drivers/mailbox/Makefile                      |   2 +
>>  drivers/mailbox/sunxi-msgbox.c                | 323 ++++++++++++++++++
>>  22 files changed, 842 insertions(+), 9 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
>>  create mode 100644 drivers/firmware/sunxi_msgbox_demo.c
>>  create mode 100644 drivers/mailbox/sunxi-msgbox.c
>>
>> -- 
>> 2.21.0
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

