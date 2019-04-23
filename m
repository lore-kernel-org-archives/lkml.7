Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31781206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556016631;
	bh=5rN9pdJ7ck/n+Zcx50tmOVXVGVA6lxSGiKzYLIkc6q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1CVYlInt/Vr70h+lKwiot1QVQqUGrKLDeqiKEmgf2AN0mBw8mm/ToNMwCNq7oGWXs
	 kgau+/bEpnxvGB4FF/eO2vL8KFtqx/RhYfi9vFUB3wmCv7V585dbYYgEcM6qBi5EVp
	 +8/ugfFI/xYM3gyr6PvfBjSipMFYGwerkO7RNzTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfDWKua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDWKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:50:29 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1742177B;
        Tue, 23 Apr 2019 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556016627;
        bh=5rN9pdJ7ck/n+Zcx50tmOVXVGVA6lxSGiKzYLIkc6q0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cceNBnUaeuFZClCn44Znh3pBlebrkhMxTOoCIgVbd5GNFI012OWUEcxjROTbEwHwU
         tD9SckjeLJX19mDo4lDg28IgKCRObxFPm76A4K8/Iubx53+DN/wNLHtEEv4MimUSti
         kxHBlULUuzEO3D7L6FMJn8DAXvsJqSA6YKFPQXTM=
Received: by mail-lj1-f178.google.com with SMTP id k8so526467lja.8;
        Tue, 23 Apr 2019 03:50:27 -0700 (PDT)
X-Gm-Message-State: APjAAAU7S8yqiQoPnkGnBz0Ynpr8BxpvCjVJlxSM8DFn8Uj+J5aH956Z
        QuK/2qqHXEoOWqXv8NG13R5S6R3Vz3qopgZ83Kc=
X-Google-Smtp-Source: APXvYqxF4aza24A8lpz/Ffbo7g8gqCbn0oV4EpRIN86gb8RdEjOxwDODYRXHv5rGJBHUejldxikKHKubTRynnE8aao8=
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr7645809ljj.184.1556016625422;
 Tue, 23 Apr 2019 03:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8@epcas2p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com> <20190404171735.12815-5-s.nawrocki@samsung.com>
In-Reply-To: <20190404171735.12815-5-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Apr 2019 12:50:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc9v8bcQs9HmiDWECCkfQCh-Ktzk9Vqq01ccUm7UG54uQ@mail.gmail.com>
Message-ID: <CAJKOXPc9v8bcQs9HmiDWECCkfQCh-Ktzk9Vqq01ccUm7UG54uQ@mail.gmail.com>
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
> +#define MHZ 1000000U
> +#endif
> +
> +static struct exynos_asv *exynos_asv;
> +
> +int exynos_asv_parse_of_table(struct device_node *node,
> +                             struct exynos_asv_table *table,
> +                             int index)
> +{
> +       u32 table_size, table_id = 0;
> +       unsigned int len1, len2 = 0;
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
> +       if (!exynos_asv)
> +               return -ENOMEM;
> +
> +       if (of_machine_is_compatible("samsung,exynos5800") ||
> +           of_machine_is_compatible("samsung,exynos5420"))
> +               ret = exynos5422_asv_init(exynos_asv);
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
> +/*
> + * Copyright (c) 2018 - 2019 Samsung Electronics Co., Ltd.
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

One more thought: you read this register multiple times in the same
function. I think it is not needed - just read once, store the value
and use the helpers to parse it.

Best regards,
Krzysztof
