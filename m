Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D56521850
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfJ1JTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:19:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43858 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfJ1JTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:19:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 136412000A9;
        Mon, 28 Oct 2019 10:19:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A40420009D;
        Mon, 28 Oct 2019 10:19:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 069544029E;
        Mon, 28 Oct 2019 17:19:07 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: imx: Add serial number support for i.MX6/7 SoCs
Date:   Mon, 28 Oct 2019 17:16:01 +0800
Message-Id: <1572254161-18914-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6/7 SoCs have a 64-bit SoC unique ID stored in OCOTP,
it can be used as SoC serial number, add this support for
i.MX6Q/6DL/6SL/6SX/6SLL/6UL/6ULL/6ULZ/7D, see below example
on i.MX6Q:

root@imx6qpdlsolox:~# cat /sys/devices/soc0/serial_number
240F31D4E1FDFCA7

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- squash the whole patch set into 1 patch for this special case.
---
 arch/arm/mach-imx/cpu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 0b137ee..d811803 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,15 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
 #include "hardware.h"
 #include "common.h"
 
+#define OCOTP_UID_H	0x420
+#define OCOTP_UID_L	0x410
+
 unsigned int __mxc_cpu_type;
 static unsigned int imx_soc_revision;
 
@@ -76,9 +81,13 @@ void __init imx_aips_allow_unprivileged_access(
 struct device * __init imx_soc_device_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	const char *ocotp_compat = NULL;
 	struct soc_device *soc_dev;
 	struct device_node *root;
+	struct regmap *ocotp;
 	const char *soc_id;
+	u64 soc_uid = 0;
+	u32 val;
 	int ret;
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -119,30 +128,39 @@ struct device * __init imx_soc_device_init(void)
 		soc_id = "i.MX53";
 		break;
 	case MXC_CPU_IMX6SL:
+		ocotp_compat = "fsl,imx6sl-ocotp";
 		soc_id = "i.MX6SL";
 		break;
 	case MXC_CPU_IMX6DL:
+		ocotp_compat = "fsl,imx6q-ocotp";
 		soc_id = "i.MX6DL";
 		break;
 	case MXC_CPU_IMX6SX:
+		ocotp_compat = "fsl,imx6sx-ocotp";
 		soc_id = "i.MX6SX";
 		break;
 	case MXC_CPU_IMX6Q:
+		ocotp_compat = "fsl,imx6q-ocotp";
 		soc_id = "i.MX6Q";
 		break;
 	case MXC_CPU_IMX6UL:
+		ocotp_compat = "fsl,imx6ul-ocotp";
 		soc_id = "i.MX6UL";
 		break;
 	case MXC_CPU_IMX6ULL:
+		ocotp_compat = "fsl,imx6ul-ocotp";
 		soc_id = "i.MX6ULL";
 		break;
 	case MXC_CPU_IMX6ULZ:
+		ocotp_compat = "fsl,imx6ul-ocotp";
 		soc_id = "i.MX6ULZ";
 		break;
 	case MXC_CPU_IMX6SLL:
+		ocotp_compat = "fsl,imx6sll-ocotp";
 		soc_id = "i.MX6SLL";
 		break;
 	case MXC_CPU_IMX7D:
+		ocotp_compat = "fsl,imx7d-ocotp";
 		soc_id = "i.MX7D";
 		break;
 	case MXC_CPU_IMX7ULP:
@@ -153,18 +171,36 @@ struct device * __init imx_soc_device_init(void)
 	}
 	soc_dev_attr->soc_id = soc_id;
 
+	if (ocotp_compat) {
+		ocotp = syscon_regmap_lookup_by_compatible(ocotp_compat);
+		if (IS_ERR(ocotp))
+			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
+
+		regmap_read(ocotp, OCOTP_UID_H, &val);
+		soc_uid = val;
+		regmap_read(ocotp, OCOTP_UID_L, &val);
+		soc_uid <<= 32;
+		soc_uid |= val;
+	}
+
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
 					   (imx_soc_revision >> 4) & 0xf,
 					   imx_soc_revision & 0xf);
 	if (!soc_dev_attr->revision)
 		goto free_soc;
 
+	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number)
+		goto free_rev;
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev))
-		goto free_rev;
+		goto free_serial_number;
 
 	return soc_device_to_device(soc_dev);
 
+free_serial_number:
+	kfree(soc_dev_attr->serial_number);
 free_rev:
 	kfree(soc_dev_attr->revision);
 free_soc:
-- 
2.7.4

