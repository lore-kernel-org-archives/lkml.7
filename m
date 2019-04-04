Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB820C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C582075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NVFGohpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfDDRWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20669 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfDDRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:34 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190404172230epoutp02eb0347b6a19e3c40fe6363c4725fc900~SVT8X_-av1978019780epoutp02Q;
        Thu,  4 Apr 2019 17:22:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190404172230epoutp02eb0347b6a19e3c40fe6363c4725fc900~SVT8X_-av1978019780epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398550;
        bh=TYWpj8p9WaDYrR6UduDz4MgfkRQie1eBkkay1mt3QIA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NVFGohpNxt5wqIoh2igHJGxPP+BuU/88xV4BrXO3I6BKKZ/YtAe6LTfB/oDiTOzpK
         p6LhzB+vFxg+MHxe4NTBPwAdxT32v13VIQIaYYAVPL80DiS877QxKelO4YBk5dtAB9
         PVBHq4F1PYGozaPKmZGh1+iEYBqBRnWTamKOSzUc=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172230epcas2p2cc0798d06ffe3a1feb4e9d7007e3f3cd~SVT8AoaAB1739317393epcas2p2m;
        Thu,  4 Apr 2019 17:22:30 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.13.04207.65D36AC5; Fri,  5 Apr 2019 02:22:30 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf~SVT7KYg813185231852epcas2p2N;
        Thu,  4 Apr 2019 17:22:29 +0000 (GMT)
X-AuditID: b6c32a48-6a1ff7000000106f-27-5ca63d564d71
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.68.03620.55D36AC5; Fri,  5 Apr 2019 02:22:29 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:29 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RFC 2/8] soc: samsung: Exynos chipid driver update
Date:   Thu, 04 Apr 2019 19:17:29 +0200
Message-id: <20190404171735.12815-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCmuW6Y7bIYg4c3xCw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik8XtxhVsFou2fmG3
        aN17hN3i8Jt2Vgc+jzXz1jB6bFrVyeaxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGWs
        WXuFveCTXMXM6/sZGxh7pboYOTkkBEwkms42sXUxcnEICexglNg7fT0LhPOdUWL23cvsXYwc
        YFXP76ZCxHczSjTuW8oK4fxklPh+7RsbyCg2AUOJ3qN9jCC2iICwxL2ly9lBipgFvjNJnHr9
        lBUkISzgJHHm1XN2EJtFQFXi3fGrLCA2r4C1xLt9kxkhbpKXWL3hADOIzSlgI/F4yRs2iPgB
        NomLvTEQtotE//1jzBC2tMSzVRsZQZZJCDQzSvTsvs0O4UxglLh/fAHUVGuJw8cvgl3BLMAn
        0XH4L9RvvBIdbUIQJR4S187ug/q/n1Fi9YwrTEAjFjAyrGIUSy0ozk1PLTYqMNErTswtLs1L
        10vOz93ECI5WLY8djAfO+RxiFOBgVOLh1WBaFiPEmlhWXJl7iFGCg1lJhDf4+9IYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwPpedGCwmkJ5akZqemFqQWwWSZODilGhjFCo9cCFT8PcW7RKXm
        RECMsvHyvjTn+zGbJmYzvP9sJqRxbW3rtL6byo/tdevqLXNPCb9dYHs977JiSkwSr9wS0+Pf
        ZPXj/r2+r8h9NWfiHoYXOzZtDNcxb9C2KX+33UA+XEhQjTWtiTng9731J61jLrPbPJL78GPT
        uqnp0y6+7/7gZJl4eo4SS3FGoqEWc1FxIgC/Oulc0gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t9jAd1Q22UxBidWyFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLvF4TftrA58HmvmrWH02LSqk81j85J6j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MpY
        s/YKe8EnuYqZ1/czNjD2SnUxcnBICJhIPL+b2sXIxSEksJNR4ve1T4wQzk9GiZe9G5i6GDk5
        2AQMJXqP9jGC2CICwhL3li5nB7GZBb4zScyelwdiCws4SZx59RwsziKgKvHu+FUWEJtXwFri
        3b7JYL0SAvISqzccYAaxOQVsJB4vecMGcoQQUM33LQkTGHkWMDKsYpRMLSjOTc8tNiowykst
        1ytOzC0uzUvXS87P3cQIDMNth7X6dzA+XhJ/iFGAg1GJh1eDaVmMEGtiWXFl7iFGCQ5mJRHe
        4O9LY4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwzsx8
        I/Twiqeiyz6vLeoGCkIzHr8xYo/ZqF7IX5ewQHDSkYvdwX/zf9Z1R9oLX9K+4VZbdfjucqm7
        kl3dNblZORduabhmmlxeEFmpkLM50tbltYzCG1N++6ULX3/lSzq1wO7yn55rSVvPdN97HNtX
        +uJxTei9gyvibkQ90P6h9PjmyZ/XF+8yUmIpzkg01GIuKk4EAKcrQJQ/AgAA
