Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A518C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B21321473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfDCIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:02:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfDCIC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:02:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [10.3.19.207])
        by Forcepoint Email with ESMTP id DBFF020F5E0B15893976;
        Wed,  3 Apr 2019 16:02:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 16:02:42 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
 release for probe failure
To:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
CC:     <linuxarm@huawei.com>, <chenxiang66@hisilicon.com>,
        <robin.murphy@arm.com>, <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh@kernel.org>,
        <hch@lst.de>
Message-ID: <703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
Date:   Wed, 3 Apr 2019 09:02:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 10:08, John Garry wrote:
> In commit 376991db4b64 ("driver core: Postpone DMA tear-down until after
> devres release"), we changed the ordering of tearing down the device DMA
> ops and releasing all the device's resources; this was because the DMA ops
> should be maintained until we release the device's managed DMA memories.
>

Hi all,

A friendly reminder on this patch... I didn't see any update.

I thought that it had some importance.

Thanks,
John

> However, we have seen another crash on an arm64 system when a
> device driver probe fails:
>
>   hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 2
>   scsi host1: hisi_sas_v3_hw
>   BUG: Bad page state in process swapper/0  pfn:313f5
>   page:ffff7e0000c4fd40 count:1 mapcount:0
>   mapping:0000000000000000 index:0x0
>   flags: 0xfffe00000001000(reserved)
>   raw: 0fffe00000001000 ffff7e0000c4fd48 ffff7e0000c4fd48
> 0000000000000000
>   raw: 0000000000000000 0000000000000000 00000001ffffffff
> 0000000000000000
>   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>   bad because of flags: 0x1000(reserved)
>   Modules linked in:
>   CPU: 49 PID: 1 Comm: swapper/0 Not tainted
> 5.1.0-rc1-43081-g22d97fd-dirty #1433
>   Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
> RC0 - V1.12.01 01/29/2019
>   Call trace:
>   dump_backtrace+0x0/0x118
>   show_stack+0x14/0x1c
>   dump_stack+0xa4/0xc8
>   bad_page+0xe4/0x13c
>   free_pages_check_bad+0x4c/0xc0
>   __free_pages_ok+0x30c/0x340
>   __free_pages+0x30/0x44
>   __dma_direct_free_pages+0x30/0x38
>   dma_direct_free+0x24/0x38
>   dma_free_attrs+0x9c/0xd8
>   dmam_release+0x20/0x28
>   release_nodes+0x17c/0x220
>   devres_release_all+0x34/0x54
>   really_probe+0xc4/0x2c8
>   driver_probe_device+0x58/0xfc
>   device_driver_attach+0x68/0x70
>   __driver_attach+0x94/0xdc
>   bus_for_each_dev+0x5c/0xb4
>   driver_attach+0x20/0x28
>   bus_add_driver+0x14c/0x200
>   driver_register+0x6c/0x124
>   __pci_register_driver+0x48/0x50
>   sas_v3_pci_driver_init+0x20/0x28
>   do_one_initcall+0x40/0x25c
>   kernel_init_freeable+0x2b8/0x3c0
>   kernel_init+0x10/0x100
>   ret_from_fork+0x10/0x18
>   Disabling lock debugging due to kernel taint
>   BUG: Bad page state in process swapper/0  pfn:313f6
>   page:ffff7e0000c4fd80 count:1 mapcount:0
> mapping:0000000000000000 index:0x0
> [   89.322983] flags: 0xfffe00000001000(reserved)
>   raw: 0fffe00000001000 ffff7e0000c4fd88 ffff7e0000c4fd88
> 0000000000000000
>   raw: 0000000000000000 0000000000000000 00000001ffffffff
> 0000000000000000
>
> The crash occurs for the same reason.
>
> In this case, on the really_probe() failure path, we are still clearing
> the DMA ops prior to releasing the device's managed memories.
>
> This patch fixes this issue by reordering the DMA ops teardown and the
> call to devres_release_all() on the failure path.
>
> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>
> For convenience, here is the 2nd half of really_probe() now:
>
> 	atomic_inc(&probe_count);
> 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
> 		 drv->bus->name, __func__, drv->name, dev_name(dev));
> 	WARN_ON(!list_empty(&dev->devres_head));
>
> re_probe:
> 	dev->driver = drv;
>
> 	/* If using pinctrl, bind pins now before probing */
> 	ret = pinctrl_bind_pins(dev);
> 	if (ret)
> 		goto pinctrl_bind_failed;
>
> 	if (dev->bus->dma_configure) {
> 		ret = dev->bus->dma_configure(dev);
> 		if (ret)
> 			goto probe_failed;
> 	}
>
> 	if (driver_sysfs_add(dev)) {
> 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> 			__func__, dev_name(dev));
> 		goto probe_failed;
> 	}
>
> 	if (dev->pm_domain && dev->pm_domain->activate) {
> 		ret = dev->pm_domain->activate(dev);
> 		if (ret)
> 			goto probe_failed;
> 	}
>
> 	if (dev->bus->probe) {
> 		ret = dev->bus->probe(dev);
> 		if (ret)
> 			goto probe_failed;
> 	} else if (drv->probe) {
> 		ret = drv->probe(dev);
> 		if (ret)
> 			goto probe_failed;
> 	}
>
> 	if (test_remove) {
> 		test_remove = false;
>
> 		if (dev->bus->remove)
> 			dev->bus->remove(dev);
> 		else if (drv->remove)
> 			drv->remove(dev);
>
> 		devres_release_all(dev);
> 		driver_sysfs_remove(dev);
> 		dev->driver = NULL;
> 		dev_set_drvdata(dev, NULL);
> 		if (dev->pm_domain && dev->pm_domain->dismiss)
> 			dev->pm_domain->dismiss(dev);
> 		pm_runtime_reinit(dev);
>
> 		goto re_probe;
> 	}
>
> 	pinctrl_init_done(dev);
>
> 	if (dev->pm_domain && dev->pm_domain->sync)
> 		dev->pm_domain->sync(dev);
>
> 	driver_bound(dev);
> 	ret = 1;
> 	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
> 		 drv->bus->name, __func__, dev_name(dev), drv->name);
> 	goto done;
>
> probe_failed:
> 	if (dev->bus)
> 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> pinctrl_bind_failed:
> 	device_links_no_driver(dev);
> 	devres_release_all(dev);
> 	arch_teardown_dma_ops(dev);
> 	driver_sysfs_remove(dev);
> 	dev->driver = NULL;
> 	dev_set_drvdata(dev, NULL);
> 	if (dev->pm_domain && dev->pm_domain->dismiss)
> 		dev->pm_domain->dismiss(dev);
> 	pm_runtime_reinit(dev);
> 	dev_pm_set_driver_flags(dev, 0);
>
> 	switch (ret) {
> 	case -EPROBE_DEFER:
> 		/* Driver requested deferred probing */
> 		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
> 		driver_deferred_probe_add_trigger(dev, local_trigger_count);
> 		break;
> 	case -ENODEV:
> 	case -ENXIO:
> 		pr_debug("%s: probe of %s rejects match %d\n",
> 			 drv->name, dev_name(dev), ret);
> 		break;
> 	default:
> 		/* driver matched but the probe failed */
> 		printk(KERN_WARNING
> 		       "%s: probe of %s failed with error %d\n",
> 		       drv->name, dev_name(dev), ret);
> 	}
> 	/*
> 	 * Ignore errors returned by ->probe so that the next driver can try
> 	 * its luck.
> 	 */
> 	ret = 0;
> done:
> 	atomic_dec(&probe_count);
> 	wake_up(&probe_waitqueue);
> 	return ret;
> }
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a823f469e53f..0df9b4461766 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -490,7 +490,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	if (dev->bus->dma_configure) {
>  		ret = dev->bus->dma_configure(dev);
>  		if (ret)
> -			goto dma_failed;
> +			goto probe_failed;
>  	}
>
>  	if (driver_sysfs_add(dev)) {
> @@ -546,14 +546,13 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	goto done;
>
>  probe_failed:
> -	arch_teardown_dma_ops(dev);
> -dma_failed:
>  	if (dev->bus)
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>  pinctrl_bind_failed:
>  	device_links_no_driver(dev);
>  	devres_release_all(dev);
> +	arch_teardown_dma_ops(dev);
>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
>  	dev_set_drvdata(dev, NULL);
>


