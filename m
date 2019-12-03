Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF80AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D720661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLCI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:58:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:54152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfLCI6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:58:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2665AD77;
        Tue,  3 Dec 2019 08:58:40 +0000 (UTC)
Subject: Re: [RFC 2/5] hwspinlock: Add Realtek RTD1195 SB2
To:     Fabien DESSENNE <fabien.dessenne@st.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Cheng-Yu Lee <cylee12@realtek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
References: <20191202220535.6208-1-afaerber@suse.de>
 <20191202220535.6208-3-afaerber@suse.de>
 <14b79ade-e1ae-388f-37de-07d67837de2f@st.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <037384de-90b4-a4b0-d761-ffb3353cdbae@suse.de>
Date:   Tue, 3 Dec 2019 09:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <14b79ade-e1ae-388f-37de-07d67837de2f@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Am 03.12.19 um 09:46 schrieb Fabien DESSENNE:
> On 02/12/2019 11:05 PM, Andreas Färber wrote:
>> Implement a driver for hardware semaphores found in RTD1195 SoC.
>> It allows for both per-register instances (SB2_HD_SEM) as well as
>> contiguous register ranges (SB2_HD_SEM_NEW[0-7]).
>>
>> While these registers are part of the SB2 syscon, this implementation
>> does not use syscon, to allow assigning one as SB2 syscon's hwlock.
>>
>> Cc: Cheng-Yu Lee <cylee12@realtek.com>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>   drivers/hwspinlock/Kconfig           |  11 ++++
>>   drivers/hwspinlock/Makefile          |   1 +
>>   drivers/hwspinlock/rtd1195_sb2_sem.c | 101 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 113 insertions(+)
>>   create mode 100644 drivers/hwspinlock/rtd1195_sb2_sem.c
>>
>> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
>> index 37740e992cfa..9c26c436d399 100644
>> --- a/drivers/hwspinlock/Kconfig
>> +++ b/drivers/hwspinlock/Kconfig
>> @@ -28,6 +28,17 @@ config HWSPINLOCK_QCOM
>>   
>>   	  If unsure, say N.
>>   
>> +config HWSPINLOCK_RTD1195_SB2
>> +	tristate "Realtek RTD1195 SB2 Hardware Spinlock device"
>> +	depends on HWSPINLOCK
>> +	depends on ARCH_REALTEK || COMPILE_TEST
>> +	default ARCH_REALTEK
>> +	help
>> +	  Say y here to support the Realtek Hardware Semaphore functionality,
>> +	  found on the RTD1195 and later SoC families.
>> +
>> +	  If unsure, say N.
>> +
>>   config HWSPINLOCK_SIRF
>>   	tristate "SIRF Hardware Spinlock device"
>>   	depends on HWSPINLOCK
>> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
>> index ed053e3f02be..d5bd59412468 100644
>> --- a/drivers/hwspinlock/Makefile
>> +++ b/drivers/hwspinlock/Makefile
>> @@ -6,6 +6,7 @@
>>   obj-$(CONFIG_HWSPINLOCK)		+= hwspinlock_core.o
>>   obj-$(CONFIG_HWSPINLOCK_OMAP)		+= omap_hwspinlock.o
>>   obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
>> +obj-$(CONFIG_HWSPINLOCK_RTD1195_SB2)	+= rtd1195_sb2_sem.o
>>   obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
>>   obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
>>   obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
>> diff --git a/drivers/hwspinlock/rtd1195_sb2_sem.c b/drivers/hwspinlock/rtd1195_sb2_sem.c
>> new file mode 100644
>> index 000000000000..ae925d057874
>> --- /dev/null
>> +++ b/drivers/hwspinlock/rtd1195_sb2_sem.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * RTD1195 SB2 hardware semaphore
>> + *
>> + * Copyright (c) 2019 Andreas Färber
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/hwspinlock.h>
>> +#include <linux/idr.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "hwspinlock_internal.h"
>> +
>> +struct rtd1195_sb2_sem {
>> +	struct platform_device *pdev;
>> +	void __iomem *base;
>> +	int base_id;
> The pdev, base and base_id members of this struct are set in .probe() 
> but never read anywhere: you may remove them and keep only lockdev

Hmm, this module driver is still missing a remove hook that might need
them. I was originally planning to pass this struct as priv to the
initial locks, but that didn't work out for more than one lock.

Also, have you ever had the case where an hwspinlock driver were using a
syscon instead of __iomem pointer, and potentially be used as hwlock for
that same syscon? I assumed that would cause circular probing problems,
but I didn't actually test it and considered it a bad design idea? If it
is supported, a regmap would be the alternative to base above.

>> +	struct hwspinlock_device lockdev;
>> +};
>> +
>> +static DEFINE_IDR(rtd1195_sb2_sem_idr);
>> +
>> +static int rtd1195_sb2_sem_trylock(struct hwspinlock *lock)
>> +{
>> +	void __iomem *reg = (void __iomem *)lock->priv;
>> +
>> +	return readl_relaxed(reg) & BIT(0);
>> +}
>> +
>> +static void rtd1195_sb2_sem_unlock(struct hwspinlock *lock)
>> +{
>> +	void __iomem *reg = (void __iomem *)lock->priv;
>> +
>> +	writel_relaxed(0, reg);
>> +}
>> +
>> +static const struct hwspinlock_ops rtd1195_sb2_sem_hwspinlock_ops = {
>> +	.trylock	= rtd1195_sb2_sem_trylock,
>> +	.unlock		= rtd1195_sb2_sem_unlock,
>> +};
>> +
>> +static int rtd1195_sb2_sem_probe(struct platform_device *pdev)
>> +{
>> +	struct rtd1195_sb2_sem *sem;
>> +	struct hwspinlock *lock;
>> +	struct resource *res;
>> +	int i, num;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	num = resource_size(res) / 4;
>> +
>> +	sem = devm_kzalloc(&pdev->dev, sizeof(*sem) + num * sizeof(*lock),
>> +			   GFP_KERNEL);
>> +	if (!sem)
>> +		return -ENOMEM;
>> +
>> +	sem->pdev = pdev;
>> +
>> +	sem->base = of_iomap(pdev->dev.of_node, 0);
> You may use devm_ioremap_resource() here.

Wouldn't that also reserve this memory and thus cause conflicts?

I have another unposted driver on the same syscon (reason for basing
this on the syscon series [1]), which currently overlaps it - to be
updated to syscon.

Thanks for initial review,
Andreas

[1] https://patchwork.kernel.org/cover/11269971/

>> +	if (!sem->base)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		lock = &sem->lockdev.lock[i];
>> +		lock->priv = sem->base + i * 4;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, sem);
>> +
>> +	sem->base_id = idr_alloc(&rtd1195_sb2_sem_idr, sem, 0, 0, GFP_KERNEL);
>> +
>> +	return devm_hwspin_lock_register(&pdev->dev, &sem->lockdev,
>> +		&rtd1195_sb2_sem_hwspinlock_ops, sem->base_id, num);
>> +}
>> +
>> +static const struct of_device_id rtd1195_sb2_sem_dt_ids[] = {
>> +	{ .compatible = "realtek,rtd1195-sb2-sem" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rtd1195_sb2_sem_dt_ids);
>> +
>> +static struct platform_driver rtd1195_sb2_sem_platform_driver = {
>> +	.driver = {
>> +		.name = "rtd1195-sb2-sem",
>> +		.of_match_table = rtd1195_sb2_sem_dt_ids,
>> +	},
>> +	.probe = rtd1195_sb2_sem_probe,
>> +};
>> +module_platform_driver(rtd1195_sb2_sem_platform_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Hardware spinlock driver for Realtek RTD1195 SB2");
>> +MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
