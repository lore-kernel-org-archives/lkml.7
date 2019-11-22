Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C8C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310E42071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="t/Ygz2LT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKVSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:55:11 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45506 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574448908; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkPm0nFcORKp1/R1WzCEpphPU3Hst8cL8sW87UZYmf8=;
        b=t/Ygz2LTFrcMAahrPqGihnu/yrVXvuT+NRwlpWzSdFUqOuSqpmuqCb/94OK4Wdh9GFREPx
        gD9QH2M0Ccxp9U03jo+OijswJjYuOuckDpXQs6pnRo/ZShA+aF53WPhipxNCq9EPKK4cl8
        EDcfINCHiGeLDNNBZ55yrLlNsvPp3Uo=
Date:   Fri, 22 Nov 2019 19:55:02 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 4/4] remoteproc: ingenic: Added remoteproc driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1574448902.3.3@crapouillou.net>
In-Reply-To: <20191118225628.GA18243@xps15>
References: <20191116170846.67220-1-paul@crapouillou.net>
        <20191116170846.67220-4-paul@crapouillou.net> <20191118225628.GA18243@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,


Le lun., nov. 18, 2019 at 15:56, Mathieu Poirier=20
<mathieu.poirier@linaro.org> a =E9crit :
> Hi Paul,
>=20
> On Sat, Nov 16, 2019 at 06:08:46PM +0100, Paul Cercueil wrote:
>>  This driver is used to boot, communicate with and load firmwares to=20
>> the
>>  MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
>>  Ingenic.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: Remove exception for always-mapped memories
>>      v3: - Use clk_bulk API
>>          - Move device-managed code to its own patch [3/4]
>>      	- Move devicetree table right above ingenic_rproc_driver
>>      	- Removed #ifdef CONFIG_OF around devicetree table
>>      	- Removed .owner =3D THIS_MODULE in ingenic_rproc_driver
>>      	- Removed useless platform_set_drvdata()
>>=20
>>   drivers/remoteproc/Kconfig         |   8 +
>>   drivers/remoteproc/Makefile        |   1 +
>>   drivers/remoteproc/ingenic_rproc.c | 242=20
>> +++++++++++++++++++++++++++++
>>   3 files changed, 251 insertions(+)
>>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
>>=20
>>  diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>  index 94afdde4bc9f..f7d4b183d152 100644
>>  --- a/drivers/remoteproc/Kconfig
>>  +++ b/drivers/remoteproc/Kconfig
>>  @@ -214,6 +214,14 @@ config STM32_RPROC
>>=20
>>   	  This can be either built-in or a loadable module.
>>=20
>>  +config INGENIC_RPROC
>=20
> Are you sure you don't want to make this something like
> INGENIC_RPROC_JZ47XX_VPU so that future remote proc system from=20
> Ingenic can be
> added easily?

Ingenic SoCs aren't named JZ47xx anymore; I'll name the symbol=20
INGENIC_VPU_RPROC then.