X-CMS-MailID: 20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf
CMS-TYPE: 102P
X-CMS-RootMailID: 20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172229epcas2p25a819e37035b26ccf53613e880bdcacf@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds definition of selected CHIP ID register offsets
and register bit field definitions for Exynos5422 SoC.

exynos_chipid_read() helper function is added to allow reading
the CHIP ID block registers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/exynos-chipid.c | 16 +++++-----
 drivers/soc/samsung/exynos-chipid.h | 48 +++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-chipid.h

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 5cb018807817..4920f0ef2c55 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -16,10 +16,7 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
-#define EXYNOS_SUBREV_MASK	(0xF << 4)
-#define EXYNOS_MAINREV_MASK	(0xF << 0)
-#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
-#define EXYNOS_MASK		0xFFFFF000
+#include "exynos-chipid.h"
 
 static const struct exynos_soc_id {
 	const char *name;
@@ -40,6 +37,13 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5433", 0xE5433000 },
 };
 
+static void __iomem *exynos_chipid_base;
+
+unsigned int exynos_chipid_read(unsigned int offset)
+{
+	return readl_relaxed(exynos_chipid_base + offset);
+}
+
 static const char * __init product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
@@ -53,7 +57,6 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
 int __init exynos_chipid_early_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	void __iomem *exynos_chipid_base;
 	struct soc_device *soc_dev;
 	struct device_node *root;
 	struct device_node *np;
@@ -73,9 +76,8 @@ int __init exynos_chipid_early_init(void)
 		return -ENXIO;
 	}
 
-	product_id = readl_relaxed(exynos_chipid_base);
+	product_id = exynos_chipid_read(EXYNOS_CHIPID_REG_PRO_ID);
 	revision = product_id & EXYNOS_REV_MASK;
-	iounmap(exynos_chipid_base);
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
diff --git a/drivers/soc/samsung/exynos-chipid.h b/drivers/soc/samsung/exynos-chipid.h
new file mode 100644
index 000000000000..826a12c25fa2
--- /dev/null
+++ b/drivers/soc/samsung/exynos-chipid.h
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ */
+
+#define EXYNOS_CHIPID_REG_PRO_ID	0x00
+ #define EXYNOS_SUBREV_MASK		(0xf << 4)
+ #define EXYNOS_MAINREV_MASK		(0xf << 0)
+ #define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | \
+					 EXYNOS_MAINREV_MASK)
+ #define EXYNOS_MASK			0xfffff000
+
+#define EXYNOS_CHIPID_REG_PKG_ID	0x04
+ #define EXYNOS5422_IDS_OFFSET		24
+ #define EXYNOS5422_IDS_MASK		0xff
+ #define EXYNOS5422_USESG_OFFSET	3
+ #define EXYNOS5422_USESG_MASK		0x01
+ #define EXYNOS5422_SG_OFFSET		0
+ #define EXYNOS5422_SG_MASK		0x07
+ #define EXYNOS5422_TABLE_OFFSET	8
+ #define EXYNOS5422_TABLE_MASK		0x03
+ #define EXYNOS5422_SG_A_OFFSET		17
+ #define EXYNOS5422_SG_A_MASK		0x0f
+ #define EXYNOS5422_SG_B_OFFSET		21
+ #define EXYNOS5422_SG_B_MASK		0x03
+ #define EXYNOS5422_SG_BSIGN_OFFSET	23
+ #define EXYNOS5422_SG_BSIGN_MASK	0x01
+ #define EXYNOS5422_BIN2_OFFSET		12
+ #define EXYNOS5422_BIN2_MASK		0x01
+
+#define EXYNOS_CHIPID_REG_LOT_ID	0x14
+
+#define EXYNOS_CHIPID_AUX_INFO		0x1c
+ #define EXYNOS5422_TMCB_OFFSET		0
+ #define EXYNOS5422_TMCB_MASK		0x7f
+ #define EXYNOS5422_ARM_UP_OFFSET	8
+ #define EXYNOS5422_ARM_UP_MASK		0x03
+ #define EXYNOS5422_ARM_DN_OFFSET	10
+ #define EXYNOS5422_ARM_DN_MASK		0x03
+ #define EXYNOS5422_KFC_UP_OFFSET	12
+ #define EXYNOS5422_KFC_UP_MASK		0x03
+ #define EXYNOS5422_KFC_DN_OFFSET	14
+ #define EXYNOS5422_KFC_DN_MASK		0x03
+
+unsigned int exynos_chipid_read(unsigned int offset);
-- 
2.17.1

