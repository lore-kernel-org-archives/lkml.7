Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F07C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCAE217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554459873;
	bh=mtCbqrBO1QMweqx3KQDf/X30KR017SC5VwgwInDd1fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q/VM3U/5lMOwnkuwheUBU+t8geQvN8hz5D9By62iIJuoJU5Fqd6olCdvoz/OV/kCx
	 gIql8yUVYW6siYS8Int5SVzXKjB2YtK3m/I/BlTjK28acCYH8wkeLgBN/SIZo7+U/C
	 0FcSfJSFVqrv10kMf66eu0zgi3di7CHS+KaeOZ7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfDEKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfDEKY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:24:28 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BD1218FE;
        Fri,  5 Apr 2019 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554459866;
        bh=mtCbqrBO1QMweqx3KQDf/X30KR017SC5VwgwInDd1fo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vfA+XyHwtd7oP4R9sErW82HUSQwm+768bOGc2rf8Tk3syUCdoISayNwvM9wqrGbn5
         T0BRXp2YAx/s4WwLL5I/h/Q7zaO4pHQ5A3ByuhV9OVVYPlwYr1M9BXMK2vgLUhG0xS
         ucA5tfNIric2wmxugo8s7nMFqZ0z1j7kL3kT8HYQ=
Received: by mail-lj1-f169.google.com with SMTP id k8so4745314lja.8;
        Fri, 05 Apr 2019 03:24:25 -0700 (PDT)
X-Gm-Message-State: APjAAAVbqw85ZGIpGBGh5GZKON9xS6bOEGAaS184EkVV1NEwpi1lnkgT
        JiHgmMZ4fWGSJltqGVhP6Ev2QvYFbOo7R5aO49A=
X-Google-Smtp-Source: APXvYqzszKA0G1MYwhmkgcWZK7TzX9mNuST2QyxJMG4hg/F3bOuK4WMQCsPl6l+9Wi8MEKhiTTYltriHS8C9lT9XcLs=
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr6425333ljj.159.1554459863865;
 Fri, 05 Apr 2019 03:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8@epcas2p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com> <20190404171735.12815-5-s.nawrocki@samsung.com>
In-Reply-To: <20190404171735.12815-5-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 5 Apr 2019 12:24:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPevELAn6ZQGKwpTOVdvyevzMmPnsO52VvF-MCk=X3Myhg@mail.gmail.com>
Message-ID: <CAJKOXPevELAn6ZQGKwpTOVdvyevzMmPnsO52VvF-MCk=X3Myhg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] soc: samsung: Add Exynos Adaptive Supply Voltage driver
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

Nice work, thank you!

I have a lot of minor nits all around and few more architecture-like comments.

I think this should be a driver. You initialize it quite late and it
is required by other drivers (cpufreq, devfreq), not by core.

I would also prefer it to be slightly more generic. I mean, now you
get the tables from "samsung,exynos-asv-v1" node and then, depending
on many different compatibles, you do this or that. If it is
samsung,exynos5800, you call 542x code. If it is hardkernel, you
assume it is bin2. This will be not easily portable to other Exynos
chips and other boards (e.g. you need to update the driver for new
board which is forced to be in bin2).

Instead all this information should come from chipid and/or DT. I
could imagine that the device binds to ASV node and parses its
properties. Optionally it could bind to chipid... but then you would
have two devices on same node. Then depending on the of_device_id
match, you have all necessary static configuration data (the same as
PMU driver or all other typical drivers). Dynamic data you read from
chip id.

There are some comments below but I guess the code will change a lot
so there is no point to do through code review.

