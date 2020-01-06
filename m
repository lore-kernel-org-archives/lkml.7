Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289BC33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F01217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578279557;
	bh=Fevvnl4RnqYZ7TIx/wmZITfpCbFbNblxka/5cM3df40=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=PCWKXIpvzFfejj5210S1jW1A23A23dFEFxcjiXdHDaoR3tn4J8EuRuPyUY8TZjds3
	 iK0KTXzhdXuMBySVZiHLm29CzrDBlth5kjHID+lwaQvutEERYUcX+oiDfeIjQsxKPo
	 2U0XyLrwO/jeWaQ9vvXFlRm15xKv6Io1mB0YUFTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgAFC7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFC7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:59:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A180E206F0;
        Mon,  6 Jan 2020 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578279554;
        bh=Fevvnl4RnqYZ7TIx/wmZITfpCbFbNblxka/5cM3df40=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=TLie7Vn3TeYHwtqiDX04AsTUgrJsDbSxZcL8qqY4YIHCRaQvLsic9ntW0eYTN1X0a
         waKC7lNKOmCt8Z05eE62Wy+5oYIq8WyKAI7rlSbLGeSFEAKArimYyVf6JeJ9Jm8Zg1
         8f4VHnYCQHtbgSMuwPBZ9S3A2435ZlYW/uzvF8F8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1577412748-28213-2-git-send-email-Anson.Huang@nxp.com>
References: <1577412748-28213-1-git-send-email-Anson.Huang@nxp.com> <1577412748-28213-2-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
        mark.rutland@arm.com, maxime@cerno.tech, mturquette@baylibre.com,
        olof@lixom.net, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, will@kernel.org
Subject: Re: [PATCH 2/3] clk: imx: Add support for i.MX8MP clock driver
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 18:59:13 -0800
Message-Id: <20200106025914.A180E206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-12-26 18:12:27)
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> new file mode 100644
> index 0000000..7f0d482
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -0,0 +1,767 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <linux/clk.h>

Please include clk-provider.h as this is a clk provider. If possible,
don't include clk.h as this shouldn't be a consumer.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Is this include used?

> +#include <linux/of_address.h>

Is this include used?

> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +static u32 share_count_nand;
> +static u32 share_count_media;
> +
> +static const char *pll_ref_sels[] =3D { "osc_24m", "dummy", "dummy", "du=
mmy", };

Is it possible to make these const char * const foo[] arrays?

> +static const char *audio_pll1_bypass_sels[] =3D {"audio_pll1", "audio_pl=
l1_ref_sel", };
> +static const char *audio_pll2_bypass_sels[] =3D {"audio_pll2", "audio_pl=
l2_ref_sel", };
> +static const char *video_pll1_bypass_sels[] =3D {"video_pll1", "video_pl=
l1_ref_sel", };
[...]
> +       clk_set_parent(clks[IMX8MP_AUDIO_PLL1_BYPASS], clks[IMX8MP_AUDIO_=
PLL1]);
> +       clk_set_parent(clks[IMX8MP_AUDIO_PLL2_BYPASS], clks[IMX8MP_AUDIO_=
PLL2]);
> +       clk_set_parent(clks[IMX8MP_VIDEO_PLL1_BYPASS], clks[IMX8MP_VIDEO_=
PLL1]);
> +       clk_set_parent(clks[IMX8MP_DRAM_PLL_BYPASS], clks[IMX8MP_DRAM_PLL=
]);
> +       clk_set_parent(clks[IMX8MP_GPU_PLL_BYPASS], clks[IMX8MP_GPU_PLL]);
> +       clk_set_parent(clks[IMX8MP_VPU_PLL_BYPASS], clks[IMX8MP_VPU_PLL]);
> +       clk_set_parent(clks[IMX8MP_ARM_PLL_BYPASS], clks[IMX8MP_ARM_PLL]);
> +       clk_set_parent(clks[IMX8MP_SYS_PLL1_BYPASS], clks[IMX8MP_SYS_PLL1=
]);
> +       clk_set_parent(clks[IMX8MP_SYS_PLL2_BYPASS], clks[IMX8MP_SYS_PLL2=
]);
> +       clk_set_parent(clks[IMX8MP_SYS_PLL3_BYPASS], clks[IMX8MP_SYS_PLL3=
]);

These can't be done with assigned-clock-parents properties in DT?

> +
> +       clks[IMX8MP_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "a=
udio_pll1_bypass", base, 13);
> +       clks[IMX8MP_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "a=
udio_pll2_bypass", base + 0x14, 13);
> +       clks[IMX8MP_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "v=
ideo_pll1_bypass", base + 0x28, 13);
> +       clks[IMX8MP_DRAM_PLL_OUT] =3D imx_clk_gate("dram_pll_out", "dram_=
pll_bypass", base + 0x50, 13);
> +       clks[IMX8MP_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll=
_bypass", base + 0x64, 11);
> +       clks[IMX8MP_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll=
_bypass", base + 0x74, 11);
> +       clks[IMX8MP_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll=
_bypass", base + 0x84, 11);
> +       clks[IMX8MP_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_p=
ll1_bypass", base + 0x94, 11);
> +       clks[IMX8MP_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_p=
ll2_bypass", base + 0x104, 11);
> +       clks[IMX8MP_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_p=
ll3_bypass", base + 0x114, 11);

Any reason why we can't get back clk_hw pointers instead and register a
hw based provider?

> +
> +       clks[IMX8MP_SYS_PLL1_40M] =3D imx_clk_fixed_factor("sys_pll1_40m"=
, "sys_pll1_out", 1, 20);
> +       clks[IMX8MP_SYS_PLL1_80M] =3D imx_clk_fixed_factor("sys_pll1_80m"=
, "sys_pll1_out", 1, 10);
> +       clks[IMX8MP_SYS_PLL1_100M] =3D imx_clk_fixed_factor("sys_pll1_100=
m", "sys_pll1_out", 1, 8);
> +       clks[IMX8MP_SYS_PLL1_133M] =3D imx_clk_fixed_factor("sys_pll1_133=
m", "sys_pll1_out", 1, 6);
> +       clks[IMX8MP_SYS_PLL1_160M] =3D imx_clk_fixed_factor("sys_pll1_160=
m", "sys_pll1_out", 1, 5);
> +       clks[IMX8MP_SYS_PLL1_200M] =3D imx_clk_fixed_factor("sys_pll1_200=
m", "sys_pll1_out", 1, 4);
> +       clks[IMX8MP_SYS_PLL1_266M] =3D imx_clk_fixed_factor("sys_pll1_266=
m", "sys_pll1_out", 1, 3);
> +       clks[IMX8MP_SYS_PLL1_400M] =3D imx_clk_fixed_factor("sys_pll1_400=
m", "sys_pll1_out", 1, 2);
> +       clks[IMX8MP_SYS_PLL1_800M] =3D imx_clk_fixed_factor("sys_pll1_800=
m", "sys_pll1_out", 1, 1);
> +
> +       clks[IMX8MP_SYS_PLL2_50M] =3D imx_clk_fixed_factor("sys_pll2_50m"=
, "sys_pll2_out", 1, 20);
> +       clks[IMX8MP_SYS_PLL2_100M] =3D imx_clk_fixed_factor("sys_pll2_100=
m", "sys_pll2_out", 1, 10);
> +       clks[IMX8MP_SYS_PLL2_125M] =3D imx_clk_fixed_factor("sys_pll2_125=
m", "sys_pll2_out", 1, 8);
> +       clks[IMX8MP_SYS_PLL2_166M] =3D imx_clk_fixed_factor("sys_pll2_166=
m", "sys_pll2_out", 1, 6);
> +       clks[IMX8MP_SYS_PLL2_200M] =3D imx_clk_fixed_factor("sys_pll2_200=
m", "sys_pll2_out", 1, 5);
> +       clks[IMX8MP_SYS_PLL2_250M] =3D imx_clk_fixed_factor("sys_pll2_250=
m", "sys_pll2_out", 1, 4);
> +       clks[IMX8MP_SYS_PLL2_333M] =3D imx_clk_fixed_factor("sys_pll2_333=
m", "sys_pll2_out", 1, 3);
> +       clks[IMX8MP_SYS_PLL2_500M] =3D imx_clk_fixed_factor("sys_pll2_500=
m", "sys_pll2_out", 1, 2);
> +       clks[IMX8MP_SYS_PLL2_1000M] =3D imx_clk_fixed_factor("sys_pll2_10=
00m", "sys_pll2_out", 1, 1);
> +
> +       np =3D dev->of_node;
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (WARN_ON(IS_ERR(base))) {
> +               ret =3D PTR_ERR(base);
> +               goto unregister_clks;

Why not ioremap first so we don't have to unwind clk registration on
failure?

> +       }
> +
> +       clks[IMX8MP_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0=
x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels));
> +       clks[IMX8MP_CLK_M7_SRC] =3D imx_clk_mux2("arm_m7_src", base + 0x8=
080, 24, 3, imx8mp_m7_sels, ARRAY_SIZE(imx8mp_m7_sels));
> +       clks[IMX8MP_CLK_ML_SRC] =3D imx_clk_mux2("ml_src", base + 0x8100,=
 24, 3, imx8mp_ml_sels, ARRAY_SIZE(imx8mp_ml_sels));
> +       clks[IMX8MP_CLK_GPU3D_CORE_SRC] =3D imx_clk_mux2("gpu3d_core_src"=
, base + 0x8180, 24, 3,  imx8mp_gpu3d_core_sels, ARRAY_SIZE(imx8mp_gpu3d_co=
re_sels));
> +       clks[IMX8MP_CLK_GPU3D_SHADER_SRC] =3D imx_clk_mux2("gpu3d_shader_=
src", base + 0x8200, 24, 3, imx8mp_gpu3d_shader_sels, ARRAY_SIZE(imx8mp_gpu=
3d_shader_sels));
> +       clks[IMX8MP_CLK_GPU2D_SRC] =3D imx_clk_mux2("gpu2d_src", base + 0=
x8280, 24, 3, imx8mp_gpu2d_sels, ARRAY_SIZE(imx8mp_gpu2d_sels));
> +       clks[IMX8MP_CLK_AUDIO_AXI_SRC] =3D imx_clk_mux2("audio_axi_src", =
base + 0x8300, 24, 3, imx8mp_audio_axi_sels, ARRAY_SIZE(imx8mp_audio_axi_se=
ls));
[...]
> +
> +       imx_register_uart_clocks(uart_clks);
> +
> +       return 0;
> +
> +unregister_clks:
> +       imx_unregister_clocks(clks, ARRAY_SIZE(clks));
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id imx8mp_clk_of_match[] =3D {
> +       { .compatible =3D "fsl,imx8mp-ccm" },
> +       { /* Sentinel */ },

Please drop the comma after sentinel so that nothing can go after it.

> +};
> +MODULE_DEVICE_TABLE(of, imx8mp_clk_of_match);
> +
> +static struct platform_driver imx8mp_clk_driver =3D {
> +       .probe =3D imx8mp_clocks_probe,
