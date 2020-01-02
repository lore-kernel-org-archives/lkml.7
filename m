Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD77215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgABOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:39:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:34256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbgABOjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E6A2AD03;
        Thu,  2 Jan 2020 14:39:19 +0000 (UTC)
Subject: Re: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and
 RTD1295
To:     James Tai <james.tai@realtek.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-3-afaerber@suse.de>
 <93eeece5be0640488096f20a9beb3d1d@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <5792d721-cd67-5e19-dac2-1310894ef7c2@suse.de>
Date:   Thu, 2 Jan 2020 15:39:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <93eeece5be0640488096f20a9beb3d1d@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.01.20 um 15:29 schrieb James Tai:
> Add Stanley Chang for review.

Did you forget to CC him?

Note that this series needs updates once we apply my syscon patches.

> 
>> Add a soc bus driver to print chip model and revision details.
>>
>> Revisions from downstream drivers/soc/realtek/rtd{119x,129x}/rtk_chip.c.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>   Naming: What to call the family vs. soc_id?
>>
>>   drivers/soc/Kconfig          |   1 +
>>   drivers/soc/Makefile         |   1 +
>>   drivers/soc/realtek/Kconfig  |  13 ++++
>>   drivers/soc/realtek/Makefile |   2 +
>>   drivers/soc/realtek/chip.c   | 164
>> +++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 181 insertions(+)
>>   create mode 100644 drivers/soc/realtek/Kconfig  create mode 100644
>> drivers/soc/realtek/Makefile  create mode 100644 drivers/soc/realtek/chip.c
>>
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig index
>> 833e04a7835c..06ae9d97321c 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -11,6 +11,7 @@ source "drivers/soc/imx/Kconfig"
>>   source "drivers/soc/ixp4xx/Kconfig"
>>   source "drivers/soc/mediatek/Kconfig"
>>   source "drivers/soc/qcom/Kconfig"
>> +source "drivers/soc/realtek/Kconfig"
>>   source "drivers/soc/renesas/Kconfig"
>>   source "drivers/soc/rockchip/Kconfig"
>>   source "drivers/soc/samsung/Kconfig"
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile index
>> 2ec355003524..1d55d838a342 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>>   obj-y				+= mediatek/
>>   obj-y				+= amlogic/
>>   obj-y				+= qcom/
>> +obj-y				+= realtek/
>>   obj-y				+= renesas/
>>   obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>>   obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>> diff --git a/drivers/soc/realtek/Kconfig b/drivers/soc/realtek/Kconfig new file
>> mode 100644 index 000000000000..be75c1889c61
>> --- /dev/null
>> +++ b/drivers/soc/realtek/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later if ARCH_REALTEK ||
>> +COMPILE_TEST
>> +
>> +config REALTEK_SOC
>> +	tristate "Realtek chip info"
>> +	default ARCH_REALTEK
>> +	select SOC_BUS
>> +	help
>> +	  Say 'y' here to enable support for SoC info on Realtek RTD1195 and
>> +	  RTD1295 SoC families.
>> +	  If unsure, say 'n'.
>> +
>> +endif
>> diff --git a/drivers/soc/realtek/Makefile b/drivers/soc/realtek/Makefile new
>> file mode 100644 index 000000000000..49900273905b
>> --- /dev/null
>> +++ b/drivers/soc/realtek/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +obj-$(CONFIG_REALTEK_SOC) += chip.o
>> diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c new file
>> mode 100644 index 000000000000..9d13422e9936
>> --- /dev/null
>> +++ b/drivers/soc/realtek/chip.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Realtek System-on-Chip info
>> + *
>> + * Copyright (c) 2017-2019 Andreas Färber  */
>> +
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/sys_soc.h>
>> +
>> +#define REG_CHIP_ID	0x0
>> +#define REG_CHIP_REV	0x4
>> +
>> +struct rtd_soc_revision {
>> +	const char *name;
>> +	u32 chip_rev;
>> +};
>> +
>> +static const struct rtd_soc_revision rtd1195_revisions[] = {
>> +	{ "A", 0x00000000 },
>> +	{ "B", 0x00010000 },
>> +	{ "C", 0x00020000 },
>> +	{ "D", 0x00030000 },
>> +	{ }
>> +};
>> +
>> +static const struct rtd_soc_revision rtd1295_revisions[] = {
>> +	{ "A00", 0x00000000 },
>> +	{ "A01", 0x00010000 },
>> +	{ "B00", 0x00020000 },
>> +	{ "B01", 0x00030000 },
>> +	{ }
>> +};

