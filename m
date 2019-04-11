Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B230BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DB32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmD6pE/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKSgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:36:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40090 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:36:55 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so11215753itb.5;
        Thu, 11 Apr 2019 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9TNf3UZ35qeYaXcIAD6Jv3jypBLTq8q3CpN92zAumA=;
        b=TmD6pE/j5mgVbno8cslMwumh6exLxW9mCQU13hx1QZ5KeOu0L84BN4zZarNmXEE02O
         G+D6VrR9OnOdipmlrTyF/S7Kw6f8Cn32piGg7ifOQsg5xN/Ad91WGpl0In3ShB2t5Lg7
         AbMfD0PkJzmGktt6ShrAwVGloVGgqrEg8Ka/njlX/ymdhJ9CReRMhHVibd9o05jTtV2c
         8xgCcIiHUpQE+2HwIhB8+rwZvx4NPPfUupmtb590Qiz9rGC//3CS1L1SVvvDAvqWlatV
         w9Becw86FbDsqRl99oJ3nP3Nk8LOYQAdXizAj8SZ/4CUYwRdWHsBeBb3BjyOEpmOOGN2
         vmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9TNf3UZ35qeYaXcIAD6Jv3jypBLTq8q3CpN92zAumA=;
        b=NMxujN2vgp48sdtWDdtNRLWFmWP2WPjSWCsDqqldCSL8UonW+rOKikKk3JwtC4SoH5
         VC5C31obNBGRJzxkGf3F4PBmiCe+uut9jZhSfNVhE9tCc0zgBrXHrbcLoljIk/ND2XFF
         +MvS/L6gkIt1QZ2HMGLPqtb0H5bjxenggh/a+Us6mEE0kjFqIsndWIuYVBtP6pqljNGn
         JSbjnZV6Ya/Uck6KeEW2XiFJFEjDd/qGkJX86noUhCdXFgl90eMe2q4urAvbeATToglb
         iEM+twYzZUOsW4zUjI7ys+aF5eVJjE4Hpzo7jPwjFYXF65e6zJiXwbm+Y4jQsotbCUac
         fybw==
X-Gm-Message-State: APjAAAUIng1grThH25eOHYaSL+otD3PtfO/nkpn89B7Y9dTyq+GPWRwQ
        XnOX/wynrcdiuz92TZi884B1fSAr2agNNxEz5C8=
X-Google-Smtp-Source: APXvYqzPphzMLED9oICsy9RE9R0jAzoFDCSwTkJjrbhF+K1Dhnf31CHfnDQrAsgrXGoP3yhrQv2JTup+DXqJ2ej3IZw=
X-Received: by 2002:a24:160d:: with SMTP id a13mr9751033ita.4.1555007813898;
 Thu, 11 Apr 2019 11:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-2-tiny.windzz@gmail.com>
 <20190411080955.ysp3wreifwqrpn3n@flea>
In-Reply-To: <20190411080955.ysp3wreifwqrpn3n@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 12 Apr 2019 02:36:42 +0800
Message-ID: <CAEExFWvcoK+C=_+knCw4nZQso2Frz0-CpbECQbVzKPS11P9RUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Changes:
    1. I removed this sunxi_cpufreq_soc_data structure for now.
    2. Convert to  less generic name.
    3. Update soc_bin xlate. (LINE:484
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/soc/sunxi/sunxi-sid.c)

    Now temporarily consider it as supporting only one platform.
    Anything else to modify?

THx,
Yangtao

