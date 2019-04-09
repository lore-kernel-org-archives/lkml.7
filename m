Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A91C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DE52084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554843498;
	bh=XAqxphxAEDUteUfduE+ThszJ5rLtpCy8VwH5QWrEcU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bago9Kct5edWr8sNEzs1s5c1qC/4KtXV8P4vUYmqRyh5B/zvqizSRhpZJoXnmhWWU
	 i8ycyG08EQOEf+tSrbRy6PO6wxnBapiqwi/mXMiuWXrb5/ulOvRwEnoVNbhyP3VoWd
	 bIpQ+oWbJrDGHFezt+S1m/J9SY+UyaHu/3T2jWQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDIU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDIU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:58:17 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA0A2084F;
        Tue,  9 Apr 2019 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554843495;
        bh=XAqxphxAEDUteUfduE+ThszJ5rLtpCy8VwH5QWrEcU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QOiOA4AK5Bb0eYhU5p+kD1zV/R5vGpVE9Dl0yaFD38Z8R9Zvnm4Yxblb/72se92/U
         MvUxBBgOi4+WhIz31k6cUmicLylBV33Ya5ahAlpsPIq2FAjFSNW3mt6j86YXd+mwNa
         Y1K9KtYEEvFbO+9QXMWVfyvK+e2jJXYMOB81+aa4=
Received: by mail-ed1-f49.google.com with SMTP id u2so59514eds.8;
        Tue, 09 Apr 2019 13:58:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXzFsOo11ymXIu+1HKxFuAkWNykreu8GDAVRXTKU6+Bf6EW/gWw
        h87zRLmwp5pVENoxOcEbWKFu4SexKc2Nk1W7wE8=
X-Google-Smtp-Source: APXvYqyS17zht/Ku6uZK9LO+Z9rOqub0UAMXynZTzsTn25b1kRd2F5ZK3byRyFpPRcPoHsEeaeB0ey//2x9YZfBBXtY=
X-Received: by 2002:a17:906:1d0f:: with SMTP id n15mr10358745ejh.83.1554843493687;
 Tue, 09 Apr 2019 13:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-12-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-12-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 9 Apr 2019 15:57:37 -0500
X-Gmail-Original-Message-ID: <CANk1AXS_JcdOve_7rfdzg6hkGCHY9Yp7qz6UKVq8YsRiB_fdGg@mail.gmail.com>
Message-ID: <CANk1AXS_JcdOve_7rfdzg6hkGCHY9Yp7qz6UKVq8YsRiB_fdGg@mail.gmail.com>
Subject: Re: [PATCH 11/17] fpga: dfl: afu: add error reporting support.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:24 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

>
> Error reporting is one important private feature, it reports error
> detected on port and accelerated function unit (AFU). It introduces
> several sysfs interfaces to allow userspace to check and clear
> errors detected by hardware.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-port |  29 +++
>  drivers/fpga/Makefile                             |   1 +
>  drivers/fpga/dfl-afu-error.c                      | 225 ++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c                       |   4 +
>  drivers/fpga/dfl-afu.h                            |   4 +
>  5 files changed, 263 insertions(+)
>  create mode 100644 drivers/fpga/dfl-afu-error.c
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
> index f611e47..e6140aa 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-port
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
> @@ -79,3 +79,32 @@ KernelVersion:       5.2
>  Contact:       Wu Hao <hao.wu@intel.com>
>  Description:   Read-only. Read this file to get the status of issued command
>                 to userclck_freqcntrcmd.
> +
> +What:          /sys/bus/platform/devices/dfl-port.0/errors/errors
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. Read this file to get errors detected on port and
> +               Accelerated Function Unit (AFU).
> +
> +What:          /sys/bus/platform/devices/dfl-port.0/errors/first_error
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. Read this file to get the first error detected by
> +               hardware.
> +
> +What:          /sys/bus/platform/devices/dfl-port.0/errors/first_malformed_req
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Read-only. Read this file to get the first malformed request
> +               captured by hardware.
> +
> +What:          /sys/bus/platform/devices/dfl-port.0/errors/clear
> +Date:          March 2019
> +KernelVersion: 5.2
> +Contact:       Wu Hao <hao.wu@intel.com>
> +Description:   Write-only. Write error code to this file to clear errors. If
> +               the input error code doesn't match, it returns -EBUSY error
> +               code.

