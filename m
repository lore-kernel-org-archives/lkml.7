Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A276C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038CD208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfDAXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:19:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfDAXTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1A1AACFB;
        Mon,  1 Apr 2019 23:19:00 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mips@vger.kernel.org
Date:   Tue, 02 Apr 2019 10:18:50 +1100
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices
In-Reply-To: <20190321144251.28313-1-gch981213@gmail.com>
References: <20190321144251.28313-1-gch981213@gmail.com>
Message-ID: <8736n12u1x.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21 2019, Chuanhong Guo wrote:

> For a long time the mt7621 uses a fixed cpu clock which causes a problem
> if the cpu frequency is not 880MHz.
>
> This patch fixes the cpu clock calculation and adds the cpu/bus clkdev
> which will be used in dts.
>
> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
>
> Ported from OpenWrt:
> c7ca224299 ramips: fix cpu clock of mt7621 and add dt clk devices
>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Thanks for posting this.
I've been using this patch on my mt7621 board (gnubee NAS) for a while
and it is much better than having to specify the clock speed in the DTS
file.
  Tested-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
>
> Change since v1:
>  Correctly fix the following checkpatch.pl warning:
>  WARNING: Missing a blank line after declarations
>  #137: FILE: arch/mips/ralink/mt7621.c:146:
>  +	u32 xtal_clk, cpu_clk, bus_clk;
>  +	const static u32 prediv_tbl[] =3D {0, 1, 2, 2};
>
>  arch/mips/include/asm/mach-ralink/mt7621.h |  20 ++++
>  arch/mips/ralink/mt7621.c                  | 102 ++++++++++++++-------
>  arch/mips/ralink/timer-gic.c               |   4 +-
>  3 files changed, 93 insertions(+), 33 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/inclu=
de/asm/mach-ralink/mt7621.h
> index a672e06fa5fd..b8a8834164c8 100644
> --- a/arch/mips/include/asm/mach-ralink/mt7621.h
> +++ b/arch/mips/include/asm/mach-ralink/mt7621.h
> @@ -19,6 +19,10 @@
>  #define SYSC_REG_CHIP_REV		0x0c
>  #define SYSC_REG_SYSTEM_CONFIG0		0x10
>  #define SYSC_REG_SYSTEM_CONFIG1		0x14
> +#define SYSC_REG_CLKCFG0		0x2c
> +#define SYSC_REG_CUR_CLK_STS		0x44
> +
> +#define MEMC_REG_CPU_PLL		0x648
>=20=20
>  #define CHIP_REV_PKG_MASK		0x1
>  #define CHIP_REV_PKG_SHIFT		16
> @@ -26,6 +30,22 @@
>  #define CHIP_REV_VER_SHIFT		8
>  #define CHIP_REV_ECO_MASK		0xf
>=20=20
> +#define XTAL_MODE_SEL_MASK		0x7
> +#define XTAL_MODE_SEL_SHIFT		6
> +
> +#define CPU_CLK_SEL_MASK		0x3
> +#define CPU_CLK_SEL_SHIFT		30
> +
> +#define CUR_CPU_FDIV_MASK		0x1f
> +#define CUR_CPU_FDIV_SHIFT		8
> +#define CUR_CPU_FFRAC_MASK		0x1f
> +#define CUR_CPU_FFRAC_SHIFT		0
> +
> +#define CPU_PLL_PREDIV_MASK		0x3
> +#define CPU_PLL_PREDIV_SHIFT		12
> +#define CPU_PLL_FBDIV_MASK		0x7f
> +#define CPU_PLL_FBDIV_SHIFT		4
> +
>  #define MT7621_DRAM_BASE                0x0
>  #define MT7621_DDR2_SIZE_MIN		32
>  #define MT7621_DDR2_SIZE_MAX		256
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index d2718de60b9b..6828eefb0a85 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -9,22 +9,22 @@
>=20=20
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <dt-bindings/clock/mt7621-clk.h>
>=20=20
>  #include <asm/mipsregs.h>
>  #include <asm/smp-ops.h>
>  #include <asm/mips-cps.h>
>  #include <asm/mach-ralink/ralink_regs.h>
>  #include <asm/mach-ralink/mt7621.h>
> +#include <asm/time.h>
>=20=20
>  #include <pinmux.h>
>=20=20
>  #include "common.h"
>=20=20
> -#define SYSC_REG_SYSCFG		0x10
> -#define SYSC_REG_CPLL_CLKCFG0	0x2c
> -#define SYSC_REG_CUR_CLK_STS	0x44
> -#define CPU_CLK_SEL		(BIT(30) | BIT(31))
> -
>  #define MT7621_GPIO_MODE_UART1		1
>  #define MT7621_GPIO_MODE_I2C		2
>  #define MT7621_GPIO_MODE_UART3_MASK	0x3
> @@ -110,49 +110,89 @@ static struct rt2880_pmx_group mt7621_pinmux_data[]=
 =3D {
>  	{ 0 }
>  };
>=20=20
> +static struct clk *clks[MT7621_CLK_MAX];
> +static struct clk_onecell_data clk_data =3D {
> +	.clks =3D clks,
> +	.clk_num =3D ARRAY_SIZE(clks),
> +};
> +
>  phys_addr_t mips_cpc_default_phys_base(void)
>  {
>  	panic("Cannot detect cpc address");
>  }
>=20=20
> +static struct clk *__init mt7621_add_sys_clkdev(
> +	const char *id, unsigned long rate)
> +{
> +	struct clk *clk;
> +	int err;
> +
> +	clk =3D clk_register_fixed_rate(NULL, id, NULL, 0, rate);
> +	if (IS_ERR(clk))
> +		panic("failed to allocate %s clock structure", id);
> +
> +	err =3D clk_register_clkdev(clk, id, NULL);
> +	if (err)
> +		panic("unable to register %s clock device", id);
> +
> +	return clk;
> +}
> +
>  void __init ralink_clk_init(void)
>  {
> -	int cpu_fdiv =3D 0;
> -	int cpu_ffrac =3D 0;
> -	int fbdiv =3D 0;
> -	u32 clk_sts, syscfg;
> -	u8 clk_sel =3D 0, xtal_mode;
> -	u32 cpu_clk;
> +	const static u32 prediv_tbl[] =3D {0, 1, 2, 2};
> +	u32 syscfg, xtal_sel, clkcfg, clk_sel, curclk, ffiv, ffrac;
> +	u32 pll, prediv, fbdiv;
> +	u32 xtal_clk, cpu_clk, bus_clk;
> +
> +	syscfg =3D rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
> +	xtal_sel =3D (syscfg >> XTAL_MODE_SEL_SHIFT) & XTAL_MODE_SEL_MASK;
>=20=20
> -	if ((rt_sysc_r32(SYSC_REG_CPLL_CLKCFG0) & CPU_CLK_SEL) !=3D 0)
> -		clk_sel =3D 1;
> +	clkcfg =3D rt_sysc_r32(SYSC_REG_CLKCFG0);
> +	clk_sel =3D (clkcfg >> CPU_CLK_SEL_SHIFT) & CPU_CLK_SEL_MASK;
> +
> +	curclk =3D rt_sysc_r32(SYSC_REG_CUR_CLK_STS);
> +	ffiv =3D (curclk >> CUR_CPU_FDIV_SHIFT) & CUR_CPU_FDIV_MASK;
> +	ffrac =3D (curclk >> CUR_CPU_FFRAC_SHIFT) & CUR_CPU_FFRAC_MASK;
> +
> +	if (xtal_sel <=3D 2)
> +		xtal_clk =3D 20 * 1000 * 1000;
> +	else if (xtal_sel <=3D 5)
> +		xtal_clk =3D 40 * 1000 * 1000;
> +	else
> +		xtal_clk =3D 25 * 1000 * 1000;
>=20=20
>  	switch (clk_sel) {
>  	case 0:
> -		clk_sts =3D rt_sysc_r32(SYSC_REG_CUR_CLK_STS);
> -		cpu_fdiv =3D ((clk_sts >> 8) & 0x1F);
> -		cpu_ffrac =3D (clk_sts & 0x1F);
> -		cpu_clk =3D (500 * cpu_ffrac / cpu_fdiv) * 1000 * 1000;
> +		cpu_clk =3D 500 * 1000 * 1000;
>  		break;
> -
>  	case 1:
> -		fbdiv =3D ((rt_sysc_r32(0x648) >> 4) & 0x7F) + 1;
> -		syscfg =3D rt_sysc_r32(SYSC_REG_SYSCFG);
> -		xtal_mode =3D (syscfg >> 6) & 0x7;
> -		if (xtal_mode >=3D 6) {
> -			/* 25Mhz Xtal */
> -			cpu_clk =3D 25 * fbdiv * 1000 * 1000;
> -		} else if (xtal_mode >=3D 3) {
> -			/* 40Mhz Xtal */
> -			cpu_clk =3D 40 * fbdiv * 1000 * 1000;
> -		} else {
> -			/* 20Mhz Xtal */
> -			cpu_clk =3D 20 * fbdiv * 1000 * 1000;
> -		}
> +		pll =3D rt_memc_r32(MEMC_REG_CPU_PLL);
> +		fbdiv =3D (pll >> CPU_PLL_FBDIV_SHIFT) & CPU_PLL_FBDIV_MASK;
> +		prediv =3D (pll >> CPU_PLL_PREDIV_SHIFT) & CPU_PLL_PREDIV_MASK;
> +		cpu_clk =3D ((fbdiv + 1) * xtal_clk) >> prediv_tbl[prediv];
>  		break;
> +	default:
> +		cpu_clk =3D xtal_clk;
>  	}
> +
> +	cpu_clk =3D cpu_clk / ffiv * ffrac;
> +	bus_clk =3D cpu_clk / 4;
> +
> +	clks[MT7621_CLK_CPU] =3D mt7621_add_sys_clkdev("cpu", cpu_clk);
> +	clks[MT7621_CLK_BUS] =3D mt7621_add_sys_clkdev("bus", bus_clk);
> +
> +	pr_info("CPU Clock: %dMHz\n", cpu_clk / 1000000);
> +	mips_hpt_frequency =3D cpu_clk / 2;
>  }
>=20=20
> +static void __init mt7621_clocks_init_dt(struct device_node *np)
> +{
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +
> +CLK_OF_DECLARE(mt7621_clk, "mediatek,mt7621-pll", mt7621_clocks_init_dt);
> +
>  void __init ralink_of_remap(void)
>  {
>  	rt_sysc_membase =3D plat_of_remap_node("mtk,mt7621-sysc");
> diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
> index b5f07d21fcf2..4fed842ae8eb 100644
> --- a/arch/mips/ralink/timer-gic.c
> +++ b/arch/mips/ralink/timer-gic.c
> @@ -11,14 +11,14 @@
>=20=20
>  #include <linux/of.h>
>  #include <linux/clk-provider.h>
> -#include <linux/clocksource.h>
> +#include <asm/time.h>
>=20=20
>  #include "common.h"
>=20=20
>  void __init plat_time_init(void)
>  {
>  	ralink_of_remap();
> -
> +	ralink_clk_init();
>  	of_clk_init(NULL);
>  	timer_probe();
>  }
> --=20
> 2.21.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyinFsACgkQOeye3VZi
gbk5RRAAk/vEJPo+gZ/6bq0NA4pjwbhgqTFF4aZ4e7d5Ls5hVAX5lA54vFCqLsjR
wVL1lwGM4uO+Z5THrc+3vA61wBf46SDh3O0N6QkqSQwracxd8zFyYeOdvXaN6m5F
StZ+m/DydOpe1PAHBz4slz7err0NAsQUQ8cUTaYPj5ovp6ooVO5DNgc2zDHf0dAL
WSImGHCQ+7qUWmOYXXfknbCFji3psKWDnPqxYMBwGfbq6zjCP8r+3O4jrBHi7eGE
Ord9vWeOJQPrtar+6kCUzHJzGe0+w8VQoYPFUMSpsRG/xmTxyk3XnNNsXLR1CciK
o4AghsX3QZBQPu/i7PDCnlDBA90EWOXdF8SbR5Lshvny0F2NOeNtpzYGgvkp13zm
dTFRyzKGYYu1AFTyviFoopUcWkiPsTLW5wD/yILVFm7RqDmBU+j+XJLcDxdijQQ/
vN8pnnE5G8xSEo/ms/+XqMUqL+lZ+OKbq3HwDFSN0ZEkluGe/y/z9GKMa5aym5/N
3mH+V3PHHsiVthrIdwLzk56KxcYtD2/aBD7fpg+I+EavYg/KIbd4hGSnojNnsYVh
nxtkHp2mDoQvLwZWmaETm1u8Meho0PZReR5+f0uT0Nh6THxXBfeUY8rXXBRswH/Q
xifhDj1Rec57sjEnZGtexTv4pW8DsuVgGB2Ca5FeiNZuj3hHIzk=
=Aafe
-----END PGP SIGNATURE-----
--=-=-=--
