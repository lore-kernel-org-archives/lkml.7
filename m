Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1770C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A9206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P+6vRxJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDDRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:30 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20657 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfDDRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:29 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190404172226epoutp0219b9bb7f0607467f91eac5a62a1ae7c5~SVT39deTR2371123711epoutp02c;
        Thu,  4 Apr 2019 17:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190404172226epoutp0219b9bb7f0607467f91eac5a62a1ae7c5~SVT39deTR2371123711epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398546;
        bh=56F8YknQeIUdm0RoBagHdbdLbfVDNx3ZWv0Khy0irX0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=P+6vRxJpjVHuvK1rFXw/N9/vbdSvUMPfc6qzAQzwbpoXbl9yAAlknYkOheTuKpA/A
         6ulzFmN0udn9A7EtZd+EiObHx2MJIk6YKTQIaf11xLQaIdfYEaL+oKqUDwmQyUmoPG
         BPeUxBfjm27unO3+wO/WFwyu9hPqwhmhXZ84NpAE=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190404172225epcas2p3a0b4c4d882c8fcf775b0fe7ab5aeabfd~SVT3rCooO0641906419epcas2p3M;
        Thu,  4 Apr 2019 17:22:25 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.13.04207.15D36AC5; Fri,  5 Apr 2019 02:22:25 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2~SVT2yLCEj0820708207epcas2p2A;
        Thu,  4 Apr 2019 17:22:24 +0000 (GMT)
X-AuditID: b6c32a48-6a1ff7000000106f-21-5ca63d51f5e0
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.58.03620.05D36AC5; Fri,  5 Apr 2019 02:22:24 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:24 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: [PATCH RFC 1/8] soc: samsung: Add exynos chipid driver support
Date:   Thu, 04 Apr 2019 19:17:28 +0200
Message-id: <20190404171735.12815-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCmqW6g7bIYg9aduhYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfuslssvX6RyeJ24wo2i0Vbv7Bb
        tO49wu7A67Fm3hpGj02rOtk8Ni+p9+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mjwf3MBZs
        0q5YdnEzawPjFpUuRk4OCQETiVM3uplBbCGBHYwSnROVuxi5gOzvjBK/1jawwhS9u3KKBSKx
        m1Hi5PfvjBDOT0aJw99/sYBUsQkYSvQe7WMEsUUEhCXuLV3ODlLELHCCSWLWsWNgo4QF3CUu
        HG8DauDgYBFQlZj6xAfE5BWwlvi5IhximbzE6g0HwC7iFLCReLzkDRvIGAmBLWwSx/a/gLrI
        RaLxzV4oW1ri2aqNjBBFzYwSPbtvs0M4Exgl7h9fwAhRZS1x+PhFsA5mAT6JjsN/2UE2Swjw
        SnS0CUGUeEis/D2fDeKzfkaJKzfWsQGNWMDIsIpRLLWgODc9tdiowESvODG3uDQvXS85P3cT
        IzhCtTx2MB4453OIUYCDUYmHV4NpWYwQa2JZcWXuIUYJDmYlEd7g70tjhHhTEiurUovy44tK
        c1KLDzFKc7AoifM+lJ4bLSSQnliSmp2aWpBaBJNl4uCUamAs3J27fP/HU7WsCdtvx/zbM+fP
        Yb8v3uW73bUucte/OHNrd6vc4p7asLgzq2f1exsx+ol2ejRziDK565aonNq0IdpqZ9hR07Iz
        gd5NOpvi9/AzT9l3pUh5zqIX7hba83na3gWw/ivtbD4nOf/NtcoTad63RI5pvhNJK6xweiuZ
        0znvCs9pn2IlluKMREMt5qLiRABG9xMSzAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t9jAd0A22UxBts/6ltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLsDr8eaeWsYPTat6mTz2Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyPh7cw1iw
        Sbti2cXNrA2MW1S6GDk5JARMJN5dOcXSxcjFISSwk1Fi/cOZUM5PRonHf3Yxg1SxCRhK9B7t
        YwSxRQSEJe4tXc4OUsQscIJJ4v/CNSwgCWEBd4kLx9uAbA4OFgFVialPfEBMXgFriZ8rwiGW
        yUus3nAAbCSngI3E4yVv2EBKhIBKvm9JmMDIs4CRYRWjZGpBcW56brFRgVFearlecWJucWle
        ul5yfu4mRmDwbTus1b+D8fGS+EOMAhyMSjy8GkzLYoRYE8uKK3MPMUpwMCuJ8AZ/XxojxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgdE0/+VX8xetNs4O
        RnU7Hncq1ldNyp7HcPtNzxGuCau4ub7P2JSj9SMyLIbTc5fEVifzpOga9oNlKbxWCSsDdrC1
        Kjvc+rKIeTNTxxN3NvH2nUGOszNz3m4IbbTWvfAmhkX40p2i13VXvVlfxu67+OuXi9TcR771
        1/ylV+1cuCWhwvYZt6O1mxJLcUaioRZzUXEiAJ2+amk6AgAA