I understand how -EBUSY could be the right error code for when the
hardware is in a state where the error can't be cleared.  But if the
input error code doesn't match, shouldn't the code be -EINVAL?  Also
as noted below, the way this is currently coded, -ETIMEDOUT could get
returned.

> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index c0dd4c8..f1f0af7 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_FPGA_DFL_AFU)            += dfl-afu.o
>
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
>  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> +dfl-afu-objs += dfl-afu-error.o
>
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)             += dfl-pci.o
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> new file mode 100644
> index 0000000..b66bd4a
> --- /dev/null
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Accelerated Function Unit (AFU) Error Reporting
> + *
> + * Copyright 2019 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@linux.intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Mitchel Henry <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/uaccess.h>
> +
> +#include "dfl-afu.h"
> +
> +#define PORT_ERROR_MASK                0x8
> +#define PORT_ERROR             0x10
> +#define PORT_FIRST_ERROR       0x18
> +#define PORT_MALFORMED_REQ0    0x20
> +#define PORT_MALFORMED_REQ1    0x28
> +
> +#define ERROR_MASK             GENMASK_ULL(63, 0)
> +
> +/* mask or unmask port errors by the error mask register. */
> +static void __port_err_mask(struct device *dev, bool mask)
> +{
> +       void __iomem *base;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +       writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
> +}
> +
> +/* clear port errors. */
> +static int __port_err_clear(struct device *dev, u64 err)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       void __iomem *base_err, *base_hdr;
> +       int ret;
> +       u64 v;
> +
> +       base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +       base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +
> +       /*
> +        * clear Port Errors
> +        *
> +        * - Check for AP6 State
> +        * - Halt Port by keeping Port in reset
> +        * - Set PORT Error mask to all 1 to mask errors
> +        * - Clear all errors
> +        * - Set Port mask to all 0 to enable errors
> +        * - All errors start capturing new errors
> +        * - Enable Port by pulling the port out of reset
> +        */
> +
> +       /* if device is still in AP6 power state, can not clear any error. */
> +       v = readq(base_hdr + PORT_HDR_STS);
> +       if (FIELD_GET(PORT_STS_PWR_STATE, v) == PORT_STS_PWR_STATE_AP6) {
> +               dev_err(dev, "Could not clear errors, device in AP6 state.\n");
> +               return -EBUSY;
> +       }
> +
> +       /* Halt Port by keeping Port in reset */
> +       ret = __port_disable(pdev);
> +       if (ret)
> +               return ret;

__port_disable can return -ETIMEDOUT which will then get returned from
clear_store.  The sysfs document only talks about -EBUSY. You could
either document -ETIMEDOUT in the sysfs doc or you could change the
code to adjust the returned error code.

> +
> +       /* Mask all errors */
> +       __port_err_mask(dev, true);
> +
> +       /* Clear errors if err input matches with current port errors.*/
> +       v = readq(base_err + PORT_ERROR);
> +
> +       if (v == err) {
> +               writeq(v, base_err + PORT_ERROR);
> +
> +               v = readq(base_err + PORT_FIRST_ERROR);
> +               writeq(v, base_err + PORT_FIRST_ERROR);
> +       } else {
> +               ret = -EBUSY;
> +       }
> +
> +       /* Clear mask */
> +       __port_err_mask(dev, false);
> +
> +       /* Enable the Port by clear the reset */
> +       __port_enable(pdev);
> +
> +       return ret;
> +}
> +
> +static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
> +                            char *buf)
> +{
> +       void __iomem *base;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", dfl_feature_revision(base));
> +}
> +static DEVICE_ATTR_RO(revision);

This appears to be adding a
/sys/bus/platform/devices/dfl-port.0/errors/revision attribute that
isn't documented in the sysfs document.