I believe the lower 16 bits are reserved, so we should only be comparing 
the upper 16.

>> +
>> +struct rtd_soc {
>> +	u32 chip_id;
>> +	const char *family;
>> +	const char *(*get_name)(struct device *dev, const struct rtd_soc *s);
>> +	const struct rtd_soc_revision *revisions;
>> +	const char *codename;
>> +};
>> +
>> +static const char *default_name(struct device *dev, const struct
>> +rtd_soc *s) {
>> +	return s->family;
>> +}
>> +
>> +static const struct rtd_soc rtd_soc_families[] = {
>> +	{ 0x00006329, "RTD1195", default_name, rtd1195_revisions, "Phoenix" },
>> +	{ 0x00006421, "RTD1295", default_name, rtd1295_revisions, "Kylin" },
>> +};

Similarly here I believe the upper 16 bits are reserved, so we should 
only be comparing the lower 16, which should make it easier to stay 
within 80 characters per line.

Regards,
Andreas

>> +
>> +static const struct rtd_soc *rtd_soc_by_chip_id(u32 chip_id) {
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(rtd_soc_families); i++) {
>> +		const struct rtd_soc *family = &rtd_soc_families[i];
>> +
>> +		if (family->chip_id == chip_id)
>> +			return family;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static const char *rtd_soc_rev(const struct rtd_soc *family, u32
>> +chip_rev) {
>> +	if (family) {
>> +		const struct rtd_soc_revision *rev = family->revisions;
>> +
>> +		while (rev && rev->name) {
>> +			if (rev->chip_rev == chip_rev)
>> +				return rev->name;
>> +			rev++;
>> +		}
>> +	}
>> +	return "unknown";
>> +}
>> +
>> +static int rtd_soc_probe(struct platform_device *pdev) {
>> +	const struct rtd_soc *s;
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +	struct device_node *node;
>> +	void __iomem *base;
>> +	u32 chip_id, chip_rev;
>> +
>> +	base = of_iomap(pdev->dev.of_node, 0);
>> +	if (!base)
>> +		return -ENODEV;
>> +
>> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +	if (!soc_dev_attr)
>> +		return -ENOMEM;
>> +
>> +	chip_id  = readl_relaxed(base + REG_CHIP_ID);
>> +	chip_rev = readl_relaxed(base + REG_CHIP_REV);
>> +
>> +	node = of_find_node_by_path("/");
>> +	of_property_read_string(node, "model", &soc_dev_attr->machine);
>> +	of_node_put(node);
>> +
>> +	s = rtd_soc_by_chip_id(chip_id);
>> +
>> +	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Realtek %s",
>> +		(s && s->codename) ? s->codename :
>> +		((s && s->family) ? s->family : "Digital Home Center"));
>> +
>> +	if (likely(s && s->get_name))
>> +		soc_dev_attr->soc_id = s->get_name(&pdev->dev, s);
>> +	else
>> +		soc_dev_attr->soc_id = "unknown";
>> +
>> +	soc_dev_attr->revision = rtd_soc_rev(s, chip_rev);
>> +
>> +	soc_dev = soc_device_register(soc_dev_attr);
>> +	if (IS_ERR(soc_dev)) {
>> +		kfree(soc_dev_attr->family);
>> +		kfree(soc_dev_attr);
>> +		return PTR_ERR(soc_dev);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, soc_dev);
>> +
>> +	dev_info(soc_device_to_device(soc_dev),
>> +		"%s %s (0x%08x) rev %s (0x%08x) detected\n",
>> +		soc_dev_attr->family, soc_dev_attr->soc_id, chip_id,
>> +		soc_dev_attr->revision, chip_rev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtd_soc_remove(struct platform_device *pdev) {
>> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
>> +
>> +	soc_device_unregister(soc_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id rtd_soc_dt_ids[] = {
>> +	 { .compatible = "realtek,rtd1195-chip" },
>> +	 { }
>> +};
>> +
>> +static struct platform_driver rtd_soc_driver = {
>> +	.probe = rtd_soc_probe,
>> +	.remove = rtd_soc_remove,
>> +	.driver = {
>> +		.name = "rtd1195-soc",
>> +		.of_match_table	= rtd_soc_dt_ids,
>> +	},
>> +};
>> +module_platform_driver(rtd_soc_driver);
>> +
>> +MODULE_DESCRIPTION("Realtek SoC identification");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.16.4
>>
>>
>> _______________________________________________
>> linux-realtek-soc mailing list
>> linux-realtek-soc@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-realtek-soc
>>
>> ------Please consider the environment before printing this e-mail.


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
