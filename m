Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E963C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2531A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565828846;
	bh=4QD7Yk9ya09l1BYXkFzaH6f/MQAdtDiTlU/hy2yf93s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gCeg40nvhvLuTv41x9MKLXfni225GUgVzxmqVtvjwUAj3FFZutJi2IxbX1IBj+YQ5
	 WSI7Wf+YTuT5q7mCf7aNnLI//inNZJXW0r8C5mRdzcel+2GlzR7m1aNS77/RwhZEM/
	 tlrunZmJlY01nsQEaVU6Fsg80erXNd8aQRN0q2ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfHOA1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfHOA1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:27:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71C72083B;
        Thu, 15 Aug 2019 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565828841;
        bh=4QD7Yk9ya09l1BYXkFzaH6f/MQAdtDiTlU/hy2yf93s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GWEev4ti/zpH5NkWvdRHWHVC5rtGnCFwG9y0sBVYQBJp6ooktPmxhpe9Lvyd9C5dj
         ORtsiqRQ/hl+Q//gM3NuYjiRF/V6lDE7d8o0a4hGuTY3mGZCGhxENp0572tM7+mePH
         kcvE2LJVBvyBLaLD6Hhj0BSxxvxQOQwo08dN1r2c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1562924653-10056-6-git-send-email-macpaul.lin@mediatek.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com> <1562924653-10056-6-git-send-email-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v6 5/8] clk: mediatek: Add MT6765 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 17:27:20 -0700
Message-Id: <20190815002721.A71C72083B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Macpaul Lin (2019-07-12 02:43:41)
> diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediat=
ek/clk-mt6765-audio.c
> new file mode 100644
> index 000000000000..41f19343dfb9
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6765-audio.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Please use SPDX tags.

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/media=
tek/clk-mt6765-vcodec.c
> new file mode 100644
> index 000000000000..eb9ae1c2c99c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

SPDX tags.

> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk=
-mt6765.c
> new file mode 100644
> index 000000000000..f716a48a926d
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -0,0 +1,961 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

SPDX tags.

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>

Is this used? Maybe I deleted it.

> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
[...]
> +
> +static const char * const axi_parents[] =3D {
> +       "clk26m",
> +       "syspll_d7",
> +       "syspll1_d4",
> +       "syspll3_d2"
> +};
> +
> +static const char * const mem_parents[] =3D {
> +       "clk26m",
> +       "dmpll_ck",
> +       "apll1_ck"
> +};
> +
> +static const char * const mm_parents[] =3D {
> +       "clk26m",
> +       "mmpll_ck",
> +       "syspll1_d2",
> +       "syspll_d5",
> +       "syspll1_d4",
> +       "univpll_d5",
> +       "univpll1_d2",
> +       "mmpll_d2"
> +};
> +
> +static const char * const scp_parents[] =3D {
> +       "clk26m",
> +       "syspll4_d2",
> +       "univpll2_d2",
> +       "syspll1_d2",
> +       "univpll1_d2",
> +       "syspll_d3",
> +       "univpll_d3"
> +};
> +
> +static const char * const mfg_parents[] =3D {
> +       "clk26m",
> +       "mfgpll_ck",
> +       "syspll_d3",
> +       "univpll_d3"
> +};
> +
> +static const char * const atb_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d4",
> +       "syspll1_d2"
> +};
> +
> +static const char * const camtg_parents[] =3D {
> +       "clk26m",
> +       "usb20_192m_d8",
> +       "univpll2_d8",
> +       "usb20_192m_d4",
> +       "univpll2_d32",
> +       "usb20_192m_d16",
> +       "usb20_192m_d32"
> +};
> +
> +static const char * const uart_parents[] =3D {
> +       "clk26m",
> +       "univpll2_d8"
> +};
> +
> +static const char * const spi_parents[] =3D {
> +       "clk26m",
> +       "syspll3_d2",
> +       "syspll4_d2",
> +       "syspll2_d4"
> +};
> +
> +static const char * const msdc5hclk_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d2",
> +       "univpll1_d4",
> +       "syspll2_d2"
> +};
> +
> +static const char * const msdc50_0_parents[] =3D {
> +       "clk26m",
> +       "msdcpll_ck",
> +       "syspll2_d2",
> +       "syspll4_d2",
> +       "univpll1_d2",
> +       "syspll1_d2",
> +       "univpll_d5",
> +       "univpll1_d4"
> +};
> +
> +static const char * const msdc30_1_parents[] =3D {
> +       "clk26m",
> +       "msdcpll_d2",
> +       "univpll2_d2",
> +       "syspll2_d2",
> +       "syspll1_d4",
> +       "univpll1_d4",
> +       "usb20_192m_d4",
> +       "syspll2_d4"
> +};
> +
> +static const char * const audio_parents[] =3D {
> +       "clk26m",
> +       "syspll3_d4",
> +       "syspll4_d4",
> +       "syspll1_d16"
> +};
> +
> +static const char * const aud_intbus_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d4",
> +       "syspll4_d2"
> +};
> +
> +static const char * const aud_1_parents[] =3D {
> +       "clk26m",
> +       "apll1_ck"
> +};
> +
> +static const char * const aud_engen1_parents[] =3D {
> +       "clk26m",
> +       "apll1_d2",
> +       "apll1_d4",
> +       "apll1_d8"
> +};
> +
> +static const char * const disp_pwm_parents[] =3D {
> +       "clk26m",
> +       "univpll2_d4",
> +       "ulposc1_d2",
> +       "ulposc1_d8"
> +};
> +
> +static const char * const sspm_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d2",
> +       "syspll_d3"
> +};
> +
> +static const char * const dxcc_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d2",
> +       "syspll1_d4",
> +       "syspll1_d8"
> +};
> +
> +static const char * const usb_top_parents[] =3D {
> +       "clk26m",
> +       "univpll3_d4"
> +};
> +
> +static const char * const spm_parents[] =3D {
> +       "clk26m",
> +       "syspll1_d8"
> +};
> +
> +static const char * const i2c_parents[] =3D {
> +       "clk26m",
> +       "univpll3_d4",
> +       "univpll3_d2",
> +       "syspll1_d8",
> +       "syspll2_d8"
> +};
> +
> +static const char * const pwm_parents[] =3D {
> +       "clk26m",
> +       "univpll3_d4",
> +       "syspll1_d8"
> +};
> +
> +static const char * const seninf_parents[] =3D {
> +       "clk26m",
> +       "univpll1_d4",
> +       "univpll1_d2",
> +       "univpll2_d2"
> +};
> +
> +static const char * const aes_fde_parents[] =3D {
> +       "clk26m",
> +       "msdcpll_ck",
> +       "univpll_d3",
> +       "univpll2_d2",
> +       "univpll1_d2",
> +       "syspll1_d2"
> +};
> +
> +static const char * const ulposc_parents[] =3D {
> +       "clk26m",
> +       "ulposc1_d4",
> +       "ulposc1_d8",
> +       "ulposc1_d16",
> +       "ulposc1_d32"
> +};
> +
> +static const char * const camtm_parents[] =3D {
> +       "clk26m",
> +       "univpll1_d4",
> +       "univpll1_d2",
> +       "univpll2_d2"
> +};
> +