On Thu, 4 Apr 2019 at 19:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> The Adaptive Supply Voltage (ASV) on Exynos SoCs is a technique of adjusting
> operating points of devices in order to better match actual capabilities
> of the hardware and optimize power consumption.
>
> This patch adds common code for parsing the ASV tables from devicetree
> and updating CPU OPPs.
>
> Also support for Exynos5422/5800 SoC is added, the Exynos5422 specific part
> of the patch is partially based on code from
> https://github.com/hardkernel/linux repository, branch odroidxu4-4.14.y,
> files: arch/arm/mach-exynos/exynos5422-asv.[ch].
>
> Tested on Odroid XU3, XU4, XU3 Lite.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/soc/samsung/Kconfig          |  11 ++
>  drivers/soc/samsung/Makefile         |   3 +
>  drivers/soc/samsung/exynos-asv.c     | 279 +++++++++++++++++++++++++++
>  drivers/soc/samsung/exynos-asv.h     | 114 +++++++++++
>  drivers/soc/samsung/exynos5422-asv.c | 209 ++++++++++++++++++++
>  drivers/soc/samsung/exynos5422-asv.h |  25 +++
>  6 files changed, 641 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-asv.c
>  create mode 100644 drivers/soc/samsung/exynos-asv.h
>  create mode 100644 drivers/soc/samsung/exynos5422-asv.c
>  create mode 100644 drivers/soc/samsung/exynos5422-asv.h
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2905f5262197..4d121984f71a 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -7,6 +7,17 @@ menuconfig SOC_SAMSUNG
>
>  if SOC_SAMSUNG
>
> +config EXYNOS_ASV
> +       bool "Exynos Adaptive Supply Voltage support" if COMPILE_TEST
> +       depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)

Why it cannot be compile tested outside of ARM? The PMU driver has
this constraint because of asm/cputype.h but you probably do not need
it.

> +       depends on EXYNOS_CHIPID
> +       select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
> +
> +# There is no need to enable these drivers for ARMv8
> +config EXYNOS_ASV_ARM
> +       bool "Exynos ASV ARMv7-specific driver extensions" if COMPILE_TEST
> +       depends on EXYNOS_ASV
> +
>  config EXYNOS_CHIPID
>         bool "Exynos Chipid controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 3b6a8797416c..edd1d6ea064d 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +obj-$(CONFIG_EXYNOS_ASV)       += exynos-asv.o
> +obj-$(CONFIG_EXYNOS_ASV_ARM)   += exynos5422-asv.o
> +
>  obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
> diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
> new file mode 100644
> index 000000000000..60532c7eb3aa
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-asv.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.

Since it is first publish date, copyright should be only 2019....
unless this was copied from hardkernel repo but then original
copyright should be included as well.

> + *           http://www.samsung.com/
> + * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
> + *
> + * Samsung Exynos SoC Adaptive Supply Voltage support
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#include "exynos-asv.h"
> +#include "exynos5422-asv.h"
> +#include "exynos5433-asv.h"
> +
> +#ifndef MHZ

There is no existing definition, so just #define. It will also easily
be noticed by preprocessor if someone adds such define later.

> +#define MHZ 1000000U
> +#endif
> +
> +static struct exynos_asv *exynos_asv;

Please avoid it. This should be a driver which registers it's state as drvdata.