>>  +	tristate "Ingenic JZ47xx VPU remoteproc support"
>>  +	depends on MIPS || COMPILE_TEST
>>  +	help
>>  +	  Say y or m here to support the VPU in the JZ47xx SoCs from=20
>> Ingenic.
>>  +	  This can be either built-in or a loadable module.
>>  +	  If unsure say N.
>>  +
>>   endif # REMOTEPROC
>>=20
>>   endmenu
>>  diff --git a/drivers/remoteproc/Makefile=20
>> b/drivers/remoteproc/Makefile
>>  index 00f09e658cb3..6eb0137abbc7 100644
>>  --- a/drivers/remoteproc/Makefile
>>  +++ b/drivers/remoteproc/Makefile
>>  @@ -10,6 +10,7 @@ remoteproc-y				+=3D remoteproc_sysfs.o
>>   remoteproc-y				+=3D remoteproc_virtio.o
>>   remoteproc-y				+=3D remoteproc_elf_loader.o
>>   obj-$(CONFIG_IMX_REMOTEPROC)		+=3D imx_rproc.o
>>  +obj-$(CONFIG_INGENIC_RPROC)			+=3D ingenic_rproc.a
>=20
> This comes out as one tab to many on my side.
>=20
>>   obj-$(CONFIG_OMAP_REMOTEPROC)		+=3D omap_remoteproc.o
>>   obj-$(CONFIG_WKUP_M3_RPROC)		+=3D wkup_m3_rproc.o
>>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+=3D da8xx_remoteproc.o
>>  diff --git a/drivers/remoteproc/ingenic_rproc.c=20
>> b/drivers/remoteproc/ingenic_rproc.c
>>  new file mode 100644
>>  index 000000000000..5a7c7d8d9a90
>>  --- /dev/null
>>  +++ b/drivers/remoteproc/ingenic_rproc.c
>>  @@ -0,0 +1,242 @@
>>  +// SPDX-License-Identifier: GPL-2.0+
>>  +/*
>>  + * Ingenic JZ47xx remoteproc driver
>>  + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
>>  + */
>>  +
>>  +#include <linux/bitops.h>
>>  +#include <linux/clk.h>
>>  +#include <linux/err.h>
>>  +#include <linux/interrupt.h>
>>  +#include <linux/io.h>
>>  +#include <linux/module.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/remoteproc.h>
>>  +
>>  +#include "remoteproc_internal.h"
>>  +
>>  +#define REG_AUX_CTRL		0x0
>>  +#define REG_AUX_MSG_ACK		0x10
>>  +#define REG_AUX_MSG		0x14
>>  +#define REG_CORE_MSG_ACK	0x18
>>  +#define REG_CORE_MSG		0x1C
>>  +
>>  +#define AUX_CTRL_SLEEP		BIT(31)
>>  +#define AUX_CTRL_MSG_IRQ_EN	BIT(3)
>>  +#define AUX_CTRL_NMI_RESETS	BIT(2)
>>  +#define AUX_CTRL_NMI		BIT(1)
>>  +#define AUX_CTRL_SW_RESET	BIT(0)
>>  +
>>  +struct vpu_mem_map {
>>  +	const char *name;
>>  +	unsigned int da;
>>  +};
>>  +
>>  +struct vpu_mem_info {
>>  +	const struct vpu_mem_map *map;
>>  +	unsigned long len;
>>  +	void __iomem *base;
>>  +};
>>  +
>>  +static const struct vpu_mem_map vpu_mem_map[] =3D {
>>  +	{ "tcsm0", 0x132b0000 },
>>  +	{ "tcsm1", 0xf4000000 },
>>  +	{ "sram",  0x132f0000 },
>>  +};
>>  +
>>  +/* Device data */
>>  +struct vpu {
>>  +	int irq;
>>  +	struct clk_bulk_data clks[2];
>>  +	void __iomem *aux_base;
>>  +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
>>  +	struct device *dev;
>>  +};
>=20
> Documentation of structure fields is always appreciated but it is up=20
> to Bjorn to
> decide on this one.

It's a private structure within a driver, does it matter that much?
Besides, it's pretty much self-explanatory.

>>  +
>>  +static int ingenic_rproc_prepare(struct rproc *rproc)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +	int ret;
>>  +
>>  +	/* The clocks must be enabled for the firmware to be loaded in=20
>> TCSM */
>>  +	ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
>>  +	if (ret)
>>  +		dev_err(vpu->dev, "Unable to start clocks: %d", ret);
>>  +
>>  +	return ret;
>>  +}
>>  +
>>  +static void ingenic_rproc_unprepare(struct rproc *rproc)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +
>>  +	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
>>  +}
>>  +
>>  +static int ingenic_rproc_start(struct rproc *rproc)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +	u32 ctrl;
>>  +
>>  +	enable_irq(vpu->irq);
>>  +
>>  +	/* Reset the AUX and enable message IRQ */
>>  +	ctrl =3D AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
>>  +	writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
>=20
> Out of curiosity, there is no power domain associated with this
> co-processor?  Clocks are all you need?

That's correct.

>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int ingenic_rproc_stop(struct rproc *rproc)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +
>>  +	/* Keep AUX in reset mode */
>>  +	writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
>>  +
>>  +	disable_irq_nosync(vpu->irq);
>=20
> Also out of curiosity, why the need for _nosync()?

It probably doesn't need it. I'll remove it.