Can you migrate this driver to the new way of specifying clk parents?
That way we don't just have lists of strings.

> +#define INVALID_UPDATE_REG 0xFFFFFFFF
> +#define INVALID_UPDATE_SHIFT -1
> +#define INVALID_MUX_GATE -1
> +
> +static const struct mtk_mux top_muxes[] =3D {
> +       /* CLK_CFG_0 */
> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parent=
s,
> +                             CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
> +                             0, 2, 7, CLK_CFG_UPDATE, 0, CLK_IS_CRITICAL=
),

Please add a comment why CLK_IS_CRITICAL flag is used in each place.

> +       MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, "mem_sel", mem_parent=
s,
> +                             CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
> +                             8, 2, 15, CLK_CFG_UPDATE, 1, CLK_IS_CRITICA=
L),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_parents, CLK_CF=
G_0,
> +                       CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 3, 23,
> +                       CLK_CFG_UPDATE, 2),
> +       MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel", scp_parents, CLK=
_CFG_0,
> +                       CLK_CFG_0_SET, CLK_CFG_0_CLR, 24, 3, 31,
> +                       CLK_CFG_UPDATE, 3),
[...]
> +       }, {
> +               .compatible =3D "mediatek,mt6765-topckgen",
> +               .data =3D clk_mt6765_top_probe,
> +       }, {
> +               .compatible =3D "mediatek,mt6765-infracfg",
> +               .data =3D clk_mt6765_ifr_probe,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static int clk_mt6765_probe(struct platform_device *pdev)
> +{
> +       int (*clk_probe)(struct platform_device *d);
> +       int r;
> +
> +       clk_probe =3D of_device_get_match_data(&pdev->dev);
> +       if (!clk_probe)
> +               return -EINVAL;
> +
> +       r =3D clk_probe(pdev);
> +       if (r)
> +               dev_err(&pdev->dev,
> +                       "could not register clock provider: %s: %d\n",
> +                       pdev->name, r);
> +
> +       return r;
> +}
> +
> +static struct platform_driver clk_mt6765_drv =3D {
> +       .probe =3D clk_mt6765_probe,
> +       .driver =3D {
> +               .name =3D "clk-mt6765",
> +               .owner =3D THIS_MODULE,

Remove this line, platform_driver_register() should take care of it.

> +               .of_match_table =3D of_match_clk_mt6765,
> +       },
> +};
> +
