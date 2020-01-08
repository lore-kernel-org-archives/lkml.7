Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A9C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6772073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgAHKWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:22:36 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52041 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgAHKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:22:34 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CC9E024000E;
        Wed,  8 Jan 2020 10:22:30 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
In-Reply-To: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
Date:   Wed, 08 Jan 2020 11:22:30 +0100
Message-ID: <8736cqb63d.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

> U-boot disables MBUS error propagation for Armada-385. The effect of
> this on the kernel is that any access to a mapped but inaccessible
> address causes the system to hang.
>
> By enabling MBUS error propagation the kernel can raise a Bus Error and
> panic to restart the system.

Unless I miss it, it seems that nobody comment this patch: sorry for the
delay.

>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     We've encountered an issue where rogue accesses to PCI-e space cause an
>     Armada-385 system to lockup. We've found that enabling MBUS error
>     propagation lets us get a bus error which at least gives us a panic to
>     help identify what was accessed.
>     
>     U-boot clears the IO Err Prop Enable Bit[1] but so far no-one seems to
>     know why.
>     
>     I wasn't sure where to put this code. There is similar code for kirwood
>     in the equivalent dt_init function. On Armada-XP the register is part of
>     the Core Coherency Fabric block (for A385 it's documented as part of the
>     CCF block).

What about adding a new set of register to the mvebu mbus driver?

In this case it will be called even earlier allowing to see bus error
earlier.

In any case, you should separate the device tree change from the code
change and at least provide 2 patches.

Gregory

>     
>     --
>     [1] - https://gitlab.denx.de/u-boot/u-boot/blob/master/arch/arm/mach-mvebu/cpu.c#L489
>
>  arch/arm/boot/dts/armada-38x.dtsi |  5 +++++
>  arch/arm/mach-mvebu/board-v7.c    | 27 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 3f4bb44d85f0..3214c67433eb 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -386,6 +386,11 @@
>  				      <0x20250 0x8>;
>  			};
>  
> +			ioerrc: io-err-control@20200 {
> +				compatible = "marvell,io-err-control";
> +				reg = <0x20200 0x4>;
> +			};
> +
>  			mpic: interrupt-controller@20a00 {
>  				compatible = "marvell,mpic";
>  				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index d2df5ef9382b..fb7718386ef9 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -138,10 +138,36 @@ static void __init i2c_quirk(void)
>  	}
>  }
>  
> +#define MBUS_ERR_PROP_EN BIT(8)
> +
> +/*
> + * U-boot disables MBUS error propagation. Re-enable it so we
> + * can handle them as Bus Errors.
> + */
> +static void __init enable_mbus_error_propagation(void)
> +{
> +	struct device_node *np =
> +		of_find_compatible_node(NULL, NULL, "marvell,io-err-control");
> +
> +	if (np) {
> +		void __iomem *reg;
> +
> +		reg = of_iomap(np, 0);
> +		if (reg) {
> +			u32 val;
> +
> +			val = readl_relaxed(reg);
> +			writel_relaxed(val | MBUS_ERR_PROP_EN, reg);
> +		}
> +		of_node_put(np);
> +	}
> +}
> +
>  static void __init mvebu_dt_init(void)
>  {
>  	if (of_machine_is_compatible("marvell,armadaxp"))
>  		i2c_quirk();
> +	enable_mbus_error_propagation();
>  }
>  
>  static void __init armada_370_xp_dt_fixup(void)
> @@ -191,6 +217,7 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
>  	.l2c_aux_val	= 0,
>  	.l2c_aux_mask	= ~0,
>  	.init_irq       = mvebu_init_irq,
> +	.init_machine	= mvebu_dt_init,
>  	.restart	= mvebu_restart,
>  	.dt_compat	= armada_38x_dt_compat,
>  MACHINE_END
> -- 
> 2.24.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
