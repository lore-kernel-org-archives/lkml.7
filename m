Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACACC4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C9A21A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="XtHCSzy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfIIDWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:22:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:57512 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733187AbfIIDWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1567999329; bh=vGYPee7mKvLamg5HC7jtXbBVYj6KXR/2WLHAods+Fag=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=XtHCSzy5e62L1bITKndtj+3FFoPAdA6OegqfjwJSR/jyEmq+59SgqFa+A8wFEwHS0
         WLmj3PTQilbBuH5qhJMipBhxeByZPp/oTf4p5Fnm1GQcApTFCfSnZmqWjg2QLt07Hw
         tP6IhXE0K/lCI8SUbrEwrpjP32k4VpLdiNm8ITrA=
Date:   Mon, 9 Sep 2019 05:22:08 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Subject: Re: [PATCH v4 00/10] Allwinner sunxi message box support
Message-ID: <20190909032208.rlorx2ppytymtyej@core.my.home>
Mail-Followup-To: Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Samuel,

On Mon, Aug 19, 2019 at 10:23:01PM -0500, Samuel Holland wrote:
> This series adds support for the "hardware message box" in sun8i, sun9i,
> and sun50i SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the AR100 CPU, or to use the mailbox to forward NMIs that the
> firmware picks up from R_INTC.
> 
> Unfortunately, the ARM SCPI client no longer works with this driver
> since it now exposes all 8 hardware FIFOs individually. The SCPI client
> could be made to work (and I posted proof-of-concept code to that effect
> with v1 of this series), but that is a low priority, as Linux does not
> directly use SCPI with the current firmware version; all SCPI use goes
> through ATF via PSCI.
> 
> As requested in the comments to v3 of this patchset, a demo client is
> provided in the final patch. This demo goes along with a toy firmware
> which shows that the driver does indeed work for two-way communication
> on all channels. To build the firmware component, run:

I've tried using this driver with mainline arm_scpi driver (which is probably
an expected future use, since crust provides SCPI interface).

The problem I've found is that arm_scpi expects message box to be
bi-directional, but this driver provides uni-directional interface.

What do you think about making this driver provide bi-directional interface?
We could halve the number of channels to 4 and mandate TX/RX configuration
(from main CPU's PoV) as ABI.

Otherwise it's impossible to use it with the arm_scpi driver.

Or do you have any other ideas? I guess arm_scpi can be fixed to add a
property that would make it possible to use single shmem with two
mailboxes, one for rx and one for tx, but making sun6i mailbox have
bi-directional interface sounds easier.

regards,
	o.

>   git clone https://github.com/crust-firmware/meta meta
>   git clone -b mailbox-demo https://github.com/crust-firmware/crust meta/crust
>   cd meta
>   make
> 
> That will by default produce a U-Boot + ATF + SCP firmware image in
> [meta/]build/pinebook/u-boot-sunxi-with-spl.bin. See the top-level
> README.md for more information, such as cross-compiler setup.
> 
> I've now used this driver with three separate clients over the past two
> years, and they all work. If there are no remaining concerns with the
> driver, I'd like it to get merged.
> 
> Even without the driver, the clock patches (1-2) can go in at any time.
> 
> Changes from v3:
>   - Rebased on sunxi-next
>   - Added Rob's Reviewed-by for patch 3
>   - Fixed a crash when receiving a message on a disabled channel
>   - Cleaned up some comments/formatting in the driver
>   - Fixed #mbox-cells in sunxi-h3-h5.dtsi (patch 7)
>   - Removed the irqchip example (no longer relevant to the fw design)
>   - Added a demo/example client that uses the driver and a toy firmware
> 
> Changes from v2:
>   - Merge patches 1-3
>   - Add a comment in the code explaining the CLK_IS_CRITICAL usage
>   - Add a patch to mark the AR100 clocks as critical
>   - Use YAML for the device tree binding
>   - Include a not-for-merge example usage of the mailbox
> 
> Changes from v1:
>   - Marked message box clocks as critical instead of hacks in the driver
>   - 8 unidirectional channels instead of 4 bidirectional pairs
>   - Use per-SoC compatible strings and an A31 fallback compatible
>   - Dropped the mailbox framework patch
>   - Include DT patches for SoCs that document the message box
> 
> Samuel Holland (10):
>   clk: sunxi-ng: Mark msgbox clocks as critical
>   clk: sunxi-ng: Mark AR100 clocks as critical
>   dt-bindings: mailbox: Add a sunxi message box binding
>   mailbox: sunxi-msgbox: Add a new mailbox driver
>   ARM: dts: sunxi: a80: Add msgbox node
>   ARM: dts: sunxi: a83t: Add msgbox node
>   ARM: dts: sunxi: h3/h5: Add msgbox node
>   arm64: dts: allwinner: a64: Add msgbox node
>   arm64: dts: allwinner: h6: Add msgbox node
>   [DO NOT MERGE] drivers: firmware: msgbox demo
> 
>  .../mailbox/allwinner,sunxi-msgbox.yaml       |  79 +++++
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
>  arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  34 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  24 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   3 +-
>  drivers/clk/sunxi-ng/ccu-sun8i-r.c            |   2 +-
>  drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   3 +-
>  drivers/firmware/Kconfig                      |   6 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/sunxi_msgbox_demo.c          | 307 +++++++++++++++++
>  drivers/mailbox/Kconfig                       |  10 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/sunxi-msgbox.c                | 323 ++++++++++++++++++
>  22 files changed, 842 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
>  create mode 100644 drivers/firmware/sunxi_msgbox_demo.c
>  create mode 100644 drivers/mailbox/sunxi-msgbox.c
> 
> -- 
> 2.21.0
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