> +
> +static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +       void __iomem *base;
> +       u64 error;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +       mutex_lock(&pdata->lock);
> +       error = readq(base + PORT_ERROR);
> +       mutex_unlock(&pdata->lock);
> +
> +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)error);
> +}
> +static DEVICE_ATTR_RO(errors);
> +
> +static ssize_t first_error_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +       void __iomem *base;
> +       u64 error;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +       mutex_lock(&pdata->lock);
> +       error = readq(base + PORT_FIRST_ERROR);
> +       mutex_unlock(&pdata->lock);
> +
> +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)error);
> +}
> +static DEVICE_ATTR_RO(first_error);
> +
> +static ssize_t first_malformed_req_show(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +       void __iomem *base;
> +       u64 req0, req1;
> +
> +       base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +       mutex_lock(&pdata->lock);
> +       req0 = readq(base + PORT_MALFORMED_REQ0);
> +       req1 = readq(base + PORT_MALFORMED_REQ1);
> +       mutex_unlock(&pdata->lock);
> +
> +       return scnprintf(buf, PAGE_SIZE, "0x%016llx%016llx\n",
> +                        (unsigned long long)req1, (unsigned long long)req0);
> +}
> +static DEVICE_ATTR_RO(first_malformed_req);
> +
> +static ssize_t clear_store(struct device *dev, struct device_attribute *attr,
> +                          const char *buff, size_t count)
> +{
> +       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +       u64 value;
> +       int ret;
> +
> +       if (kstrtou64(buff, 0, &value))
> +               return -EINVAL;
> +
> +       mutex_lock(&pdata->lock);
> +       ret = __port_err_clear(dev, value);
> +       mutex_unlock(&pdata->lock);
> +
> +       return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(clear);
> +
> +static struct attribute *port_err_attrs[] = {
> +       &dev_attr_revision.attr,
> +       &dev_attr_errors.attr,
> +       &dev_attr_first_error.attr,
> +       &dev_attr_first_malformed_req.attr,
> +       &dev_attr_clear.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group port_err_attr_group = {
> +       .attrs = port_err_attrs,
> +       .name = "errors",
> +};
> +
> +static int port_err_init(struct platform_device *pdev,
> +                        struct dfl_feature *feature)
> +{
> +       struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +       dev_dbg(&pdev->dev, "PORT ERR Init.\n");
> +
> +       mutex_lock(&pdata->lock);
> +       __port_err_mask(&pdev->dev, false);
> +       mutex_unlock(&pdata->lock);
> +
> +       return sysfs_create_group(&pdev->dev.kobj, &port_err_attr_group);
> +}
> +
> +static void port_err_uinit(struct platform_device *pdev,
> +                          struct dfl_feature *feature)
> +{
> +       dev_dbg(&pdev->dev, "PORT ERR UInit.\n");
> +
> +       sysfs_remove_group(&pdev->dev.kobj, &port_err_attr_group);
> +}
> +
> +const struct dfl_feature_id port_err_id_table[] = {
> +       {.id = PORT_FEATURE_ID_ERROR,},
> +       {0,}
> +};
> +
> +const struct dfl_feature_ops port_err_ops = {
> +       .init = port_err_init,
> +       .uinit = port_err_uinit,
> +};
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index e727d9b..754729e 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -528,6 +528,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>                 .ops = &port_afu_ops,
>         },
>         {
> +               .id_table = port_err_id_table,
> +               .ops = &port_err_ops,
> +       },
> +       {
>                 .ops = NULL,
>         }
>  };
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 35e60c5..c3182a2 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -100,4 +100,8 @@ int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova);
>  struct dfl_afu_dma_region *
>  afu_dma_region_find(struct dfl_feature_platform_data *pdata,
>                     u64 iova, u64 size);
> +
> +extern const struct dfl_feature_ops port_err_ops;
> +extern const struct dfl_feature_id port_err_id_table[];
> +
>  #endif /* __DFL_AFU_H */
> --
> 2.7.4
>

Thanks,
Alan