X-CMS-MailID: 20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2
CMS-TYPE: 102P
X-CMS-RootMailID: 20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

Exynos SoCs have Chipid, for identification of product IDs and SoC
revisions. This patch intends to provide initialization code for all
these functionalities, at the same time it provides some sysfs entries
for accessing these information to user-space.

This driver uses existing binding for exynos-chipid.

Changes by Bartlomiej:
- fixed return values on errors
- removed bogus kfree_const()
- added missing Exynos4210 EVT0 id
- converted code to use EXYNOS_MASK define
- fixed np use after of_node_put()
- fixed too early use of dev_info()
- made driver fail for unknown SoC-s
- added SPDX tag
- updated Copyrights

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
[m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/soc/samsung/Kconfig         |   5 ++
 drivers/soc/samsung/Makefile        |   2 +
 drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2186285fda92..2905f5262197 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG

 if SOC_SAMSUNG

+config EXYNOS_CHIPID
+	bool "Exynos Chipid controller driver" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select SOC_BUS
+
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 29f294baac6e..3b6a8797416c 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o

 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
new file mode 100644
index 000000000000..5cb018807817
--- /dev/null
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define EXYNOS_SUBREV_MASK	(0xF << 4)
+#define EXYNOS_MAINREV_MASK	(0xF << 0)
+#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
+#define EXYNOS_MASK		0xFFFFF000
+
+static const struct exynos_soc_id {
+	const char *name;
+	unsigned int id;
+} soc_ids[] = {
+	{ "EXYNOS3250", 0xE3472000 },
+	{ "EXYNOS4210", 0x43200000 },	/* EVT0 revision */
+	{ "EXYNOS4210", 0x43210000 },
+	{ "EXYNOS4212", 0x43220000 },
+	{ "EXYNOS4412", 0xE4412000 },
+	{ "EXYNOS5250", 0x43520000 },
+	{ "EXYNOS5260", 0xE5260000 },
+	{ "EXYNOS5410", 0xE5410000 },
+	{ "EXYNOS5420", 0xE5420000 },
+	{ "EXYNOS5440", 0xE5440000 },
+	{ "EXYNOS5800", 0xE5422000 },
+	{ "EXYNOS7420", 0xE7420000 },
+	{ "EXYNOS5433", 0xE5433000 },
+};
+
+static const char * __init product_id_to_soc_id(unsigned int product_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
+		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+			return soc_ids[i].name;
+	return NULL;
+}
+
+int __init exynos_chipid_early_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	void __iomem *exynos_chipid_base;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	struct device_node *np;
+	u32 product_id;
+	u32 revision;
+
+	/* look up for chipid node */
+	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
+	if (!np)
+		return -ENODEV;
+
+	exynos_chipid_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!exynos_chipid_base) {
+		pr_err("Failed to map SoC chipid\n");
+		return -ENXIO;
+	}
+
+	product_id = readl_relaxed(exynos_chipid_base);
+	revision = product_id & EXYNOS_REV_MASK;
+	iounmap(exynos_chipid_base);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Samsung Exynos";
+
+	root = of_find_node_by_path("/");
+	of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
+	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+	if (!soc_dev_attr->soc_id) {
+		pr_err("Unknown SoC\n");
+		return -ENODEV;
+	}
+
+	/* please note that the actual registration will be deferred */
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	/* it is too early to use dev_info() here (soc_dev is NULL) */
+	pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		soc_dev_attr->soc_id, product_id, revision);
+
+	return 0;
+}
+early_initcall(exynos_chipid_early_init);
--
2.17.1

