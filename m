Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F005CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46013205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKDHg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:36:59 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57612 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfKDHg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:36:59 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB60F1A078B;
        Mon,  4 Nov 2019 08:36:56 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE5B91A06DD;
        Mon,  4 Nov 2019 08:36:52 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5CD62402AD;
        Mon,  4 Nov 2019 15:36:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: imx: Add i.MX7ULP SoC serial number support
Date:   Mon,  4 Nov 2019 15:35:31 +0800
Message-Id: <1572852931-24101-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP's unique ID layout in OCOTP is different from other
i.MX6/7 SoCs as below:

OCOTP layout		unique ID

0x4b0 bit[15:0]		bit[15:0]
0x4c0 bit[15:0]		bit[31:16]
0x4d0 bit[15:0]		bit[47:32]
0x4e0 bit[15:0]		bit[63:48]

Add support for reading serial number from OCOTP on i.MX7ULP.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index d811803..d70b6fc 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -15,6 +15,11 @@
 #define OCOTP_UID_H	0x420
 #define OCOTP_UID_L	0x410
 
+#define OCOTP_ULP_UID_1		0x4b0
+#define OCOTP_ULP_UID_2		0x4c0
+#define OCOTP_ULP_UID_3		0x4d0
+#define OCOTP_ULP_UID_4		0x4e0
+
 unsigned int __mxc_cpu_type;
 static unsigned int imx_soc_revision;
 
@@ -164,6 +169,7 @@ struct device * __init imx_soc_device_init(void)
 		soc_id = "i.MX7D";
 		break;
 	case MXC_CPU_IMX7ULP:
+		ocotp_compat = "fsl,imx7ulp-ocotp";
 		soc_id = "i.MX7ULP";
 		break;
 	default:
@@ -176,11 +182,25 @@ struct device * __init imx_soc_device_init(void)
 		if (IS_ERR(ocotp))
 			pr_err("%s: failed to find %s regmap!\n", __func__, ocotp_compat);
 
-		regmap_read(ocotp, OCOTP_UID_H, &val);
-		soc_uid = val;
-		regmap_read(ocotp, OCOTP_UID_L, &val);
-		soc_uid <<= 32;
-		soc_uid |= val;
+		if (__mxc_cpu_type == MXC_CPU_IMX7ULP) {
+			regmap_read(ocotp, OCOTP_ULP_UID_4, &val);
+			soc_uid = val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_3, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_2, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+			regmap_read(ocotp, OCOTP_ULP_UID_1, &val);
+			soc_uid <<= 16;
+			soc_uid |= val & 0xffff;
+		} else {
+			regmap_read(ocotp, OCOTP_UID_H, &val);
+			soc_uid = val;
+			regmap_read(ocotp, OCOTP_UID_L, &val);
+			soc_uid <<= 32;
+			soc_uid |= val;
+		}
 	}
 
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
-- 
2.7.4