diff --git a/drivers/cpufreq/sun5i-cpufreq-nvmem.c
b/drivers/cpufreq/sun5i-cpufreq-nvmem.c
new file mode 100644
index 000000000000..08a8f99463ba
--- /dev/null
+++ b/drivers/cpufreq/sun5i-cpufreq-nvmem.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner CPUFreq nvmem based driver
+ *
+ * The sun5i-cpufreq-nvmem driver reads the efuse value from the SoC to
+ * provide the OPP framework with required information.
+ *
+ * Copyright (C) 2019 Yangtao Li <tiny.windzz@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define MAX_NAME_LEN 7
+
+#define NVMEM_MASK 0x7
+#define NVMEM_SHIFT 5
+
+static struct platform_device *cpufreq_dt_pdev, *sunxi_cpufreq_pdev;
+
+/**
+ * sunxi_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * @versions: Set to the value parsed from efuse
+ *
+ * Returns 0 if success.
+ */
+static int sunxi_cpufreq_get_efuse(u32 *versions)
+{
+ struct nvmem_cell *speedbin_nvmem;
+ struct device_node *np;
+ struct device *cpu_dev;
+ u32 *speedbin, efuse_value;
+ size_t len;
+ int ret;
+
+ cpu_dev = get_cpu_device(0);
+ if (!cpu_dev)
+ return -ENODEV;
+
+ np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+ if (!np)
+ return -ENOENT;
+
+ ret = of_device_is_compatible(np,
+ "allwinner,sun50i-h6-operating-points");
+ if (!ret) {
+ of_node_put(np);
+ return -ENOENT;
+ }
+
+ speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+ of_node_put(np);
+ if (IS_ERR(speedbin_nvmem)) {
+ if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+ pr_err("Could not get nvmem cell: %ld\n",
+ PTR_ERR(speedbin_nvmem));
+ return PTR_ERR(speedbin_nvmem);
+ }
+
+ speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+ nvmem_cell_put(speedbin_nvmem);
+ if (IS_ERR(speedbin))
+ return PTR_ERR(speedbin);
+
+ efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
+ switch (efuse_value) {
+ case 0b0001:
+ *versions = 1;
+ break;
+ case 0b0011:
+ *versions = 2;
+ break;
+ default:
+ /*
+ * For other situations, we treat it as bin0.
+ * This vf table can be run for any good cpu.
+ */
+ *versions = 0;
+ break;
+ }
+
+ kfree(speedbin);
+ return 0;
+};
+
+static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
+{
+ struct opp_table **opp_tables;
+ char name[MAX_NAME_LEN];
+ unsigned int cpu;
+ u32 speed = 0;
+ int ret;
+
+ opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
+      GFP_KERNEL);
+ if (!opp_tables)
+ return -ENOMEM;
+
+ ret = sunxi_cpufreq_get_efuse(&speed);
+ if (ret)
+ return ret;
+
+ snprintf(name, MAX_NAME_LEN, "speed%d", speed);
+
+ for_each_possible_cpu(cpu) {
+ struct device *cpu_dev = get_cpu_device(cpu);
+
+ if (cpu_dev == NULL) {
+ ret = -ENODEV;
+ goto free_opp;
+ }
+
+ opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
+ if (IS_ERR(opp_tables[cpu])) {
+ ret = PTR_ERR(opp_tables[cpu]);
+ pr_err("Failed to set prop name\n");
+ goto free_opp;
+ }
+ }
+
+ cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
+   NULL, 0);
+ if (!IS_ERR(cpufreq_dt_pdev)) {
+ platform_set_drvdata(pdev, opp_tables);
+ return 0;
+ }
+
+ ret = PTR_ERR(cpufreq_dt_pdev);
+ pr_err("Failed to register platform device\n");
+
+free_opp:
+ for_each_possible_cpu(cpu) {
+ if (IS_ERR_OR_NULL(opp_tables[cpu]))
+ break;
+ dev_pm_opp_put_prop_name(opp_tables[cpu]);
+ }
+ kfree(opp_tables);
+
+ return ret;
+}
+
+static int sunxi_cpufreq_nvmem_remove(struct platform_device *pdev)
+{
+ struct opp_table **opp_tables = platform_get_drvdata(pdev);
+ unsigned int cpu;
+
+ platform_device_unregister(cpufreq_dt_pdev);
+
+ for_each_possible_cpu(cpu)
+ dev_pm_opp_put_prop_name(opp_tables[cpu]);
+
+ kfree(opp_tables);
+
+ return 0;
+}
+
+static struct platform_driver sunxi_cpufreq_driver = {
+ .probe = sunxi_cpufreq_nvmem_probe,
+ .remove = sunxi_cpufreq_nvmem_remove,
+ .driver = {
+ .name = "sunxi-cpufreq-nvmem",
+ },
+};
+
+static const struct of_device_id sunxi_cpufreq_match_list[] = {
+ { .compatible = "allwinner,sun50i-h6" },
+ {}
+};
+
+static const struct of_device_id *sunxi_cpufreq_match_node(void)
+{
+ const struct of_device_id *match;
+ struct device_node *np;
+
+ np = of_find_node_by_path("/");
+ match = of_match_node(sunxi_cpufreq_match_list, np);
+ of_node_put(np);
+
+ return match;
+}
+
+/*
+ * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
+ * all the real activity is done in the probe, which may be defered as well.
+ * The init here is only registering the driver and the platform device.
+ */
+static int __init sunxi_cpufreq_init(void)
+{
+ const struct of_device_id *match;
+ int ret;
+
+ match = sunxi_cpufreq_match_node();
+ if (!match)
+ return -ENODEV;
+
+ ret = platform_driver_register(&sunxi_cpufreq_driver);
+ if (unlikely(ret < 0))
+ return ret;
+
+ sunxi_cpufreq_pdev = platform_device_register_simple(
+ "sunxi-cpufreq-nvmem", -1, NULL, 0);
+ ret = PTR_ERR_OR_ZERO(sunxi_cpufreq_pdev);
+ if (ret == 0)
+ return 0;
+
+ platform_driver_unregister(&sunxi_cpufreq_driver);
+ return ret;
+}
+module_init(sunxi_cpufreq_init);
+
+static void __exit sunxi_cpufreq_exit(void)
+{
+ platform_device_unregister(sunxi_cpufreq_pdev);
+ platform_driver_unregister(&sunxi_cpufreq_driver);
+}
+module_exit(sunxi_cpufreq_exit);
+
+MODULE_DESCRIPTION("Sunxi cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