> +
> +int exynos_asv_parse_of_table(struct device_node *node,

A nit: node->np because it is more popular. And shorter.

> +                             struct exynos_asv_table *table,
> +                             int index)
> +{
> +       u32 table_size, table_id = 0;
> +       unsigned int len1, len2 = 0;

Please move the initialized variables to separate lines (first probably).

> +       unsigned int num_cols, num_rows;
> +       u32 tmp[20];
> +       u32 *buf;
> +       int ret;
> +
> +       ret = of_property_read_u32(node, "samsung,asv-table-id",
> +                                  &table_id);
> +       if (ret < 0) {
> +               pr_err("ASV: Missing table id in %pOF\n", node);
> +               return ret;
> +       }
> +       table->id = table_id;
> +
> +       if (index >= 0 && asv_table_to_index(table_id) != index)
> +               return -EBADR;
> +
> +       ret = of_property_read_u32_array(node, "samsung,asv-table-size",
> +                                        tmp, 2);
> +       if (ret < 0)
> +               return ret;
> +
> +       num_rows = tmp[0];
> +       num_cols = tmp[1];
> +       if (num_rows > EXYNOS_ASV_MAX_LEVELS ||
> +           num_cols > (EXYNOS_ASV_MAX_GROUPS + 1)) {
> +               pr_err("ASV: Unsupported ASV table size (%d x %d)\n",
> +                      num_rows, num_cols);
> +               return -EINVAL;
> +       }
> +
> +       table_size = num_rows * num_cols;
> +       buf = kcalloc(table_size, sizeof(u32), GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       ret = of_property_read_variable_u32_array(node, "samsung,asv-data",
> +                                                 buf, 0, table_size);
> +       if (ret < 0)
> +               goto err_free_buf;
> +
> +       len1 = ret;
> +
> +       if (ret < table_size) {
> +               u32 *dst, *src;
> +               ret = of_property_read_variable_u32_array(node,
> +                                               "samsung,asv-common-data",
> +                                               (u32 *)tmp, 0,
> +                                               ARRAY_SIZE(tmp));
> +               if (ret < 0) {
> +                       pr_err("ASV: Not enough data for table #%x (%d x %d)\n",
> +                              table_id, num_rows, num_cols);
> +                       goto err_free_buf;
> +               }
> +               len2 = ret;
> +
> +               if (len1 + ((len2 / 2) * num_cols) > table_size) {
> +                       pr_err("ASV: Incorrect table %#x definition\n",
> +                              table_id);
> +                               ret = -EINVAL;
> +                               goto err_free_buf;
> +                       }
> +               /*
> +                * Copy data common to all ASV levels to first and second column
> +                * in the main buffer.  We don't replicate data to further
> +                * columns, instead they are left initialized to 0 (invalid,
> +                * unused frequency value).  We assume that users of the table
> +                * will refer to voltage data in column 1 if 0 is encountered
> +                * in any further column (2, 3,...).
> +                */
> +               dst = buf + len1;
> +               src = tmp;
> +
> +               while (len2 >= 2) {
> +                       memcpy(dst, src, 2 * sizeof(u32));
> +                       dst += num_cols;
> +                       src += 2;
> +                       len2 -= 2;
> +               }
> +       }
> +
> +       table->num_cols = num_cols;
> +       table->num_rows = num_rows;
> +       table->buf = buf;
> +       return 0;
> +
> +err_free_buf:
> +       kfree(buf);
> +       return ret;
> +}
> +
> +int exynos_asv_parse_cpu_tables(struct exynos_asv *asv,        struct device_node *np,
> +                               int table_index)
> +{
> +       struct exynos_asv_subsys *subsys;
> +       struct exynos_asv_table table;
> +       struct device_node *child;
> +       int ret;
> +
> +       for_each_child_of_node(np, child) {
> +               ret = exynos_asv_parse_of_table(child, &table, table_index);
> +               if (ret < 0) {
> +                       if (ret == -EBADR)
> +                               continue;
> +                       of_node_put(child);
> +                       return ret;
> +               }
> +
> +               pr_debug("%s: Matching table: id: %#x at %pOF\n",
> +                        __func__, table.id, child);
> +
> +               switch(asv_table_to_subsys_id(table.id)) {
> +               case EXYNOS_ASV_SUBSYS_ID_ARM:
> +                       subsys = &asv->arm;
> +                       break;
> +               case EXYNOS_ASV_SUBSYS_ID_KFC:
> +                       subsys = &asv->kfc;
> +                       break;
> +               default:
> +                       of_node_put(child);
> +                       return -EINVAL;
> +               }
> +
> +               subsys->num_asv_levels = table.num_rows;
> +               subsys->num_asv_groups = table.num_cols - 1;
> +               subsys->table = table;
> +               subsys->id = asv_table_to_subsys_id(table.id);
> +       }
> +
> +       return 0;
> +}
> +
> +static int exynos_asv_update_cpu_opps(struct device *cpu)
> +{
> +       struct exynos_asv_subsys *subsys = NULL;
> +       struct dev_pm_opp *opp;
> +       unsigned int opp_freq;
> +       int i;
> +
> +       if (of_device_is_compatible(cpu->of_node,
> +                                   exynos_asv->arm.cpu_dt_compat))
> +               subsys = &exynos_asv->arm;
> +       else if (of_device_is_compatible(cpu->of_node,
> +                                        exynos_asv->kfc.cpu_dt_compat))
> +               subsys = &exynos_asv->kfc;
> +
> +       if (!subsys)
> +               return -EINVAL;
> +
> +       for (i = 0; i < subsys->num_asv_levels; i++) {
> +               unsigned int new_voltage;
> +               unsigned int voltage;
> +               int timeout = 1000;
> +               int err;
> +
> +               opp_freq = exynos_asv_opp_get_frequency(subsys, i);
> +
> +               opp = dev_pm_opp_find_freq_exact(cpu, opp_freq * MHZ, true);
> +               if (IS_ERR(opp)) {
> +                       pr_info("%s cpu%d opp%d, freq: %u missing\n",
> +                               __func__, cpu->id, i, opp_freq);
> +
> +                       continue;
> +               }
> +
> +               voltage = dev_pm_opp_get_voltage(opp);
> +               new_voltage = exynos_asv->opp_get_voltage(subsys, i, voltage);
> +               dev_pm_opp_put(opp);
> +
> +               opp_freq *= MHZ;
> +               dev_pm_opp_remove(cpu, opp_freq);
> +
> +               while (--timeout) {
> +                       opp = dev_pm_opp_find_freq_exact(cpu, opp_freq, true);
> +                       if (IS_ERR(opp))
> +                               break;
> +                       dev_pm_opp_put(opp);
> +                       msleep(1);
> +               }
> +
> +               err = dev_pm_opp_add(cpu, opp_freq, new_voltage);
> +               if (err < 0)
> +                       pr_err("%s: Failed to add OPP %u Hz/%u uV for cpu%d\n",
> +                              __func__, opp_freq, new_voltage, cpu->id);
> +       }
> +
> +       return 0;
> +}
> +
> +static int exynos_asv_update_opps(void)
> +{
> +       struct opp_table *last_opp_table = NULL;
> +       struct device *cpu;
> +       int ret, cpuid;
> +
> +       for_each_possible_cpu(cpuid) {
> +               struct opp_table *opp_table;
> +
> +               cpu = get_cpu_device(cpuid);
> +               if (!cpu)
> +                       continue;
> +
> +               opp_table = dev_pm_opp_get_opp_table(cpu);
> +               if (IS_ERR(opp_table))
> +                       continue;
> +
> +               if (!last_opp_table || opp_table != last_opp_table) {
> +                       last_opp_table = opp_table;
> +
> +                       ret = exynos_asv_update_cpu_opps(cpu);
> +                       if (ret < 0)
> +                               pr_err("%s: Couldn't udate OPPs for cpu%d\n",
> +                                      __func__, cpuid);
> +               }
> +
> +               dev_pm_opp_put_opp_table(opp_table);
> +       }
> +
> +       return  0;
> +}
> +
> +static int __init exynos_asv_init(void)
> +{
> +       int ret;
> +
> +       exynos_asv = kcalloc(1, sizeof(struct exynos_asv), GFP_KERNEL);

sizeof(*exynos_asv)

> +       if (!exynos_asv)
> +               return -ENOMEM;
> +
> +       if (of_machine_is_compatible("samsung,exynos5800") ||
> +           of_machine_is_compatible("samsung,exynos5420"))
> +               ret = exynos5422_asv_init(exynos_asv);

No, as I mentioned at beginning, bind to specific node and
differentiate behavior based on of_device_id.

> +       else
> +               return 0;
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = exynos_asv_update_opps();
> +
> +       if (exynos_asv->release)
> +               exynos_asv->release(exynos_asv);
> +
> +       return ret;
> +}
> +late_initcall(exynos_asv_init)
> diff --git a/drivers/soc/samsung/exynos-asv.h b/drivers/soc/samsung/exynos-asv.h
> new file mode 100644
> index 000000000000..3444b361e5e3
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-asv.h
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0

In headers this goes with /* */

> +/*
> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.

Date.

> + *           http://www.samsung.com/
> + * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
> + *
> + * Samsung Exynos SoC Adaptive Supply Voltage support
> + */
> +#ifndef __EXYNOS_ASV_H
> +#define __EXYNOS_ASV_H
> +
> +#define EXYNOS_ASV_MAX_GROUPS          16
> +#define EXYNOS_ASV_MAX_LEVELS          24
> +
> +#define EXYNOS_ASV_TABLE_INDEX_MASK    (0xff)
> +#define EXYNOS_ASV_SUBSYS_ID_MASK      (0xff << 8)
> +
> +#define asv_table_to_subsys_id(_id)    ((_id >> 8) & 0xff)
> +#define asv_table_to_index(_id)                ((_id) & 0xff)
> +
> +#define EXYNOS_ASV_SUBSYS_ID_ARM       0x0
> +#define EXYNOS_ASV_SUBSYS_ID_EGL       EXYNOS_ASV_SUBSYS_ID_ARM
> +#define EXYNOS_ASV_SUBSYS_ID_KFC       0x1
> +#define EXYNOS_ASV_SUBSYS_ID_INT       0x2
> +#define EXYNOS_ASV_SUBSYS_ID_MIF       0x3
> +#define EXYNOS_ASV_SUBSYS_ID_G3D       0x4
> +#define EXYNOS_ASV_SUBSYS_ID_CAM       0x5
> +#define EXYNOS_ASV_SUBSYS_ID_MAX       0x6
> +
> +struct device_node;
> +
> +/* HPM, IDS values to select target group */
> +struct asv_limit_entry {
> +       unsigned int hpm;
> +       unsigned int ids;
> +};
> +
> +struct exynos_asv_table {
> +       unsigned int num_rows;
> +       unsigned int num_cols;
> +       unsigned int id;
> +       u32 *buf;
> +};
> +
> +struct exynos_asv_subsys {
> +       int id;
> +       char *cpu_dt_compat;
> +
> +       unsigned int base_volt;
> +       unsigned int num_asv_levels;
> +       unsigned int num_asv_groups;
> +       unsigned int offset_volt_h;
> +       unsigned int offset_volt_l;
> +       struct exynos_asv_table table;
> +};
> +
> +struct exynos_asv {
> +       struct device_node *chipid_node;
> +       struct exynos_asv_subsys arm;
> +       struct exynos_asv_subsys kfc;
> +
> +       int (*opp_get_voltage)(struct exynos_asv_subsys *subs, int level,
> +                              unsigned int voltage);
> +       void (*release)(struct exynos_asv *asv);
> +
> +       unsigned int group;
> +       unsigned int table;
> +
> +       /* TODO: Move member fields below to SoC type specific data structure */
> +       unsigned int is_bin2;
> +       unsigned int is_special_lot;
> +};
> +
> +static inline u32 __exynos_asv_get_item(struct exynos_asv_table *table,
> +                                     unsigned int row, unsigned int col)
> +{
> +       return table->buf[row * (table->num_cols) + col];
> +}
> +
> +static inline u32 exynos_asv_opp_get_frequency(struct exynos_asv_subsys *subsys,
> +                                              unsigned int index)
> +{
> +       return __exynos_asv_get_item(&subsys->table, index, 0);
> +}

Empty line needed.

> +/**
> + * exynos_asv_parse_of_table - Parse ASV table from devicetree
> + *
> + * @node: DT node containing the table
> + * @table: The parsed table data
> + * @index: Used to select table with specific index to parse, if >= 0.
> + *         This argument is ignored if the value is less than 0.
> + *
> + * Returns: 0 on success, or negative value on failure. EBADR is returned
> + * when @index is >= 0 but the index value of the parsed table ID is different
> + * than @index.
> + */
> +int exynos_asv_parse_of_table(struct device_node *node,
> +                             struct exynos_asv_table *table,
> +                             int index);
> +
> +/**
> + * exynos_asv_parse_cpu_tables - Parse ARM and KFC ASV tables from DT
> + *
> + * @asv: data structure to store the parsed data to
> + * @node: DT node containing the tables
> + * @index: Used to select table with specific index to parse, if >= 0.
> + *         This argument is ignored if the value is less than 0.
> + *
> + * Returns: 0 on success, or negative value on failure.
> + */
> +int exynos_asv_parse_cpu_tables(struct exynos_asv *asv,        struct device_node *np,
> +                               int table_index);
> +
> +#endif /* __EXYNOS_ASV_H */
> diff --git a/drivers/soc/samsung/exynos5422-asv.c b/drivers/soc/samsung/exynos5422-asv.c
> new file mode 100644
> index 000000000000..f0b7bdd873a9
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos5422-asv.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.

The same - copyright date.

> + *           http://www.samsung.com/
> + *
> + * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "exynos-asv.h"
> +#include "exynos-chipid.h"
> +
> +#define EXYNOS5422_NUM_ASV_GROUPS      14
> +
> +static struct exynos_asv *exynos_asv;
> +
> +static int exynos5422_asv_get_table(void)
> +{
> +       unsigned int reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
> +
> +       return (reg >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
> +}
> +
> +static int exynos5422_asv_check_bin2(void)
> +{
> +       unsigned int reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
> +
> +       return (reg >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
> +}
> +
> +static bool exynos5422_asv_check_lot_id(void)
> +{
> +       unsigned int reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
> +
> +       return ((reg >> EXYNOS5422_USESG_OFFSET) & EXYNOS5422_USESG_MASK);
> +}
> +
> +static const struct asv_limit_entry __asv_limits[EXYNOS5422_NUM_ASV_GROUPS] = {
> +       { 13, 55 },
> +       { 21, 65 },
> +       { 25, 69 },
> +       { 30, 72 },
> +       { 36, 74 },
> +       { 43, 76 },
> +       { 51, 78 },
> +       { 65, 80 },
> +       { 81, 82 },
> +       { 98, 84 },
> +       { 119, 87 },
> +       { 135, 89 },
> +       { 150, 92 },
> +       { 999, 999 },
> +};
> +
> +static int exynos5422_asv_get_group(struct exynos_asv *asv)
> +{
> +       unsigned int pkgid_reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
> +       unsigned int auxi_reg = exynos_chipid_read(EXYNOS_CHIPID_AUX_INFO);
> +       int hpm, ids, i;
> +
> +       if (asv->is_special_lot) {
> +               u32 sga = (pkgid_reg >> EXYNOS5422_SG_A_OFFSET) &
> +                          EXYNOS5422_SG_A_MASK;
> +
> +               u32 sgb = (pkgid_reg >> EXYNOS5422_SG_B_OFFSET) &
> +                          EXYNOS5422_SG_B_MASK;
> +
> +               if ((pkgid_reg >> EXYNOS5422_SG_BSIGN_OFFSET) &
> +                    EXYNOS5422_SG_BSIGN_MASK)
> +                       return sga + sgb;
> +               else
> +                       return sga - sgb;
> +       }
> +
> +       hpm = (auxi_reg >> EXYNOS5422_TMCB_OFFSET) & EXYNOS5422_TMCB_MASK;
> +       ids = (pkgid_reg >> EXYNOS5422_IDS_OFFSET) & EXYNOS5422_IDS_MASK;
> +
> +       for (i = 0; i < EXYNOS5422_NUM_ASV_GROUPS; i++) {
> +               if (ids <= __asv_limits[i].ids)
> +                       break;
> +               if (hpm <= __asv_limits[i].hpm)
> +                       break;
> +       }
> +       if (i < EXYNOS5422_NUM_ASV_GROUPS)
> +               return i;
> +
> +       return 0;
> +}
> +
> +static int __asv_offset_voltage(unsigned int index)
> +{
> +       static const unsigned int offset_table[] = { 12500, 50000, 25000 };
> +
> +       if (index == 0 || index > 3)
> +               return 0;
> +
> +       return offset_table[index - 1];
> +}
> +
> +static void exynos5422_asv_offset_voltage_setup(struct exynos_asv *asv)
> +{
> +       struct exynos_asv_subsys *subsys;
> +       unsigned int reg, value;
> +
> +       reg = exynos_chipid_read(EXYNOS_CHIPID_AUX_INFO);
> +
> +       /* ARM offset voltage setup */
> +       subsys = &asv->arm;
> +
> +       subsys->base_volt = 1000000;
> +
> +       value = (reg >> EXYNOS5422_ARM_UP_OFFSET) & EXYNOS5422_ARM_UP_MASK;
> +       subsys->offset_volt_h = __asv_offset_voltage(value);
> +
> +       value = (reg >> EXYNOS5422_ARM_DN_OFFSET) & EXYNOS5422_ARM_DN_MASK;
> +       subsys->offset_volt_l = __asv_offset_voltage(value);
> +
> +       /* KFC offset voltage setup */
> +       subsys = &asv->kfc;
> +
> +       subsys->base_volt = 1000000;
> +
> +       value = (reg >> EXYNOS5422_KFC_UP_OFFSET) & EXYNOS5422_KFC_UP_MASK;
> +       subsys->offset_volt_h = __asv_offset_voltage(value);
> +
> +       value = (reg >> EXYNOS5422_KFC_DN_OFFSET) & EXYNOS5422_KFC_DN_MASK;
> +       subsys->offset_volt_l = __asv_offset_voltage(value);
> +}
> +
> +static int exynos5422_asv_opp_get_voltage(struct exynos_asv_subsys *subsys,
> +                               int level, unsigned int volt)
> +{
> +       unsigned int asv_volt;
> +
> +       if (level >= subsys->num_asv_levels)
> +               return volt;
> +
> +       asv_volt = __exynos_asv_get_item(&subsys->table, level,
> +                                        exynos_asv->group + 1);
> +       if (asv_volt == 0 && exynos_asv->group > 1)
> +               asv_volt = __exynos_asv_get_item(&subsys->table, level, 1);
> +
> +       if (volt > subsys->base_volt)
> +               asv_volt += subsys->offset_volt_h;
> +       else
> +               asv_volt += subsys->offset_volt_l;
> +
> +       return asv_volt;
> +}
> +
> +static void __init exynos5422_asv_release(struct exynos_asv *asv)
> +{
> +       kfree(asv->arm.table.buf);
> +       asv->arm.table.buf = NULL;
> +       kfree(asv->kfc.table.buf);
> +       asv->kfc.table.buf = NULL;
> +}
> +
> +int __init exynos5422_asv_init(struct exynos_asv *asv)
> +{
> +       struct device_node *node;
> +       unsigned int table_index;
> +       int ret;
> +
> +       exynos_asv = asv;
> +
> +       asv->is_bin2 = exynos5422_asv_check_bin2();
> +       asv->is_special_lot = exynos5422_asv_check_lot_id();
> +
> +       if (of_machine_is_compatible("hardkernel,odroid-xu3-lite")) {
> +               asv->is_bin2 = true;
> +               asv->is_special_lot = false;
> +       }
> +
> +       asv->group = exynos5422_asv_get_group(asv);
> +       asv->table = exynos5422_asv_get_table();
> +
> +       exynos5422_asv_offset_voltage_setup(asv);
> +
> +       node = of_find_compatible_node(NULL, NULL, "samsung,exynos-asv-v1");
> +       if (!node)
> +               return -ENODEV;
> +
> +       if (!asv->is_bin2) {
> +               if (asv->table == 2 || asv->table == 3)
> +                       table_index = asv->table;
> +               else
> +                       table_index = 0;
> +       } else {
> +               table_index = 4;
> +       }
> +
> +       ret = exynos_asv_parse_cpu_tables(asv, node, table_index);
> +       of_node_put(node);
> +       if (ret < 0)
> +               return ret;
> +
> +       asv->arm.cpu_dt_compat = "arm,cortex-a15";
> +       asv->kfc.cpu_dt_compat = "arm,cortex-a7";
> +
> +       asv->opp_get_voltage = exynos5422_asv_opp_get_voltage;
> +       asv->release = exynos5422_asv_release;
> +
> +       return ret;
> +}
> diff --git a/drivers/soc/samsung/exynos5422-asv.h b/drivers/soc/samsung/exynos5422-asv.h
> new file mode 100644
> index 000000000000..f0d9107d6d0a
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos5422-asv.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0

/**/ needed

> +/*
> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.

Date

Best regards,
Krzysztof

> + *           http://www.samsung.com/
> + *
> + * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
> + */
> +
> +#ifndef __EXYNOS5422_ASV_H
> +#define __EXYNOS5422_ASV_H
> +
> +#include <linux/errno.h>
> +
> +struct exynos_asv;
> +
> +#ifdef CONFIG_EXYNOS_ASV_ARM
> +int exynos5422_asv_init(struct exynos_asv *asv);
> +#else
> +static inline int exynos5422_asv_init(struct exynos_asv *asv)
> +{
> +       return -ENOTSUPP;
> +}
> +#endif
> +
> +#endif /* __EXYNOS5422_ASV_H */
> --
> 2.17.1
>
