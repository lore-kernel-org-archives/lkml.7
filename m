Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78902075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hpzKwRXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEBNhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:37:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56178 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfEBNhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:37:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x42Db0Me053306;
        Thu, 2 May 2019 08:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556804220;
        bh=w0xhuSvWo6AdH0kUHQMj7h/c5ozWGAeD8dqkj3K/spQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hpzKwRXBv8rV5ZrHmOBenSiPLatGUQBQDBpZMh91RlGx7XX8p2HHJnDhCruEBj5zY
         qeiFDYTVXTz5e+Vxp4zMns94H7Yfhs2BfQeRvCrOTmAFDISF71u9mAbAd3QHpi/d7S
         bwGbHr8wvWGhvbmUBuynzd9t+wge1HYcTeBFGxIc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x42Db0Hf070226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 May 2019 08:37:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 2 May
 2019 08:36:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 2 May 2019 08:36:59 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x42DaxOW078864;
        Thu, 2 May 2019 08:36:59 -0500
Subject: Re: [PATCH v2 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller
 driver for SiFive SoCs
To:     Yash Shah <yash.shah@sifive.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <palmer@sifive.com>
CC:     <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <aou@eecs.berkeley.edu>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <sachin.ghadi@sifive.com>
References: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
 <1556793293-21019-3-git-send-email-yash.shah@sifive.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a92e356d-aadc-2c4f-8b23-3d732e7aa58a@ti.com>
Date:   Thu, 2 May 2019 09:36:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556793293-21019-3-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 6:34 AM, Yash Shah wrote:
> The driver currently supports only SiFive FU540-C000 platform.
> 
> The initial version of L2 cache controller driver includes:
> - Initial configuration reporting at boot up.
> - Support for ECC related functionality.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/mm/Makefile          |   1 +
>  arch/riscv/mm/sifive_l2_cache.c | 221 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 arch/riscv/mm/sifive_l2_cache.c
> 
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index eb22ab4..1523ee5 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -3,3 +3,4 @@ obj-y += fault.o
>  obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
> +obj-y += sifive_l2_cache.o
> diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
> new file mode 100644
> index 0000000..923ab34
> --- /dev/null
> +++ b/arch/riscv/mm/sifive_l2_cache.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SiFive L2 cache controller Driver
> + *
> + * Copyright (C) 2018-2019 SiFive, Inc.
> + *
> + */
> +#include <linux/debugfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +
> +#define SIFIVE_L2_DIRECCFIX_LOW 0x100
> +#define SIFIVE_L2_DIRECCFIX_HIGH 0x104
> +#define SIFIVE_L2_DIRECCFIX_COUNT 0x108
> +
> +#define SIFIVE_L2_DATECCFIX_LOW 0x140
> +#define SIFIVE_L2_DATECCFIX_HIGH 0x144
> +#define SIFIVE_L2_DATECCFIX_COUNT 0x148
> +
> +#define SIFIVE_L2_DATECCFAIL_LOW 0x160
> +#define SIFIVE_L2_DATECCFAIL_HIGH 0x164
> +#define SIFIVE_L2_DATECCFAIL_COUNT 0x168
> +
> +#define SIFIVE_L2_CONFIG 0x00
> +#define SIFIVE_L2_WAYENABLE 0x08
> +#define SIFIVE_L2_ECCINJECTERR 0x40
> +
> +#define SIFIVE_L2_ERR_TYPE_CE 0
> +#define SIFIVE_L2_ERR_TYPE_UE 1
> +#define SIFIVE_L2_MAX_ECCINTR 3
> +
> +static void __iomem *l2_base;
> +static int g_irq[SIFIVE_L2_MAX_ECCINTR];
> +
> +enum {
> +	DIR_CORR = 0,
> +	DATA_CORR,
> +	DATA_UNCORR,
> +};
> +
> +static unsigned int l2_dirfix_addr_high(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
> +}
> +
> +static unsigned int l2_dirfix_addr_low(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
> +}
> +
> +static unsigned int l2_dirfix_count(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
> +}
> +
> +static unsigned int l2_datfix_addr_high(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
> +}
> +
> +static unsigned int l2_datfix_addr_low(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
> +}
> +
> +static unsigned int l2_datfix_count(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
> +}
> +
> +static unsigned int l2_datfail_addr_high(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
> +}
> +
> +static unsigned int l2_datfail_addr_low(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
> +}
> +
> +static unsigned int l2_datfail_count(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
> +}

Do you really need all these single line functions? Below in several
spots you use the readl directly, just do that everywhere.

Andrew

> +
> +#ifdef CONFIG_DEBUG_FS
> +static struct dentry *sifive_test;
> +
> +static ssize_t l2_write(struct file *file, const char __user *data,
> +			size_t count, loff_t *ppos)
> +{
> +	unsigned int val;
> +
> +	if (kstrtouint_from_user(data, count, 0, &val))
> +		return -EINVAL;
> +	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
> +		writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
> +	else
> +		return -EINVAL;
> +	return count;
> +}
> +
> +static const struct file_operations l2_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.write = l2_write
> +};
> +
> +static void setup_sifive_debug(void)
> +{
> +	sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
> +
> +	debugfs_create_file("sifive_debug_inject_error", 0200,
> +			    sifive_test, NULL, &l2_fops);
> +}
> +#endif
> +
> +static void l2_config_read(void)
> +{
> +	u32 regval, val;
> +
> +	regval = readl(l2_base + SIFIVE_L2_CONFIG);
> +	val = regval & 0xFF;
> +	pr_info("L2CACHE: No. of Banks in the cache: %d\n", val);
> +	val = (regval & 0xFF00) >> 8;
> +	pr_info("L2CACHE: No. of ways per bank: %d\n", val);
> +	val = (regval & 0xFF0000) >> 16;
> +	pr_info("L2CACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
> +	val = (regval & 0xFF000000) >> 24;
> +	pr_info("L2CACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
> +
> +	regval = readl(l2_base + SIFIVE_L2_WAYENABLE);
> +	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
> +}
> +
> +static const struct of_device_id sifive_l2_ids[] = {
> +	{ .compatible = "sifive,fu540-c000-ccache" },
> +	{ /* end of table */ },
> +};
> +
> +static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
> +
> +int register_sifive_l2_error_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&l2_err_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_sifive_l2_error_notifier);
> +
> +int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_unregister(&l2_err_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
> +
> +static irqreturn_t l2_int_handler(int irq, void *device)
> +{
> +	unsigned int regval, add_h, add_l;
> +
> +	if (irq == g_irq[DIR_CORR]) {
> +		add_h = l2_dirfix_addr_high();
> +		add_l = l2_dirfix_addr_low();
> +		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
> +		regval = l2_dirfix_count();
> +		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
> +					   "DirECCFix");
> +	}
> +	if (irq == g_irq[DATA_CORR]) {
> +		add_h = l2_datfix_addr_high();
> +		add_l = l2_datfix_addr_low();
> +		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
> +		regval = l2_datfix_count();
> +		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
> +					   "DatECCFix");
> +	}
> +	if (irq == g_irq[DATA_UNCORR]) {
> +		add_h = l2_datfail_addr_high();
> +		add_l = l2_datfail_addr_low();
> +		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
> +		regval = l2_datfail_count();
> +		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
> +					   "DatECCFail");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int __init sifive_l2_init(void)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +	int i, rc;
> +
> +	np = of_find_matching_node(NULL, sifive_l2_ids);
> +	if (!np)
> +		return -ENODEV;
> +
> +	if (of_address_to_resource(np, 0, &res))
> +		return -ENODEV;
> +
> +	l2_base = ioremap(res.start, resource_size(&res));
> +	if (!l2_base)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < SIFIVE_L2_MAX_ECCINTR; i++) {
> +		g_irq[i] = irq_of_parse_and_map(np, i);
> +		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
> +		if (rc) {
> +			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
> +			return rc;
> +		}
> +	}
> +
> +	l2_config_read();
> +
> +#ifdef CONFIG_DEBUG_FS
> +	setup_sifive_debug();
> +#endif
> +	return 0;
> +}
> +device_initcall(sifive_l2_init);
> 
