Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D224EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958C92147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfHEQ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:58:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37502 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:58:39 -0400
Received: from [10.137.184.118] (unknown [131.107.147.118])
        by linux.microsoft.com (Postfix) with ESMTPSA id 21E2620B7186;
        Mon,  5 Aug 2019 09:58:37 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] sys-hypervisor: /sys/hypervisor/type for Hyper-V
To:     Nuno Das Neves "<Nuno.Das@microsoft.com>;" Nuno Das Neves
         "<Nuno.Das@microsoft.com>;" "gregkh@linuxfoundation.org"
         "<gregkh@linuxfoundation.org>;" Sasha Levin
         "<Alexander.Levin@microsoft.com>;" Haiyang Zhang
         "<haiyangz@microsoft.com>;" KY Srinivasan
         "<kys@microsoft.com>;" Michael Kelley <mikelley@microsoft.com>
References: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
 <1564183046-128211-2-git-send-email-nudasnev@microsoft.com>
 <MN2PR21MB1216DBB3BD918B6DCC738E30CCC30@MN2PR21MB1216.namprd21.prod.outlook.com>
 <MWHPR21MB07015125F311AF5E2A8D813883DD0@MWHPR21MB0701.namprd21.prod.outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Nuno Das Neves <nuno.das@linux.microsoft.com>
Message-ID: <c3cbae7a-d0d1-4c63-ccf1-10f73dd25fc9@linux.microsoft.com>
Date:   Mon, 5 Aug 2019 09:58:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB07015125F311AF5E2A8D813883DD0@MWHPR21MB0701.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/2019 3:54 PM, Nuno Das Neves wrote:
> *From:*Stephen Hemminger <sthemmin@microsoft.com>
> *Sent:* Friday, 26 July 2019 5:43 PM
> *To:* Nuno Das Neves <Nuno.Das@microsoft.com>; Nuno Das Neves <Nuno.Das@microsoft.com>; gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>; Sasha Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Michael Kelley <mikelley@microsoft.com>
> *Cc:* linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> *Subject:* Re: [RFC PATCH 1/2] sys-hypervisor: /sys/hypervisor/type for Hyper-V
>  
> I am not sure about this. 
> The existing tools like lscpu just use CPUID. What is does this addition add?
> 
The main motivation is to replicate functionality available on Xen.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> *From:* Nuno Das Neves <nudasnev@microsoft.com>
> *Sent:* Friday, July 26, 2019 4:17 PM
> *To:* Nuno Das Neves <Nuno.Das@microsoft.com>; gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>; Stephen Hemminger <sthemmin@microsoft.com>; Sasha Levin <Alexander.Levin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Michael Kelley <mikelley@microsoft.com>
> *Cc:* linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> *Subject:* [RFC PATCH 1/2] sys-hypervisor: /sys/hypervisor/type for Hyper-V
>  
> Populate /sys/hypervisor with entries for Hyper-V.
> This patch adds /sys/hypervisor/type which contains "Hyper-V".
> 
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> ---
>  .../ABI/stable/sysfs-hypervisor-hyperv        |  7 ++++
>  drivers/hv/Kconfig                            | 10 +++++
>  drivers/hv/Makefile                           |  7 ++--
>  drivers/hv/sys-hypervisor.c                   | 41 +++++++++++++++++++
>  4 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-hypervisor-hyperv
>  create mode 100644 drivers/hv/sys-hypervisor.c
> 
> diff --git a/Documentation/ABI/stable/sysfs-hypervisor-hyperv b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
> new file mode 100644
> index 000000000000..58380ea81315
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
> @@ -0,0 +1,7 @@
> +What:          /sys/hypervisor/type
> +Date:          July 2019
> +KernelVersion: 5.2.1
> +Contact:       linux-hyperv@vger.kernel.org
> +Description:   If running under Hyper-V:
> +               Type of hypervisor:
> +               "Hyper-V": Hyper-V hypervisor
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 1c1a2514d6f3..e693adf0b77f 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -25,4 +25,14 @@ config HYPERV_BALLOON
>          help
>            Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_SYS_HYPERVISOR
> +       bool "Create Hyper-V entries under /sys/hypervisor"
> +       depends on HYPERV && SYSFS
> +       select SYS_HYPERVISOR
> +       default y
> +       help
> +         Create Hyper-V entries under /sys/hypervisor (e.g., type). When running
> +         native or on another hypervisor, /sys/hypervisor may still be
> +         present, but it will have no Hyper-V entries.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a1eec7177c2d..87f569659555 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_HYPERV)           += hv_vmbus.o
> -obj-$(CONFIG_HYPERV_UTILS)     += hv_utils.o
> -obj-$(CONFIG_HYPERV_BALLOON)   += hv_balloon.o
> +obj-$(CONFIG_HYPERV)                   += hv_vmbus.o
> +obj-$(CONFIG_HYPERV_UTILS)             += hv_utils.o
> +obj-$(CONFIG_HYPERV_BALLOON)           += hv_balloon.o
> +obj-$(CONFIG_HYPERV_SYS_HYPERVISOR)    += sys-hypervisor.o
>  
>  CFLAGS_hv_trace.o = -I$(src)
>  CFLAGS_hv_balloon.o = -I$(src)
> diff --git a/drivers/hv/sys-hypervisor.c b/drivers/hv/sys-hypervisor.c
> new file mode 100644
> index 000000000000..eb3d2a6502c4
> --- /dev/null
> +++ b/drivers/hv/sys-hypervisor.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2019, Microsoft, Inc.
> + *
> + * Authored by: Nuno Das Neves <nudasnev@microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/err.h>
> +
> +#include <asm/hypervisor.h>
> +
> +static ssize_t type_show(struct kobject *obj,
> +                       struct kobj_attribute *attr,
> +                       char *buf)
> +{
> +       return sprintf(buf, "Hyper-V\n");
> +}
> +
> +static struct kobj_attribute type_attr = __ATTR_RO(type);
> +
> +static int __init hyperv_sysfs_type_init(void)
> +{
> +       return sysfs_create_file(hypervisor_kobj, &type_attr.attr);
> +}
> +
> +static int __init hyper_sysfs_init(void)
> +{
> +       int ret;
> +
> +       if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
> +               return -ENODEV;
> +
> +       ret = hyperv_sysfs_type_init();
> +
> +       return ret;
> +}
> +device_initcall(hyper_sysfs_init);
> -- 
> 2.17.1
> 