>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +
>>  +	writel(vqid, vpu->aux_base + REG_CORE_MSG);
>>  +}
>>  +
>>  +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,=20
>> int len)
>>  +{
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +	void __iomem *va =3D NULL;
>>  +	unsigned int i;
>>  +
>>  +	if (len <=3D 0)
>>  +		return NULL;
>>  +
>>  +	for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>  +		const struct vpu_mem_info *info =3D &vpu->mem_info[i];
>>  +		const struct vpu_mem_map *map =3D info->map;
>>  +
>>  +		if (da >=3D map->da && (da + len) < (map->da + info->len)) {
>>  +			va =3D info->base + (da - map->da);
>>  +			break;
>>  +		}
>>  +	}
>>  +
>>  +	return (__force void *)va;
>>  +}
>>  +
>>  +static struct rproc_ops ingenic_rproc_ops =3D {
>>  +	.prepare =3D ingenic_rproc_prepare,
>>  +	.unprepare =3D ingenic_rproc_unprepare,
>>  +	.start =3D ingenic_rproc_start,
>>  +	.stop =3D ingenic_rproc_stop,
>>  +	.kick =3D ingenic_rproc_kick,
>>  +	.da_to_va =3D ingenic_rproc_da_to_va,
>>  +};
>>  +
>>  +static irqreturn_t vpu_interrupt(int irq, void *data)
>>  +{
>>  +	struct rproc *rproc =3D data;
>>  +	struct vpu *vpu =3D rproc->priv;
>>  +	u32 vring;
>>  +
>>  +	vring =3D readl(vpu->aux_base + REG_AUX_MSG);
>>  +
>>  +	/* Ack the interrupt */
>>  +	writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
>>  +
>>  +	return rproc_vq_interrupt(rproc, vring);
>>  +}
>>  +
>>  +static int ingenic_rproc_probe(struct platform_device *pdev)
>>  +{
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct resource *mem;
>>  +	struct rproc *rproc;
>>  +	struct vpu *vpu;
>>  +	unsigned int i;
>>  +	int ret;
>>  +
>>  +	rproc =3D devm_rproc_alloc(dev, "ingenic-vpu",
>>  +				 &ingenic_rproc_ops, NULL, sizeof(*vpu));
>>  +	if (!rproc)
>>  +		return -ENOMEM;
>>  +
>>  +	vpu =3D rproc->priv;
>>  +	vpu->dev =3D &pdev->dev;
>>  +
>>  +	mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
>>  +	vpu->aux_base =3D devm_ioremap_resource(dev, mem);
>>  +	if (IS_ERR(vpu->aux_base)) {
>>  +		dev_err(dev, "Failed to ioremap");
>>  +		return PTR_ERR(vpu->aux_base);
>>  +	}
>>  +
>>  +	for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
>>  +		mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>  +						   vpu_mem_map[i].name);
>>  +
>>  +		vpu->mem_info[i].base =3D devm_ioremap_resource(dev, mem);
>>  +		if (IS_ERR(vpu->mem_info[i].base)) {
>>  +			ret =3D PTR_ERR(vpu->mem_info[i].base);
>>  +			dev_err(dev, "Failed to ioremap");
>>  +			return ret;
>>  +		}
>>  +
>>  +		vpu->mem_info[i].len =3D resource_size(mem);
>>  +		vpu->mem_info[i].map =3D &vpu_mem_map[i];
>>  +	}
>>  +
>>  +	vpu->clks[0].id =3D "vpu";
>>  +	vpu->clks[1].id =3D "aux";
>>  +
>>  +	ret =3D devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to get clocks");
>>  +		return ret;
>>  +	}
>>  +
>>  +	vpu->irq =3D platform_get_irq(pdev, 0);
>>  +	if (vpu->irq < 0) {
>>  +		dev_err(dev, "Failed to get platform IRQ");
>>  +		return vpu->irq;
>>  +	}
>>  +
>>  +	ret =3D devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU",=20
>> rproc);
>>  +	if (ret < 0) {
>>  +		dev_err(dev, "Failed to request IRQ");
>>  +		return ret;
>>  +	}
>>  +
>>  +	disable_irq_nosync(vpu->irq);
>>  +
>>  +	ret =3D devm_rproc_add(dev, rproc);
>>  +	if (ret) {
>>  +		dev_err(dev, "Failed to register remote processor");
>>  +		return ret;
>>  +	}
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static const struct of_device_id ingenic_rproc_of_matches[] =3D {
>>  +	{ .compatible =3D "ingenic,jz4770-vpu-rproc", },
>>  +	{}
>>  +};
>>  +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
>>  +
>>  +static struct platform_driver ingenic_rproc_driver =3D {
>>  +	.probe =3D ingenic_rproc_probe,
>>  +	.driver =3D {
>>  +		.name =3D "ingenic-vpu",
>>  +		.of_match_table =3D of_match_ptr(ingenic_rproc_of_matches),
>>  +	},
>>  +};
>>  +module_platform_driver(ingenic_rproc_driver);
>>  +
>>  +MODULE_LICENSE("GPL");
>>  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control=20
>> driver");
>=20
> Nice, clean and simple driver.  With the above and after rolling in=20
> Julia's
> patch:
>=20
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks!

Cheers,
-Paul

=

