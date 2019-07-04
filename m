Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C718C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0329218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfGDO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:29:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41412 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfGDO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:29:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A25E61A05FF;
        Thu,  4 Jul 2019 16:29:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6C61A05F8;
        Thu,  4 Jul 2019 16:29:33 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9B0CD402C3;
        Thu,  4 Jul 2019 22:29:27 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     gregkh@linuxfoundation.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com
Subject: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform support
Date:   Thu,  4 Jul 2019 22:20:32 +0800
Message-Id: <20190704142032.10745-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

i.MX8QM efuse table has some difference with i.MX8QXP platform,
so add i.MX8QM platform support.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index be2f5f0..0d78ab4 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -16,6 +16,7 @@
 
 enum ocotp_devtype {
 	IMX8QXP,
+	IMX8QM,
 };
 
 struct ocotp_devtype_data {
@@ -39,6 +40,11 @@ static struct ocotp_devtype_data imx8qxp_data = {
 	.nregs = 800,
 };
 
+static struct ocotp_devtype_data imx8qm_data = {
+	.devtype = IMX8QM,
+	.nregs = 800,
+};
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -118,6 +124,7 @@ static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 
 static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
+	{ .compatible = "fsl,imx8qm-scu-ocotp", (void *)&imx8qm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
-- 
2.7.4

